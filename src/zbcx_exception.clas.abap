class ZBCX_EXCEPTION definition
  public
  inheriting from CX_SALV_MSG
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  aliases DEFAULT_TEXTID
    for IF_T100_MESSAGE~DEFAULT_TEXTID .
  aliases T100KEY
    for IF_T100_MESSAGE~T100KEY .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !MSGID type SYMSGID default '38'
      !MSGNO type SYMSGNO default '000'
      !MSGTY type SYMSGTY optional
      !MSGV1 type SYMSGV optional
      !MSGV2 type SYMSGV optional
      !MSGV3 type SYMSGV optional
      !MSGV4 type SYMSGV optional .
  methods DISPLAY_MSG .
protected section.
private section.

  methods _MAPI_MSG_TO_T100KEY .
ENDCLASS.



CLASS ZBCX_EXCEPTION IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
MSGID = MSGID
MSGNO = MSGNO
MSGTY = MSGTY
MSGV1 = MSGV1
MSGV2 = MSGV2
MSGV3 = MSGV3
MSGV4 = MSGV4
.
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.


  METHOD display_msg.
    _mapi_msg_to_t100key( ).

    IF msgty IS NOT INITIAL.
      MESSAGE ID t100key-msgid TYPE msgty NUMBER t100key-msgno
        WITH t100key-attr1 t100key-attr2
             t100key-attr3 t100key-attr4.
    ELSE.
      MESSAGE ID t100key-msgid TYPE 'S' NUMBER t100key-msgno
        WITH t100key-attr1 t100key-attr2
             t100key-attr3 t100key-attr4 DISPLAY LIKE 'E'.
    ENDIF.
  ENDMETHOD.


  METHOD _mapi_msg_to_t100key.
    t100key-msgid = msgid.
    t100key-msgno = msgno.
    t100key-attr1 = msgv1.
    t100key-attr2 = msgv2.
    t100key-attr3 = msgv3.
    t100key-attr4 = msgv4.
  ENDMETHOD.
ENDCLASS.
