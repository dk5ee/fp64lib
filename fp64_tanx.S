/* Copyright (c) 2020  Uwe Bissinger
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   * Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in
     the documentation and/or other materials provided with the
     distribution.
   * Neither the name of the copyright holders nor the names of
     contributors may be used to endorse or promote products derived
     from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
   LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
   POSSIBILITY OF SUCH DAMAGE. */

/* $Id$ */

#include "fp64def.h"
#include "asmdef.h"

/* float64_t fp64_tan (float64_t x);
     The fp64_tan() function returns the tangent of x, which is
     defined mathematically as sin(x) / cos(x).
 */

FUNCTION fp64_tan
ENTRY fp64_tan
	XCALL _U(__fp64_pushB)		; preserve registers

	push rA7					; save x
	push rA6
	push rA5
	push rA4
	push rA3
	push rA2
	push rA1
	push rA0

	XCALL _U(fp64_cos)			; calculate cos(x) 

	pop rB0						; restore x
	pop rB1	
	pop rB2
	pop rB3
	pop rB4
	pop rB5
	pop rB6
	pop rB7
	
	push rA7					; save cos(x)
	push rA6
	push rA5
	push rA4
	push rA3
	push rA2
	push rA1
	push rA0
	
	XCALL _U(__fp64_movAB)		; move x into A
	XCALL _U(fp64_sin)			; calculate sin(x) 
	
	pop rB0						; restore cos(x)
	pop rB1	
	pop rB2
	pop rB3
	pop rB4
	pop rB5
	pop rB6
	pop rB7
	
	XCALL _U(__fp64_isBzero)	; is cos(x) == 0?
	sec
	breq 1f						; yes, no need to calculate sin(x)/cos(x), return +/-Inf.

	XCALL _U(fp64_div)			; calculate sin(x)/cos(x)

1:	
	XJMP _U(__fp64_popBret)		; restore registers and return

ENDFUNC
