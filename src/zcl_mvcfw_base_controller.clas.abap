CLASS zcl_mvcfw_base_controller DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_stack,
        name       TYPE dfies-tabname,
        view       TYPE REF TO zcl_mvcfw_base_view,
        model      TYPE REF TO zcl_mvcfw_base_model,
        controller TYPE REF TO zcl_mvcfw_base_controller,
        is_main    TYPE flag,
        is_current TYPE flag,
        line       TYPE sy-index,
      END OF ty_stack .
    TYPES:
      BEGIN OF ty_stack_name,
        line TYPE sy-index,
        name TYPE dfies-tabname,
      END OF ty_stack_name .
    TYPES:
      tty_stack TYPE TABLE OF ty_stack WITH EMPTY KEY
                                             WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .
    TYPES:
      tty_stack_name TYPE TABLE OF ty_stack_name WITH EMPTY KEY
                                            WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .

    CONSTANTS mc_stack_main TYPE dfies-tabname VALUE 'MAIN' ##NO_TEXT.
    CONSTANTS mc_deflt_cntl TYPE seoclsname VALUE 'LCL_CONTROLLER' ##NO_TEXT.
    CONSTANTS mc_deflt_model TYPE seoclsname VALUE 'LCL_MODEL' ##NO_TEXT.
    CONSTANTS mc_deflt_view TYPE seoclsname VALUE 'LCL_VIEW' ##NO_TEXT.
    CONSTANTS mc_deflt_sscr TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_SSCR' ##NO_TEXT.
    CONSTANTS mc_deflt_outtab TYPE dfies-tabname VALUE 'MT_OUTTAB' ##NO_TEXT.
    DATA mo_sscr TYPE REF TO zcl_mvcfw_base_sscr .
    DATA mo_model TYPE REF TO zcl_mvcfw_base_model .
    DATA mo_view TYPE REF TO zcl_mvcfw_base_view .

    EVENTS evt_pf_status
      EXPORTING
        VALUE(it_extab) TYPE slis_t_extab OPTIONAL .
    EVENTS evt_user_command
      EXPORTING
        VALUE(im_ucomm) TYPE sy-ucomm OPTIONAL
        VALUE(is_selfield) TYPE slis_selfield OPTIONAL .
    EVENTS evt_check_changed_data
      EXPORTING
        VALUE(io_data_changed) TYPE REF TO cl_alv_changed_data_protocol OPTIONAL .
    EVENTS evt_register_event .
    EVENTS evt_top_of_page .
    EVENTS evt_top_of_page_html
      EXPORTING
        VALUE(io_dd_doc) TYPE REF TO cl_dd_document OPTIONAL .
    EVENTS evt_end_of_page_html
      EXPORTING
        VALUE(io_dd_doc) TYPE REF TO cl_dd_document OPTIONAL .

    METHODS constructor
      IMPORTING
        !iv_cntl_name   TYPE seoclsname DEFAULT mc_deflt_cntl
        !iv_modl_name   TYPE seoclsname DEFAULT mc_deflt_model
        !iv_view_name   TYPE seoclsname DEFAULT mc_deflt_view
        !iv_sscr_name   TYPE seoclsname DEFAULT mc_deflt_sscr
        !iv_set_handler TYPE abap_bool DEFAULT abap_true .
    METHODS display
      IMPORTING
        !iv_repid                     TYPE sy-cprog DEFAULT sy-cprog
        !iv_set_pf_status             TYPE slis_formname DEFAULT 'SET_PF_STATUS'
        !iv_user_command              TYPE slis_formname DEFAULT 'USER_COMMAND'
        !iv_callback_top_of_page      TYPE slis_formname OPTIONAL
        !iv_callback_html_top_of_page TYPE slis_formname OPTIONAL
        !iv_callback_html_end_of_list TYPE slis_formname OPTIONAL
        !is_grid_title                TYPE lvc_title OPTIONAL
        !is_grid_settings             TYPE lvc_s_glay OPTIONAL
        !is_layout                    TYPE lvc_s_layo OPTIONAL
        !it_fieldcat                  TYPE lvc_t_fcat OPTIONAL
        !it_excluding                 TYPE slis_t_extab OPTIONAL
        !it_specl_grps                TYPE lvc_t_sgrp OPTIONAL
        !it_sort                      TYPE lvc_t_sort OPTIONAL
        !it_filter                    TYPE lvc_t_filt OPTIONAL
        !iv_default                   TYPE char1 DEFAULT abap_true
        !iv_save                      TYPE char1 DEFAULT abap_true
        !is_variant                   TYPE disvariant OPTIONAL
        !it_event                     TYPE slis_t_event OPTIONAL
        !it_event_exit                TYPE slis_t_event_exit OPTIONAL
        !iv_screen_start_column       TYPE i OPTIONAL
        !iv_screen_start_line         TYPE i OPTIONAL
        !iv_screen_end_column         TYPE i OPTIONAL
        !iv_screen_end_line           TYPE i OPTIONAL
        !iv_html_height_top           TYPE i OPTIONAL
        !iv_html_height_end           TYPE i OPTIONAL
        !iv_stack_name                TYPE dfies-tabname OPTIONAL
      CHANGING
        !ct_data                      TYPE table OPTIONAL
      RAISING
        zbcx_exception .
    METHODS process_any_model
      IMPORTING
        !iv_method TYPE seoclsname
        !it_param  TYPE abap_parmbind_tab OPTIONAL
        !it_excpt  TYPE abap_excpbind_tab OPTIONAL
      RAISING
        zbcx_exception .
    METHODS handle_sscr_pbo
      IMPORTING
        !iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr .
    METHODS handle_sscr_pai
      IMPORTING
        !iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr .
    METHODS handle_pf_status
      FOR EVENT evt_pf_status OF zcl_mvcfw_base_controller
      IMPORTING
        !it_extab .
    METHODS handle_user_command
      FOR EVENT evt_user_command OF zcl_mvcfw_base_controller
      IMPORTING
        !im_ucomm
        !is_selfield .
    METHODS handle_check_changed_data
      FOR EVENT evt_check_changed_data OF zcl_mvcfw_base_controller
      IMPORTING
        !io_data_changed .
    METHODS handle_register_event
        FOR EVENT evt_register_event OF zcl_mvcfw_base_controller .
    METHODS handle_top_of_page
        FOR EVENT evt_top_of_page OF zcl_mvcfw_base_controller .
    METHODS handle_top_of_page_html
      FOR EVENT evt_top_of_page_html OF zcl_mvcfw_base_controller
      IMPORTING
        !io_dd_doc .
    METHODS handle_end_of_page_html
      FOR EVENT evt_end_of_page_html OF zcl_mvcfw_base_controller
      IMPORTING
        !io_dd_doc .
    METHODS raise_pf_status
      IMPORTING
        !it_extab TYPE slis_t_extab OPTIONAL .
    METHODS raise_user_command
      IMPORTING
        !im_ucomm    TYPE sy-ucomm
      CHANGING
        !cs_selfield TYPE slis_selfield .
    METHODS raise_check_changed_data
      IMPORTING
        !io_data_changed TYPE REF TO cl_alv_changed_data_protocol .
    METHODS raise_register_event .
    METHODS raise_top_of_page .
    METHODS raise_top_of_page_html
      IMPORTING
        !io_dd_doc TYPE REF TO cl_dd_document OPTIONAL .
    METHODS raise_end_of_page_html
      IMPORTING
        !io_dd_doc TYPE REF TO cl_dd_document OPTIONAL .
    CLASS-METHODS get_control_instance
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_controller .
    CLASS-METHODS set_stack_name
      IMPORTING
        !iv_stack_name  TYPE dfies-tabname
        !io_model       TYPE REF TO zcl_mvcfw_base_model OPTIONAL
        !io_view        TYPE REF TO zcl_mvcfw_base_view OPTIONAL
        !iv_not_checked TYPE flag DEFAULT space .
    CLASS-METHODS check_routine
      IMPORTING
        !iv_set_value   TYPE flag OPTIONAL
        !iv_get_value   TYPE flag OPTIONAL
      EXPORTING
        VALUE(ev_value) TYPE flag .
    CLASS-METHODS check_routine_only
      RETURNING
        VALUE(rv_check_only) TYPE flag .
    CLASS-METHODS destroy_stack
      IMPORTING
        VALUE(iv_name)         TYPE dfies-tabname OPTIONAL
        VALUE(iv_current_name) TYPE dfies-tabname OPTIONAL .
    CLASS-METHODS get_stack_by_name
      IMPORTING
        !iv_stack_name  TYPE dfies-tabname
      RETURNING
        VALUE(rs_stack) TYPE REF TO ty_stack .
    CLASS-METHODS get_all_stack
      RETURNING
        VALUE(rt_stack) TYPE tty_stack .
    CLASS-METHODS get_current_stack
      RETURNING
        VALUE(rv_current_stack) TYPE dfies-tabname .
  PROTECTED SECTION.

    CLASS-DATA lmt_stack_called TYPE tty_stack_name .
    DATA lmo_cntl TYPE REF TO zcl_mvcfw_base_controller .
    CLASS-DATA lmo_static_cntl TYPE REF TO zcl_mvcfw_base_controller .
    CLASS-DATA lmt_stack TYPE tty_stack .
    CONSTANTS lmc_obj_model TYPE seoclsname VALUE 'MODEL' ##NO_TEXT.
    CONSTANTS lmc_obj_view TYPE seoclsname VALUE 'VIEW' ##NO_TEXT.
    DATA lmv_cl_view_name TYPE char30 .
    DATA lmv_cl_modl_name TYPE char30 .
    DATA lmv_cl_sscr_name TYPE char30 .
    DATA lmv_cl_cntl_name TYPE char30 .
    DATA lms_selfield TYPE slis_selfield .

    METHODS _set_event_handler_for_control .
  PRIVATE SECTION.

    TYPES:
      BEGIN OF lty_class_type,
        sscr       TYPE flag,
        model      TYPE flag,
        view       TYPE flag,
        controller TYPE flag,
      END OF lty_class_type .

    CLASS-DATA lmv_current_stack TYPE dfies-tabname VALUE 'MAIN' ##NO_TEXT.
    DATA lmo_current_model TYPE REF TO zcl_mvcfw_base_model .
    DATA lmo_current_view TYPE REF TO zcl_mvcfw_base_view .
    CLASS-DATA lmv_routine_check TYPE flag .
    CONSTANTS lmc_base_cntl TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_CONTROLLER' ##NO_TEXT.
    CONSTANTS lmc_base_model TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_MODEL' ##NO_TEXT.
    CONSTANTS lmc_base_view TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_VIEW' ##NO_TEXT.
    CONSTANTS lmc_base_sscr TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_SSCR' ##NO_TEXT.

    METHODS _create_any_object
      IMPORTING
        !iv_class_name  TYPE seoclsname
        !is_class_type  TYPE lty_class_type
      EXPORTING
        !ev_class_name  TYPE seoclsname
      RETURNING
        VALUE(ro_class) TYPE REF TO object .
    CLASS-METHODS _check_stack
      IMPORTING
        !iv_name  TYPE dfies-tabname
        !io_model TYPE REF TO zcl_mvcfw_base_model
        !io_view  TYPE REF TO zcl_mvcfw_base_view .
    CLASS-METHODS _get_stack
      IMPORTING
        !iv_name        TYPE dfies-tabname
      RETURNING
        VALUE(rs_stack) TYPE REF TO ty_stack .
    METHODS _set_dynp_stack_name
      IMPORTING
        !io_stack            TYPE REF TO ty_stack
        !iv_object_name      TYPE dfies-tabname
        !iv_stack_name       TYPE dfies-tabname
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_controller .
    CLASS-METHODS _incl_form_base_controller .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_CONTROLLER IMPLEMENTATION.


  METHOD check_routine.

    IF iv_set_value IS SUPPLIED.
      lmv_routine_check = ev_value = iv_set_value.
    ELSEIF iv_get_value IS SUPPLIED.
      ev_value = lmv_routine_check.
    ENDIF.

  ENDMETHOD.


  METHOD check_routine_only.

    zcl_mvcfw_base_controller=>check_routine( EXPORTING iv_get_value = abap_true
                                        IMPORTING ev_value     = rv_check_only ).

  ENDMETHOD.


  METHOD constructor.

    mo_sscr  ?= _create_any_object( EXPORTING iv_class_name = iv_sscr_name
                                              is_class_type = VALUE #( sscr = abap_true )
                                    IMPORTING ev_class_name = lmv_cl_sscr_name ).
    mo_model ?= _create_any_object( EXPORTING iv_class_name = iv_modl_name
                                              is_class_type = VALUE #( model = abap_true )
                                    IMPORTING ev_class_name = lmv_cl_modl_name ).
    mo_view  ?= _create_any_object( EXPORTING iv_class_name = iv_view_name
                                              is_class_type = VALUE #( view = abap_true )
                                    IMPORTING ev_class_name = lmv_cl_view_name ).
    lmo_cntl ?= me.
    lmo_static_cntl ?= me.

    IF iv_set_handler IS NOT INITIAL.
      _set_event_handler_for_control( ).
    ENDIF.

  ENDMETHOD.


  METHOD destroy_stack.
    DATA: ls_stack_called LIKE LINE OF lmt_stack_called,
          ls_stack        LIKE LINE OF lmt_stack.
    FIELD-SYMBOLS <lfs_stack_called> LIKE LINE OF lmt_stack_called.

    IF iv_name IS INITIAL.
      READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
      IF sy-subrc EQ 0.
        DELETE: lmt_stack_called WHERE line EQ ls_stack_called-line,
                lmt_stack       WHERE name EQ ls_stack_called-name.
      ENDIF.

      READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
      IF sy-subrc EQ 0.
        READ TABLE lmt_stack INTO ls_stack
          WITH KEY k2
            COMPONENTS name = ls_stack_called-name.
        IF sy-subrc EQ 0.
          set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                    io_model       = ls_stack-model
                                    io_view        = ls_stack-view
                                    iv_not_checked = abap_true ).
        ENDIF.
      ENDIF.
    ELSE.
      READ TABLE lmt_stack_called INTO ls_stack_called
        WITH KEY k2
          COMPONENTS name = |{ iv_name CASE = UPPER }|.
      IF sy-subrc EQ 0.
        DELETE: lmt_stack_called WHERE line EQ ls_stack_called-line,
                lmt_stack       WHERE name EQ ls_stack_called-name.
      ENDIF.

      SORT lmt_stack_called BY line.

      LOOP AT lmt_stack_called ASSIGNING <lfs_stack_called>.
        <lfs_stack_called>-line = sy-tabix.
      ENDLOOP.

      IF iv_current_name IS NOT INITIAL.
        READ TABLE lmt_stack_called INTO ls_stack_called
          WITH KEY k2
            COMPONENTS name = |{ iv_current_name CASE = UPPER }|.
        IF sy-subrc NE 0.
          READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
        ENDIF.
        IF sy-subrc EQ 0.
          READ TABLE lmt_stack INTO ls_stack
            WITH KEY k2
              COMPONENTS name = ls_stack_called-name.
          IF sy-subrc EQ 0.
            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = ls_stack-model
                                      io_view        = ls_stack-view
                                      iv_not_checked = abap_true ).
          ENDIF.
        ENDIF.
      ELSE.
        READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
        IF sy-subrc EQ 0.
          READ TABLE lmt_stack INTO ls_stack
            WITH KEY k2
              COMPONENTS name = ls_stack_called-name.
          IF sy-subrc EQ 0.
            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = ls_stack-model
                                      io_view        = ls_stack-view
                                      iv_not_checked = abap_true ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD display.
    DATA: lo_out TYPE REF TO data.

    lmv_current_stack = COND #( WHEN iv_stack_name IS NOT INITIAL THEN |{ iv_stack_name CASE = UPPER }|
                               WHEN lmv_current_stack IS INITIAL  THEN mc_stack_main
                               ELSE lmv_current_stack ).

    zcl_mvcfw_base_controller=>_check_stack( iv_name  = lmv_current_stack   "'MAIN'
                                       io_model = mo_model
                                       io_view  = mo_view ).
    DATA(lo_stack) = zcl_mvcfw_base_controller=>_get_stack( lmv_current_stack ).
    IF lo_stack IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          iv_msgv1 = 'Cannot display ALV'.
    ELSE.
      lmo_current_model ?= lo_stack->model.
      lmo_current_view  ?= lo_stack->view.
    ENDIF.

    "Set Object name for Model
    _set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                    iv_object_name = lmc_obj_model
                                    iv_stack_name  = lmv_current_stack ).

    IF ct_data IS SUPPLIED
   AND ct_data IS NOT INITIAL.
      lo_out = REF #( ct_data ).
    ELSE.
      lo_out = lo_stack->model->get_outtab( iv_stack_name = lmv_current_stack ).
    ENDIF.
    IF lo_out IS BOUND.
      ASSIGN lo_out->* TO FIELD-SYMBOL(<lft_out>).
      CHECK <lft_out> IS NOT INITIAL.

      TRY.
          "Set Object name for View
          _set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                          iv_object_name = lmc_obj_view
                                          iv_stack_name  = lmv_current_stack ).

          "Display ALV
          lo_stack->view->display( EXPORTING iv_repid                     = iv_repid
                                             iv_set_pf_status             = iv_set_pf_status
                                             iv_user_command              = iv_user_command
                                             iv_callback_top_of_page      = iv_callback_top_of_page
                                             iv_callback_html_top_of_page = iv_callback_html_top_of_page
                                             iv_callback_html_end_of_list = iv_callback_html_end_of_list
                                             is_grid_title                = is_grid_title
                                             is_grid_settings             = is_grid_settings
                                             is_layout                    = is_layout
                                             it_fieldcat                  = it_fieldcat
                                             it_excluding                 = it_excluding
                                             it_specl_grps                = it_specl_grps
                                             it_sort                      = it_sort
                                             it_filter                    = it_filter
                                             iv_default                   = iv_default
                                             iv_save                      = iv_save
                                             is_variant                   = is_variant
                                             it_event                     = it_event
                                             it_event_exit                = it_event_exit
                                             iv_screen_start_column       = iv_screen_start_column
                                             iv_screen_start_line         = iv_screen_start_line
                                             iv_screen_end_column         = iv_screen_end_column
                                             iv_screen_end_line           = iv_screen_end_line
                                             iv_html_height_top           = iv_html_height_top
                                             iv_html_height_end           = iv_html_height_end
                                    CHANGING ct_data                      = <lft_out> ).
        CATCH zbcx_exception INTO DATA(lo_except).
          RAISE EXCEPTION TYPE zbcx_exception
            EXPORTING
              iv_msgv1 = lo_except->get_text( ).
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD get_all_stack.
    rt_stack = lmt_stack.
  ENDMETHOD.


  METHOD get_control_instance.
    READ TABLE lmt_stack INTO DATA(ls_stack)
      WITH KEY k2 COMPONENTS name = lmv_current_stack.
    IF sy-subrc EQ 0.
      IF ls_stack-controller IS BOUND.
        ro_controller ?= ls_stack-controller.
      ELSE.
        IF lmo_static_cntl IS NOT BOUND.
          lmo_static_cntl = NEW #( ).
        ENDIF.

        ro_controller ?= lmo_static_cntl.
      ENDIF.
    ELSE.
      IF lmo_static_cntl IS NOT BOUND.
        lmo_static_cntl = NEW #( ).
      ENDIF.

      ro_controller ?= lmo_static_cntl.
    ENDIF.
  ENDMETHOD.


  METHOD get_current_stack.
    rv_current_stack = lmv_current_stack.
  ENDMETHOD.


  METHOD get_stack_by_name.
    CHECK iv_stack_name IS NOT INITIAL.

    rs_stack = zcl_mvcfw_base_controller=>_get_stack( EXPORTING iv_name = iv_stack_name ).
  ENDMETHOD.


  METHOD handle_check_changed_data.
    TRY.
        mo_view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                               io_model        = lmo_current_model
                                               iv_stack_name   = lmv_current_stack ).
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_end_of_page_html.
  ENDMETHOD.


  METHOD handle_pf_status.
    TRY.
        mo_view->set_pf_status( EXPORTING it_extab      = it_extab
                                          iv_stack_name = lmv_current_stack ).
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_register_event.
    TRY.
        mo_view->register_event( ).
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_sscr_pai.
    IF mo_sscr IS BOUND.
      mo_sscr->pai( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_sscr_pbo.
    IF mo_sscr IS BOUND.
      mo_sscr->pbo( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_top_of_page.
*CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
*  EXPORTING
*    it_list_commentary       =
**   I_LOGO                   =
**   I_END_OF_LIST_GRID       =
**   I_ALV_FORM               =
*          .
  ENDMETHOD.


  METHOD handle_top_of_page_html.
  ENDMETHOD.


  METHOD handle_user_command.

    lms_selfield = is_selfield.

    TRY.
        DATA(lo_stack) = _get_stack( lmv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->user_command( EXPORTING im_ucomm    = im_ucomm
                                                  io_model    = lo_stack->model
                                                  io_cntlr    = lo_stack->controller
                                        CHANGING  cs_selfield = lms_selfield ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_view( ).
          IF lo_view IS BOUND.
            lo_view->user_command( EXPORTING im_ucomm    = im_ucomm
                                             io_model    = me->mo_model
                                             io_cntlr    = me
                                   CHANGING  cs_selfield = lms_selfield ).
          ENDIF.
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_except).
    ENDTRY.

  ENDMETHOD.


  METHOD process_any_model.
    DATA lv_method TYPE seoclsname.

    IF mo_model IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          iv_msgv1 = 'Model was not created'.
    ENDIF.

    TRY.
        lv_method = |{ iv_method CASE = UPPER }|.

        IF it_param IS SUPPLIED AND it_param IS NOT INITIAL
       AND it_excpt IS SUPPLIED AND it_excpt IS NOT INITIAL.
          CALL METHOD mo_model->(lv_method)
            PARAMETER-TABLE it_param
            EXCEPTION-TABLE it_excpt.
        ELSEIF it_param IS SUPPLIED AND it_param IS NOT INITIAL.
          CALL METHOD mo_model->(lv_method)
            PARAMETER-TABLE it_param.
        ELSE.
          CALL METHOD mo_model->(lv_method).
        ENDIF.
      CATCH cx_sy_no_handler
            cx_sy_dyn_call_excp_not_found
            cx_sy_dyn_call_illegal_class
            cx_sy_dyn_call_illegal_method
            cx_sy_dyn_call_illegal_type
            cx_sy_dyn_call_param_missing
            cx_sy_dyn_call_param_not_found
            cx_sy_ref_is_initial
        INTO DATA(lo_except).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            iv_msgv1 = lo_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD raise_check_changed_data.

    RAISE EVENT evt_check_changed_data
      EXPORTING
        io_data_changed = io_data_changed.

  ENDMETHOD.


  METHOD raise_end_of_page_html.

    RAISE EVENT evt_end_of_page_html
      EXPORTING
        io_dd_doc = io_dd_doc.

  ENDMETHOD.


  METHOD raise_pf_status.

    RAISE EVENT evt_pf_status
     EXPORTING
       it_extab = it_extab.

  ENDMETHOD.


  METHOD raise_register_event.

    RAISE EVENT evt_register_event.

  ENDMETHOD.


  METHOD raise_top_of_page.

    RAISE EVENT evt_top_of_page.

  ENDMETHOD.


  METHOD raise_top_of_page_html.

    RAISE EVENT evt_top_of_page_html
      EXPORTING
        io_dd_doc = io_dd_doc.

  ENDMETHOD.


  METHOD raise_user_command.

    RAISE EVENT evt_user_command
      EXPORTING
        im_ucomm    = im_ucomm
        is_selfield = cs_selfield.

    cs_selfield = lms_selfield.

  ENDMETHOD.


  METHOD set_stack_name.
    CHECK iv_stack_name IS NOT INITIAL.

    lmv_current_stack = |{ iv_stack_name CASE = UPPER }|.

    IF io_model IS BOUND.
      io_model->set_stack_name( lmv_current_stack ).
    ENDIF.

    IF io_view IS BOUND.
      io_view->set_stack_name( lmv_current_stack ).
    ENDIF.

    IF iv_not_checked IS INITIAL.
      _check_stack( iv_name  = lmv_current_stack   "'MAIN'
                    io_model = io_model
                    io_view  = io_view ).
    ELSE.
      LOOP AT lmt_stack ASSIGNING FIELD-SYMBOL(<lfs_stack>).
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( lmt_stack ) THEN abap_true ).
      ENDLOOP.
    ENDIF.

  ENDMETHOD.


  METHOD _check_stack.
    DATA: lo_view  TYPE REF TO zcl_mvcfw_base_view,
          lo_model TYPE REF TO zcl_mvcfw_base_model.
    DATA: lv_line TYPE sy-index.

    DATA(lv_name) = |{ iv_name CASE = UPPER }|.

    IF NOT line_exists( lmt_stack[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR: lo_view, lo_model, lv_line.

      lo_view  ?= io_view.
      lo_model ?= io_model.
      lv_line   = lines( lmt_stack ) + 1.

      IF lmo_static_cntl IS NOT BOUND.
        lmo_static_cntl = NEW #( ).
      ENDIF.

*      APPEND VALUE #( name       = lv_name
*                      view       = lo_view
*                      model      = lo_model
*                      controller = me ) TO lmt_stack.
      APPEND VALUE #( name       = COND #( WHEN lv_line EQ 1 THEN mc_stack_main ELSE lv_name )
                      view       = lo_view
                      model      = lo_model
                      controller = lmo_static_cntl
                      is_main    = COND #( WHEN lv_line EQ 1 THEN abap_true )
                      line       = lv_line
                    ) TO lmt_stack.

      LOOP AT lmt_stack ASSIGNING FIELD-SYMBOL(<lfs_stack>).
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( lmt_stack ) THEN abap_true ).
      ENDLOOP.
    ENDIF.

    IF NOT line_exists( lmt_stack_called[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR lv_line.

      lv_line = lines( lmt_stack_called ) + 1.

      APPEND VALUE #( line = lv_line
                      name = COND #( WHEN lv_line EQ 1 THEN mc_stack_main ELSE lv_name )
                    ) TO lmt_stack_called.
    ENDIF.
  ENDMETHOD.


  METHOD _create_any_object.
    DATA: ls_class_type TYPE lty_class_type.
    DATA: lv_object     TYPE string,
          lv_class_name TYPE char30.

    lv_class_name = |{ iv_class_name CASE = UPPER }|.
    lv_object     = |\\PROGRAM={ sy-cprog }\\CLASS={ lv_class_name }|.
    ls_class_type = is_class_type.

    TRY.
        CREATE OBJECT ro_class TYPE (lv_object).
        ev_class_name = lv_class_name.
      CATCH cx_sy_create_object_error.
        TRY.
            lv_object = COND #( WHEN ls_class_type-sscr       IS NOT INITIAL THEN lmc_base_sscr
                                WHEN ls_class_type-model      IS NOT INITIAL THEN lmc_base_model
                                WHEN ls_class_type-view       IS NOT INITIAL THEN lmc_base_view
                                WHEN ls_class_type-controller IS NOT INITIAL THEN lmc_base_cntl ).
            CHECK lv_object IS NOT INITIAL.

            CREATE OBJECT ro_class TYPE (lv_object).
            ev_class_name = lv_object.
          CATCH cx_sy_create_object_error.
        ENDTRY.
    ENDTRY.
  ENDMETHOD.


  METHOD _get_stack.
    TRY.
        rs_stack = REF #( lmt_stack[ KEY k2 COMPONENTS name = iv_name ] ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.


  METHOD _incl_form_base_controller.
*&---------------------------------------------------------------------*
*& Don't use this method!!!.
*& This is only prototype code to copy for creating new include program
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Include          ZINCL_FORM_BASE_CONTROLLER
*&---------------------------------------------------------------------*
*  FORM set_pf_status USING rt_extab TYPE slis_t_extab.
*
*    ZCL_MVCFW_BASE_CONTROLLER=>get_control_instance( )->raise_pf_status( rt_extab ).
*
*  ENDFORM.
*
*  FORM user_command  USING up_ucomm    TYPE sy-ucomm
*                           us_selfield TYPE slis_selfield.
*
*    ZCL_MVCFW_BASE_CONTROLLER=>get_control_instance( )->raise_user_command( EXPORTING im_ucomm    = up_ucomm
*                                                                      CHANGING  cs_selfield = us_selfield ).
*  ENDFORM.
*
*  FORM check_data_changed USING er_data_changed  TYPE REF TO cl_alv_changed_data_protocol.
*
*    ZCL_MVCFW_BASE_CONTROLLER=>get_control_instance( )->raise_check_changed_data( er_data_changed ).
*
*  ENDFORM.
*
*  FORM caller_exit USING is_data TYPE slis_data_caller_exit.
*
*    ZCL_MVCFW_BASE_CONTROLLER=>get_control_instance( )->raise_register_event( ).
*
*  ENDFORM.
*
*  FORM top_of_page.
*
*    ZCL_MVCFW_BASE_CONTROLLER=>check_routine( EXPORTING iv_get_value = abap_true
*                                        IMPORTING ev_value     = DATA(lv_check_only) ).
*    IF lv_check_only IS NOT INITIAL.  RETURN.  ENDIF.
*
*    ZCL_MVCFW_BASE_CONTROLLER=>get_control_instance( )->raise_top_of_page( ).
*
*  ENDFORM.
*
*  FORM top_of_page_html USING cl_dd TYPE REF TO cl_dd_document.
*
*    ZCL_MVCFW_BASE_CONTROLLER=>get_control_instance( )->raise_top_of_page_html( cl_dd ).
*
*  ENDFORM.
*
*  FORM end_of_page_html USING cl_dd TYPE REF TO cl_dd_document.
*
*    ZCL_MVCFW_BASE_CONTROLLER=>get_control_instance( )->raise_end_of_page_html( cl_dd ).
*
*  ENDFORM.
  ENDMETHOD.


  METHOD _set_dynp_stack_name.
    ro_controller = me.

    CHECK io_stack IS BOUND.

    TRY.
        CASE iv_object_name.
          WHEN lmc_obj_model.
            io_stack->model->set_stack_name( iv_stack_name ).
          WHEN lmc_obj_view.
            io_stack->view->set_stack_name( iv_stack_name ).
        ENDCASE.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.

  ENDMETHOD.


  METHOD _set_event_handler_for_control.
    SET HANDLER handle_pf_status
                handle_user_command
                handle_check_changed_data
                handle_register_event
                handle_top_of_page
                handle_top_of_page_html
                handle_end_of_page_html
            FOR me.
  ENDMETHOD.
ENDCLASS.
