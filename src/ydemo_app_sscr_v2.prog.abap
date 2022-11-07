**&---------------------------------------------------------------------*
**& Include          YDEMO_APP_SSCR
**&---------------------------------------------------------------------*
*CLASS lcx_exception DEFINITION INHERITING FROM cx_demo_dyn_t100.
*  PUBLIC SECTION.
*    DATA t100key TYPE scx_t100key.
*
*    METHODS constructor
*      IMPORTING im_msgid TYPE sy-msgid DEFAULT '38'
*                im_msgty TYPE sy-msgty DEFAULT 'E'
*                im_msgno TYPE sy-msgno DEFAULT '000'
*                im_msgv1 TYPE any OPTIONAL
*                im_msgv2 TYPE any OPTIONAL
*                im_msgv3 TYPE any OPTIONAL
*                im_msgv4 TYPE any OPTIONAL.
*    METHODS display_msg.
*ENDCLASS. "lcx_exception DEFINITION
*
*CLASS lcx_exception IMPLEMENTATION.
*  METHOD constructor.
*    DATA: ls_textid   TYPE scx_t100key.
*
*    super->constructor( ).
*
*    t100key-msgid = im_msgid.
*    t100key-msgno = im_msgno.
*    t100key-attr1 = im_msgv1.
*    t100key-attr2 = im_msgv2.
*    t100key-attr3 = im_msgv3.
*    t100key-attr4 = im_msgv4.
*  ENDMETHOD.                    "constructor
*
*  METHOD display_msg.
*    IF msgty IS NOT INITIAL.
*      MESSAGE ID t100key-msgid TYPE 'S' NUMBER t100key-msgno
*        WITH t100key-attr1 t100key-attr2
*             t100key-attr3 t100key-attr4 DISPLAY LIKE msgty.
*    ELSE.
*      MESSAGE ID t100key-msgid TYPE 'S' NUMBER t100key-msgno
*        WITH t100key-attr1 t100key-attr2
*             t100key-attr3 t100key-attr4 DISPLAY LIKE 'E'.
*    ENDIF.
*  ENDMETHOD.
*ENDCLASS.
*
*CLASS lcl_selscr DEFINITION.
*  PUBLIC SECTION.
*    METHODS pbo
*      IMPORTING iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr.
*    METHODS pai
*      IMPORTING iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr.
*
*  PROTECTED SECTION.
*
*    METHODS pbo_1000.
*    METHODS pai_1000
*      IMPORTING iv_ucomm TYPE sy-ucomm.
*
*ENDCLASS.
*
*CLASS lcl_selscr IMPLEMENTATION.
*  METHOD pbo.
*    DATA: lv_method TYPE string.
*    CONCATENATE 'PBO_' iv_dynnr INTO lv_method.
*    TRY.
*        CALL METHOD (lv_method).
*      CATCH cx_sy_dyn_call_error.
*    ENDTRY.
*  ENDMETHOD.
*
*  METHOD pai.
*    DATA: lv_method TYPE string.
*    CONCATENATE 'PAI_' iv_dynnr INTO lv_method.
*    TRY.
*        IF iv_dynnr EQ 1000.
*          DATA(ptab) = VALUE abap_parmbind_tab( ( name  = 'IV_UCOMM'
*                                                  kind  = cl_abap_objectdescr=>exporting
*                                                  value = REF #( sy-ucomm ) ) ).
*
*          CALL METHOD (lv_method)
*            PARAMETER-TABLE ptab.
*        ELSE.
*          CALL METHOD (lv_method).
*        ENDIF.
*      CATCH cx_sy_dyn_call_error.
*    ENDTRY.
*  ENDMETHOD.
*
*  METHOD pbo_1000.
*
*  ENDMETHOD.
*
*  METHOD pai_1000.
*
*    IF iv_ucomm = 'ONLI'
*    OR iv_ucomm = 'PRIN'.
*
*    ENDIF.
*
*  ENDMETHOD.
*
*ENDCLASS.
