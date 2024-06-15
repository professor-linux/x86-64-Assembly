# Get the contents of /etc/hosts

.section .data
file_path: .asciz "/etc/hosts"
buffer: .space 256

.section .text
.global _start

_start:
    # sys_open: open the file
    mov $2, %rax             # syscall number for sys_open
    lea file_path(%rip), %rdi # first argument: file path
    mov $0, %rsi             # second argument: flags (O_RDONLY)
    syscall

    # save the file descriptor
    mov %rax, %rdi

    # sys_read: read the file
    mov $0, %rax             # syscall number for sys_read
    lea buffer(%rip), %rsi   # second argument: buffer to read into
    mov $255, %rdx           # third argument: number of bytes to read
    syscall

    # sys_write: write to stdout
    mov $1, %rax             # syscall number for sys_write
    mov $1, %rdi             # first argument: file descriptor (stdout)
    lea buffer(%rip), %rsi   # second argument: buffer to write
    syscall

    # sys_exit: exit the program
    mov $60, %rax            # syscall number for sys_exit
    xor %rdi, %rdi           # first argument: exit status (0)
    syscall
