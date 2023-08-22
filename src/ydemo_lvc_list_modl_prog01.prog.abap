*&---------------------------------------------------------------------*
*& Include          YDEMO_APP_MODL
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_model DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_model DEFINITION INHERITING FROM zcl_mvcfw_base_lvc_model.

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_outtab.
*             chkbox TYPE flag.
             INCLUDE TYPE spfli.
*             INCLUDE TYPE zcl_mvcfw_base_lvc_model=>ts_incl_outtab_ext.
    TYPES:   END OF ty_outtab.
    TYPES: tty_outtab TYPE TABLE OF ty_outtab WITH EMPTY KEY.

    METHODS select_data REDEFINITION.
    METHODS process_data REDEFINITION.
    METHODS get_outtab REDEFINITION.
    METHODS set_outtab REDEFINITION.

  PROTECTED SECTION.


  PRIVATE SECTION.

    DATA mt_outtab TYPE tty_outtab.

    METHODS _get_main_outtab
      RETURNING VALUE(ro_data) TYPE REF TO data.

ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_model IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_model IMPLEMENTATION.
  METHOD select_data.
    DATA: ls_cell TYPE lvc_s_styl.

*      me->get_xxx( ).

    SELECT *
      INTO CORRESPONDING FIELDS OF TABLE @mt_outtab
      FROM spfli
     WHERE carrid IN @so_airid.

*    LOOP AT mt_outtab ASSIGNING FIELD-SYMBOL(<lfs_out>).
*      IF sy-tabix BETWEEN 1 AND 5.
*        <lfs_out>-alv_traff = 1. "Red
*        me->set_editable_cell(
*             EXPORTING iv_fname = 'CHKBOX'
*             CHANGING  ct_style = <lfs_out>-alv_celltab ).
*      ELSEIF sy-tabix BETWEEN 6 AND 8.
*        <lfs_out>-alv_traff = 2. "Yellow
*      ELSE.
*        <lfs_out>-alv_traff = 3. "Green
*      ENDIF.
*    ENDLOOP.

    IF mt_outtab IS INITIAL.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'No data found'.
    ENDIF.
  ENDMETHOD.

  METHOD process_data.
    TRY .
*      me->xxx( ).
      CATCH zbcx_exception INTO DATA(lo_except).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'Error processing data'.
    ENDTRY.
  ENDMETHOD.

  METHOD get_outtab.
    CASE iv_stack_name.
      WHEN mc_stack_main.
        ro_data = _get_main_outtab( ).
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD set_outtab.
    mt_outtab = it_data.
  ENDMETHOD.

  METHOD _get_main_outtab.
    ro_data = REF #( mt_outtab ).
  ENDMETHOD.

ENDCLASS.
