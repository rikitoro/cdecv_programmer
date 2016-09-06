
START:  LD    0xFF, A     //  $0x00   81  FF
        MOV   A,    B     //  $0x02   06
        ST    B,    0xFF  //  $0x03   A8  FF
        ST    B,    0x08  //  $0x05   A8  10
        HALT              //  $0x07   FF
; HEX format (ignore and skip underlines '_')
; :10_0000_00_81FF06A8FFA810FF0000000000000000_00
; :00_0000_01_FF