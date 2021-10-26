  .set ALIGN, 1 << 0
  .set MEMINFO, 1 << 1
  .set MAGIC, 0x1BADB002
  .set FLAGS, ALIGN | MEMINFO
  .set CHECKSUM, -(MAGIC + FLAGS)

  .section .multiboot.data, "aw"
  .align 4
  .long MAGIC
  .long FLAGS
  .long CHECKSUM

  .section .bootstrap_stack, "aw", @nobits
stack_bottom:
  .skip 16384 // 16 KiB
stack_top:

  .section .bss, "aw", @nobits
  .align 4096
boot_page_directory:
  .skip 4096
boot_page_table1:
  .skip 4096
  // we only keep a single page table because our kernel memory usage <= 3 MiB
  // and each page holds 4 MiB

  .section .multiboot.text, "a"
  .global _start
  .type _start, @function
_start:
  // Page the first 1023 double words (16 bit), setting them both present, readable and writable
  // FIXME: .rodata and .text should NOT be writable
  //movl $(0x100000 | 3), %eax
  movl $0, %eax
  movl $1023, %ecx
  movl $(boot_page_table1 - 0xC0000000), %edi
.nextPage:
  // should be able to use stosd instead?
  cmpl $_kernel_start, %eax
  jl .skipWrite
  cmpl $(_kernel_end - 0xC0000000), %eax
  jge .donePaging
  movl %eax, %edx
  orl $3, %edx
  movl %edx, (%edi)
.skipWrite:
  addl $4, %edi
  addl $0x1000, %eax
  loop .nextPage
.donePaging:

  // Page VGA in the last remaining page, from 0x000B8000 to 0xC03FF000, as present and r/w
  movl $(0xB8000 | 3), boot_page_table1 - 0xC0000000 + 1023 * 4

  // Identity mapping
  movl $(boot_page_table1 - 0xC0000000 + 3), boot_page_directory - 0xC0000000 + 0

  // Map onto 0xC0000000
  movl $(boot_page_table1 - 0xC0000000 + 3), boot_page_directory - 0xC0000000 + 768*4

  // Enable paging, set protection bit, and set read-only enforcement for supervisor
  movl $(boot_page_directory - 0xC0000000), %ecx
  movl %ecx, %cr3
  movl %cr0, %eax
  orl $0x80010001, %eax
  movl %eax, %cr0

  lea paged, %ecx
  jmp *%ecx

.section .text
paged:
  // Remove identity mapping
  movl $0, boot_page_directory + 0

  // Reload cr3 to force a TLB flush to reload page directory
  movl %cr3, %eax
  movl %eax, %cr3

  movl $stack_top, %esp // setup stack

  // enable SSE (https://wiki.osdev.org/SSE)
  // TODO: check for SSE support with cpuid before enabling it
  movl %cr0, %eax
  andw $(~(1 << 2)), %ax   //clear coprocessor emulation CR0.EM
  orw $(1 << 1), %ax   //set coprocessor monitoring  CR0.MP
  movl %eax, %cr0
  movl %cr4, %eax
  orw $(3 << 9), %ax  //set CR4.OSFXSR (1 << 9) and CR4.OSXMMEXCPT (1 << 10) at the same time
  movl %eax, %cr4

  call kmain

  cli
  hlt
