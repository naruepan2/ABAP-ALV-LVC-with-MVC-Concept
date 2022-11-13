CLASS zbcx_exception DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg.

    METHODS constructor
      IMPORTING
        !iv_msgid TYPE sy-msgid DEFAULT '38'
        !iv_msgty TYPE sy-msgty DEFAULT 'E'
        !iv_msgno TYPE sy-msgno DEFAULT '000'
        !iv_msgv1 TYPE any OPTIONAL
        !iv_msgv2 TYPE any OPTIONAL
        !iv_msgv3 TYPE any OPTIONAL
        !iv_msgv4 TYPE any OPTIONAL .
    METHODS display_msg .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA t100key TYPE scx_t100key .
    DATA msgty TYPE symsgty .
ENDCLASS.



CLASS ZBCX_EXCEPTION IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    DATA: ls_textid   TYPE scx_t100key.

    super->constructor( ).

    t100key-msgid = iv_msgid.
    t100key-msgno = iv_msgno.
    t100key-attr1 = iv_msgv1.
    t100key-attr2 = iv_msgv2.
    t100key-attr3 = iv_msgv3.
    t100key-attr4 = iv_msgv4.
    msgty         = iv_msgty.
  ENDMETHOD.


  METHOD display_msg.
    IF msgty IS NOT INITIAL.
      MESSAGE ID t100key-msgid TYPE 'S' NUMBER t100key-msgno
        WITH t100key-attr1 t100key-attr2
             t100key-attr3 t100key-attr4 DISPLAY LIKE msgty.
    ELSE.
      MESSAGE ID t100key-msgid TYPE 'S' NUMBER t100key-msgno
        WITH t100key-attr1 t100key-attr2
             t100key-attr3 t100key-attr4 DISPLAY LIKE 'E'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
