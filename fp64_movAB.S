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

/*  __fp64_movABx() move B into A
   Input:
	  rBE1.rBE0.rB7.rB6.rB5.rB4.rB3.rB2.rB1.rB0  - B in unpacked format 
   Return:
	  rAE1.rAE0.rA7.rA6.rA5.rA4.rA3.rA2.rA1.rA0  - a copy of B in unpacked format
   Modifies:
	  nothing - also SREG is preserved
 */

FUNCTION __fp64_movAB
ENTRY __fp64_movABx
   X_movw rAE0, rBE0

/*  __fp64_movAB() move B into A
   Input:
	  rB7.rB6.rB5.rB4.rB3.rB2.rB1.rB0  - B in packed format 
   Return:
	  rA7.rA6.rA5.rA4.rA3.rA2.rA1.rA0  - a copy of B in packed format
   Modifies:
	  nothing - also SREG is preserved
 */
ENTRY __fp64_movAB
   X_movw rA6, rB6		; A = B
   X_movw rA4, rB4
   X_movw rA2, rB2
   X_movw rA0, rB0
   ret
ENDFUNC
