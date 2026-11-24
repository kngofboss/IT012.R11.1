.data
m1:      .asciiz "Thang "
m2:      .asciiz ": "
mt:      .asciiz "Tong: "
mm:      .asciiz "Thang cao nhat: "
lp:      .asciiz " ("
rp:      .asciiz ")"
nl:      .asciiz "\n"
bac_str: .asciiz "Bac "
reading: .word 1000, 1095, 1205, 1345, 1510, 1715, 1955
         .word 2210, 2440, 2625, 2775, 2895, 2995
usage:   .space 48
cnt:     .word 0, 0, 0, 0

.text
.globl main
main:
    la $s0, reading      # $s0 = dia chi nen reading
    la $s1, usage        # $s1 = dia chi nen usage
    addi $s2, $zero, 0   # i = 0
    addi $s3, $zero, 12  # n = 12 thang

CalcUsageLoop:
    beq $s2, $s3, DoneUsage

    sll $t1, $s2, 2
    add $t1, $t1, $s0
    lw  $t3, 0($t1)      # reading[i]
    lw  $t4, 4($t1)      # reading[i+1]
    sub $t5, $t4, $t3    # dien nang thang i+1

    sll $t2, $s2, 2
    add $t2, $t2, $s1
    sw  $t5, 0($t2)      # usage[i] = $t5

    li $v0, 4
    la $a0, m1
    syscall

    li $v0, 1
    addi $a0, $s2, 1
    syscall

    li $v0, 4
    la $a0, m2
    syscall

    li $v0, 1
    move $a0, $t5
    syscall

    li $v0, 4
    la $a0, nl
    syscall

    addi $s2, $s2, 1
    j CalcUsageLoop

DoneUsage:
    la $s1, usage        # $s1 = dia chi nen usage
    la $t6, cnt          # $t6 = dia chi nen cnt
    addi $s2, $zero, 0   # i = 0
    addi $s3, $zero, 12  # n = 12

CountTierLoop:
    beq $s2, $s3, PrintTiers

    sll $t1, $s2, 2
    add $t1, $t1, $s1
    lw  $t0, 0($t1)      # $t0 = usage[i]

    slti $t1, $t0, 101   # <= 100 -> bac 1 (index 0)
    bne  $t1, $zero, AddBac1

    slti $t1, $t0, 151   # <= 150 -> bac 2 (index 1)
    bne  $t1, $zero, AddBac2

    slti $t1, $t0, 201   # <= 200 -> bac 3 (index 2)
    bne  $t1, $zero, AddBac3

    addi $t2, $t6, 12    # dia chi cnt[3] (bac 4)
    j IncCnt

AddBac1:
    addi $t2, $t6, 0     # dia chi cnt[0] (bac 1)
    j IncCnt

AddBac2:
    addi $t2, $t6, 4     # dia chi cnt[1] (bac 2)
    j IncCnt

AddBac3:
    addi $t2, $t6, 8     # dia chi cnt[2] (bac 3)

IncCnt:
    lw   $t3, 0($t2)     # doc cnt[k-1]
    addi $t3, $t3, 1     # tang 1
    sw   $t3, 0($t2)     # ghi lai cnt[k-1]

    addi $s2, $s2, 1
    j CountTierLoop

PrintTiers:
    addi $s2, $zero, 0   # k_idx = 0 (in Bac 1..4)
    addi $s3, $zero, 4

PrintLoop:
    beq $s2, $s3, ExitProg

    li $v0, 4
    la $a0, bac_str
    syscall

    li $v0, 1
    addi $a0, $s2, 1     # <k> = 1..4
    syscall

    li $v0, 4
    la $a0, m2
    syscall

    sll $t1, $s2, 2
    add $t1, $t1, $t6
    lw  $a0, 0($t1)      # <so thang>
    li  $v0, 1
    syscall

    li $v0, 4
    la $a0, nl
    syscall

    addi $s2, $s2, 1
    j PrintLoop

ExitProg:
    li $v0, 10
    syscall
