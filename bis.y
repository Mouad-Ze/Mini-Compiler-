%{
#include <stdio.h>
#include <stdlib.h>
#include "symboltable.h"

entry_t** symbol_table;
entry_t** constant_table;

int current_dtype;
int yyerror(const char *s);
void yyerror(const char *s) {
    fprintf(stderr, "Error at line %d: %s\n", yylineno, s);
}

%}

%union {
    int ival;
    char *sval;
}

%token <sval> IDENTIFIER STRING
%token <ival> INTEGER

/* Keywords */
%token CLASS IMPORT PUBLIC PROTECTED MAIN

/* Data types */
%token INT REAL STR

%type <sval> identifier
%type <sval> class_name
%type <sval> library_name

%start program

%%

program:
    program class_definition
    | class_definition
    ;

class_definition:
    opt_public_protected CLASS class_name '{' opt_variable_declarations main_function '}'
    | error '{' opt_variable_declarations main_function '}' { yyerror("Syntax error in class definition"); }
    ;

opt_public_protected:
    PUBLIC { $$ = $1; }
    | PROTECTED { $$ = $1; }
    | /* empty */
    ;

class_name: IDENTIFIER { $$ = $1; }
    ;

opt_variable_declarations:
    variable_declarations
    | /* empty */
    ;

variable_declarations:
    variable_declarations variable_declaration
    | variable_declaration
    ;

variable_declaration:
    type identifier ';'
    ;

type:
    INT { $$ = $1; }
    | REAL { $$ = $1; }
    | STR { $$ = $1; }
    ;

identifier: IDENTIFIER { $$ = $1; }
    ;

main_function:
    MAIN '{' statements '}'
    ;

statements:
    statements statement
    | /* empty */
    ;

statement:
    expression ';'
    | declaration ';'
    | control_structure
    ;

expression:
    identifier '=' expression { $$ = $1; } // Basic assignment for now
    ;

declaration:
    type identifier { $$ = $1; }
    ;

control_structure:
    'if' '(' expression ')' statement %prec LOWER_THAN_ELSE
    | 'if' '(' expression ')' statement 'else' statement
    | 'while' '(' expression ')' statement
    ;

%%

#include "lex.yy.c"

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error opening file");
            return 1;
        }
    }

    symbol_table = create_table();
    constant_table = create_table();

    if (!yyparse()) {
        printf("\nParsing complete\n");
        display(symbol_table);
    } else {
        printf("\nParsing failed\n");
    }

    fclose(yyin);
    return 0;
}
