;   Copyright (C) 2019 e474 <e474sr@gmail.com>
;
;   This program is free software; you can redistribute it and/or modify
;   it under the terms of the GNU General Public License as published by
;   the Free Software Foundation; either version 3 of the License, or
;   (at your option) any later version.
;
;   This program is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU General Public License for more details.
;
;   You should have received a copy of the GNU General Public License
;   along with this program; if not, write to the Free Software
;   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.



;
; TEXT.asm




; holder for single key keyboard input of main menu
OPTION_CHAR
	.BYTE 00

; holder for single key keyboard input of help text screen
HELP_TEXT_CHAR
	.BYTE 00

; holder for single key keyboard input of help text screen
RESTART_TO_MAIN_MENU_CHAR
	.BYTE 00

WAIT_TO_CONTINUE_CHAR
	.BYTE 00

YES_OR_NO_CHAR
	.BYTE 00

CALCULATED_SOURCE_DRIVE_NUMBER
	.BYTE 00
	
PARA_SECTOR_SIZE
PARA_SECTOR_SIZE_LO
	.BYTE 0	
PARA_SECTOR_SIZE_HI	
	.BYTE 0	

CURRENT_ELEMENT	
	.BYTE 0

FNAME_CHAR
	.BYTE 0
	
KEYBOARD_DEVICE_TEXT
	.BYTE "K:",0	

NEW_FILE_NAME_PROMPT_TEXT
	.SBYTE "New File: "
NEW_FILE_NAME_PROMPT_TEXT_LENGTH = * - NEW_FILE_NAME_PROMPT_TEXT


TOTAL_NUMBER_OF_SECTORS
	.WORD 0,0 

CALCULATED_TOTAL_NUMBER_OF_SECTORS
	.WORD 0, 0						; 4 byte destination value for computation


CALCULATED_DISK_SIZE_IN_PARAGRAPHS
	.WORD 0, 0						; 4 byte destination value for computation

ASK_ON_BAD_SECTOR
	.BYTE 0


REMAINING_NUMBER_OF_SECTORS
	.WORD 0

EXISTING_FILE_NAME
	.BYTE "D"
EXISTING_FILE_DRIVE_NUMBER
	.BYTE "2"
	.BYTE ":"
EXISTING_FILE_NAME_BUFFER	
	.BYTE "DISK0000.ATR", EOL
	; * = * + $40

NEXT_SECTOR_TO_READ
	.WORD 0,0

BIN_VAL			
	.WORD  12345
	
BCD_VAL		
	.BYTE  0,0,0


FNAME_DISPLAY_INDEX
	.BYTE 0

FNAME_LENGTH
	.BYTE 0

FNAME_TMP
	.BYTE "1234567890"
	
FNAME_EXTENSION
	.SBYTE ".ATR"
FNAME_EXTENSION_LENGHT = * - FNAME_EXTENSION

RETRY_COUNT
	.BYTE 5

RETRY_COUNT_MAX
	.BYTE 5

;
; Structure that holds the data and representation for a field
OUTPUT_FIELD_STRUCTURE

; this structure holds:
;	destination storage pointer (.WORD)
;	value of field (.WORD, can be accessed as a BYTE)
;	number of different values (.BYTE if a list, 0 if only a label)
;	label for field, terminated with EOL (.SBYTE,EOL)
; 	all alternative text values possible, each terminated with an EOL (.SBYTE,EOL)*

SCREEN_DESTINATION_ADDRESS_LABEL = 0
;	.WORD 0							; pointer to screen memory for
;									; start of field (label + value, if any)

SCREEN_DESTINATION_ADDRESS_VALUE = SCREEN_DESTINATION_ADDRESS_LABEL + 2
;	.WORD 0							; pointer to screen memory for
;									; start of field (label + value, if any)



CURRENT_FIELD_VALUE = SCREEN_DESTINATION_ADDRESS_VALUE + 2
;	.WORD 0							; used for value of field (BYTE or WORD)
;									; also index into VALUE list
;
NUMBER_OF_VALUES = 		CURRENT_FIELD_VALUE + 2		
									; number of different values that field
									; can have, $00 indicacates label only
;	.BYTE 0

;
; first element is the label/prefix, all elements teminated with EOL
;
START_OF_TEXT_VALUES = NUMBER_OF_VALUES + 1





STATUS_LINE_DATA
STATUS_LINE_SD_LABEL = [SCREEN_TEXT_START  + [STATUS_LINE * TEXT_LINE_WIDTH]]
STATUS_LINE_SD_VALUE = [SCREEN_TEXT_START  + [STATUS_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD STATUS_LINE_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD STATUS_LINE_SD_VALUE			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE "D"
SOURCE_DISPLAY_DRIVE_NUMBER
	.SBYTE "1"
	.SBYTE " -> D"
DESTINATION_DISPLAY_DRIVE
	.SBYTE "2:"
STATUS_LINE_DESTINATION_FILE_NAME	
	.SBYTE "DISK0000.ATR "
DISK_SECTOR_VAL	
	.SBYTE "000000 "
DISK_SECTOR_SIZE_VAL
	.SBYTE "0000 "
DISK_NUMBER_OF_HEADS_VAL
	.SBYTE "01 "
DISK_DENSITY_CODE_VAL
	.SBYTE " "
	.BYTE EOL

SOURCE_FIELD_DATA

SOURCE_SD_LABEL = [SCREEN_TEXT_START  + [SOURCE_FIELD_LINE * TEXT_LINE_WIDTH]]
SOURCE_SD_VALUE = SOURCE_DISPLAY_DRIVE_NUMBER ; [SCREEN_TEXT_START  + [STATUS_LINE * TEXT_LINE_WIDTH]] + 1

	.WORD SOURCE_SD_LABEL
	.WORD SOURCE_SD_VALUE
	.WORD 0
	.BYTE 4
; label
	.SBYTE +$80, "S"
	.SBYTE "ource drive number+"
	.BYTE EOL
; values
	.SBYTE "1"
	.BYTE EOL
	.SBYTE "2"
	.BYTE EOL
	.SBYTE "3"
	.BYTE EOL
	.SBYTE "4"
	.BYTE EOL

DESTINATION_FIELD_DATA

DESTINATION_SD_LABEL = [SCREEN_TEXT_START  + [DESTINATION_FIELD_LINE * TEXT_LINE_WIDTH]]
DESTINATION_SD_VALUE = [DESTINATION_DISPLAY_DRIVE ]; + [STATUS_LINE * TEXT_LINE_WIDTH]] + 7
;DESTINATION_SD_VALUE = [SCREEN_TEXT_START  + [STATUS_LINE * TEXT_LINE_WIDTH]] + 7


	.WORD DESTINATION_SD_LABEL
	.WORD DESTINATION_SD_VALUE
	.WORD 1
	.BYTE 9
; label
	.SBYTE +$80, "D"
	.SBYTE "estination drive number+"
	.BYTE EOL
; values
	.SBYTE "1"
	.BYTE EOL
	.SBYTE "2"
	.BYTE EOL
	.SBYTE "3"
	.BYTE EOL
	.SBYTE "4"
	.BYTE EOL
	.SBYTE "5"
	.BYTE EOL
	.SBYTE "6"
	.BYTE EOL
	.SBYTE "7"
	.BYTE EOL
	.SBYTE "8"
	.BYTE EOL
	.SBYTE "9"
	.BYTE EOL

BACKGROUND_FIELD_DATA
BACKGROUND_SD_LABEL = [SCREEN_TEXT_START  + [BACKGROUND_INTENSITY_LINE * TEXT_LINE_WIDTH]]
BACKGROUND_SD_VALUE = [SCREEN_TEXT_START  + [BACKGROUND_INTENSITY_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD BACKGROUND_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD BACKGROUND_SD_VALUE			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE +$80, "B"
	.SBYTE "ackground+"
	.BYTE EOL

TEXT_FIELD_DATA
TEXT_SD_LABEL = [SCREEN_TEXT_START  + [TEXT_INTENSITY_LINE * TEXT_LINE_WIDTH]]
TEXT_SD_VALUE = [SCREEN_TEXT_START  + [TEXT_INTENSITY_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD TEXT_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD TEXT_SD_VALUE			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE +$80, "T"
	.SBYTE "ext+"
	.BYTE EOL


UPDATE_SETTINGS_FIELD_DATA
UPDATE_SETTINGS_SD_LABEL = [SCREEN_TEXT_START  + [UPDATE_SETTINGS_LINE * TEXT_LINE_WIDTH]]
UPDATE_SETTINGS_SD_VALUE = [SCREEN_TEXT_START  + [UPDATE_SETTINGS_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD UPDATE_SETTINGS_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD UPDATE_SETTINGS_SD_VALUE			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE +$80, "U"
	.SBYTE "pdate settings"
	.BYTE EOL


OVERWRITE_FILE_FIELD_DATA
OVERWRITE_FILE_SD_LABEL = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]]
OVERWRITE_FILE_SD_VALUE = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD OVERWRITE_FILE_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD OVERWRITE_FILE_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE "Overwrite existing file (Y/N) : "
	.BYTE EOL

OVERWRITING_FILE_FIELD_DATA
OVERWRITING_FILE_SD_LABEL = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]]
OVERWRITING_FILE_SD_VALUE = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD OVERWRITING_FILE_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD OVERWRITING_FILE_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE "Overwriting existing file."
	.BYTE EOL

FILE_ERROR_FIELD_DATA
FILE_ERROR__SD_LABEL = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]]
FILE_ERROR__SD_VALUE = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD FILE_ERROR__SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD FILE_ERROR__SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE "File error: "
FILE_ERROR_TEXT	
	.SBYTE "000"
	.SBYTE ". Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue."
	
	.BYTE EOL

SOURCE_IS_DESTINATION_ERROR_FIELD_DATA
SOURCE_IS_DESTINATION_ERROR__SD_LABEL = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]]
SOURCE_IS_DESTINATION_ERROR__SD_VALUE = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD SOURCE_IS_DESTINATION_ERROR__SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD SOURCE_IS_DESTINATION_ERROR__SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE "Source and Destination are the same!"
	
	.BYTE EOL







DISK_HAS_BAD_SECTORS_ERROR_FIELD_DATA
DISK_HAS_BAD_SECTORS_SD_LABEL = [SCREEN_TEXT_START  + [BAD_SECTOR_RETRY_FIELD_LINE * TEXT_LINE_WIDTH]]
DISK_HAS_BAD_SECTORS_SD_VALUE = [SCREEN_TEXT_START  + [BAD_SECTOR_RETRY_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD DISK_HAS_BAD_SECTORS_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD DISK_HAS_BAD_SECTORS_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE +$80,"Disk has bad sectors!"
	.BYTE EOL




RETRY_ANOTHER_5_DATA
RETRY_ANOTHER_5_SD_LABEL = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]]
RETRY_ANOTHER_5_SD_VALUE = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD RETRY_ANOTHER_5_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD RETRY_ANOTHER_5_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE "Retry reading 5 more times (Y/N) : "
	.BYTE EOL




CONVERSION_COMPLETE_FIELD_DATA
CONVERSION_COMPLETE_SD_LABEL = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]]
CONVERSION_COMPLETE_SD_VALUE = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD CONVERSION_COMPLETE_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD CONVERSION_COMPLETE_SD_VALUE			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE "    << "
	.SBYTE +$80,"Pleased to be of service"
	.SBYTE " >>"

	.BYTE EOL





HELP_FIELD_DATA
HELP_SD_LABEL = [SCREEN_TEXT_START  + [HELP_LINE * TEXT_LINE_WIDTH]]
HELP_SD_VALUE = [SCREEN_TEXT_START  + [HELP_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD HELP_SD_LABEL			; SCREEN_DESTINATION_ADDRESS
	.WORD HELP_SD_VALUE			; SCREEN_DESTINATION_ADDRESS
	.WORD 0						; CURRENT_FIELD_VALUE
	.BYTE 0						; NUMBER_OF_VALUES
; label
	.SBYTE +$80,"H"
	.SBYTE "elp and license information"
	.BYTE EOL,EOL

;
; Error Sector Field data structure

ERROR_SECTORS_FIELD_DATA
; data values
ERROR_SD_LABEL = [SCREEN_TEXT_START  + [ERROR_FIELD_LINE * TEXT_LINE_WIDTH]]
ERROR_SD_VALUE = [SCREEN_TEXT_START  + [ERROR_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD ERROR_SD_LABEL		; SCREEN_DESTINATION_ADDRESS
	.WORD ERROR_SD_VALUE		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 4				; NUMBER_OF_VALUES
; label
	.SBYTE +$80, "E"					
	.SBYTE "rror on read : "
	.BYTE EOL
; values
	.SBYTE +$80,"Retry 5 then ask"
;	.SBYTE " "
	.BYTE EOL
	.SBYTE +$80,"Retry 5 then skip"
;	.SBYTE "     "
	.BYTE EOL
	.SBYTE +$80,"Skip"
	.SBYTE "                "
	.BYTE EOL
	.SBYTE +$80,"Ask"
	.SBYTE " "
	.BYTE EOL


MODE_FIELD_DATA
; data values
MODE_SD_LABEL = [SCREEN_TEXT_START  + [MODE_FIELD_LINE * TEXT_LINE_WIDTH]]
MODE_SD_VALUE = [SCREEN_TEXT_START  + [MODE_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET

	.WORD MODE_SD_LABEL		; SCREEN_DESTINATION_ADDRESS
	.WORD MODE_SD_VALUE		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 2				; NUMBER_OF_VALUES
; label
	.SBYTE +$80, "M"
	.SBYTE "ode          : "
	.BYTE EOL
; values
	.SBYTE +$80,"File"
	.SBYTE "       "
	.BYTE EOL
	.SBYTE +$80,"Sector Copy"			
	.BYTE EOL

FILE_FIELD_DATA
; data values
FILE_SD_LABEL = [SCREEN_TEXT_START  + [FILE_FIELD_LINE * TEXT_LINE_WIDTH]]
FILE_SD_VALUE = [SCREEN_TEXT_START  + [FILE_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET
	.WORD FILE_SD_LABEL		; SCREEN_DESTINATION_ADDRESS
	.WORD FILE_SD_VALUE		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 1				; NUMBER_OF_VALUES
; label
	.SBYTE +$80, "F"
	.SBYTE "ile          : "
	.BYTE EOL
; values
;
; special case, holding bytes for string
DESTINATION_FILE_NAME
	.SBYTE "DISK0000.ATR"
DESTINATION_FILE_NAME_LENGHT = * - DESTINATION_FILE_NAME	
	.BYTE EOL


LOG_FIELD_DATA
; 
; data values
;

LOG_SD_LABEL = [SCREEN_TEXT_START  + [LOG_FIELD_LINE * TEXT_LINE_WIDTH]]
LOG_SD_VALUE = [SCREEN_TEXT_START  + [LOG_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET

	.WORD LOG_SD_LABEL		; SCREEN_DESTINATION_ADDRESS
	.WORD LOG_SD_VALUE		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 2				; NUMBER_OF_VALUES

;
; label
;
	.SBYTE +$80, "L"
	.SBYTE "og file      : "
	.BYTE EOL
;
; values
;
	.SBYTE +$80,"Yes"
	.BYTE EOL
	.SBYTE +$80,"No"			
	.SBYTE " "
	.BYTE EOL

RETRY_FIELD_DATA
; 
; data values
;

RETRY_SD_LABEL = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]]
RETRY_SD_VALUE = [SCREEN_TEXT_START  + [RETRY_FIELD_LINE * TEXT_LINE_WIDTH]] + BAD_SECTOR_COLON_OFFSET

	.WORD RETRY_SD_LABEL		; SCREEN_DESTINATION_ADDRESS
	.WORD RETRY_SD_VALUE		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 6				; NUMBER_OF_VALUES

;
; label
;
	.SBYTE "Bad sector, retrying : "
	.BYTE EOL
;
; values
;
	.SBYTE "   "
	.BYTE EOL

	.SBYTE "1/5"
	.BYTE EOL
	.SBYTE "2/5"			
	.BYTE EOL
	.SBYTE "3/5"			
	.BYTE EOL
	.SBYTE "4/5"			
	.BYTE EOL
	.SBYTE "5/5"			
	.BYTE EOL






NOTE_FIELD_DATA
; 
; data values
;

NOTE_SD_LABEL = [SCREEN_TEXT_START  + [NOTE_FIELD_LINE * TEXT_LINE_WIDTH]]
NOTE_SD_VALUE = [SCREEN_TEXT_START  + [NOTE_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET

	.WORD NOTE_SD_LABEL		; SCREEN_DESTINATION_ADDRESS
	.WORD NOTE_SD_VALUE		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 2				; NUMBER_OF_VALUES

;
; label
;
	.SBYTE +$80, "N"
	.SBYTE "ote text     : "
	.BYTE EOL
;
; values
;
	.SBYTE +$80,"Yes"
	.BYTE EOL
	.SBYTE +$80,"No"			
	.SBYTE " "
	.BYTE EOL
	

VIEW_SECTORS_FIELD_DATA
; 
; data values
;

VIEW_SECTORS_SD_LABEL = [SCREEN_TEXT_START  + [VIEW_SECTORS_FIELD_LINE * TEXT_LINE_WIDTH]]
VIEW_SECTORS_SD_VALUE = [SCREEN_TEXT_START  + [VIEW_SECTORS_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET

	.WORD VIEW_SECTORS_SD_LABEL	; SCREEN_DESTINATION_ADDRESS_LABEL
	.WORD VIEW_SECTORS_SD_VALUE ; SCREEN_DESTINATION_ADDRESS_VALUE
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 2				; NUMBER_OF_VALUES

;
; label
;
	.SBYTE +$80, "V"
	.SBYTE "iew sectors  : "
	.BYTE EOL
;
; values
;
	.SBYTE +$80,"Yes"
	.BYTE EOL
	.SBYTE +$80,"No"			
	.SBYTE " "
	.BYTE EOL

INTERFACE_FIELD_DATA
; 
; data values
;

INTERFACE_SD_LABEL = [SCREEN_TEXT_START  + [INTERFACE_FIELD_LINE * TEXT_LINE_WIDTH]]
INTERFACE_SD_VALUE = [SCREEN_TEXT_START  + [INTERFACE_FIELD_LINE * TEXT_LINE_WIDTH]] + COLON_OFFSET

	.WORD INTERFACE_SD_LABEL		; SCREEN_DESTINATION_ADDRESS
	.WORD INTERFACE_SD_VALUE		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 1				; NUMBER_OF_VALUES

;
; label
;
	.SBYTE +$80, "I"
	.SBYTE "nterface     : "
	.BYTE EOL
;
; values
;
	
	.SBYTE +$80, "English"
	;  .SBYTE "                 *",
	 .BYTE EOL
	
	
	
SYSTEM_RESET_FIELD_DATA
; data values
SYSTEM_RESET_SD = [SCREEN_TEXT_START  + [SYSTEM_RESET_FIELD_LINE * TEXT_LINE_WIDTH]] + 8
	.WORD SYSTEM_RESET_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD SYSTEM_RESET_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 0				; NUMBER_OF_VALUES
; label
	.SBYTE "<"
	.SBYTE +$80,"System Reset"
	.SBYTE "> to exit       "
	.BYTE EOL
	
SPACE_TO_CONTINUE_FIELD_DATA
; data values
SPACE_TO_CONTINUE_SD = [SCREEN_TEXT_START  + [SPACE_TO_CONTINUE_FIELD_LINE * TEXT_LINE_WIDTH]]
	.WORD SPACE_TO_CONTINUE_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD SPACE_TO_CONTINUE_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 0				; NUMBER_OF_VALUES
; label
	.SBYTE "  <<<<< Press "
	.SBYTE +$80,"Space"
	.SBYTE " to make ATR >>>>>"
	.BYTE EOL
	
ABBUC_CONTEST_2019_FIELD_DATA
; data values
ABBUC_SD = [SCREEN_TEXT_START  + [ABBUC_FIELD_LINE * TEXT_LINE_WIDTH]]
	.WORD ABBUC_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD ABBUC_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 0				; NUMBER_OF_VALUES
; label
	.SBYTE "     !ABBUC Software Contest 2019!"
	.BYTE EOL, EOL

ATR_MAKER_DELUXE_FIELD_DATA
; data values
ATR_MAKER_SD = [SCREEN_TEXT_START  + [ATR_MAKER_FIELD_LINE * TEXT_LINE_WIDTH]]
	.WORD ATR_MAKER_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD ATR_MAKER_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 0				; NUMBER_OF_VALUES
; label
	.SBYTE "     Copyright (c) E474, UK, 2019."
	.BYTE EOL, EOL


ATR_MAKER_DELUXE_NAME_DATA
; data values
ATR_MAKER_NAME_SD = [SCREEN_TEXT_START  + [ATR_MAKER_NAME_LINE * TEXT_LINE_WIDTH]]
	.WORD ATR_MAKER_NAME_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD ATR_MAKER_NAME_SD		; SCREEN_DESTINATION_ADDRESS
	.WORD 0				; CURRENT_FIELD_VALUE
	.BYTE 0				; NUMBER_OF_VALUES
; label
	.SBYTE "        ATR Maker Deluxe v. 1.0"
	.BYTE EOL, EOL





SCREEN_ELEMENTS
	.WORD STATUS_LINE_DATA
	.WORD SOURCE_FIELD_DATA
	.WORD DESTINATION_FIELD_DATA
;	.WORD BACKGROUND_FIELD_DATA
;	.WORD TEXT_FIELD_DATA
;	.WORD UPDATE_SETTINGS_FIELD_DATA
	.WORD HELP_FIELD_DATA
	.WORD ATR_MAKER_DELUXE_NAME_DATA
	.WORD ERROR_SECTORS_FIELD_DATA
;	.WORD MODE_FIELD_DATA
	.WORD FILE_FIELD_DATA
;	.WORD LOG_FIELD_DATA
;	.WORD NOTE_FIELD_DATA
;	.WORD VIEW_SECTORS_FIELD_DATA
;	.WORD INTERFACE_FIELD_DATA
	.WORD SYSTEM_RESET_FIELD_DATA
	.WORD SPACE_TO_CONTINUE_FIELD_DATA
	.WORD ABBUC_CONTEST_2019_FIELD_DATA
	.WORD ATR_MAKER_DELUXE_FIELD_DATA
	
NUMBER_OF_SCREEN_ELEMENTS = [[* - SCREEN_ELEMENTS ] + 2]	

;NUMBER_OF_SCREEN_ELEMENTS
;	.BYTE [SCREEN_ELEMENTS_SIZE / 2]
	
	
	
;
; command codes usable on main menu
;
	
MAIN_MENU_COMMAND_CODES
;	.BYTE "BDEFHILMNSTUV "   ; full/finished version
	.BYTE "DEFHS "

NUMBER_OF_MAIN_MENU_COMMAND_CODES = * - MAIN_MENU_COMMAND_CODES
	
;
; destination addresses for command handler routines (lo byte)	
;

MAIN_MENU_FIELD_PROCESS_JUMP_VECTOR_LO	
;	.BYTE <BACKGROUND_COLOR_INPUT_HANDLER
	.BYTE <DESTINATION_DRIVE_INPUT_HANDLER
	.BYTE <ERROR_SECTOR_INPUT_HANDLER
	.BYTE <FILE_OR_FORMAT_CHANGE_INPUT_HANDLER
	.BYTE <HELP_TEXT_INPUT_HANDLER
;	.BYTE <INTERFACE_LANGUAGE_INPUT_HANDLER
;	.BYTE <LOG_FILE_CHANGE_INPUT_HANDLER
;	.BYTE <MODE_CHANGE_INPUT_HANDLER
;	.BYTE <NOTE_PROMPT_INPUT_HANDLER
	.BYTE <SOURCE_DRIVE_INPUT_HANDLER
;	.BYTE <TEXT_COLOR_INPUT_HANDLER
;	.BYTE <UPDATE_SETTINGS_INPUT_HANDLER
;	.BYTE <VIEW_SECTORS_INPUT_HANDLER		
	.BYTE <SPACE_BAR_INPUT_HANDLER

MAIN_MENU_FIELD_PROCESS_JUMP_VECTOR_HI
;	.BYTE >BACKGROUND_COLOR_INPUT_HANDLER
	.BYTE >DESTINATION_DRIVE_INPUT_HANDLER
	.BYTE >ERROR_SECTOR_INPUT_HANDLER
	.BYTE >FILE_OR_FORMAT_CHANGE_INPUT_HANDLER
	.BYTE >HELP_TEXT_INPUT_HANDLER
;	.BYTE >INTERFACE_LANGUAGE_INPUT_HANDLER
;	.BYTE >LOG_FILE_CHANGE_INPUT_HANDLER
;	.BYTE >MODE_CHANGE_INPUT_HANDLER
;	.BYTE >NOTE_PROMPT_INPUT_HANDLER
	.BYTE >SOURCE_DRIVE_INPUT_HANDLER
;	.BYTE >TEXT_COLOR_INPUT_HANDLER
;	.BYTE >UPDATE_SETTINGS_INPUT_HANDLER
;	.BYTE >VIEW_SECTORS_INPUT_HANDLER		
	.BYTE >SPACE_BAR_INPUT_HANDLER

	
HELP_TEXT
	.SBYTE "  Welcome to ATR Maker Deluxe v. ",
ATR_MAKER_VERSION_NUMBER
	.SBYTE "1.0"
	.BYTE EOL,EOL
	.SBYTE "ATR Maker Deluxe converts an unprotected"
	.BYTE EOL
	.SBYTE "floppy disk to an ATR format file."
	.BYTE EOL
	.SBYTE "In order to create large files for" 
	.BYTE EOL
	.SBYTE "storing disk images, you need to"
	.BYTE EOL
	.SBYTE "run ATR Maker Deluxe from a DOS that"
	.BYTE EOL
	.SBYTE "supports large files, such as MyDOS,"
	.BYTE EOL
	.SBYTE "SpartaDOS, or similar."
	.BYTE EOL
	.SBYTE "The .ATR files that ATR Maker Deluxe"
	.BYTE EOL
	 .SBYTE "creates should be written to"
	.BYTE EOL
	.SBYTE "external storage devices such as the" 
	.BYTE EOL
	.SBYTE "SD-Drive Max, Side2, etc."
	.BYTE EOL
	.SBYTE "This program comes with ABSOLUTELY"
	.BYTE EOL
	.SBYTE "NO WARRANTY; licensed under GPL "
	.BYTE EOL
	.SBYTE "v3.0. Sources are on this disk,"
	.BYTE EOL
	
	.SBYTE "latest version on"
	.BYTE EOL
	.SBYTE "github.com/e474/atrmaker/ after end"	
	.BYTE EOL
	.SBYTE "of contest. Updates welcome!"	
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOZ	
		   	
CANT_READ_SECTOR_TEXT
	.SBYTE "Cannot read sector!!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"S"
	.SBYTE " to skip >>>>"
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"R"
	.SBYTE " to retry >>>>"
	.BYTE EOL

	.BYTE EOL
	.SBYTE "If you are having problems with this"
	.BYTE EOL
	.SBYTE "disk, you might want to remove the disk,"
	.BYTE EOL
	.SBYTE "power down the drive, clean the drive"
	
	.BYTE EOL
	.SBYTE "head with IPA, then power up the drive,"
	.BYTE EOL
	.SBYTE "load the disk, and continue this copy."
	.BYTE EOL

	.BYTE EOZ

SINGLE_DENSITY_DISK_TEXT
	.SBYTE "Calculated as single density disk!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ


ENHANCED_DENSITY_DISK_TEXT
	.SBYTE "Calculated as enhanced density disk!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ

BAD_CALCULATION_TEXT
	.SBYTE "Bad calculation!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ	



	
CHECK_DRIVE_STATUS_TEXT_DETECTED_DRIVE
	.SBYTE "Detected drive!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ	
	
CHECK_DRIVE_STATUS_TEXT_CANT_DETECT_DRIVE
	.SBYTE "Can't etect drive!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ	
	


		   	
CHECK_PERCOM_BLOCK_TEXT_SUPPORTED_BY_DRIVE
	.SBYTE "Drive supports Percom Block!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ	
	
CHECK_PERCOM_BLOCK_TEXT_NOT_SUPPORTED_BY_DRIVE
	.SBYTE "Drive does not support Percom Block!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ	
	
CHECK_SECTOR_1_TEXT_COULD_NOT_READ_SECTOR
	.SBYTE "Could not read first 3 sectors!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ	

DRIVE_STATUS_BIT_7_SET
	.SBYTE "Bit 7 status bit set!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ	
	
DRIVE_STATUS_BIT_7_NOT_SET
	.SBYTE "Bit 7 status bit not set!"
	.BYTE EOL
	.BYTE EOL
	.BYTE EOL
	.SBYTE "     <<<< Press "
	.SBYTE +$80,"C"
	.SBYTE " to continue >>>>"
	.BYTE EOL
	.BYTE EOZ	

		   	
DRIVE_STATUS_BUFFER
	.WORD 0,0		   	
	
DECIMAL_TO_SCREEN
	.SBYTE	"0123456789"
	
		   	
; PERCOM block description
	
;Offset	Description
;$00	Number of tracks
;$01	Step rate (00=30ms 01=20ms 10=12ms 11=6ms)
;$02	Sectors per Track HIGH
;$03	Sectors per Track LOW
;$04	Number of sides decreased by one
;$05	Record Method (0=FM single, 4=MFM double, 6=1.2M)
;$06	Bytes per Sector HIGH
;$07	Bytes per Sector LOW
;$08	Drive online ($FF or $40 for XF551)
;$09	Unused (Serial rate control?)
;$0A	Unused
;$0B	Unused
	
PERCOM_BLOCK_BUFFER	
PERCOM_NUMBER_OF_TRACKS
	.BYTE 40					; Number of tracks
PERCOM_STEP_RATE
	.BYTE 0						; Step rate (00=30ms 01=20ms 10=12ms 11=6ms)
PERCOM_SECTORS_PER_TRACK_HI
	.BYTE 0					; Sectors per Track HIGH
PERCOM_SECTORS_PER_TRACK_LO
	.BYTE 18					; Sectors per Track LO
PERCOM_NUMBER_OF_SIDES
	.BYTE 0						; actually number of sides-1
PERCOM_RECORD_METHOD
	.BYTE 0						; Record Method (0=FM single, 4=MFM double, 6=1.2M)
PERCOM_BYTES_PER_SECTOR_HI
	.BYTE 0
PERCOM_BYTES_PER_SECTOR_LO
	.BYTE 0
PERCOM_DRIVE_ONLINE
	.BYTE 0
PERCOM_UNUSED_1
	.BYTE 0
PERCOM_UNUSED_2
	.BYTE 0
PERCOM_UNUSED_3
	.BYTE 0

PERCOM_BLOCK_BUFFER_SIZE = * - PERCOM_BLOCK_BUFFER

;
; end of PERCOM block
;


; ATR Header record
; 
; see https://www.atarimax.com/jindroush.atari.org/afmtatr.html
;
;
;Conventions
;DWORD - 32bit unsigned long (little endian) 
;WORD - 16bit unsigned short (little endian) 
;BYTE - 8bit unsigned char

;Header - 16 bytes long. 
 
;Type	Name			Description
;WORD	wMagic			$0296 (sum of 'NICKATARI')
;WORD	wPars			size of this disk image, in paragraphs (size/$10)
;WORD	wSecSize		sector size. ($80 or $100) bytes/sector
;BYTE	btParsHigh		high part of size, in paragraphs (added by REV 3.00)
;DWORD	dwCRC			32bit CRC of file (added by APE?)
;DWORD	dwUnused		unused
;BYTE	btFlags			bit 0 (ReadOnly) (added by APE?)
;
;Body
;Then there are continuous sectors. Some ATR files are incorrect - if sector size is > $80 first three sectors should be $80 long. But, few files have these sectors $100 long.

ATR_HEADER
ATR_W_MAGIC
	.word $0296
ATR_W_PARS
	.WORD 0			; updated in code
ATR_W_SEC_SIZE
	.WORD 0			; updated in code
ATR_BT_PARS_HIGH
	.BYTE 0			; updated in code
ATR_DW_CRC
	.WORD 0		; updated in code
	.WORD 0
ATR_DW_UNUSED
	.WORD 0
	.WORD 0
ATR_BT_FLAGS
	.BYTE 0
	
ATR_HEADER_LENGTH = * - ATR_HEADER



	