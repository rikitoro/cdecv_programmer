        ORG   0x00
        LD    ZERO, B     //  $00   82  13
        LD    0xFF, A     //  $02   81  FF
LOOP:   ADD   A           //  $04   21
        JC    COUNT       //  $05   E4  0B
        JZ    STORE       //  $07   E8  0E
        JMP   LOOP        //  $09   C0  04
COUNT:  INC   B           //  $0B   42
        JMP   LOOP        //  $0C   C0  04
STORE:  ST    B   , 0xFF  //  $0E   A8  FF
        ST    B   , RSLT  //  $10   A8  14
        HALT              //  $12   FF
        ORG   0x13
ZERO    DB    0x00        //  $13   00
RSLT    DB    0x00        //  $14   00

; HEX format (ignore and skip under scores '_')
; :20_0000_00_821381FF21E40BE80EC00442C004A8FFA814FF00000000000000000000000000_00
; :00_0000_01_FF

