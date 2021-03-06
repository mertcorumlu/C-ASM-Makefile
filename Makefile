CC = cc
CC_FLAGS = 

NASM = NASM
NASM_FLAGS = -f elf64

BUILD_PATH = build/

PROGRAM = program

C_SRC = $(shell find . -name "*.c" -o -name "*.S" -o -name "*.s")
ASM_SRC = $(shell find . -name "*.asm")

ASM_OBJ = $(ASM_SRC:./%.asm=$(BUILD_PATH)obj/%.o)

.PHONY: clean clean_objs all

all: dir $(ASM_OBJ) $(PROGRAM) clean_objs

$(ASM_OBJ): $(ASM_SRC)
	@mkdir -p $(dir $@)
	@nasm $(NASM_FLAGS) $(patsubst $(BUILD_PATH)obj/%.o, %.asm, $@) -o $@

$(PROGRAM): $(C_SRC)
	@$(CC) $(CC_FLAGS) $^ $(ASM_OBJ) -o $(BUILD_PATH)$(PROGRAM) && make --no-print-directory run || rm -rf $(BUILD_PATH)

dir: 
	@mkdir -p $(BUILD_PATH)

run:
	@chmod +x $(BUILD_PATH)$(PROGRAM)
	@./$(BUILD_PATH)$(PROGRAM)

clean_objs:
	@rm -rf $(BUILD_PATH)obj/

clean:
	@rm -rf $(BUILD_PATH)