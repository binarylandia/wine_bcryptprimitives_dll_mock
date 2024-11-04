BUILD_TIME=$(shell date -u '+%Y-%m-%d_%H-%M-%S')

CFLAGS=-g0 -Os
LDFLAGS=-shared

BUILD_DIR=.build
OUT_DIR=.out

SOURCES=src/main.c
OBJECTS=$(BUILD_DIR)/main.o

DLL_OUT=$(BUILD_DIR)/bcryptprimitives.dll
LIB_OUT=$(BUILD_DIR)/libbcryptprimitives.a
DEF_OUT=$(BUILD_DIR)/bcryptprimitives.def

GZ_OUT=$(OUT_DIR)/bcryptprimitives.dll-$(BUILD_TIME).gz


.PHONY: all clean dist

all: clean $(DLL_OUT) dist

$(DLL_OUT): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^ -Wl,--output-def,$(DEF_OUT),--out-implib,$(LIB_OUT)

$(BUILD_DIR)/%.o: src/%.c | $(BUILD_DIR)  # Ensured correct source path and added directory prerequisite
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR):  # Ensure directory exists before compiling objects
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(OUT_DIR) $(BUILD_DIR)

dist: $(DLL_OUT)
	mkdir -p $(OUT_DIR)
	gzip -c $(DLL_OUT) > $(GZ_OUT)
