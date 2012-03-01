;Author: Julianna Hensey
;Date: April 21, 2010
;Purpose: Initializes an array of integers in assembly language. Learning Exercise.

TITLE Program 5: Sorting Arrays
INCLUDE Irvine32.inc

.data

header   BYTE "This program works with an array of integers",0
unsorted BYTE "This is the unsorted list:",0
sorted 	 BYTE "This is the sorted list:",0
select	 BYTE "Do you want to see SORTED or UNSORTED list? Reply S or U: ",0
crepeat	 BYTE "Repeat program? Reply Y or N: ",0
error	 BYTE "Invalid response",0
prompt	 BYTE "Please enter an integer: ",0	;prompt for ints in the array
SortedCount DWORD ?				;count variable storage for LOOP2
iArray DWORD 10 DUP (?)				;declare unintialized array
iArraySize = ($ - iArray)/TYPE Array		;calculate array size

.code
Main PROC

START:			;jump point for repeat program

;declaration introducing purpose of program
lea edi,iArray		;edi points to beginning of array
call Crlf		;carriage return
call Crlf		;carriage return
lea edx,header		;load header declaration to output
call WriteString	;display header
call Crlf		;carriage return	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;PROMPTU;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;PROMPTU setup (prompt for integers)
lea edx,prompt		;stores prompt in edx
mov ecx,iArraySize	;set loop counter

;PROMPTU
PROMPTU:		;loop PROMPTU
call WriteString	;display prompt
call ReadInt		;read user input and store in eax
mov [edi],eax		;store user integer in current part of array
add edi,TYPE iArray	;add size of type of intArray to edi to get to next address
Loop PROMPTU		;loop back 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;SORTCHOICE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SORTCHOICE (User choice sorted/unsorted)
SORTCHOICE:
call Crlf		;carriage return
lea edx,select		;load prompt into edx
call WriteString	;display select prompt
call ReadChar		;read response from user
call WriteChar		;display character
call Crlf		;carriage return
cmp al, 'u'		;if unsorted
je UNSORTEDL		;jump to loop to display unsorted
cmp al, 'U'		;if unsorted
je UNSORTEDL		;jump to loop to display unsorted
cmp al, 's'		;if sorted
je SORTEDL		;jump to sorted
cmp al, 'S'		;if sorted
je SORTEDL		;jump to sorted

;if invalid character given
lea edx,error		;load error message into edx
call WriteString	;display error message
loop SORTCHOICE		;loop back & display prompt/receive input

;;;;;;;;;;;;;;;;;;;;;;;;;;;;UNSORTED;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;UNSORTED setup (unsorted list)
UNSORTEDL:
call Crlf		;carriage return
lea edx,unsorted	;load unsorted declaration to output
call WriteString	;display unsorted declaration
call Crlf		;carriage return
jmp DISPLAY		;jump to display list loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;SORTED;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;SORTED setup (sorted list)
SORTEDL:
lea edi,iArray		;edi points to beginning of array
lea esi,iArray		;esi points to beginning of array
mov ecx,iArraySize	;make counter for ecx

;SORTED loop

LOOP2:			;loop SORTED
mov SortedCOUNT,ecx	;save outer loop counter and keep decremented
			;ecx for innerloop counter
INNERLOOP2:
mov eax,[edi]		;stores literal of edi into eax
mov edx,[esi]		;stores literal of esi into ebx
cmp eax,edx		;compares edi and esi
jle UPDATEesi 		;jumps to moving esi to next value
push [edi]		;remove value edi
push [esi]		;remove value esi
pop [edi]		;puts edi value on first
pop [esi] 		;puts esi value on top

;update ESI for innerloop

UPDATEesi:
add esi,TYPE iArray
loop INNERLOOP2

;update EDI

add edi,TYPE iArray	;point edi to the next value in array
mov esi,edi		;point esi at the same value as edi
mov ecx,SortedCOUNT	;restore counter for SORTED loop
loop LOOP2

;display sorted list

call Crlf		;carriage return
lea edx,sorted		;load sorted declaration to output
call WriteString	;display unsorted declaration
call Crlf		;carriage return

;moves on to display list loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;DISPLAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Display list

DISPLAY:		;loop DISPLAY
lea edi,iArray		;edi points to beginning of array
mov ecx,iArraySize	;set loop counter for DISPLAY
DISPLAYLOOP:
mov eax,[edi]		;move value for current place in array into eax
call WriteInt		;display number
add edi,TYPE iArray	;increment to next address in array
call Crlf		;carriage return
Loop DISPLAYLOOP	;loop back
jmp REPEATP

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;REPEATP;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;prompt for repeat of program
REPEATP:
lea edx,crepeat		;repeat program?
call WriteString	;display repeat program message
call ReadChar		;read user response
call WriteChar		;display character
cmp al,'y'		;if reply y
je START		;jump to beginning of program
cmp al,'Y'		;if reply Y
je START		;jump to beginning of program
cmp al,'n'		;if reply n
je ENDPROGRAM		;jump to end of program
cmp al,'N'		;if reply N
je ENDPROGRAM		;jump to end of program
;error message
call Crlf
lea edx,error		;load error message into edx
call WriteString	;display error message
call Crlf		;carriage return
call Crlf		;carriage return
loop REPEATP		;loop back & display prompt/receive input

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ENDPROGRAM;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;end program sequence
ENDPROGRAM:
call Crlf		;carriage return
call Crlf		;carriage return
call WaitMsg		;ending message
push 0			;return 0
call ExitProcess
Main ENDP
END Main
