/* Runtime ABI for the ARM Cortex-M0  
 * uread4.S: unaligned memory read
 *
 * Copyright (c) 2017 Jörg Mische <bobbl@gmx.de>
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT
 * OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */



	.syntax unified
	.text
	.thumb
	.cpu cortex-m0



@ int __aeabi_uwrite4(int r0, void *r1)
@
@ Write 4 little endian bytes to unaligned memory address
@
	.thumb_func
	.global __aeabi_uwrite4
__aeabi_uwrite4:

	lsrs	r2, r1, #1
	bcc	.Lhalfword_aligned

	strb	r0, [r1]
	adds	r1, r1, #1
	lsrs	r0, r0, #8
	strh	r0, [r1]
	lsrs	r0, r0, #16
	strb	r0, [r1, #2]
	bx	lr

.Lhalfword_aligned:
	strh	r0, [r1]
	lsrs	r0, r0, #16
	strh	r0, [r1, #2]
	bx	lr
