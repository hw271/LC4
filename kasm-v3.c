///----------------------
///  kasm-v3.c
///  
///  An assembler for the LC4-v3.
///  
///  Usage: kasm < prog.asm > prog.bin
///  
///  Build: cc kasm-v3.c -o kasm
///----------------------

///----------------------
///  kasm assembly language
///----------------------
///
///  Assembler directives, examples:
///  
///      .ORIG h0200     add header so program code will be loaded to address h0200
///      .FILL hF12C     fill program word with the value 16'hF12C
///                      ( signed expressions are not supported; unsigned expressions can )
///                      ( be in binary "b", or hex "h", or decimal "d" )
/// 
///  Output file format:
///  The output is plain text in verilog readmemb() input file format. Each line consists
///  of (1) a generated 16-bit instruction word, and (2) the original source code line
///  preceded by readmemb() comment characters "//".
/// 
///  Example of a complete LC4 assembly language program:
/// 
///     # SampleProgram.asm
///     # This is a comment.
///         # These comment lines and blank lines are ignored.
///     
///     .ORIG h0200    #--- verilog memory will be loaded at address 16'h0200.
///                    #--- .ORIG is required.
///     LDR DR1 AR2    #--- comments are allowed on a code or directive line.
///     LIM DR3 d17    #--- 9-bit immediate value expressed in decimal.
///     LIM DR3 h0A2   #--- 9-bit value in hex, with leading 1-bit 0.
///     LIM DR3 h1A2   #--- 9-bit value in hex, with leading 1-bit 1.
///     LIM DR3 b100001111         #--- 9-bit value in binary.
///     .FILL hABCD                #--- hex expression of 16-bit word.
///     .FILL d137                 #--- decimal expression of 16-bit word.
///     .FILL b0000111100001111    #--- binary expression of 16-bit word.
///         BRR CR2 AR7            #--- leading white space is ignored.
///                      
///     .ORIG h1000    #--- verilog memory will be loaded at address 16'h1000.
///                    #--- multiple load locations are allowed.
///     ALU R1 R2 R3 ADD
/// 
/// 
//------------------------------------------------------------------------------------------------
//---------------------------------------------------------------
//-- Instruction           [ Assembly language example *      ]
//--    Semantics          [ Machine language format          ]
//---------------------------------------------------------------
//-- ADD                   [ ALU    SR7    SR3    DR5    ADD  ]
//--   R5 <=== R7 + R3     [ 0000   111    011    011    000  ]
//---------------------------------------------------------------
//-- NOT                   [ ALU    SR2           DR5    NOT  ]
//--   R5 <=== NOT( R2 )   [ 0000   010    xxx    101    010  ]
//---------------------------------------------------------------
//-- LIM                   [ LIM    DR3    h6                 ]
//--   R3 <=== x6          [ 0001   011    000____000____110  ]
//---------------------------------------------------------------
//-- LDR                   [ LDR    DR4    AR6                ]
//--   R4 <=== DMEM[ R6 ]  [ 0010   100    110    xxx    xxx  ]
//---------------------------------------------------------------
//-- STR                   [ STR    SR5    AR2                ]
//--   DMEM[ R2 ] <=== R5  [ 0011   101    010    xxx    xxx  ]
//---------------------------------------------------------------
//-- LEA                   [ LEA    DR2                       ]
//--   R2 <=== PC+1        [ 0100   010    xxx    xxx    xxx  ]
//---------------------------------------------------------------
//-- BRR                   [ BRR    CR7    AR2                ]
//--   R7<0? PC <=== R2    [ 0101   111    010    xxx    xxx  ]
//---------------------------------------------------------------
//-- SYS                   [ SYS    CALL                      ]
//--  SavedPC  <=== PC+1   [ 0110   000    xxx    xxx    xxx  ]
//--  PC       <=== h1000    
//--  SavedPSR <=== PSR
//--  PSR      <=== newPSR
//---------------------------------------------------------------
//-- SYS                   [ SYS    RET                       ]
//--  PC  <=== SavedPC     [ 0110   100    xxx    xxx    xxx  ]
//--  PSR <=== SavedPSR
//---------------------------------------------------------------
//-- NOP                   [ NOP                              ]
//--                       [ 0111   xxx    xxx    xxx    xxx  ]
//---------------------------------------------------------------
//-----------------------------
//--   ALU        code
//-- operation    ALU.func[2:0]
//-- ----------   --------
//-- ADD          000
//-- AND          001
//-- NOT          010
//-- INC          011
//-- SUB          100
//-- OR           101
//-- NOR          110
//-- DEC          111

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char line[256];                                 //-- line-at-a-time input

                                                //-- source code input strings:
char INS[80];                                   //--     operation identifier
char SRx[80], SRy[80], DR[80], AR[80], CR[80];  //--     register fields
char IMM[80], FUN[80], ADDR[80], ACT[80];       //--     data and function fields
char CON[80], DATA_WORD[80];                    //--     assembler directive fields

char *FLD0, *FLD1, *FLD2, *FLD3, *FLD4;         //-- instruction's translated fields

int linenum = 0;                                //-- source code input line.

#define NUMOPCODES 16
struct {                                        //-- opcode lookup table
    char *INS;
    char *opcode;
} opcodeTable[NUMOPCODES];

#define NUMFUNS 8
struct {                                        //-- function code lookup table
    char *FUN;
    char *code;
} funcTable[NUMFUNS];

#define NUMACTS 2
struct {                                        //-- function code lookup table
    char *ACT;
    char *code;
} actTable[NUMACTS];

//-------------------------------------------
//-- Report translation error and die.
//-------------------------------------------
void doERROR( char * msg ){
    fprintf(stderr, "\n lcasm ERROR (line %d): %s\n", linenum, msg);
    exit(1);
}

//-------------------------------------------
//-- opcode identifier to binary translation table.
//-------------------------------------------
#define NUMOPS 7
void initOpcodes(void) {
    opcodeTable[0].INS    = "ALU";
    opcodeTable[0].opcode = "0000";
    opcodeTable[1].INS    = "LIM";
    opcodeTable[1].opcode = "0001";
    opcodeTable[2].INS    = "LDR";
    opcodeTable[2].opcode = "0010";
    opcodeTable[3].INS    = "STR";
    opcodeTable[3].opcode = "0011";
    opcodeTable[4].INS    = "LEA";
    opcodeTable[4].opcode = "0100";
    opcodeTable[5].INS    = "BRR";
    opcodeTable[5].opcode = "0101";
    opcodeTable[6].INS    = "SYS";
    opcodeTable[6].opcode = "0110";
}

//-------------------------------------------
//-- Convert opcode identifier to binary.
//-------------------------------------------
void INS2opcode( char *INS, char **code ) {
    int i;
    int found = 0;
    if( 3 != strlen(INS) ) doERROR("bad INS length");
    for( i = 0; i < NUMOPS; i++ ){
       if (0 == strcmp( INS, opcodeTable[i].INS )){
            found = 1;
            *code  = opcodeTable[i].opcode;
            break;
       }
    }
    if( 0 == found ) doERROR("no INS match");
}

//-------------------------------------------
//-- ALU function identifier to binary translation table.
//-------------------------------------------
void initFUNcodes(void) {
    funcTable[0].FUN  = "ADD";
    funcTable[0].code = "000";
    funcTable[1].FUN  = "AND";
    funcTable[1].code = "001";
    funcTable[2].FUN  = "NOT";
    funcTable[2].code = "010";
    funcTable[3].FUN  = "INC";
    funcTable[3].code = "011";
    funcTable[4].FUN  = "SUB";
    funcTable[4].code = "100";
    funcTable[5].FUN  = "iOR";
    funcTable[5].code = "101";
    funcTable[6].FUN  = "NOR";
    funcTable[6].code = "110";
    funcTable[7].FUN  = "DEC";
    funcTable[7].code = "111";
}

//-------------------------------------------
//-- SYS action identifier to binary translation table.
//-------------------------------------------
void initACTcodes(void) {
    actTable[0].ACT  = "CALL";
    actTable[0].code = "000";
    actTable[1].ACT  = "RET";
    actTable[1].code = "100";
}

//-------------------------------------------
//-- Convert ALU function identifier to binary.
//-------------------------------------------
void FUN2code( char *FUN, char **code ){
    int i;
    int found = 0;
    if( 3 != strlen(FUN) ) doERROR("bad FUN size");
    for( i = 0; i < NUMFUNS; i++ ){
       if (0 == strcmp( FUN, funcTable[i].FUN )){
            found = 1;
            *code  = funcTable[i].code;
            break;
       }
    }
    if( 0 == found ) doERROR("FUN not found");
}

//-------------------------------------------
//-- Convert SYS action identifier to binary.
//-------------------------------------------
void ACT2code( char *ACT, char **code ){
    int i;
    int found = 0;
    for( i = 0; i < NUMACTS; i++ ){
       if (0 == strcmp( ACT, actTable[i].ACT )){
            found = 1;
            *code  = actTable[i].code;
            break;
       }
    }
    if( 0 == found ) doERROR("ACT not found");
}

//-------------------------------------------
//-- dig2bin
//-- Convert identifier digit to binary.
//-------------------------------------------
void dig2bin( char c, char **bin ) {
    switch (c) {
      case '0' : *bin = "000"; break;
      case '1' : *bin = "001"; break;
      case '2' : *bin = "010"; break;
      case '3' : *bin = "011"; break;
      case '4' : *bin = "100"; break;
      case '5' : *bin = "101"; break;
      case '6' : *bin = "110"; break;
      case '7' : *bin = "111"; break;
      default: doERROR("bad digit specifier");
    }
}

//----------------------------------------------------
//-- int2binary
//--    convert integer to n-bit binary expression string.
//--    unsigned.
//----------------------------------------------------
void int2binary( int n, unsigned int x, char **bin ) {
    char bits[80];
    int i, j;

    if( x >= (1 << n))  printf("integer value too big.\n");
    for (i=0; i < n; i++) {
        bits[i] = (x & 1) == 1 ? '1' : '0';
        x >>= 1;
    }
    j = 0;
    for (i = n-1; i >= 0; i--) {
        CON[j++] = bits[i];
    }
    CON[j] = '\0';
    *bin = CON;
}

//----------------------------------------------------
//-- binary2int
//--    convert n-bit unsigned binary expression string to unsigned integer.
//--    Converts a bit at a time, high-bit to low-bit.
//--    String is ordered left-to-right, char_0 (bit_n-1) to char_n-1 (bit_0).
//----------------------------------------------------
void binary2int( int n, unsigned int *x, char *bin ) {
     int bit_num  = n-1;
     int char_num = 0;

    if( n != strlen( bin ))  doERROR("binary expression not correct number of bits.");
    *x = 0;
    while(1) {
        switch( bin[ char_num ] ) {
          case '0' : *x += 0; break;
          case '1' : *x += 1; break;
          default  : doERROR("bad binary integer digit.");
        }
        if( *x < 0 ) doERROR("internal error: string too long for conversion to type int.");
        if( bit_num == 0 ) break;
        char_num++;
        bit_num--;
        *x <<= 1;
    }
}

//-------------------------------------------
//-- Convert SR register identifier to binary.
//-------------------------------------------
void SR2binary( char *reg, char **bin ) {
    if (3 != strlen(reg)) doERROR("bad SR field size");
    if (reg[0] != 'S')    doERROR("bad SR field format");
    if (reg[1] != 'R')    doERROR("bad SR field format");
    dig2bin( reg[2], bin );
}

//-------------------------------------------
//-- Convert DR register identifier to binary.
//-------------------------------------------
void DR2binary( char *reg, char **bin ) {
    if (3 != strlen(reg)) doERROR("bad DR field size");
    if (reg[0] != 'D')    doERROR("bad DR field format");
    if (reg[1] != 'R')    doERROR("bad DR field format");
    dig2bin( reg[2], bin );
}

//-------------------------------------------
//-- Convert AR register identifier to binary.
//-------------------------------------------
void AR2binary( char *reg, char **bin ) {
    if (3 != strlen(reg)) doERROR("bad AR field size");
    if (reg[0] != 'A')    doERROR("bad AR field format");
    if (reg[1] != 'R')    doERROR("bad AR field format");
    dig2bin( reg[2], bin );
}

//-------------------------------------------
//-- Convert CR register identifier to binary.
//-------------------------------------------
void CR2binary( char *reg, char **bin ) {
    if (3 != strlen(reg)) doERROR("bad CR field size");
    if (reg[0] != 'C')    doERROR("bad CR field format");
    if (reg[1] != 'R')    doERROR("bad CR field format");
    dig2bin( reg[2], bin );
}

//-------------------------------------------
//-- Convert IMM binary field to binary.
//-------------------------------------------
void bin2binary( char *imm, char **bin ) {
    int i, n;
    n = strlen( imm );
    if (n != 9) doERROR("immediate field has bad binary field length");
    for(i=0; i<n; i++) {
        if (imm[i] == '0') continue;
        if (imm[i] == '1') continue;
        doERROR("immediate field has bad digit");
    }
    *bin = imm;
}

//-------------------------------------------
//-- Convert IMM hex field to binary.
//-------------------------------------------
void hex2binary( char *imm, char **bin ) {
     unsigned int x;
    
    if( 1 !=sscanf( imm, "%x", &x)) doERROR("bad hex expression.");
    if( x >= (1 << 9))              doERROR("value too big.");
    int2binary( 9, x, bin );
}

//-------------------------------------------
//-- Convert IMM decimal field to binary.
//-------------------------------------------
void dec2binary( char *imm, char **bin ) {
     unsigned int x;
    
    if( 1 !=sscanf( imm, "%d", &x)) doERROR("bad decimal expression.");
    if( x >= (1 << 9))              doERROR("value too big.");
    int2binary( 9, x, bin );
}

//-------------------------------------------
//-- Convert IMM field to binary.
//-------------------------------------------
void IMM2binary( char *imm, char **bin ) {
    switch (imm[0]) {
      case 'b': bin2binary( &imm[1], bin ); break;
      case 'h': hex2binary( &imm[1], bin ); break;
      case 'd': dec2binary( &imm[1], bin ); break;
      default : doERROR("bad immediate format specifier");
    }
}

//-------------------------------------------
//-- Get instruction's opcode identifer.
//-------------------------------------------
void getINS( char *INS ) {
    if (1 != sscanf( line, "%s", INS)) doERROR("cannot read an instruction or directive" );
}

//-------------------------------------------
//-- Translate an ALU instruction's fields to binary.
//-------------------------------------------
void doALU(void){

    if (5 != sscanf( line, "%s %s %s %s %s", INS, SRx, SRy, DR, FUN )) doERROR("ALU format");
    INS2opcode( INS, & FLD0 );
    SR2binary(  SRx, & FLD1 );
    SR2binary(  SRy, & FLD2 );
    DR2binary(   DR, & FLD3 );
    FUN2code(   FUN, & FLD4 );
    printf( "%s_%s_%s_%s_%s", FLD0, FLD1, FLD2, FLD3, FLD4);
}

//-------------------------------------------
//-- Translate an LIM instruction's fields to binary.
//-------------------------------------------
void doLIM(void){

    if (3 != sscanf( line, "%s %s %s", INS, DR, IMM )) doERROR("LIM format");
    INS2opcode( INS, & FLD0 );
    DR2binary(  DR , & FLD1 );
    IMM2binary( IMM, & FLD2 );
    printf( "%s_%s_%s  ", FLD0, FLD1, FLD2 );
}

//-------------------------------------------
//-- Translate an LDR instruction's fields to binary.
//-------------------------------------------
void doLDR(void){

    if (3 != sscanf( line, "%s %s %s", INS, DR, AR )) doERROR("LDR format");
    INS2opcode( INS, & FLD0 );
    DR2binary(  DR , & FLD1 );
    AR2binary(  AR , & FLD2 );
    printf( "%s_%s_%s_000_000", FLD0, FLD1, FLD2 );
}

//-------------------------------------------
//-- Translate an STR instruction's fields to binary.
//-------------------------------------------
void doSTR(void){

    if (3 != sscanf( line, "%s %s %s", INS, SRx, AR )) doERROR("STR format");
    INS2opcode( INS, & FLD0 );
    SR2binary(  SRx, & FLD1 );
    AR2binary(  AR , & FLD2 );
    printf( "%s_%s_%s_000_000", FLD0, FLD1, FLD2 );
}

//-------------------------------------------
//-- Translate an LEA instruction's fields to binary.
//-------------------------------------------
void doLEA(void){

    if (2 != sscanf( line, "%s %s", INS, DR )) doERROR("LEA format");
    INS2opcode( INS, & FLD0 );
    DR2binary(  DR , & FLD1 );
    printf( "%s_%s_000_000_000", FLD0, FLD1 );
}

//-------------------------------------------
//-- Translate an BRR instruction's fields to binary.
//-------------------------------------------
void doBRR(void){

    if (3 != sscanf( line, "%s %s %s", INS, CR, AR )) doERROR("BRR format");
    INS2opcode( INS, & FLD0 );
    CR2binary(  CR , & FLD1 );
    AR2binary(  AR, & FLD2 );
    printf( "%s_%s_%s_000_000", FLD0, FLD1, FLD2 );
}

//-------------------------------------------
//-- Translate a SYS instruction's fields to binary.
//-------------------------------------------
void doSYS(void){

    if (2 != sscanf( line, "%s %s", INS, ACT )) doERROR("SYS format");
    INS2opcode( INS, & FLD0 );
    ACT2code(  ACT, & FLD1 );
    printf( "%s_%s_000_000_000", FLD0, FLD1 );
}

//-------------------------------------------
//-- const2binary
//--     convert 16-bit constant expression to binary.
//-------------------------------------------
void const2binary( char * DATA_WORD ) {

    unsigned int x;

    if ('b' == DATA_WORD[0] ) {
        binary2int( 16, &x, &DATA_WORD[1] );
        int2binary( 16, x, &DATA_WORD );
        printf("%s    ", DATA_WORD); return;
        return;
    }
    if ('h' == DATA_WORD[0] ) {
        if( 1 !=sscanf( &DATA_WORD[1], "%x", &x)) doERROR("bad hex expression.");
        int2binary( 16, x, &DATA_WORD );
        printf("%s    ", DATA_WORD);
        return;
    }
    if ('d' == DATA_WORD[0] ) {
        if( 1 !=sscanf( &DATA_WORD[1], "%d", &x)) doERROR("bad decimal expression.");
        int2binary( 16, x, &DATA_WORD );
        printf("%s    ", DATA_WORD);
        return;
    }
    doERROR("bad numeric expression specifier.");
}

//-------------------------------------------
//-- doDir()
//-- Handle assembler directive.
//-------------------------------------------
void doDir(void){
    unsigned int x;

    if ( 0 == strcmp( INS, ".ORIG") ) {
        if (2 != sscanf( line, "%s %s", INS, ADDR )) doERROR(".ORIG format");
        if (5 != strlen( ADDR ))                     doERROR(".ORIG hex format");
        if ('h' !=  ADDR[0] )                        doERROR(".ORIG hex format, missing h");
        if (1 !=  sscanf( &ADDR[1], "%x", &x ) )     doERROR(".ORIG address not hex number");
        printf( "@%s               ", &ADDR[1] );
        return;
    }
    if ( 0 == strcmp( INS, ".FILL") ) {
        if (2 != sscanf( line, "%s %s", INS, CON )) doERROR(".FILL format");
        const2binary( CON );
        return;
    }
    doERROR("unknown assembler directive.");
}

//-------------------------------------------
//--------------  MAIN ----------------------
//-------------------------------------------

int main (void) {

    char c;

    //--------------- init lookup tables.
    initOpcodes();
    initFUNcodes();
    initACTcodes();

    //--------------- process source code a line at a time.

    while ( NULL != fgets(line, sizeof(line), stdin) ) {

        linenum++;                                ///-- got a line.

        if ( line[0] == '\n' ) continue;          ///-- skip blank line.
        if ( line[0] == '#' )  continue;          ///-- skip whole-line comment.

        if( 0 != sscanf(line,"%*[ \t]%c", &c) ) { ///-- skip white space:
            if ( c == '\n') continue;                 ///-- skip all-white-space line.
	    if ( c == '#')  continue;                 ///-- skip indented whole-line comment.
        }

	getINS( INS );                            ///-- get instruction's identifier.

        //-- identify instruction and do translation to binary:

        if ( INS[0] == '.' )           { doDir(); printf("    //--  %s", line ); continue; }
        if ( 0 == strcmp( INS, "ALU")) { doALU(); printf("    //--  %s", line ); continue; }
        if ( 0 == strcmp( INS, "LIM")) { doLIM(); printf("    //--  %s", line ); continue; }
        if ( 0 == strcmp( INS, "LDR")) { doLDR(); printf("    //--  %s", line ); continue; }
        if ( 0 == strcmp( INS, "STR")) { doSTR(); printf("    //--  %s", line ); continue; }
        if ( 0 == strcmp( INS, "LEA")) { doLEA(); printf("    //--  %s", line ); continue; }
        if ( 0 == strcmp( INS, "BRR")) { doBRR(); printf("    //--  %s", line ); continue; }
        if ( 0 == strcmp( INS, "SYS")) { doSYS(); printf("    //--  %s", line ); continue; }

        doERROR("unknown instruction or directive");

    }

    return(0); 
}
