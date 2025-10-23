#ifndef SYMBOLTABLE_H
#define SYMBOLTABLE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Maximum size of symbol table
#define TABLE_SIZE 100

// Token types
typedef enum {
    IDENTIFIER = 1,
    INTEGER,
    REAL,
    STRING,
    CLASS,
    PUBLIC,
    PROTECTED,
    MAIN,
    IMPORT,
    LIBRARY,
    LIBRARY_NAME,
    INT,
    STR,
    PLUS,
    MINUS,
    MULT,
    DIV,
    SEMICOLON,
    COMMA,
    LPAREN,
    RPAREN,
    LBRACE,
    RBRACE,
    LBRACKET,
    RBRACKET
} token_type_t;

// Symbol table entry structure
typedef struct entry {
    char *name;
    token_type_t type;
    int scope_level;
    struct entry *next;
} entry_t;

// Function declarations
entry_t** create_table(void);
void insert(entry_t **table, const char *name, token_type_t type);
entry_t* lookup(entry_t **table, const char *name);
void display(entry_t **table);
void free_table(entry_t **table);
unsigned int hash(const char *str);

// Global symbol table functions
entry_t** create_table(void) {
    entry_t **table = (entry_t**)calloc(TABLE_SIZE, sizeof(entry_t*));
    if (!table) {
        fprintf(stderr, "Error: Unable to allocate memory for symbol table\n");
        exit(1);
    }
    return table;
}

void insert(entry_t **table, const char *name, token_type_t type) {
    if (!table || !name) return;
    
    unsigned int index = hash(name) % TABLE_SIZE;
    entry_t *entry = (entry_t*)malloc(sizeof(entry_t));
    
    if (!entry) {
        fprintf(stderr, "Error: Unable to allocate memory for symbol table entry\n");
        return;
    }
    
    entry->name = strdup(name);
    entry->type = type;
    entry->scope_level = 0; // Default scope level
    entry->next = table[index];
    table[index] = entry;
}

entry_t* lookup(entry_t **table, const char *name) {
    if (!table || !name) return NULL;
    
    unsigned int index = hash(name) % TABLE_SIZE;
    entry_t *entry = table[index];
    
    while (entry) {
        if (strcmp(entry->name, name) == 0) {
            return entry;
        }
        entry = entry->next;
    }
    
    return NULL;
}

void display(entry_t **table) {
    if (!table) return;
    
    printf("\n=== Symbol Table ===\n");
    int empty = 1;
    
    for (int i = 0; i < TABLE_SIZE; i++) {
        entry_t *entry = table[i];
        if (entry) {
            empty = 0;
            printf("Bucket %d:\n", i);
            while (entry) {
                printf("  %s (type: %d, scope: %d)\n", 
                       entry->name, entry->type, entry->scope_level);
                entry = entry->next;
            }
        }
    }
    
    if (empty) {
        printf("Symbol table is empty\n");
    }
    printf("===================\n\n");
}

void free_table(entry_t **table) {
    if (!table) return;
    
    for (int i = 0; i < TABLE_SIZE; i++) {
        entry_t *entry = table[i];
        while (entry) {
            entry_t *next = entry->next;
            free(entry->name);
            free(entry);
            entry = next;
        }
    }
    free(table);
}

unsigned int hash(const char *str) {
    unsigned int hash = 5381;
    int c;
    
    while ((c = *str++)) {
        hash = ((hash << 5) + hash) + c; // hash * 33 + c
    }
    
    return hash;
}

#endif // SYMBOLTABLE_H
