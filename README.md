# Mini Compiler Project

A simple compiler implementation for a custom programming language called "MiniL" built using Flex (lexical analyzer) and Bison (parser generator).

## Overview

This project implements a basic compiler that can parse and analyze a simple programming language with the following features:

- **Lexical Analysis**: Token recognition for keywords, identifiers, constants, and operators
- **Syntax Analysis**: Grammar parsing using Bison
- **Symbol Table Management**: Tracking identifiers and constants
- **Error Handling**: Basic error reporting with line and column information

## Language Features

### Keywords
- `Import` - Import statements
- `Library` - Library declarations
- `public` / `protected` - Access modifiers
- `class` - Class definitions
- `main` - Main function

### Data Types
- `int` - Integer type
- `real` - Real/floating-point type
- `str` - String type

### Syntax Elements
- Class definitions with access modifiers
- Variable declarations
- Basic expressions and assignments
- Control structures (if, while)
- Comments (single-line `//` and multi-line `/* */`)

## Project Structure

```
├── lex.l              # Flex lexical analyzer specification
├── bis.y              # Bison parser specification
├── symboltable.h      # Symbol table header file
├── Makefile          # Build configuration
├── examples/         # Example source files
│   ├── hello.minil   # Basic example
│   └── class.minil   # Class definition example
└── README.md         # This file
```

## Prerequisites

- **Flex** (Fast Lexical Analyzer Generator)
- **Bison** (GNU Parser Generator)
- **GCC** (GNU Compiler Collection)
- **Make** (Build automation tool)

### Installation on Windows
```bash
# Using Chocolatey
choco install flex bison make gcc

# Or using MSYS2
pacman -S flex bison make gcc
```

### Installation on Linux/macOS
```bash
# Ubuntu/Debian
sudo apt-get install flex bison make gcc

# macOS with Homebrew
brew install flex bison make gcc
```

## Building the Compiler

1. Clone the repository:
```bash
git clone <repository-url>
cd mini-compiler
```

2. Build the compiler:
```bash
make
```

This will generate the executable `mini-compiler`.

## Usage

### Basic Usage
```bash
./mini-compiler input.minil
```

### Verbose Mode
```bash
./mini-compiler -v input.minil
```

### Example
```bash
./mini-compiler examples/hello.minil
```

## Example Programs

### Hello World (`examples/hello.minil`)
```minil
public class HelloWorld {
    int x;
    
    main {
        x = 42;
    }
}
```

### Class Definition (`examples/class.minil`)
```minil
protected class Calculator {
    int result;
    real pi;
    
    main {
        pi = 3.14159;
        result = 10;
    }
}
```

## Language Grammar

The compiler recognizes the following grammar:

```
program → class_definition+
class_definition → [public|protected] class IDENTIFIER { variable_declarations? main_function }
variable_declarations → variable_declaration+
variable_declaration → type IDENTIFIER ;
type → int | real | str
main_function → main { statements }
statements → statement*
statement → expression ; | declaration ; | control_structure
expression → IDENTIFIER = expression
control_structure → if ( expression ) statement [else statement] | while ( expression ) statement
```

## Development

### Adding New Features

1. **Lexical Analysis**: Add new token patterns in `lex.l`
2. **Syntax Analysis**: Extend grammar rules in `bis.y`
3. **Semantic Analysis**: Modify symbol table operations

### Testing

Create test files with `.minil` extension and run:
```bash
./mini-compiler test.minil
```

## Error Handling

The compiler provides:
- Line and column number reporting
- Syntax error detection
- Unterminated comment detection
- Illegal character detection

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## Acknowledgments

- Built using Flex and Bison
- Inspired by compiler design principles
- Educational project for Compilers course
