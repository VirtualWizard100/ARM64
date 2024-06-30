.include "socketMacros.s"

/*.equ AF_INET6, 10
.equ SOCK_STREAM, 1*/
.equ ipv6address, 0x98fb8585c318c974
.equ ipv6Len, 16

.global _start

_start:
	socket AF_INET6, SOCK_STREAM, 0
	adds x9, xzr, x0
loop:
	connect x9, ipv6address, ipv6Len
	b loop
