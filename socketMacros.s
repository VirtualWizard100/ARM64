.equ AF_INET, 0x2
.equ AF_INET6, 0xa
.equ SOCK_STREAM, 1
.equ SOCK_DGRAM, 2

/* Creates the initial socket file with the TCP/UDP L4 header and port number- */
/* which is usually 0 for tcp to tell the socket to assign any port number */
.macro socket ipAddressVersion, transportType, port /* Server side linux syscall */
	ldr x0, =\ipAddressVersion
	ldr x1, =\transportType
	mov x2, #\port
	mov x8, #0xc6
	svc 0
.endm

.macro socketpair ipaddress, transportType, port, fd
	ldr x0, =\ipaddress
	ldr x1, =transportType
	mov x2, =\port
	mov x3, \fd
	mov x8, #0xc7
	svc 0
.endm

/* Adds your IP Address to the file descriptor previously made by the socket macro */
/* as well as the byte length of your IP Address */
.macro bind fd, sockAddr, sockAddrByteLength /*Server side linux syscall */
	mov x0, \fd
	ldr x1, =\sockAddr
	ldr x2, =\sockAddrByteLength
	mov x8, #0xc8
	svc 0
/*	li x0, #0
.ifeq
	mov x0, #1
	ldr x1, =message
	ldr x2, =len
	mov x8, #0x40
	svc 0
.endif*/
.endm

/* Preferred in a while loop to connect to the client that will invoke the- */
/* connect macro, this is the syn (sync) step in the three way handshake */
.macro listen fd, backlogNumber /* Server side linux syscall */
	mov x0, \fd
	mov x1, #\backlogNumber /* Backlog is the integer amount of queued connections beside the initial connection with the client with other clients, for example, a chat room */
	mov x8, #0xc9
	svc 0
.endm

/* This is the syn ack (sync acknowledge) step in the three way handshake */
.macro connect fd, sockAddr, sockAddrLength /* Client side linux syscall */
	mov x0, \fd
	ldr x1, =\sockAddr
	ldr x2, =\sockAddrLength
	mov x8, #0xcb
	svc 0
.endm

/* This is the ack (acknowledge) step in the three way handshake */
.macro accept fd, recieverAddr, recieverAddrLength /* Server side linux syscall */
	mov x0, \fd
	ldr x1, =\recieverAddr
	ldr x2, =\recieverAddrLength
	mov x8, #0xca
.endm

.macro getSocketNameMan fd, sockAddr, sockAddrLength
	mov x0, \fd
	ldr x1, =\sockAddr
	ldr x2, =\sockAddrLength
	mov x8, #0xcc
	svc 0
.endm

/*.data
message:
	.acsiz "Connection successful\n"
len = .-message
*/
