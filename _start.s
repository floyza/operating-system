  .global _start
  .type _start, @function

_start:
  mov $0x80000, %esp // setup the stack

  call kmain // call the kernel

  // halt the cpu
  cli
  hlt
