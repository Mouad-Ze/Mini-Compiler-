# Makefile for Mini Compiler Project

# Compiler and tools
CC = gcc
FLEX = flex
BISON = bison
CFLAGS = -Wall -Wextra -std=c99 -g
LDFLAGS = -lfl

# Project files
LEX_FILE = lex.l
YACC_FILE = bis.y
HEADER_FILE = symboltable.h
TARGET = mini-compiler

# Generated files
LEX_C = lex.yy.c
YACC_C = bis.tab.c
YACC_H = bis.tab.h

# Default target
all: $(TARGET)

# Build the main executable
$(TARGET): $(LEX_C) $(YACC_C) $(HEADER_FILE)
	$(CC) $(CFLAGS) -o $(TARGET) $(YACC_C) $(LEX_C) $(LDFLAGS)

# Generate lexer from Flex specification
$(LEX_C): $(LEX_FILE)
	$(FLEX) $(LEX_FILE)

# Generate parser from Bison specification
$(YACC_C) $(YACC_H): $(YACC_FILE)
	$(BISON) -d $(YACC_FILE)

# Clean generated files
clean:
	rm -f $(LEX_C) $(YACC_C) $(YACC_H) $(TARGET)
	rm -f *.o
	rm -f core

# Clean everything including examples
distclean: clean
	rm -f examples/*.out

# Install dependencies (Ubuntu/Debian)
install-deps-ubuntu:
	sudo apt-get update
	sudo apt-get install flex bison make gcc

# Install dependencies (macOS with Homebrew)
install-deps-macos:
	brew install flex bison make gcc

# Install dependencies (Windows with Chocolatey)
install-deps-windows:
	choco install flex bison make gcc

# Run tests
test: $(TARGET)
	@echo "Running basic tests..."
	@if [ -f examples/hello.minil ]; then \
		echo "Testing hello.minil:"; \
		./$(TARGET) examples/hello.minil; \
	fi
	@if [ -f examples/class.minil ]; then \
		echo "Testing class.minil:"; \
		./$(TARGET) examples/class.minil; \
	fi

# Create examples directory and sample files
setup-examples:
	mkdir -p examples
	@echo "Creating example files..."

# Debug build
debug: CFLAGS += -DDEBUG -g3
debug: $(TARGET)

# Release build
release: CFLAGS += -O2 -DNDEBUG
release: clean $(TARGET)

# Show help
help:
	@echo "Available targets:"
	@echo "  all          - Build the compiler (default)"
	@echo "  clean        - Remove generated files"
	@echo "  distclean    - Remove all generated files and outputs"
	@echo "  test         - Run basic tests"
	@echo "  debug        - Build with debug symbols"
	@echo "  release      - Build optimized release version"
	@echo "  install-deps-ubuntu  - Install dependencies on Ubuntu/Debian"
	@echo "  install-deps-macos   - Install dependencies on macOS"
	@echo "  install-deps-windows - Install dependencies on Windows"
	@echo "  help         - Show this help message"

# Phony targets
.PHONY: all clean distclean test debug release help install-deps-ubuntu install-deps-macos install-deps-windows setup-examples
