// ARCH: riscv64

.section ".text.entry"

.option norvc

// void entry(uint64_t hartid, uint64_t dtb_table_ptr);
.type _entry, @function
.global _entry
_entry:
	/* just let one core do the job */
	bnez a0, _entry_L3

	/* Clear .bss */
	la t5, __bss_start
	la t6, __bss_end
_entry_L1:
	sd zero, (t5)
	addi t5, t5, 8
	bltu t5, t6, _entry_L1

_entry_L2:
	tail main

_entry_L3:
	la sp, multi_stack
	tail multi_main

.type spin, @function
.global spin
spin:
	j spin
	
.end
