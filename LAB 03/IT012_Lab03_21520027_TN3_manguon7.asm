# Ma nguon 7 - Tong hop ba thang voi du lieu nhap tu ban phim
.data
prompt: .asciiz "Nhap chi so (kWh): "
m1:     .asciiz "Thang 1: "
m2:     .asciiz "Thang 2: "
m3:     .asciiz "Thang 3: "
tot:    .asciiz "Tong: "
nl:     .asciiz "\n"

.text
.globl main
main:
    # --- 1. ??c 4 ch? s? công t? t? bàn phím vào $s0 ??n $s3 ---
    # Nh?p reading0 vào $s0
    li      $v0, 4
    la      $a0, prompt
    syscall
    li      $v0, 5
    syscall
    add     $s0, $v0, $zero

    # Nh?p reading1 vào $s1
    li      $v0, 4
    la      $a0, prompt
    syscall
    li      $v0, 5
    syscall
    add     $s1, $v0, $zero

    # Nh?p reading2 vào $s2
    li      $v0, 4
    la      $a0, prompt
    syscall
    li      $v0, 5
    syscall
    add     $s2, $v0, $zero

    # Nh?p reading3 vào $s3
    li      $v0, 4
    la      $a0, prompt
    syscall
    li      $v0, 5
    syscall
    add     $s3, $v0, $zero

    # --- 2. Tính toán ?i?n n?ng tiêu th? ---
    sub     $t0, $s1, $s0       # usage1 = reading1 - reading0
    sub     $t1, $s2, $s1       # usage2 = reading2 - reading1
    sub     $t2, $s3, $s2       # usage3 = reading3 - reading2
    add     $t3, $t0, $t1       # total = usage1 + usage2
    add     $t3, $t3, $t2       # total = total + usage3

    # --- 3. In k?t qu? ra màn hình theo ?úng ??nh d?ng ---
    # In Tháng 1
    li      $v0, 4
    la      $a0, m1
    syscall
    li      $v0, 1
    add     $a0, $t0, $zero
    syscall
    li      $v0, 4
    la      $a0, nl
    syscall

    # In Tháng 2
    li      $v0, 4
    la      $a0, m2
    syscall
    li      $v0, 1
    add     $a0, $t1, $zero
    syscall
    li      $v0, 4
    la      $a0, nl
    syscall

    # In Tháng 3
    li      $v0, 4
    la      $a0, m3
    syscall
    li      $v0, 1
    add     $a0, $t2, $zero
    syscall
    li      $v0, 4
    la      $a0, nl
    syscall

    # In T?ng
    li      $v0, 4
    la      $a0, tot
    syscall
    li      $v0, 1
    add     $a0, $t3, $zero
    syscall
    li      $v0, 4
    la      $a0, nl
    syscall

    # --- 4. K?t thúc ch??ng trình ---
    li      $v0, 10
    syscall