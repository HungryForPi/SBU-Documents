# This is the Makefile responsible for compiling your code
# Only make changes here if you know what your are doing.

# As a reminder, compiler your code with "make" and clean up
# with "make clean"
SRC_DIR := src
BUILD_DIR := build

SRCS := $(wildcard $(SRC_DIR)/*.c)
EXES := $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%,$(SRCS))

CC := gcc
CFLAGS := -Iinclude -Wall -O2

.PHONY: all clean

all: $(EXES)

$(BUILD_DIR)/%: $(SRC_DIR)/%.c | $(BUILD_DIR)
	$(CC) $(CFLAGS) $< -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)