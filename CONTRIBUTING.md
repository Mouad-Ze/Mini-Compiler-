# Contributing to Mini Compiler

Thank you for your interest in contributing to the Mini Compiler project! This document provides guidelines for contributing to the project.

## Getting Started

### Prerequisites
- Flex (Fast Lexical Analyzer Generator)
- Bison (GNU Parser Generator)
- GCC (GNU Compiler Collection)
- Make
- Git

### Setting Up Development Environment

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/your-username/mini-compiler.git
   cd mini-compiler
   ```

3. Build the project:
   ```bash
   make
   ```

4. Run tests:
   ```bash
   make test
   ```

## Development Guidelines

### Code Style
- Use consistent indentation (4 spaces)
- Follow C99 standard
- Add comments for complex logic
- Use meaningful variable names

### File Organization
- Keep lexical analysis code in `lex.l`
- Keep grammar rules in `bis.y`
- Symbol table operations in `symboltable.h`
- Add new examples in `examples/` directory

### Testing
- Test your changes with existing examples
- Add new test cases for new features
- Ensure error handling works correctly
- Test on different platforms if possible

## Areas for Contribution

### High Priority
1. **Enhanced Error Messages**: More descriptive error reporting
2. **Type Checking**: Implement proper type validation
3. **Function Support**: Add function definitions and calls
4. **Array Support**: Implement array data types

### Medium Priority
1. **Code Generation**: Generate intermediate or target code
2. **Optimization**: Basic compiler optimizations
3. **Standard Library**: Built-in functions and types
4. **Better Documentation**: Improve existing docs

### Low Priority
1. **IDE Integration**: Language server protocol support
2. **Performance Improvements**: Optimize parsing and analysis
3. **Cross-platform Support**: Ensure compatibility across platforms
4. **Advanced Features**: Inheritance, polymorphism, etc.

## Submitting Changes

### Pull Request Process
1. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes and test them:
   ```bash
   make clean && make
   make test
   ```

3. Commit your changes:
   ```bash
   git add .
   git commit -m "Add: Brief description of your changes"
   ```

4. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

5. Create a Pull Request on GitHub

### Commit Message Format
Use clear, descriptive commit messages:
- `Add: Feature description`
- `Fix: Bug description`
- `Update: Change description`
- `Remove: Removal description`

## Reporting Issues

### Bug Reports
When reporting bugs, please include:
- Description of the problem
- Steps to reproduce
- Expected vs actual behavior
- System information (OS, compiler versions)
- Sample code that demonstrates the issue

### Feature Requests
For feature requests, please include:
- Description of the proposed feature
- Use case and motivation
- Potential implementation approach
- Any relevant examples

## Code Review Process

### Review Criteria
- Code correctness and functionality
- Adherence to project style guidelines
- Test coverage and quality
- Documentation updates
- Performance implications

### Review Process
1. All pull requests require review
2. Address reviewer feedback promptly
3. Ensure all tests pass
4. Update documentation as needed

## Development Workflow

### Branch Naming
- `feature/description`: New features
- `fix/description`: Bug fixes
- `docs/description`: Documentation updates
- `refactor/description`: Code refactoring

### Testing Workflow
1. Write tests for new functionality
2. Ensure existing tests still pass
3. Test with various example programs
4. Verify error handling works correctly

## Resources

### Documentation
- [Flex Manual](https://www.gnu.org/software/flex/manual/)
- [Bison Manual](https://www.gnu.org/software/bison/manual/)
- [Compiler Design Principles](https://en.wikipedia.org/wiki/Compiler)

### Tools
- Flex: Lexical analyzer generator
- Bison: Parser generator
- GCC: C compiler
- Make: Build automation

## License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project.

## Questions?

If you have questions about contributing, please:
- Open an issue for discussion
- Check existing documentation
- Review closed issues for similar questions

Thank you for contributing to the Mini Compiler project!
