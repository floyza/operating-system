ENTRY(_start)
 
SECTIONS {
	. = 0x100000;

	_kernel_start = .;

	.multiboot.data : {
	  *(.multiboot.data)
  }

	.multiboot.text : {
	  *(.multiboot.text)
  }

	. += 0xC0000000;
 
	.text ALIGN(4K) : AT (ADDR (.text) - 0xC0000000) {
		KEEP(*(.multiboot.data))
		*(.text .text.*)
	}
 
	.rodata ALIGN(4K) : AT (ADDR (.rodata) - 0xC0000000) {
		*(.rodata .rodata.*)
	}
 
	.data ALIGN(4K) : AT (ADDR (.data) - 0xC0000000) {
		*(.data .data.*)
	}
 
	.bss ALIGN(4K) : AT (ADDR (.bss) - 0xC0000000) {
		*(COMMON)
		*(.bss .bss.*)
		*(.bootstrap_stack)
	}
	_kernel_end = .;
}
