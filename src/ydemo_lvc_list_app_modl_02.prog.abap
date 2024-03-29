*&---------------------------------------------------------------------*
*& Include          YDEMO_APP_MODL
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_model DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_model DEFINITION INHERITING FROM zcl_mvcfw_base_lvc_model.

  PUBLIC SECTION.

    TYPES: BEGIN OF ty_outtab,
             chkbox TYPE flag.
             INCLUDE TYPE spfli.
             INCLUDE TYPE zcl_mvcfw_base_lvc_model=>ts_incl_outtab_ext.
    TYPES:   END OF ty_outtab.
    TYPES: tty_outtab TYPE TABLE OF ty_outtab WITH EMPTY KEY.

    METHODS select_data REDEFINITION.
    METHODS process_data REDEFINITION.
    METHODS get_outtab REDEFINITION.
    METHODS set_outtab REDEFINITION.

  PROTECTED SECTION.


  PRIVATE SECTION.

    DATA mt_outtab TYPE tty_outtab.
    DATA mt_demo_sub01 TYPE sflight_tab2.

    METHODS _get_main_outtab
      RETURNING VALUE(ro_data) TYPE REF TO data.

    METHODS _get_demo_sub01_outtab
      RETURNING VALUE(ro_data) TYPE REF TO data.

    METHODS _get_demo_sub01_data
      RETURNING VALUE(rt_mard) TYPE sflight_tab2.

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

    LOOP AT mt_outtab ASSIGNING FIELD-SYMBOL(<lfs_out>).
      IF sy-tabix BETWEEN 1 AND 5.
        <lfs_out>-alv_traff = 1. "Red
        me->set_editable_cell(
             EXPORTING iv_fname    = 'CHKBOX'
                       iv_disabled = abap_true
             CHANGING  ct_style    = <lfs_out>-alv_celltab ).
      ELSEIF sy-tabix BETWEEN 6 AND 8.
        <lfs_out>-alv_traff = 2. "Yellow
      ELSE.
        <lfs_out>-alv_traff = 3. "Green
      ENDIF.
    ENDLOOP.

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
      WHEN c_stack_main.
        ro_data = _get_main_outtab( ).
      WHEN 'SUB01'.
        IF iv_from_event IS INITIAL.
          _get_demo_sub01_data( ).
        ENDIF.

        ro_data = _get_demo_sub01_outtab( ).
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

  METHOD set_outtab.
    mt_outtab = it_data.
  ENDMETHOD.

  METHOD _get_main_outtab.
    ro_data = REF #( mt_outtab ).
  ENDMETHOD.

  METHOD _get_demo_sub01_outtab.
    ro_data = REF #( mt_demo_sub01 ).
  ENDMETHOD.

  METHOD _get_demo_sub01_data.
    READ TABLE mt_outtab INTO DATA(ls_outtab) INDEX s_action-selfield-tabindex.
    IF sy-subrc EQ 0.
      SELECT * FROM sflight
        WHERE carrid EQ @ls_outtab-carrid
          AND connid EQ @ls_outtab-connid
        INTO TABLE @mt_demo_sub01.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
