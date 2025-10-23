# Compiler Architecture Documentation

## Overview

This Mini Compiler is implemented using traditional compiler construction tools:
- **Flex** (Fast Lexical Analyzer Generator) for lexical analysis
- **Bison** (GNU Parser Generator) for syntax analysis
- **C** for semantic analysis and code generation

## Architecture Components

### 1. Lexical Analyzer (`lex.l`)

The lexical analyzer is responsible for:
- Token recognition and classification
- Handling whitespace and comments
- Error detection for illegal characters
- Column tracking for error reporting

#### Key Features:
- **Token Types**: Identifiers, keywords, constants, operators, delimiters
- **Comment Handling**: Both single-line (`//`) and multi-line (`/* */`) comments
- **Error Reporting**: Line and column number tracking
- **Symbol Table Integration**: Automatic insertion of identifiers and constants

#### Token Categories:
```c
// Keywords
CLASS, PUBLIC, PROTECTED, MAIN, IMPORT, LIBRARY

// Data Types  
INT, REAL, STR, STRING

// Identifiers and Constants
IDENTIFIER, INTEGER, REAL, STRING

// Operators
PLUS, MINUS, MULT, DIV

// Delimiters
SEMICOLON, COMMA, LPAREN, RPAREN, LBRACE, RBRACE, LBRACKET, RBRACKET
```

### 2. Parser (`bis.y`)

The parser implements the grammar rules for MiniL:

#### Grammar Rules:
```
program → class_definition+

class_definition → [public|protected] class IDENTIFIER { 
    variable_declarations? main_function 
}

variable_declarations → variable_declaration+

variable_declaration → type IDENTIFIER ;

type → int | real | str

main_function → main { statements }

statements → statement*

statement → expression ; | declaration ; | control_structure

expression → IDENTIFIER = expression

control_structure → if ( expression ) statement [else statement] 
                  | while ( expression ) statement
```

#### Key Features:
- **Error Recovery**: Basic error handling with recovery
- **Symbol Table Management**: Integration with symbol table
- **Semantic Actions**: Code generation hooks for future extensions

### 3. Symbol Table (`symboltable.h`)

The symbol table manages identifiers and constants:

#### Data Structures:
```c
typedef struct entry {
    char *name;           // Symbol name
    token_type_t type;    // Token type
    int scope_level;      // Scope level (for future use)
    struct entry *next;   // Hash table collision handling
} entry_t;
```

#### Operations:
- `create_table()`: Initialize symbol table
- `insert()`: Add new symbol
- `lookup()`: Find existing symbol
- `display()`: Print symbol table contents
- `free_table()`: Clean up memory

#### Hash Table Implementation:
- **Size**: 100 buckets
- **Hash Function**: DJB2 algorithm
- **Collision Handling**: Chaining

### 4. Error Handling

The compiler provides comprehensive error reporting:

#### Error Types:
1. **Lexical Errors**: Illegal characters, unterminated comments
2. **Syntax Errors**: Grammar violations
3. **Semantic Errors**: Undefined symbols (future enhancement)

#### Error Reporting:
- Line and column number tracking
- Descriptive error messages
- Graceful error recovery

## Compilation Process

### Phase 1: Lexical Analysis
1. Input source code is read character by character
2. Tokens are recognized using regular expressions
3. Identifiers and constants are inserted into symbol tables
4. Comments are filtered out
5. Error detection for illegal characters

### Phase 2: Syntax Analysis
1. Tokens are parsed according to grammar rules
2. Parse tree is constructed
3. Semantic actions are executed
4. Error recovery is performed for syntax errors

### Phase 3: Semantic Analysis (Basic)
1. Symbol table validation
2. Type checking (future enhancement)
3. Scope analysis (future enhancement)

### Phase 4: Code Generation (Future)
1. Intermediate code generation
2. Target code generation
3. Optimization

## Build Process

### Dependencies:
- **Flex**: Generates `lex.yy.c` from `lex.l`
- **Bison**: Generates `bis.tab.c` and `bis.tab.h` from `bis.y`
- **GCC**: Compiles generated C code

### Build Steps:
1. `flex lex.l` → `lex.yy.c`
2. `bison -d bis.y` → `bis.tab.c`, `bis.tab.h`
3. `gcc -o mini-compiler bis.tab.c lex.yy.c -lfl`

### Makefile Targets:
- `make`: Build the compiler
- `make clean`: Remove generated files
- `make test`: Run example programs
- `make debug`: Build with debug symbols

## File Organization

```
├── lex.l              # Flex lexical analyzer specification
├── bis.y              # Bison parser specification  
├── symboltable.h      # Symbol table implementation
├── Makefile          # Build configuration
├── examples/         # Example MiniL programs
│   ├── hello.minil   # Basic example
│   ├── class.minil   # Class definition example
│   └── import.minil  # Import example
├── docs/             # Documentation
│   ├── language-syntax.md
│   └── architecture.md
└── README.md         # Project overview
```

## Future Enhancements

### Phase 1: Enhanced Semantic Analysis
- Type checking
- Scope management
- Function definitions
- Array support

### Phase 2: Code Generation
- Intermediate representation (IR)
- Target code generation
- Basic optimizations

### Phase 3: Advanced Features
- Object-oriented features
- Exception handling
- Standard library
- Debugging support

## Testing Strategy

### Unit Tests:
- Lexical analyzer token recognition
- Parser grammar validation
- Symbol table operations

### Integration Tests:
- Complete compilation of example programs
- Error handling verification
- Performance benchmarks

### Test Files:
- Valid programs: `examples/*.minil`
- Invalid programs: `tests/error_*.minil`
- Edge cases: `tests/edge_*.minil`

## Performance Considerations

### Lexical Analysis:
- Efficient regular expression matching
- Minimal memory allocation
- Fast symbol table insertion

### Parsing:
- LALR(1) grammar for efficient parsing
- Minimal parse tree construction
- Error recovery without backtracking

### Memory Management:
- Hash table for O(1) symbol lookup
- Automatic memory cleanup
- Minimal memory leaks

## Debugging Support

### Verbose Mode:
- Token-by-token processing output
- Symbol table state tracking
- Parse tree construction details

### Error Messages:
- Clear, descriptive error descriptions
- Precise line and column information
- Suggested fixes (future enhancement)

### Debug Symbols:
- GCC debug information (`-g` flag)
- Symbol table inspection
- Parse state debugging
