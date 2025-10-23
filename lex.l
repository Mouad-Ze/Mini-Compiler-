%{
#include <stdio.h>
#include <string.h>
#include "symboltable.h"
entry_t** symbol_table;
entry_t** constant_table;
int cmnt_strt = 0;
int yycolumn = 1;
int verbose = 0; // Verbose flag for detailed debugging

void update_yycolumn(char *text) {
    while (*text != '\0') {
        if (*text == '\t')
            yycolumn += 8 - (yycolumn % 8);
        else
            yycolumn++;
        text++;
    }
}

void print_verbose(const char* message) {
    if (verbose) {
        printf("%s", message);
    }
}
%}

%option noyywrap
%option batch

/* Definitions for MiniL */
letter [a-zA-Z]
digit [0-9]
ws  [ \t\r\f\v]+
identifier {letter}({letter}|{digit}){0,9}
alnum {letter}|{digit}

%x CMNT

%%
/* Keywords and Identifiers */
"Import" {
    print_verbose("\tProcessing Import Statement\n");
    return IMPORT;
}
"Library" { return LIBRARY; }
"MiniL.lang" | "MiniL.io" {
    print_verbose("\tValid Library Detected\n");
    return LIBRARY_NAME;
}
"public" { return PUBLIC; }
"protected" { return PROTECTED; }
"class" { return CLASS; }
{identifier} {
    print_verbose("\tIdentifier Found\n");
    insert(symbol_table, yytext, IDENTIFIER);
    return IDENTIFIER;
}

/* Constants and Types */
[0-9]+ {
    insert(constant_table, yytext, INTEGER);
    return INTEGER;
}
[0-9]+"."[0-9]* {
    insert(constant_table, yytext, REAL);
    return REAL;
}
\"[^\"\n]*\" {
    insert(constant_table, yytext, STRING);
    return STRING;
}

/* Comment Handling */
"//" { /* Ignore single line comments */ }
"/*" {
    cmnt_strt = yylineno; 
    BEGIN CMNT;
}
<CMNT>"*/" {
    BEGIN 0; 
}
<CMNT>.|"\n" {
    if (yytext[0] == '\n') {
        yylineno++;
        yycolumn = 1;
    } else {
        update_yycolumn(yytext);
    }
}
<CMNT><<EOF>> {
    fprintf(stderr, "Unterminated comment starting at line %d\n", cmnt_strt);
    yyterminate();
}

/* White Spaces */
{ws} ;

/* Operators and Symbols */
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MULT; }
"/" { return DIV; }
";" { return SEMICOLON; }
"," { return COMMA; }
"(" { return LPAREN; }
")" { return RPAREN; }
"{" { return LBRACE; }
"}" { return RBRACE; }
"[" { return LBRACKET; }
"]" { return RBRACKET; }

. {
    fprintf(stderr, "Error: Line %d, Column %d: Illegal character '%s'\n", yylineno, yycolumn, yytext);
    update_yycolumn(yytext);
}

\n {
    yylineno++;
    yycolumn = 1;
}

%%
/* Additional C Code */
int main(int argc, char **argv) {
    if (argc > 1) {
        if (strcmp(argv[1], "-v") == 0) {
            verbose = 1; // Enable verbose mode
            yyin = stdin;
        } else {
            yyin = fopen(argv[1], "r");
            if (!yyin) {
                perror(argv[1]);
                return 1;
            }
        }
    }
    symbol_table = create_table();
    constant_table = create_table();
    yylex();
    display(symbol_table);
    display(constant_table);
    return 0;
}
