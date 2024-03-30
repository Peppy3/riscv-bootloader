CROSS_COMPILE:=riscv64-linux-gnu-

AS:=$(CROSS_COMPILE)as
CC:=$(CROSS_COMPILE)gcc
LD:=$(CROSS_COMPILE)ld
OBJCOPY:=$(CROSS_COMPILE)objcopy

CFLAGS:= -Wall -Wextra -ffreestanding -ggdb -O1

SRC_DIR:=src
BUILD_DIR:=build

#####################################

OFILES:=$(BUILD_DIR)/entry.o $(BUILD_DIR)/main.o

#####################################

boot.bin: boot.elf
	$(OBJCOPY) $< -O binary $@

boot.elf: link.ld $(OFILES)
	$(LD) -static -Map out.map -T $+ -o $@

$(BUILD_DIR)/%.o:$(SRC_DIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o:$(SRC_DIR)/%.S
	$(CC) -c $< -o $@
