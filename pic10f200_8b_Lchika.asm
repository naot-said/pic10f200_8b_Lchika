; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR

;RES_VECT  CODE    0x0000            ; processor reset vector
;    GOTO    START                   ; go to beginning of program

; TODO ADD INTERRUPTS HERE IF USED


;MAIN_PROG CODE                      ; let linker place main program

;START

    list	p=10f200
    #include    <p10f200.inc>

    __CONFIG    _CP_OFF & _WDT_OFF & _MCLRE_OFF & _IntRC_OSC

CNT1	EQU	0x10
CNT2	EQU	0x11
CNT3	EQU	0x12

    ;GOTO $                          ; loop forever

    ORG	    0x00

    ;クロック較正データの書き込み
    movwf	OSCCAL
    bcf		OSCCAL,FOSC4

    ;GPIO 0を出力に設定
    movlw	b'11111110'
    TRIS	GPIO
    
main_loop
    ;GPIO 0をオン
    bsf		GPIO,0
    call	DLY_1S
    ;GPIO 0 をオフ
    bcf		GPIO,0
    call	DLY_1S
    goto	main_loop

DLY_1S ; 1Sec
    movlw	d'10'
    movwf	CNT3
DLY_100 ; 100mS
    movlw	d'100'
    movwf	CNT1
DLP1 ; 1mS
    movlw	d'200'
    movwf	CNT2
DLP2
    nop
    nop
    decfsz	CNT2,f
    goto	DLP2
    decfsz	CNT1,f
    goto	DLP1
    decfsz	CNT3,f
    goto	DLY_100
    
    retlw	0
    
    END