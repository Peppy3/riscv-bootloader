#include <stddef.h>
#include <stdint.h>

#define LOAD_ADDR 0

typedef void (*kmain) (void);
volatile void *MULTI_JMP;

__attribute__ ((aligned (4096))) uint8_t main_stack[4096];

void main(uint64_t hartid, uint8_t *dtb_table) {
	
	MULTI_JMP = LOAD_ADDR;
	((kmain)LOAD_ADDR)();
}

__attribute__ ((aligned (4096))) uint8_t multi_stack[4096];

void multi_main(uint64_t hartid, uint8_t *dtb_table) {
	while (MULTI_JMP == NULL)
		;

	((kmain)MULTI_JMP)();
}
