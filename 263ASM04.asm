;Author: Julianna Hensey
;Date: April 21, 2010
;Purpose: Initializes an array of integers in assembly language. Learning Exercise.
;Other: Kelsey helped with multiple parts of this program.

TITLE Program 4: Initializing Arrays
INCLUDE Irvine32.inc

.data

declare1 BYTE "This program initializes an array of integers",0
declare2 BYTE "This is the unsorted list:",0
prompt BYTE "Please enter an integer: ",0			;prompt for ints in the array
iArray DWORD 10 DUP (?)						;declare unintialized array
iArraySize = ($ - iArray)/4					;calculate size of array and store in iArraySize

.code
Main PROC

;declaration introducing purpose of program
lea edi,iArray		;ebx points to beginning of array
lea edx,declare1	;load first declaration to output
call WriteString	;display declare1
call Crlf		;carriage return	

;setup prompt loop
lea edx,prompt		;stores prompt in edx
mov ecx,iArraySize	;set loop counter

;prompt loop, stores integers in array
L1:			;loop 1
call WriteString	;display prompt
call ReadInt		;read user input and store in eax
mov [edi],eax		;store user integer in first part of array
add edi,TYPE iArray	;add size of type of intArray to edi to get to next address
Loop L1			;loop L1 

;declaration introducing output of Loop2
lea edx,declare2	;load second declaration to output
call WriteString	;display declare2
call Crlf		;carriage return
call Crlf		;carriage return

;setup echo loop
lea edi,iArray		;edi points to beginning of array
mov ecx,iArraySize	;set loop counter for loop 2

;echo loop, displays integers in array
L2:			;loop 2
mov eax,[edi]		;move value for current place in array into eax
call WriteInt		;display number
add edi,TYPE iArray	;increment to next address in array
call Crlf		;carriage return
Loop L2			;loop L2

;end program sequence
call WaitMsg		;ending message
push 0			;return 0
call ExitProcess
Main ENDP
END Main
