.include "socketMacros.s"
.include "fileMacros.s"

/* SOCK_STREAM is TCP */
/* AF_INET6 is IPv6 */

.equ ipv6address, 0x98fb8585c318c974
.equ ipv6Len, 16

.global _start

_start:
	socket AF_INET6, SOCK_STREAM, 4444 /* int of IP type, int of Socket type, port number */
	mov x9, x0 /* int file descriptor */
	bind x9, ipv6address, ipv6Len /* int file descriptor, hex ipv6address, int byteLength */
loop:
	listen x9, 0
	cmp x0, #0
/*	write 1, message, len */
	b loop

.data
message:
	.asciz "Connection successful\n"
len = .-message

