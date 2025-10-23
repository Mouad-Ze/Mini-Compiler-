# MiniL Language Documentation

## Overview

MiniL is a simple programming language designed for educational purposes. It features basic object-oriented concepts, control structures, and data types commonly found in modern programming languages.

## Language Syntax

### 1. Program Structure

A MiniL program consists of one or more class definitions:

```
program → class_definition+
```

### 2. Class Definitions

Classes are the main organizational unit in MiniL:

```
class_definition → [public|protected] class IDENTIFIER { 
    variable_declarations? 
    main_function 
}
```

**Example:**
```minil
public class MyClass {
    int x;
    main {
        x = 10;
    }
}
```

### 3. Access Modifiers

- `public`: Class is accessible from anywhere
- `protected`: Class has restricted access
- If no modifier is specified, default access is applied

### 4. Data Types

MiniL supports three basic data types:

- `int`: Integer numbers (e.g., `42`, `-10`, `0`)
- `real`: Real/floating-point numbers (e.g., `3.14`, `-2.5`, `0.0`)
- `str`: String literals (e.g., `"Hello"`, `"World"`)

### 5. Variable Declarations

Variables must be declared before use:

```
variable_declaration → type IDENTIFIER ;
```

**Example:**
```minil
int counter;
real pi;
str message;
```

### 6. Main Function

Every class must have a main function:

```
main_function → main { statements }
```

The main function contains the executable statements for the class.

### 7. Statements

MiniL supports several types of statements:

#### Assignment Statements
```minil
identifier = expression;
```

#### Variable Declarations
```minil
type identifier;
```

#### Control Structures
- `if` statements
- `while` loops

### 8. Expressions

Currently, MiniL supports basic assignment expressions:

```
expression → IDENTIFIER = expression
```

### 9. Control Structures

#### If Statements
```minil
if (expression) statement
if (expression) statement else statement
```

**Example:**
```minil
if (x > 0) {
    x = x + 1;
} else {
    x = 0;
}
```

#### While Loops
```minil
while (expression) statement
```

**Example:**
```minil
while (x < 10) {
    x = x + 1;
}
```

### 10. Comments

MiniL supports two types of comments:

- **Single-line comments**: `// This is a comment`
- **Multi-line comments**: `/* This is a multi-line comment */`

### 11. Import Statements

MiniL supports basic import functionality:

```minil
Import Library library_name;
```

**Example:**
```minil
Import Library MiniL.lang;
Import Library MiniL.io;
```

## Lexical Elements

### Identifiers

- Must start with a letter (`a-z`, `A-Z`)
- Can contain letters and digits
- Maximum length: 10 characters
- Case-sensitive

### Constants

- **Integers**: `[0-9]+`
- **Real numbers**: `[0-9]+.[0-9]*`
- **Strings**: `"[^"\n]*"`

### Keywords

- `class`, `public`, `protected`
- `main`, `int`, `real`, `str`
- `Import`, `Library`
- `if`, `while`, `else`

### Operators

- Arithmetic: `+`, `-`, `*`, `/`
- Assignment: `=`
- Comparison: `>`, `<`, `==`, `!=`

### Delimiters

- `;` (semicolon)
- `,` (comma)
- `(`, `)` (parentheses)
- `{`, `}` (braces)
- `[`, `]` (brackets)

## Error Handling

The MiniL compiler provides comprehensive error reporting:

1. **Syntax Errors**: Reported with line and column numbers
2. **Lexical Errors**: Illegal characters are flagged
3. **Comment Errors**: Unterminated comments are detected
4. **Semantic Errors**: Basic symbol table validation

## Example Programs

### Hello World
```minil
public class HelloWorld {
    int x;
    str message;
    
    main {
        x = 42;
        message = "Hello, World!";
    }
}
```

### Calculator Class
```minil
protected class Calculator {
    int result;
    real pi;
    
    main {
        pi = 3.14159;
        result = 10;
        
        if (result > 5) {
            result = result + 1;
        }
        
        while (result < 20) {
            result = result + 2;
        }
    }
}
```

### Import Example
```minil
Import Library MiniL.lang;

public class MathOperations {
    int a;
    int b;
    
    main {
        a = 10;
        b = 5;
        
        if (a > b) {
            a = a + b;
        }
    }
}
```

## Compiler Usage

### Building
```bash
make
```

### Running
```bash
./mini-compiler input.minil
```

### Verbose Mode
```bash
./mini-compiler -v input.minil
```

## Future Enhancements

Potential areas for language extension:

1. **Functions**: User-defined functions and methods
2. **Arrays**: Support for array data types
3. **More Operators**: Logical operators, bitwise operations
4. **Classes**: Inheritance, polymorphism
5. **Modules**: Better import/export system
6. **Error Handling**: Try-catch blocks
7. **I/O Operations**: Input/output functions

## Grammar Summary

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
