SRC_DIR   := src
BIN_DIR   := bin
INC_DIR   := include
TEST_DIR  := tests

CC        := gcc
CFLAGS    := -I$(INC_DIR) -Wall -Wextra -O2
LDFLAGS   := -lcriterion

SRCS      := $(wildcard $(SRC_DIR)/*.c)
TEST_SRC  := $(TEST_DIR)/base_tests.c

.PHONY: all tests gcov clean

# build any standalone src/foo.c → bin/foo 
all: $(SRCS:$(SRC_DIR)/%.c=$(BIN_DIR)/%)

$(BIN_DIR)/%: $(SRC_DIR)/%.c | $(BIN_DIR)
	$(CC) $(CFLAGS) $< -o $@

# tests: build & run your Criterion test‐binary 
tests: $(BIN_DIR)/tests
	@echo "\n→ Running Criterion tests (10s max)…\n"
	@timeout 10s $(BIN_DIR)/tests

$(BIN_DIR)/tests: $(SRCS) $(TEST_SRC) | $(BIN_DIR)
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

# gcov: rebuild with coverage, rerun tests, then report 
gcov: CFLAGS += --coverage
gcov: LDFLAGS += --coverage
gcov: clean all tests
	@gcov $(SRC_DIR)/*.c

$(BIN_DIR):
	mkdir -p $@

clean:
	rm -rf $(BIN_DIR) *.gcda *.gcno *.gcov
