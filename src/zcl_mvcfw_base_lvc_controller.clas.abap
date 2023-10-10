CLASS zcl_mvcfw_base_lvc_controller DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ts_lvc_view_action,
        ucomm        TYPE sy-ucomm,
        selfield     TYPE slis_selfield,
        data_changed TYPE REF TO cl_alv_changed_data_protocol,
        cl_dd        TYPE REF TO cl_dd_document,
        caller_exit  TYPE slis_data_caller_exit,
      END OF ts_lvc_view_action .
    TYPES:
      BEGIN OF ts_stack,
        name         TYPE dfies-tabname,
        view         TYPE REF TO zcl_mvcfw_base_lvc_view,
        lvc_v_action TYPE REF TO ts_lvc_view_action,
        model        TYPE REF TO zcl_mvcfw_base_lvc_model,
        controller   TYPE REF TO zcl_mvcfw_base_lvc_controller,
        is_main      TYPE flag,
        is_current   TYPE flag,
        line         TYPE sy-index,
      END OF ts_stack .
    TYPES:
      BEGIN OF ts_stack_name,
        line TYPE sy-index,
        name TYPE dfies-tabname,
      END OF ts_stack_name .
    TYPES:
      tt_stack TYPE TABLE OF ts_stack WITH EMPTY KEY
                                               WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .
    TYPES:
      tt_stack_name TYPE TABLE OF ts_stack_name WITH EMPTY KEY
                                                         WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .
    TYPES:
      tt_controller TYPE SORTED TABLE OF REF TO zcl_mvcfw_base_lvc_controller WITH UNIQUE KEY table_line .

    CONSTANTS c_stack_main TYPE dfies-tabname VALUE 'MAIN' ##NO_TEXT.
    CONSTANTS c_deflt_cntl TYPE seoclsname VALUE 'LCL_CONTROLLER' ##NO_TEXT.
    CONSTANTS c_deflt_model TYPE seoclsname VALUE 'LCL_MODEL' ##NO_TEXT.
    CONSTANTS c_deflt_view TYPE seoclsname VALUE 'LCL_VIEW' ##NO_TEXT.
    CONSTANTS c_deflt_sscr TYPE seoclsname VALUE 'LCL_SSCR' ##NO_TEXT.
    CONSTANTS c_deflt_outtab TYPE dfies-tabname VALUE 'MT_OUTTAB' ##NO_TEXT.
    CONSTANTS c_display_lvc_list TYPE salv_de_constant VALUE 1 ##NO_TEXT.
    CONSTANTS c_display_lvc_hierseq TYPE salv_de_constant VALUE 2 ##NO_TEXT.
    DATA o_sscr TYPE REF TO zcl_mvcfw_base_sscr READ-ONLY .
    DATA o_view TYPE REF TO zcl_mvcfw_base_lvc_view READ-ONLY .
    DATA o_model TYPE REF TO zcl_mvcfw_base_lvc_model READ-ONLY .
    DATA s_view_action TYPE ts_lvc_view_action READ-ONLY .

    EVENTS evt_pf_status
      EXPORTING
        VALUE(it_extab) TYPE slis_t_extab OPTIONAL .
    EVENTS evt_user_command
      EXPORTING
        VALUE(im_ucomm) TYPE sy-ucomm
        VALUE(is_selfield) TYPE slis_selfield .
    EVENTS evt_check_changed_data
      EXPORTING
        VALUE(io_data_changed) TYPE REF TO cl_alv_changed_data_protocol .
    EVENTS evt_register_event
      EXPORTING
        VALUE(is_data) TYPE slis_data_caller_exit OPTIONAL .
    EVENTS evt_top_of_page .
    EVENTS evt_top_of_page_html
      EXPORTING
        VALUE(ir_dd_doc) TYPE REF TO cl_dd_document .
    EVENTS evt_end_of_page_html
      EXPORTING
        VALUE(ir_dd_doc) TYPE REF TO cl_dd_document .

    METHODS constructor
      IMPORTING
        !iv_cntl_name   TYPE seoclsname DEFAULT c_deflt_cntl
        !iv_modl_name   TYPE seoclsname DEFAULT c_deflt_model
        !iv_view_name   TYPE seoclsname DEFAULT c_deflt_view
        !iv_sscr_name   TYPE seoclsname DEFAULT c_deflt_sscr
        !iv_set_handler TYPE abap_bool DEFAULT abap_true .
    METHODS display
      IMPORTING
        !iv_display_type              TYPE salv_de_constant DEFAULT c_display_lvc_list
        !iv_repid                     TYPE sy-cprog DEFAULT sy-cprog
        !iv_set_pf_status             TYPE flag DEFAULT abap_true
        !iv_user_command              TYPE flag DEFAULT abap_true
        !iv_callback_top_of_page      TYPE flag OPTIONAL
        !iv_callback_html_top_of_page TYPE flag OPTIONAL
        !iv_callback_html_end_of_list TYPE flag OPTIONAL
        !is_grid_title                TYPE lvc_title OPTIONAL
        !is_grid_settings             TYPE lvc_s_glay OPTIONAL
        !is_layout                    TYPE lvc_s_layo OPTIONAL
        !it_fieldcat                  TYPE lvc_t_fcat OPTIONAL
        !it_excluding                 TYPE slis_t_extab OPTIONAL
        !it_specl_grps                TYPE lvc_t_sgrp OPTIONAL
        !it_sort                      TYPE lvc_t_sort OPTIONAL
        !it_filter                    TYPE lvc_t_filt OPTIONAL
        !iv_default                   TYPE char1 DEFAULT abap_true
        !iv_save                      TYPE char1 DEFAULT 'A'
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
      EXPORTING
        !it_excpt  TYPE abap_excpbind_tab
      RAISING
        zbcx_exception .
    METHODS handle_sscr_pbo
      IMPORTING
        !iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr .
    METHODS handle_sscr_pai
      IMPORTING
        !iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr .
    METHODS handle_pf_status
      FOR EVENT evt_pf_status OF zcl_mvcfw_base_lvc_controller
      IMPORTING
        !it_extab .
    METHODS handle_user_command
      FOR EVENT evt_user_command OF zcl_mvcfw_base_lvc_controller
      IMPORTING
        !im_ucomm
        !is_selfield .
    METHODS handle_check_changed_data
      FOR EVENT evt_check_changed_data OF zcl_mvcfw_base_lvc_controller
      IMPORTING
        !io_data_changed .
    METHODS handle_top_of_page_html
      FOR EVENT evt_top_of_page_html OF zcl_mvcfw_base_lvc_controller
      IMPORTING
        !ir_dd_doc .
    METHODS handle_top_of_page
        FOR EVENT evt_top_of_page OF zcl_mvcfw_base_lvc_controller .
    METHODS handle_end_of_page_html
      FOR EVENT evt_end_of_page_html OF zcl_mvcfw_base_lvc_controller
      IMPORTING
        !ir_dd_doc .
    METHODS handle_register_event
      FOR EVENT evt_register_event OF zcl_mvcfw_base_lvc_controller
      IMPORTING
        !is_data .
    METHODS set_stack_name
      IMPORTING
        !iv_stack_name       TYPE dfies-tabname
        !io_model            TYPE REF TO zcl_mvcfw_base_lvc_model OPTIONAL
        !io_view             TYPE REF TO zcl_mvcfw_base_lvc_view OPTIONAL
        !iv_not_checked      TYPE flag DEFAULT space
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_lvc_controller .
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
    METHODS raise_register_event
      CHANGING
        !cs_data TYPE slis_data_caller_exit OPTIONAL .
    METHODS raise_top_of_page .
    METHODS raise_top_of_page_html
      IMPORTING
        !ir_dd_doc TYPE REF TO cl_dd_document OPTIONAL .
    METHODS raise_end_of_page_html
      IMPORTING
        !ir_dd_doc TYPE REF TO cl_dd_document OPTIONAL .
    CLASS-METHODS check_routine_only
      RETURNING
        VALUE(rv_check_only) TYPE flag .
    CLASS-METHODS get_instance
      IMPORTING
        !io_controller       TYPE REF TO zcl_mvcfw_base_lvc_controller OPTIONAL
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_lvc_controller .
    METHODS set_check_routine
      IMPORTING
        !iv_set_value TYPE flag OPTIONAL
        !iv_get_value TYPE flag OPTIONAL
      EXPORTING
        !ev_value     TYPE flag .
    METHODS destroy_stack
      IMPORTING
        !iv_name         TYPE dfies-tabname OPTIONAL
        !iv_current_name TYPE dfies-tabname OPTIONAL .
    METHODS get_stack_by_name
      IMPORTING
        !iv_stack_name  TYPE dfies-tabname
      RETURNING
        VALUE(rs_stack) TYPE REF TO ts_stack .
    METHODS get_all_stack
      RETURNING
        VALUE(rt_stack) TYPE tt_stack .
    METHODS get_current_stack
      RETURNING
        VALUE(rv_current_stack) TYPE dfies-tabname .
    METHODS set_view_action
      IMPORTING
        !ir_action           TYPE REF TO ts_lvc_view_action
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_lvc_controller .
    METHODS get_model
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_lvc_model .
    METHODS set_model
      IMPORTING
        !io_model            TYPE REF TO zcl_mvcfw_base_lvc_model
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_lvc_controller .
    METHODS get_view
      RETURNING
        VALUE(ro_view) TYPE REF TO zcl_mvcfw_base_lvc_view .
    METHODS set_view
      IMPORTING
        !io_view             TYPE REF TO zcl_mvcfw_base_lvc_view
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_lvc_controller .
    METHODS set_event_handler_for_control
      IMPORTING
        !io_controller TYPE REF TO zcl_mvcfw_base_lvc_controller OPTIONAL .
  PROTECTED SECTION.

    CLASS-DATA mt_stack_called TYPE tt_stack_name .
    CLASS-DATA mt_stack TYPE tt_stack .
    CONSTANTS mc_obj_model TYPE seoclsname VALUE 'MODEL' ##NO_TEXT.
    CONSTANTS mc_obj_view TYPE seoclsname VALUE 'VIEW' ##NO_TEXT.
    DATA mv_cl_view_name TYPE char30 .
    DATA mv_cl_modl_name TYPE char30 .
    DATA mv_cl_sscr_name TYPE char30 .
    DATA mv_cl_cntl_name TYPE char30 .
    DATA mv_current_stack TYPE dfies-tabname VALUE c_stack_main ##NO_TEXT.

    METHODS _store_controller_instance
      IMPORTING
        !io_controller TYPE REF TO zcl_mvcfw_base_lvc_controller OPTIONAL .
    METHODS _display_lvc_grid
      IMPORTING
        !iv_repid                     TYPE sy-cprog DEFAULT sy-cprog
        !iv_set_pf_status             TYPE flag DEFAULT abap_true
        !iv_user_command              TYPE flag DEFAULT abap_true
        !iv_callback_top_of_page      TYPE flag OPTIONAL
        !iv_callback_html_top_of_page TYPE flag OPTIONAL
        !iv_callback_html_end_of_list TYPE flag OPTIONAL
        !is_grid_title                TYPE lvc_title OPTIONAL
        !is_grid_settings             TYPE lvc_s_glay OPTIONAL
        !is_layout                    TYPE lvc_s_layo OPTIONAL
        !it_fieldcat                  TYPE lvc_t_fcat OPTIONAL
        !it_excluding                 TYPE slis_t_extab OPTIONAL
        !it_specl_grps                TYPE lvc_t_sgrp OPTIONAL
        !it_sort                      TYPE lvc_t_sort OPTIONAL
        !it_filter                    TYPE lvc_t_filt OPTIONAL
        !iv_default                   TYPE char1 DEFAULT abap_true
        !iv_save                      TYPE char1 DEFAULT 'A'
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
  PRIVATE SECTION.

    TYPES:
      BEGIN OF lty_class_type,
        sscr       TYPE flag,
        model      TYPE flag,
        view       TYPE flag,
        controller TYPE flag,
      END OF lty_class_type .

    CLASS-DATA mo_controller_instance TYPE REF TO zcl_mvcfw_base_lvc_controller .
    DATA mv_routine_check TYPE flag .
    CONSTANTS mc_base_cntl TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_LVC_CONTROLLER' ##NO_TEXT.
    CONSTANTS mc_base_model TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_LVC_MODEL' ##NO_TEXT.
    CONSTANTS mc_base_view TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_LVC_VIEW' ##NO_TEXT.
    CONSTANTS mc_base_sscr TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_SSCR' ##NO_TEXT.
    CLASS-DATA mt_controller TYPE tt_controller .

    CLASS-METHODS _create_any_object
      IMPORTING
        !iv_class_name  TYPE seoclsname
        !is_class_type  TYPE lty_class_type
      EXPORTING
        !ev_class_name  TYPE seoclsname
      RETURNING
        VALUE(ro_class) TYPE REF TO object .
    METHODS _build_stack
      IMPORTING
        !iv_name       TYPE dfies-tabname
        !io_model      TYPE REF TO zcl_mvcfw_base_lvc_model OPTIONAL
        !io_view       TYPE REF TO zcl_mvcfw_base_lvc_view OPTIONAL
        !io_controller TYPE REF TO zcl_mvcfw_base_lvc_controller OPTIONAL .
    METHODS _get_stack
      IMPORTING
        !iv_name        TYPE dfies-tabname
      RETURNING
        VALUE(rs_stack) TYPE REF TO ts_stack .
    METHODS _set_dynp_stack_name
      IMPORTING
        !io_stack            TYPE REF TO ts_stack
        !iv_object_name      TYPE dfies-tabname
        !iv_stack_name       TYPE dfies-tabname
      RETURNING
        VALUE(ro_controller) TYPE REF TO zcl_mvcfw_base_lvc_controller .
    CLASS-METHODS _form_base_controller_template .
    METHODS _clear_view_action .
    METHODS _populate_view_contoller
      IMPORTING
        !io_model        TYPE REF TO zcl_mvcfw_base_lvc_model
        !io_controller   TYPE REF TO zcl_mvcfw_base_lvc_controller
      EXPORTING
        !eo_current_view TYPE REF TO zcl_mvcfw_base_lvc_view
      CHANGING
        !co_view         TYPE REF TO zcl_mvcfw_base_lvc_view .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_LVC_CONTROLLER IMPLEMENTATION.


  METHOD check_routine_only.
    mo_controller_instance->set_check_routine( EXPORTING iv_get_value = abap_true
                                                IMPORTING ev_value     = rv_check_only ).
  ENDMETHOD.


  METHOD constructor.
*--------------------------------------------------------------------*
*
*   Parent_Class =  Child_Class   (Narrow/Up Casting)
*   Child_Class  ?= Parent_Class  (Widening/Down Casting)
*
*--------------------------------------------------------------------*
    TRY.
        o_sscr  = CAST #( _create_any_object( EXPORTING iv_class_name = iv_sscr_name
                                                        is_class_type = VALUE #( sscr = abap_true )
                                              IMPORTING ev_class_name = mv_cl_sscr_name ) ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        o_model = CAST #( _create_any_object( EXPORTING iv_class_name = iv_modl_name
                                                        is_class_type = VALUE #( model = abap_true )
                                              IMPORTING ev_class_name = mv_cl_modl_name ) ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        o_view  = CAST #( _create_any_object( EXPORTING iv_class_name = iv_view_name
                                                        is_class_type = VALUE #( view = abap_true )
                                              IMPORTING ev_class_name = mv_cl_view_name ) ).
        IF o_view IS BOUND.
*          o_view->set_controller_to_view( me )->set_model_to_view( o_model ).
          o_view->set_model_to_view( o_model ).
        ENDIF.
      CATCH cx_sy_move_cast_error.
    ENDTRY.

    _store_controller_instance( me ).

    IF iv_set_handler IS NOT INITIAL.
      set_event_handler_for_control( ).
    ENDIF.
  ENDMETHOD.


  METHOD destroy_stack.
    DATA: ls_stack_called LIKE LINE OF mt_stack_called,
          ls_stack        LIKE LINE OF mt_stack.
    DATA: lr_stack        TYPE REF TO ts_stack.
    FIELD-SYMBOLS <lfs_stack_called> LIKE LINE OF mt_stack_called.

    _clear_view_action( ).

    IF iv_name IS INITIAL.
      READ TABLE mt_stack_called INTO ls_stack_called INDEX lines( mt_stack_called ).
      IF sy-subrc EQ 0.
        DELETE: mt_stack_called WHERE line EQ ls_stack_called-line,
                mt_stack        WHERE name EQ ls_stack_called-name.
      ENDIF.

      "--------------------------------------------------------------------"
      " Read and set previous stack
      "--------------------------------------------------------------------"
      READ TABLE mt_stack_called INTO ls_stack_called INDEX lines( mt_stack_called ).
      IF sy-subrc EQ 0.
        READ TABLE mt_stack REFERENCE INTO lr_stack
          WITH KEY k2
            COMPONENTS name = ls_stack_called-name.
        IF sy-subrc EQ 0.
          mo_controller_instance = lr_stack->controller.
          o_model = lr_stack->model.
          o_view  = lr_stack->view.

          set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                    io_model       = o_model
                                    io_view        = o_view
                                    iv_not_checked = abap_true ).
          _populate_view_contoller( EXPORTING io_model        = lr_stack->model
                                              io_controller   = lr_stack->controller
                                    IMPORTING eo_current_view = o_view
                                    CHANGING  co_view         = lr_stack->view ).
        ENDIF.
      ENDIF.
    ELSE.
      READ TABLE mt_stack_called INTO ls_stack_called
        WITH KEY k2
          COMPONENTS name = |{ iv_name CASE = UPPER }|.
      IF sy-subrc EQ 0.
        DELETE: mt_stack_called WHERE line EQ ls_stack_called-line,
                mt_stack        WHERE name EQ ls_stack_called-name.
      ENDIF.

      "--------------------------------------------------------------------"
      " Read and set previous stack
      "--------------------------------------------------------------------"
      SORT mt_stack_called BY line.

      LOOP AT mt_stack_called ASSIGNING <lfs_stack_called>.
        <lfs_stack_called>-line = sy-tabix.
      ENDLOOP.

      IF iv_current_name IS NOT INITIAL.
        READ TABLE mt_stack_called INTO ls_stack_called
          WITH KEY k2
            COMPONENTS name = |{ iv_current_name CASE = UPPER }|.
        IF sy-subrc NE 0.
          READ TABLE mt_stack_called INTO ls_stack_called INDEX lines( mt_stack_called ).
        ENDIF.
        IF sy-subrc EQ 0.
          READ TABLE mt_stack REFERENCE INTO lr_stack
            WITH KEY k2
              COMPONENTS name = ls_stack_called-name.
          IF sy-subrc EQ 0.
            mo_controller_instance  = lr_stack->controller.
            o_model = lr_stack->model.
            o_view  = lr_stack->view.

            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = o_model
                                      io_view        = o_view
                                      iv_not_checked = abap_true ).
            _populate_view_contoller( EXPORTING io_model        = lr_stack->model
                                                io_controller   = lr_stack->controller
                                      IMPORTING eo_current_view = o_view
                                      CHANGING  co_view         = lr_stack->view ).
          ENDIF.
        ENDIF.
      ELSE.
        READ TABLE mt_stack_called INTO ls_stack_called INDEX lines( mt_stack_called ).
        IF sy-subrc EQ 0.
          READ TABLE mt_stack REFERENCE INTO lr_stack
            WITH KEY k2
              COMPONENTS name = ls_stack_called-name.
          IF sy-subrc EQ 0.
            mo_controller_instance  = lr_stack->controller.
            o_model = lr_stack->model.
            o_view  = lr_stack->view.

            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = o_model
                                      io_view        = o_view
                                      iv_not_checked = abap_true ).
            _populate_view_contoller( EXPORTING io_model        = lr_stack->model
                                                io_controller   = lr_stack->controller
                                      IMPORTING eo_current_view = o_view
                                      CHANGING  co_view         = lr_stack->view ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

    "--------------------------------------------------------------------"
    " Try to replace SALV parameters with previous parameters
    "--------------------------------------------------------------------"
    READ TABLE mt_stack INTO ls_stack WITH KEY is_current = abap_true.
    IF sy-subrc EQ 0.
      IF ls_stack-lvc_v_action IS BOUND.
        me->s_view_action = ls_stack-lvc_v_action->*.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD display.
    DATA: lv_display_type	TYPE salv_de_constant.

    lv_display_type = COND #( WHEN iv_display_type IS NOT INITIAL THEN iv_display_type
                              ELSE c_display_lvc_list ).

    CASE lv_display_type.
      WHEN c_display_lvc_list.
        CALL METHOD me->_display_lvc_grid
          EXPORTING
            iv_repid                     = iv_repid
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
            iv_stack_name                = iv_stack_name
          CHANGING
            ct_data                      = ct_data.
*    	WHEN mc_display_lvc_hierseq.

      WHEN OTHERS.
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = 'Display type does not match'.
    ENDCASE.
  ENDMETHOD.


  METHOD get_all_stack.
    rt_stack = mt_stack.
  ENDMETHOD.


  METHOD get_current_stack.
    rv_current_stack = mv_current_stack.
  ENDMETHOD.


  METHOD get_stack_by_name.
    CHECK iv_stack_name IS NOT INITIAL.

    rs_stack = me->_get_stack( EXPORTING iv_name = iv_stack_name ).
  ENDMETHOD.


  METHOD handle_check_changed_data.
    DATA: lo_out TYPE REF TO data.
    FIELD-SYMBOLS: <lft_outtab> TYPE table.

    TRY.
        DATA(lo_stack) = _get_stack( mv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_out = lo_stack->model->get_outtab( iv_stack_name = mv_current_stack
                                                iv_from_event = abap_true
                                                iv_formname   = zcl_mvcfw_base_lvc_view=>c_callback_fname-check_changed_data ).
          IF lo_out IS BOUND.
            ASSIGN lo_out->* TO <lft_outtab>.
          ENDIF.

          IF <lft_outtab> IS ASSIGNED.
            lo_stack->view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                                          iv_stack_name   = mv_current_stack
                                                CHANGING  ct_data         = <lft_outtab> ).
          ELSE.
            lo_stack->view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                                          iv_stack_name   = mv_current_stack ).
          ENDIF.

          lo_stack->view->handle_gui_alv_grid( lo_stack->view->get_lvc_gui_alv_grid( ) ).
          lo_stack->view->redraw_alv_grid( )->refresh_table_display( ).
        ELSE.
          lo_out = o_model->get_outtab( iv_stack_name = mv_current_stack
                                                  iv_from_event = abap_true
                                                  iv_formname   = zcl_mvcfw_base_lvc_view=>c_callback_fname-check_changed_data ).
          IF lo_out IS BOUND.
            ASSIGN lo_out->* TO <lft_outtab>.
          ENDIF.

          IF o_view IS BOUND.
            IF <lft_outtab> IS ASSIGNED.
              o_view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                                     iv_stack_name   = mv_current_stack
                                           CHANGING  ct_data         = <lft_outtab> ).
            ELSE.
              o_view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                                     iv_stack_name   = mv_current_stack ).
            ENDIF.

            o_view->handle_gui_alv_grid( o_view->get_lvc_gui_alv_grid( ) ).
            o_view->redraw_alv_grid( )->refresh_table_display( ).
          ELSE.
            DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).

            IF <lft_outtab> IS ASSIGNED.
              lo_view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                                     iv_stack_name   = mv_current_stack
                                           CHANGING  ct_data         = <lft_outtab> ).
            ELSE.
              lo_view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                                     iv_stack_name   = mv_current_stack ).
            ENDIF.

            lo_view->handle_gui_alv_grid( lo_view->get_lvc_gui_alv_grid( ) ).
            lo_view->redraw_alv_grid( )->refresh_table_display( ).
          ENDIF.
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_end_of_page_html.
    TRY.
        DATA(lo_stack) = _get_stack( mv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->set_end_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                          iv_stack_name = lo_stack->name ).
        ELSEIF o_view IS BOUND.
          o_view->set_end_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                   iv_stack_name = mv_current_stack ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->set_end_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                   iv_stack_name = mv_current_stack ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_pf_status.
    TRY.
        DATA(lo_stack) = _get_stack( mv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->set_pf_status( EXPORTING it_extab      = it_extab
                                                   iv_stack_name = lo_stack->name ).
        ELSEIF o_view IS BOUND.
          o_view->set_pf_status( EXPORTING it_extab      = it_extab
                                            iv_stack_name = mv_current_stack ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->set_pf_status( EXPORTING it_extab      = it_extab
                                            iv_stack_name = mv_current_stack ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_register_event.
    TRY.
        DATA(lo_stack) = _get_stack( mv_current_stack ).
        s_view_action-caller_exit = is_data.

        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->register_event( CHANGING cs_caller_exit = s_view_action-caller_exit ).
        ELSEIF o_view IS BOUND.
          o_view->register_event( CHANGING cs_caller_exit = s_view_action-caller_exit ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->register_event( CHANGING cs_caller_exit = s_view_action-caller_exit ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_except).
        DATA(lv_msg) = lo_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_sscr_pai.
    IF o_sscr IS NOT BOUND.
      o_sscr = NEW #( ).
    ENDIF.
    IF o_sscr IS BOUND.
      o_sscr->pai( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_sscr_pbo.
    IF o_sscr IS NOT BOUND.
      o_sscr = NEW #( ).
    ENDIF.
    IF o_sscr IS BOUND.
      o_sscr->pbo( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_top_of_page.
    TRY.
        DATA(lo_stack) = _get_stack( mv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->set_top_of_page( lo_stack->name ).
        ELSEIF o_view IS BOUND.
          o_view->set_top_of_page( mv_current_stack ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->set_top_of_page( mv_current_stack ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_top_of_page_html.
    TRY.
        DATA(lo_stack) = _get_stack( mv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->set_top_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                          iv_stack_name = lo_stack->name ).
        ELSEIF o_view IS BOUND.
          o_view->set_top_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                   iv_stack_name = mv_current_stack ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->set_top_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                   iv_stack_name = mv_current_stack ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_user_command.
    TRY.
        s_view_action-selfield = is_selfield.

        DATA(lo_stack) = _get_stack( mv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->check_changed_data_in_ucomm( )->user_command( EXPORTING im_ucomm      = im_ucomm
                                                                                  io_model      = lo_stack->model
                                                                                  io_controller = lo_stack->controller
                                                                                  iv_stack_name = lo_stack->name
                                                                        CHANGING  cs_selfield   = s_view_action-selfield ).
        ELSEIF o_view IS BOUND.
          o_view->check_changed_data_in_ucomm( )->user_command( EXPORTING im_ucomm      = im_ucomm
                                                                           io_model      = me->o_model
                                                                           io_controller = me
                                                                           iv_stack_name = mv_current_stack
                                                                 CHANGING  cs_selfield   = s_view_action-selfield ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->check_changed_data_in_ucomm( )->user_command( EXPORTING im_ucomm      = im_ucomm
                                                                           io_model      = me->o_model
                                                                           io_controller = me
                                                                           iv_stack_name = mv_current_stack
                                                                 CHANGING  cs_selfield   = s_view_action-selfield ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD process_any_model.
    DATA lv_method TYPE seoclsname.

    IF o_model IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Model was not created'.
    ENDIF.

    TRY.
        lv_method = |{ iv_method CASE = UPPER }|.

        IF it_param IS SUPPLIED AND it_param IS NOT INITIAL
       AND it_excpt IS SUPPLIED AND it_excpt IS NOT INITIAL.
          CALL METHOD o_model->(lv_method)
            PARAMETER-TABLE it_param
            EXCEPTION-TABLE it_excpt.
        ELSEIF it_param IS SUPPLIED AND it_param IS NOT INITIAL.
          CALL METHOD o_model->(lv_method)
            PARAMETER-TABLE it_param.
        ELSE.
          CALL METHOD o_model->(lv_method).
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
            msgv1 = CONV #( lo_except->get_text( ) ).
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
        ir_dd_doc = ir_dd_doc.
  ENDMETHOD.


  METHOD raise_pf_status.
    RAISE EVENT evt_pf_status
     EXPORTING
       it_extab = it_extab.
  ENDMETHOD.


  METHOD raise_register_event.
    RAISE EVENT evt_register_event
      EXPORTING
        is_data = cs_data.

    cs_data = s_view_action-caller_exit.
  ENDMETHOD.


  METHOD raise_top_of_page.
    RAISE EVENT evt_top_of_page.
  ENDMETHOD.


  METHOD raise_top_of_page_html.
    RAISE EVENT evt_top_of_page_html
      EXPORTING
        ir_dd_doc = ir_dd_doc.
  ENDMETHOD.


  METHOD raise_user_command.
    RAISE EVENT evt_user_command
      EXPORTING
        im_ucomm    = im_ucomm
        is_selfield = cs_selfield.

    cs_selfield = s_view_action-selfield.
  ENDMETHOD.


  METHOD set_stack_name.
    DATA: lo_model TYPE REF TO zcl_mvcfw_base_lvc_model,
          lo_view	 TYPE REF TO zcl_mvcfw_base_lvc_view.

    ro_controller = me.

    CHECK iv_stack_name IS NOT INITIAL.

    mv_current_stack = |{ iv_stack_name CASE = UPPER }|.
    DATA(lr_stack)    = _get_stack( mv_current_stack ).

    IF io_model IS BOUND.
      lo_model = io_model.
      lo_model->set_stack_name( mv_current_stack ).
    ELSE.
      IF lr_stack->model IS BOUND.
        lo_model = lr_stack->model.
        lo_model->set_stack_name( mv_current_stack ).
      ENDIF.
    ENDIF.

    IF io_view IS BOUND.
      lo_view = io_view.
      lo_view->set_stack_name( mv_current_stack ).
    ELSE.
      IF lr_stack->view IS BOUND.
        lo_view = lr_stack->view.
        lo_view->set_stack_name( mv_current_stack ).
      ENDIF.
    ENDIF.

    IF iv_not_checked IS INITIAL.
      _build_stack( iv_name  = mv_current_stack   "'MAIN'
                    io_model = lo_model
                    io_view  = lo_view ).
    ELSE.
      LOOP AT mt_stack ASSIGNING FIELD-SYMBOL(<lfs_stack>).
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( mt_stack ) THEN abap_true ).
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD set_view_action.
    ro_controller = me.

    IF ir_action->ucomm IS NOT INITIAL.
      s_view_action-ucomm = ir_action->ucomm.
    ELSE.
      CLEAR s_view_action-ucomm.
    ENDIF.
    IF ir_action->selfield IS NOT INITIAL.
      s_view_action-selfield = ir_action->selfield.
    ELSE.
      CLEAR s_view_action-selfield.
    ENDIF.
    IF ir_action->data_changed IS BOUND.
      s_view_action-data_changed = ir_action->data_changed.
    ELSE.
      CLEAR s_view_action-data_changed.
    ENDIF.
    IF ir_action->cl_dd IS BOUND.
      s_view_action-cl_dd = ir_action->cl_dd.
    ELSE.
      CLEAR s_view_action-cl_dd.
    ENDIF.
    IF ir_action->caller_exit IS NOT INITIAL.
      s_view_action-caller_exit = ir_action->caller_exit.
    ELSE.
      CLEAR s_view_action-caller_exit.
    ENDIF.
  ENDMETHOD.


  METHOD _build_stack.
    DATA: lo_view       TYPE REF TO zcl_mvcfw_base_lvc_view,
          lo_model      TYPE REF TO zcl_mvcfw_base_lvc_model,
          lo_controller TYPE REF TO zcl_mvcfw_base_lvc_controller.
    DATA: lv_line TYPE sy-index.

    DATA(lv_name) = |{ iv_name CASE = UPPER }|.

    IF NOT line_exists( mt_stack[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR: lo_view, lo_model, lv_line.

      lo_view       = io_view.
      lo_model      = io_model.
      lo_controller = COND #( WHEN io_controller IS BOUND THEN io_controller
                              ELSE zcl_mvcfw_base_lvc_controller=>get_instance( me ) ).
      lv_line       = lines( mt_stack ) + 1.

      INSERT VALUE #( name       = COND #( WHEN lv_line EQ 1 THEN c_stack_main ELSE lv_name )
                      view       = lo_view
                      model      = lo_model
                      controller = lo_controller
                      is_main    = COND #( WHEN lv_line EQ 1 THEN abap_true )
                      line       = lv_line
                    ) INTO TABLE mt_stack.

      LOOP AT mt_stack ASSIGNING FIELD-SYMBOL(<lfs_stack>).
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( mt_stack ) THEN abap_true ).
      ENDLOOP.
    ENDIF.

    IF NOT line_exists( mt_stack_called[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR lv_line.

      lv_line = lines( mt_stack_called ) + 1.

      INSERT VALUE #( line = lv_line
                      name = COND #( WHEN lv_line EQ 1 THEN c_stack_main ELSE lv_name )
                    ) INTO TABLE mt_stack_called.
    ENDIF.
  ENDMETHOD.


  METHOD _clear_view_action.
    CLEAR s_view_action.
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
            lv_object = COND #( WHEN ls_class_type-sscr       IS NOT INITIAL THEN mc_base_sscr
                                WHEN ls_class_type-model      IS NOT INITIAL THEN mc_base_model
                                WHEN ls_class_type-view       IS NOT INITIAL THEN mc_base_view
                                WHEN ls_class_type-controller IS NOT INITIAL THEN mc_base_cntl ).
            CHECK lv_object IS NOT INITIAL.

            CREATE OBJECT ro_class TYPE (lv_object).
            ev_class_name = lv_object.
          CATCH cx_sy_create_object_error.
        ENDTRY.
    ENDTRY.
  ENDMETHOD.


  METHOD _display_lvc_grid.
    DATA: lo_out TYPE REF TO data.

    mv_current_stack = COND #( WHEN iv_stack_name IS NOT INITIAL THEN |{ iv_stack_name CASE = UPPER }|
                                WHEN mv_current_stack IS INITIAL THEN c_stack_main
                                ELSE mv_current_stack ).

    me->_build_stack( iv_name       = mv_current_stack   "'MAIN'
                      io_model      = o_model
                      io_view       = o_view
                      io_controller = zcl_mvcfw_base_lvc_controller=>get_instance( me ) ).

    DATA(lo_stack) = me->_get_stack( mv_current_stack ).

    IF lo_stack IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Cannot display ALV'.
    ELSE.
      o_model = lo_stack->model.
      o_view  = lo_stack->view.
    ENDIF.

    "Set Object name for Model
    _set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                    iv_object_name = mc_obj_model
                                    iv_stack_name  = mv_current_stack ).

    IF ct_data IS SUPPLIED
   AND ct_data IS NOT INITIAL.
      lo_out = REF #( ct_data ).
    ELSE.
      IF lo_stack->model IS BOUND.
        lo_out = lo_stack->model->get_controller_action( s_view_action )->get_outtab(  iv_stack_name = mv_current_stack ).
      ENDIF.
    ENDIF.
    IF lo_out IS BOUND.
      ASSIGN lo_out->* TO FIELD-SYMBOL(<lft_out>).
      CHECK <lft_out> IS NOT INITIAL.

      TRY.
          "Set Object name for View
          _set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                          iv_object_name = mc_obj_view
                                          iv_stack_name  = mv_current_stack ).

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
              msgv1 = lo_except->msgv1.
      ENDTRY.
    ELSE.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'No reference data found'.
    ENDIF.
  ENDMETHOD.


  METHOD _form_base_controller_template.
*&---------------------------------------------------------------------*
*& Don't use this method!!!.
*& This is only prototype code to copy for creating new include program
*&---------------------------------------------------------------------*
**&---------------------------------------------------------------------*
**& Include          ZINCL_FORM_BASE_CONTROLLER
**&---------------------------------------------------------------------*
**FORM set_pf_status USING rt_extab TYPE slis_t_extab.
**
**  zcl_mvcfw_base_lvc_controller=>get_instance( )->raise_pf_status( rt_extab ).
**
**ENDFORM.
**
**FORM user_command  USING up_ucomm    TYPE sy-ucomm
**                         us_selfield TYPE slis_selfield.
**
**  zcl_mvcfw_base_lvc_controller=>get_instance( )->raise_user_command( EXPORTING im_ucomm    = up_ucomm
**                                                                      CHANGING  cs_selfield = us_selfield ).
**
**ENDFORM.
**
**FORM check_changed_data USING er_data_changed	TYPE REF TO	cl_alv_changed_data_protocol.
**
**  zcl_mvcfw_base_lvc_controller=>get_instance( )->raise_check_changed_data( er_data_changed ).
**
**ENDFORM.
**
**FORM caller_exit USING is_data TYPE slis_data_caller_exit.
**
**  zcl_mvcfw_base_lvc_controller=>get_instance( )->raise_register_event( CHANGING cs_data = is_data ).
**
**ENDFORM.
**
**FORM top_of_page.
**
**  CHECK zcl_mvcfw_base_lvc_controller=>check_routine_only( ) IS INITIAL.
**  zcl_mvcfw_base_lvc_controller=>get_instance( )->raise_top_of_page( ).
**
**ENDFORM.
**
**FORM top_of_page_html USING cl_dd TYPE REF TO cl_dd_document.
**
**  zcl_mvcfw_base_lvc_controller=>get_instance( )->raise_top_of_page_html( cl_dd ).
**
**ENDFORM.
**
**FORM end_of_page_html USING cl_dd TYPE REF TO cl_dd_document.
**
**  zcl_mvcfw_base_lvc_controller=>get_instance( )->raise_end_of_page_html( cl_dd ).
**
**ENDFORM.
  ENDMETHOD.


  METHOD _get_stack.
    TRY.
        rs_stack = REF #( mt_stack[ KEY k2 COMPONENTS name = iv_name ] ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.


  METHOD _set_dynp_stack_name.
    ro_controller = me.

    CHECK io_stack IS BOUND.

    TRY.
        CASE iv_object_name.
          WHEN mc_obj_model.
            io_stack->model->set_stack_name( iv_stack_name ).
          WHEN mc_obj_view.
            io_stack->view->set_stack_name( iv_stack_name ).
        ENDCASE.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD _populate_view_contoller.
    CHECK co_view IS BOUND.

    co_view->set_view_attributes( EXPORTING io_model      = io_model
                                            io_controller = io_controller ).

    eo_current_view = co_view.
  ENDMETHOD.


  METHOD get_instance.
    IF io_controller IS BOUND.
      mo_controller_instance = VALUE #( mt_controller[ table_line = io_controller ]
                                            DEFAULT mo_controller_instance ).
      ro_controller           = mo_controller_instance.
    ELSE.
      ro_controller = mo_controller_instance.
    ENDIF.
  ENDMETHOD.


  METHOD get_model.
    ro_model = o_model.
  ENDMETHOD.


  METHOD get_view.
    ro_view = o_view.
  ENDMETHOD.


  METHOD _store_controller_instance.
    IF io_controller IS BOUND.
      TRY.
          mo_controller_instance = io_controller.

          IF NOT line_exists( mt_controller[ table_line = io_controller ] ).
            mt_controller = VALUE #( BASE mt_controller ( io_controller ) ).
          ENDIF.
        CATCH cx_sy_move_cast_error.
      ENDTRY.
    ELSE.
      TRY.
          mo_controller_instance = me.

          IF NOT line_exists( mt_controller[ table_line = me ] ).
            mt_controller = VALUE #( BASE mt_controller ( me ) ).
          ENDIF.
        CATCH cx_sy_move_cast_error.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD set_view.
    ro_controller = me.

    IF io_view IS BOUND.
      o_view = io_view.
    ENDIF.
  ENDMETHOD.


  METHOD set_model.
    ro_controller = me.

    IF io_model IS BOUND.
      o_model = io_model.
    ENDIF.
  ENDMETHOD.


  METHOD set_event_handler_for_control.
    IF io_controller IS BOUND.
      SET HANDLER handle_pf_status
                  handle_user_command
                  handle_check_changed_data
                  handle_register_event
                  handle_top_of_page
                  handle_top_of_page_html
                  handle_end_of_page_html
              FOR io_controller.
    ELSE.
      SET HANDLER handle_pf_status
                  handle_user_command
                  handle_check_changed_data
                  handle_register_event
                  handle_top_of_page
                  handle_top_of_page_html
                  handle_end_of_page_html
              FOR me.
    ENDIF.
  ENDMETHOD.


  METHOD set_check_routine.
    IF iv_set_value IS SUPPLIED.
      mv_routine_check = ev_value = iv_set_value.
    ELSEIF iv_get_value IS SUPPLIED.
      ev_value = mv_routine_check.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
