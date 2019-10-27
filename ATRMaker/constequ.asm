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
; line numbers used for laying out screen

STATUS_LINE = 0
DESTINATION_FIELD_LINE = 3
FILE_FIELD_LINE = 5
ERROR_FIELD_LINE = 6
HELP_LINE = 8

SOURCE_FIELD_LINE = 2
BACKGROUND_INTENSITY_LINE = 4
TEXT_INTENSITY_LINE = 5
UPDATE_SETTINGS_LINE = 6
;HELP_LINE = 7

MODE_FIELD_LINE = 8
;FILE_FIELD_LINE = 9
LOG_FIELD_LINE = 10
NOTE_FIELD_LINE = 11

ATR_MAKER_NAME_LINE = 12

BAD_SECTOR_RETRY_FIELD_LINE = 10

VIEW_SECTORS_FIELD_LINE = 12
INTERFACE_FIELD_LINE = 13
;ERROR_FIELD_LINE = 14

SYSTEM_RESET_FIELD_LINE = 16
SPACE_TO_CONTINUE_FIELD_LINE = 18
ABBUC_FIELD_LINE = 20
ATR_MAKER_FIELD_LINE = 21


USER_PROMPT_LINE = 22
RETRY_FIELD_LINE = 22
OVERWRITE_FIELD_LINE = 22

BACKSPACE_CHAR	= 126


COLON_OFFSET = 16

BAD_SECTOR_COLON_OFFSET = 24

TEXT_LINE_WIDTH = 40

SINGLE_DENSITY_SECTOR_SIZE = $80

FIRST_THREE_SECTOR_SIZE = SINGLE_DENSITY_SECTOR_SIZE * 3


KEYBOARD_INPUT_HANDLE = $20		; channel #2

ATR_FILE_HANDLE = $50		; channel #5

EOL = $9B


*=  $0340   

IOCB

ICHID *= *+1    
ICDNO *= *+1    
ICCOM *= *+1    
ICSTA *= *+1    
ICBADR *= *+2   
ICPUT *= *+2    
ICBLEN *= *+2   
ICAUX1 *= *+1   
ICAUX2 *= *+1   
ICAUX3 *= *+1   
ICAUX4 *= *+1   
ICAUX5 *= *+1   
ICAUX6 *= *+1   

IOCBLEN = * - IOCB 

COPN =  3       
CGBINR = 7      
CGTXTR = 5      
CPBINR = 11     
CPTXTR = 9      
CCLOSE = 12      

CIO =   $E456   

