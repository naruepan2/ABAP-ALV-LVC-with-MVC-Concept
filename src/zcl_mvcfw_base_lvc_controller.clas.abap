class ZCL_MVCFW_BASE_LVC_CONTROLLER definition
  public
  create public .

public section.

  types:
    BEGIN OF ts_lvc_view_action,
        ucomm        TYPE sy-ucomm,
        selfield     TYPE slis_selfield,
        data_changed TYPE REF TO cl_alv_changed_data_protocol,
        cl_dd        TYPE REF TO cl_dd_document,
      END OF ts_lvc_view_action .
  types:
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
  types:
    BEGIN OF ts_stack_name,
        line TYPE sy-index,
        name TYPE dfies-tabname,
      END OF ts_stack_name .
  types:
    tt_stack TYPE TABLE OF ts_stack WITH EMPTY KEY
                                           WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .
  types:
    tt_stack_name TYPE TABLE OF ts_stack_name WITH EMPTY KEY
                                                     WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .

  constants MC_STACK_MAIN type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  constants MC_DEFLT_CNTL type SEOCLSNAME value 'LCL_CONTROLLER' ##NO_TEXT.
  constants MC_DEFLT_MODEL type SEOCLSNAME value 'LCL_MODEL' ##NO_TEXT.
  constants MC_DEFLT_VIEW type SEOCLSNAME value 'LCL_VIEW' ##NO_TEXT.
  constants MC_DEFLT_SSCR type SEOCLSNAME value 'LCL_SSCR' ##NO_TEXT.
  constants MC_DEFLT_OUTTAB type DFIES-TABNAME value 'MT_OUTTAB' ##NO_TEXT.
  constants MC_DISPLAY_LVC_LIST type SALV_DE_CONSTANT value 1 ##NO_TEXT.
  constants MC_DISPLAY_LVC_HIERSEQ type SALV_DE_CONSTANT value 2 ##NO_TEXT.
  data MO_SSCR type ref to ZCL_MVCFW_BASE_SSCR read-only .
  data MO_VIEW type ref to ZCL_MVCFW_BASE_LVC_VIEW read-only .
  data MO_MODEL type ref to ZCL_MVCFW_BASE_LVC_MODEL read-only .
  data MS_VIEW_ACTION type TS_LVC_VIEW_ACTION read-only .

  events EVT_PF_STATUS
    exporting
      value(IT_EXTAB) type SLIS_T_EXTAB optional .
  events EVT_USER_COMMAND
    exporting
      value(IM_UCOMM) type SY-UCOMM
      value(IS_SELFIELD) type SLIS_SELFIELD .
  events EVT_CHECK_CHANGED_DATA
    exporting
      value(IO_DATA_CHANGED) type ref to CL_ALV_CHANGED_DATA_PROTOCOL .
  events EVT_REGISTER_EVENT .
  events EVT_TOP_OF_PAGE .
  events EVT_TOP_OF_PAGE_HTML
    exporting
      value(IR_DD_DOC) type ref to CL_DD_DOCUMENT .
  events EVT_END_OF_PAGE_HTML
    exporting
      value(IR_DD_DOC) type ref to CL_DD_DOCUMENT .

  methods CONSTRUCTOR
    importing
      !IV_CNTL_NAME type SEOCLSNAME default MC_DEFLT_CNTL
      !IV_MODL_NAME type SEOCLSNAME default MC_DEFLT_MODEL
      !IV_VIEW_NAME type SEOCLSNAME default MC_DEFLT_VIEW
      !IV_SSCR_NAME type SEOCLSNAME default MC_DEFLT_SSCR
      !IV_SET_HANDLER type ABAP_BOOL default ABAP_TRUE .
  methods DISPLAY
    importing
      !IV_DISPLAY_TYPE type SALV_DE_CONSTANT default MC_DISPLAY_LVC_LIST
      !IV_REPID type SY-CPROG default SY-CPROG
      !IV_SET_PF_STATUS type SLIS_FORMNAME default 'SET_PF_STATUS'
      !IV_USER_COMMAND type SLIS_FORMNAME default 'USER_COMMAND'
      !IV_CALLBACK_TOP_OF_PAGE type SLIS_FORMNAME optional
      !IV_CALLBACK_HTML_TOP_OF_PAGE type SLIS_FORMNAME optional
      !IV_CALLBACK_HTML_END_OF_LIST type SLIS_FORMNAME optional
      !IS_GRID_TITLE type LVC_TITLE optional
      !IS_GRID_SETTINGS type LVC_S_GLAY optional
      !IS_LAYOUT type LVC_S_LAYO optional
      !IT_FIELDCAT type LVC_T_FCAT optional
      !IT_EXCLUDING type SLIS_T_EXTAB optional
      !IT_SPECL_GRPS type LVC_T_SGRP optional
      !IT_SORT type LVC_T_SORT optional
      !IT_FILTER type LVC_T_FILT optional
      !IV_DEFAULT type CHAR1 default ABAP_TRUE
      !IV_SAVE type CHAR1 default 'A'
      !IS_VARIANT type DISVARIANT optional
      !IT_EVENT type SLIS_T_EVENT optional
      !IT_EVENT_EXIT type SLIS_T_EVENT_EXIT optional
      !IV_SCREEN_START_COLUMN type I optional
      !IV_SCREEN_START_LINE type I optional
      !IV_SCREEN_END_COLUMN type I optional
      !IV_SCREEN_END_LINE type I optional
      !IV_HTML_HEIGHT_TOP type I optional
      !IV_HTML_HEIGHT_END type I optional
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CT_DATA type TABLE optional
    raising
      ZBCX_EXCEPTION .
  methods PROCESS_ANY_MODEL
    importing
      !IV_METHOD type SEOCLSNAME
      !IT_PARAM type ABAP_PARMBIND_TAB optional
    exporting
      !IT_EXCPT type ABAP_EXCPBIND_TAB
    raising
      ZBCX_EXCEPTION .
  methods HANDLE_SSCR_PBO
    importing
      !IV_DYNNR type SY-DYNNR default SY-DYNNR .
  methods HANDLE_SSCR_PAI
    importing
      !IV_DYNNR type SY-DYNNR default SY-DYNNR .
  methods HANDLE_PF_STATUS
    for event EVT_PF_STATUS of ZCL_MVCFW_BASE_LVC_CONTROLLER
    importing
      !IT_EXTAB .
  methods HANDLE_USER_COMMAND
    for event EVT_USER_COMMAND of ZCL_MVCFW_BASE_LVC_CONTROLLER
    importing
      !IM_UCOMM
      !IS_SELFIELD .
  methods HANDLE_CHECK_CHANGED_DATA
    for event EVT_CHECK_CHANGED_DATA of ZCL_MVCFW_BASE_LVC_CONTROLLER
    importing
      !IO_DATA_CHANGED .
  methods HANDLE_TOP_OF_PAGE_HTML
    for event EVT_TOP_OF_PAGE_HTML of ZCL_MVCFW_BASE_LVC_CONTROLLER
    importing
      !IR_DD_DOC .
  methods HANDLE_TOP_OF_PAGE
    for event EVT_TOP_OF_PAGE of ZCL_MVCFW_BASE_LVC_CONTROLLER .
  methods HANDLE_END_OF_PAGE_HTML
    for event EVT_END_OF_PAGE_HTML of ZCL_MVCFW_BASE_LVC_CONTROLLER
    importing
      !IR_DD_DOC .
  methods HANDLE_REGISTER_EVENT
    for event EVT_REGISTER_EVENT of ZCL_MVCFW_BASE_LVC_CONTROLLER .
  methods SET_STACK_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME
      !IO_MODEL type ref to ZCL_MVCFW_BASE_LVC_MODEL optional
      !IO_VIEW type ref to ZCL_MVCFW_BASE_LVC_VIEW optional
      !IV_NOT_CHECKED type FLAG default SPACE
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER .
  methods RAISE_PF_STATUS
    importing
      !IT_EXTAB type SLIS_T_EXTAB optional .
  methods RAISE_USER_COMMAND
    importing
      !IM_UCOMM type SY-UCOMM
    changing
      !CS_SELFIELD type SLIS_SELFIELD .
  methods RAISE_CHECK_CHANGED_DATA
    importing
      !IO_DATA_CHANGED type ref to CL_ALV_CHANGED_DATA_PROTOCOL .
  methods RAISE_REGISTER_EVENT .
  methods RAISE_TOP_OF_PAGE .
  methods RAISE_TOP_OF_PAGE_HTML
    importing
      !IR_DD_DOC type ref to CL_DD_DOCUMENT optional .
  methods RAISE_END_OF_PAGE_HTML
    importing
      !IR_DD_DOC type ref to CL_DD_DOCUMENT optional .
  class-methods CHECK_ROUTINE_ONLY
    returning
      value(RV_CHECK_ONLY) type FLAG .
  class-methods GET_STATIC_CONTROL_INSTANCE
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER .
  methods GET_CONTROL_INSTANCE
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER .
  methods CHECK_ROUTINE
    importing
      !IV_SET_VALUE type FLAG optional
      !IV_GET_VALUE type FLAG optional
    exporting
      !EV_VALUE type FLAG .
  methods DESTROY_STACK
    importing
      !IV_NAME type DFIES-TABNAME optional
      !IV_CURRENT_NAME type DFIES-TABNAME optional .
  methods GET_STACK_BY_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME
    returning
      value(RS_STACK) type ref to TS_STACK .
  methods GET_ALL_STACK
    returning
      value(RT_STACK) type TT_STACK .
  methods GET_CURRENT_STACK
    returning
      value(RV_CURRENT_STACK) type DFIES-TABNAME .
  methods SET_VIEW_ACTION
    importing
      !IR_ACTION type ref to TS_LVC_VIEW_ACTION
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER .
protected section.

  data LMT_STACK_CALLED type TT_STACK_NAME .
  data LMT_STACK type TT_STACK .
  constants LMC_OBJ_MODEL type SEOCLSNAME value 'MODEL' ##NO_TEXT.
  constants LMC_OBJ_VIEW type SEOCLSNAME value 'VIEW' ##NO_TEXT.
  data LMV_CL_VIEW_NAME type CHAR30 .
  data LMV_CL_MODL_NAME type CHAR30 .
  data LMV_CL_SSCR_NAME type CHAR30 .
  data LMV_CL_CNTL_NAME type CHAR30 .
  data LMV_CURRENT_STACK type DFIES-TABNAME value MC_STACK_MAIN ##NO_TEXT.

  methods _SET_EVENT_HANDLER_FOR_CONTROL .
  methods _DISPLAY_LVC_GRID
    importing
      !IV_REPID type SY-CPROG default SY-CPROG
      !IV_SET_PF_STATUS type SLIS_FORMNAME default 'SET_PF_STATUS'
      !IV_USER_COMMAND type SLIS_FORMNAME default 'USER_COMMAND'
      !IV_CALLBACK_TOP_OF_PAGE type SLIS_FORMNAME optional
      !IV_CALLBACK_HTML_TOP_OF_PAGE type SLIS_FORMNAME optional
      !IV_CALLBACK_HTML_END_OF_LIST type SLIS_FORMNAME optional
      !IS_GRID_TITLE type LVC_TITLE optional
      !IS_GRID_SETTINGS type LVC_S_GLAY optional
      !IS_LAYOUT type LVC_S_LAYO optional
      !IT_FIELDCAT type LVC_T_FCAT optional
      !IT_EXCLUDING type SLIS_T_EXTAB optional
      !IT_SPECL_GRPS type LVC_T_SGRP optional
      !IT_SORT type LVC_T_SORT optional
      !IT_FILTER type LVC_T_FILT optional
      !IV_DEFAULT type CHAR1 default ABAP_TRUE
      !IV_SAVE type CHAR1 default 'A'
      !IS_VARIANT type DISVARIANT optional
      !IT_EVENT type SLIS_T_EVENT optional
      !IT_EVENT_EXIT type SLIS_T_EVENT_EXIT optional
      !IV_SCREEN_START_COLUMN type I optional
      !IV_SCREEN_START_LINE type I optional
      !IV_SCREEN_END_COLUMN type I optional
      !IV_SCREEN_END_LINE type I optional
      !IV_HTML_HEIGHT_TOP type I optional
      !IV_HTML_HEIGHT_END type I optional
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CT_DATA type TABLE optional
    raising
      ZBCX_EXCEPTION .
  PRIVATE SECTION.

    TYPES:
      BEGIN OF lty_class_type,
        sscr       TYPE flag,
        model      TYPE flag,
        view       TYPE flag,
        controller TYPE flag,
      END OF lty_class_type .

    CLASS-DATA lmo_static_controller TYPE REF TO zcl_mvcfw_base_lvc_controller .
    DATA lmo_current_controller TYPE REF TO zcl_mvcfw_base_lvc_controller .
    DATA lmo_current_model TYPE REF TO zcl_mvcfw_base_lvc_model .
    DATA lmo_current_view TYPE REF TO zcl_mvcfw_base_lvc_view .
    DATA lmv_routine_check TYPE flag .
    CONSTANTS lmc_base_cntl TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_LVC_CONTROLLER' ##NO_TEXT.
    CONSTANTS lmc_base_model TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_LVC_MODEL' ##NO_TEXT.
    CONSTANTS lmc_base_view TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_LVC_VIEW' ##NO_TEXT.
    CONSTANTS lmc_base_sscr TYPE seoclsname VALUE 'ZCL_MVCFW_BASE_SSCR' ##NO_TEXT.

    METHODS _create_any_object
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
ENDCLASS.



CLASS ZCL_MVCFW_BASE_LVC_CONTROLLER IMPLEMENTATION.


  METHOD check_routine.
    IF iv_set_value IS SUPPLIED.
      lmv_routine_check = ev_value = iv_set_value.
    ELSEIF iv_get_value IS SUPPLIED.
      ev_value = lmv_routine_check.
    ENDIF.
  ENDMETHOD.


  METHOD check_routine_only.
    lmo_static_controller->check_routine( EXPORTING iv_get_value = abap_true
                                          IMPORTING ev_value     = rv_check_only ).
  ENDMETHOD.


  METHOD constructor.
    TRY.
        mo_sscr  ?= _create_any_object( EXPORTING iv_class_name = iv_sscr_name
                                                  is_class_type = VALUE #( sscr = abap_true )
                                        IMPORTING ev_class_name = lmv_cl_sscr_name ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        mo_model ?= _create_any_object( EXPORTING iv_class_name = iv_modl_name
                                                  is_class_type = VALUE #( model = abap_true )
                                        IMPORTING ev_class_name = lmv_cl_modl_name ).
      CATCH cx_sy_move_cast_error.
    ENDTRY.
    TRY.
        mo_view  ?= _create_any_object( EXPORTING iv_class_name = iv_view_name
                                                  is_class_type = VALUE #( view = abap_true )
                                        IMPORTING ev_class_name = lmv_cl_view_name ).
*        IF mo_view IS BOUND.
*          mo_view->set_controller_to_view( me )->set_model_to_view( mo_model ).
*        ENDIF.
      CATCH cx_sy_move_cast_error.
    ENDTRY.

    TRY.
        lmo_static_controller  ?= me.
        lmo_current_model      ?= mo_model.
        lmo_current_view       ?= mo_view.
        lmo_current_controller ?= me.
      CATCH cx_sy_move_cast_error.
    ENDTRY.

    IF iv_set_handler IS NOT INITIAL.
      _set_event_handler_for_control( ).
    ENDIF.
  ENDMETHOD.


  METHOD destroy_stack.
    DATA: ls_stack_called LIKE LINE OF lmt_stack_called,
          ls_stack        LIKE LINE OF lmt_stack.
    FIELD-SYMBOLS <lfs_stack_called> LIKE LINE OF lmt_stack_called.

    _clear_view_action( ).

    IF iv_name IS INITIAL.
      READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
      IF sy-subrc EQ 0.
        DELETE: lmt_stack_called WHERE line EQ ls_stack_called-line,
                lmt_stack        WHERE name EQ ls_stack_called-name.
      ENDIF.

      "--------------------------------------------------------------------"
      " Read and set previous stack
      "--------------------------------------------------------------------"
      READ TABLE lmt_stack_called INTO ls_stack_called INDEX lines( lmt_stack_called ).
      IF sy-subrc EQ 0.
        READ TABLE lmt_stack INTO ls_stack
          WITH KEY k2
            COMPONENTS name = ls_stack_called-name.
        IF sy-subrc EQ 0.
          lmo_static_controller  ?= ls_stack-controller.
          lmo_current_controller ?= ls_stack-controller.
          lmo_current_model      ?= ls_stack-model.
          lmo_current_view       ?= ls_stack-view.

          set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                    io_model       = lmo_current_model
                                    io_view        = lmo_current_view
                                    iv_not_checked = abap_true ).
        ENDIF.
      ENDIF.
    ELSE.
      READ TABLE lmt_stack_called INTO ls_stack_called
        WITH KEY k2
          COMPONENTS name = |{ iv_name CASE = UPPER }|.
      IF sy-subrc EQ 0.
        DELETE: lmt_stack_called WHERE line EQ ls_stack_called-line,
                lmt_stack        WHERE name EQ ls_stack_called-name.
      ENDIF.

      "--------------------------------------------------------------------"
      " Read and set previous stack
      "--------------------------------------------------------------------"
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
            lmo_static_controller  ?= ls_stack-controller.
            lmo_current_controller ?= ls_stack-controller.
            lmo_current_model      ?= ls_stack-model.
            lmo_current_view       ?= ls_stack-view.

            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = lmo_current_model
                                      io_view        = lmo_current_view
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
            lmo_static_controller  ?= ls_stack-controller.
            lmo_current_controller ?= ls_stack-controller.
            lmo_current_model      ?= ls_stack-model.
            lmo_current_view       ?= ls_stack-view.

            set_stack_name( EXPORTING iv_stack_name  = ls_stack_called-name
                                      io_model       = lmo_current_model
                                      io_view        = lmo_current_view
                                      iv_not_checked = abap_true ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

    "--------------------------------------------------------------------"
    " Try to replace SALV parameters with previous parameters
    "--------------------------------------------------------------------"
    READ TABLE lmt_stack INTO ls_stack WITH KEY is_current = abap_true.
    IF sy-subrc EQ 0.
      IF ls_stack-lvc_v_action IS BOUND.
        me->ms_view_action = ls_stack-lvc_v_action->*.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD display.
    DATA: lv_display_type	TYPE salv_de_constant.

    lv_display_type = COND #( WHEN iv_display_type IS NOT INITIAL THEN iv_display_type
                              ELSE mc_display_lvc_list ).

    CASE lv_display_type.
      WHEN mc_display_lvc_list.
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
    rt_stack = lmt_stack.
  ENDMETHOD.


  METHOD get_control_instance.
    READ TABLE lmt_stack INTO DATA(ls_stack)
      WITH KEY k2 COMPONENTS name = lmv_current_stack.
    IF sy-subrc EQ 0.
      IF ls_stack-controller IS BOUND.
        ro_controller ?= ls_stack-controller.
      ELSE.
        IF lmo_static_controller IS NOT BOUND.
          lmo_static_controller = NEW #( ).
        ENDIF.

        ro_controller ?= lmo_static_controller.
      ENDIF.
    ELSE.
      IF lmo_static_controller IS NOT BOUND.
        lmo_static_controller = NEW #( ).
      ENDIF.

      ro_controller ?= lmo_static_controller.
    ENDIF.
  ENDMETHOD.


  METHOD get_current_stack.
    rv_current_stack = lmv_current_stack.
  ENDMETHOD.


  METHOD get_stack_by_name.
    CHECK iv_stack_name IS NOT INITIAL.

    rs_stack = me->_get_stack( EXPORTING iv_name = iv_stack_name ).
  ENDMETHOD.


  METHOD get_static_control_instance.
    ro_controller = lmo_static_controller->get_control_instance( ).
  ENDMETHOD.


  METHOD handle_check_changed_data.
    DATA: lo_out TYPE REF TO data.
    FIELD-SYMBOLS: <lft_outtab> TYPE table.

    TRY.
        DATA(lo_stack) = _get_stack( lmv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_out = lo_stack->model->get_outtab( lmv_current_stack ).
          IF lo_out IS BOUND.
            ASSIGN lo_out->* TO <lft_outtab>.
          ENDIF.

          CHECK <lft_outtab> IS ASSIGNED.

          lo_stack->view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                              CHANGING  ct_data         = <lft_outtab> ).
          lo_stack->view->refresh_table_display( ).
        ELSE.
          lo_out = lmo_current_model->get_outtab( lmv_current_stack ).
          IF lo_out IS BOUND.
            ASSIGN lo_out->* TO <lft_outtab>.
          ENDIF.

          CHECK <lft_outtab> IS ASSIGNED.

          IF mo_view IS BOUND.
            mo_view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                         CHANGING  ct_data         = <lft_outtab> ).
            mo_view->refresh_table_display( ).
          ELSE.
            DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
            lo_view->check_changed_data( EXPORTING io_data_changed = io_data_changed
                                         CHANGING  ct_data         = <lft_outtab> ).
            lo_view->refresh_table_display( ).
          ENDIF.
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_end_of_page_html.
    TRY.
        DATA(lo_stack) = _get_stack( lmv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->set_end_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                          iv_stack_name = lo_stack->name ).
        ELSEIF mo_view IS BOUND.
          mo_view->set_end_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                   iv_stack_name = lmv_current_stack ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->set_end_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                   iv_stack_name = lmv_current_stack ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_pf_status.
    TRY.
        DATA(lo_stack) = _get_stack( lmv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->set_pf_status( EXPORTING it_extab      = it_extab
                                                   iv_stack_name = lo_stack->name ).
        ELSEIF mo_view IS BOUND.
          mo_view->set_pf_status( EXPORTING it_extab      = it_extab
                                            iv_stack_name = lmv_current_stack ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->set_pf_status( EXPORTING it_extab      = it_extab
                                            iv_stack_name = lmv_current_stack ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_register_event.
    TRY.
        DATA(lo_stack) = _get_stack( lmv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->register_event( ).
        ELSEIF mo_view IS BOUND.
          mo_view->register_event( ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->register_event( ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_except).
        DATA(lv_msg) = lo_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_sscr_pai.
    IF mo_sscr IS NOT BOUND.
      mo_sscr = NEW #( ).
    ENDIF.
    IF mo_sscr IS BOUND.
      mo_sscr->pai( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_sscr_pbo.
    IF mo_sscr IS NOT BOUND.
      mo_sscr = NEW #( ).
    ENDIF.
    IF mo_sscr IS BOUND.
      mo_sscr->pbo( iv_dynnr ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_top_of_page.
    TRY.
        DATA(lo_stack) = _get_stack( lmv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->set_top_of_page( lo_stack->name ).
        ELSEIF mo_view IS BOUND.
          mo_view->set_top_of_page( lmv_current_stack ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->set_top_of_page( lmv_current_stack ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_top_of_page_html.
    TRY.
        DATA(lo_stack) = _get_stack( lmv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->set_top_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                          iv_stack_name = lo_stack->name ).
        ELSEIF mo_view IS BOUND.
          mo_view->set_top_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                   iv_stack_name = lmv_current_stack ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->set_top_of_page_html( EXPORTING ir_dd_doc     = ir_dd_doc
                                                   iv_stack_name = lmv_current_stack ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD handle_user_command.
    TRY.
        ms_view_action-selfield = is_selfield.

        DATA(lo_stack) = _get_stack( lmv_current_stack ).
        IF lo_stack IS BOUND AND lo_stack->view IS BOUND.
          lo_stack->view->user_command( EXPORTING im_ucomm      = im_ucomm
                                                  io_model      = lo_stack->model
                                                  io_controller = lo_stack->controller
                                                  iv_stack_name = lo_stack->name
                                        CHANGING  cs_selfield   = ms_view_action-selfield ).
        ELSEIF mo_view IS BOUND.
          mo_view->user_command( EXPORTING im_ucomm      = im_ucomm
                                           io_model      = me->mo_model
                                           io_controller = me
                                           iv_stack_name = lmv_current_stack
                                 CHANGING  cs_selfield   = ms_view_action-selfield ).
        ELSE.
          DATA(lo_view) = NEW zcl_mvcfw_base_lvc_view( ).
          lo_view->user_command( EXPORTING im_ucomm      = im_ucomm
                                           io_model      = me->mo_model
                                           io_controller = me
                                           iv_stack_name = lmv_current_stack
                                 CHANGING  cs_selfield   = ms_view_action-selfield ).
        ENDIF.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_msg) = lo_dyn_except->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD process_any_model.
    DATA lv_method TYPE seoclsname.

    IF mo_model IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Model was not created'.
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
    RAISE EVENT evt_register_event.
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

    cs_selfield = ms_view_action-selfield.
  ENDMETHOD.


  METHOD set_stack_name.
    DATA: lo_model TYPE REF TO zcl_mvcfw_base_lvc_model,
          lo_view	 TYPE REF TO zcl_mvcfw_base_lvc_view.

    ro_controller = me.

    CHECK iv_stack_name IS NOT INITIAL.

    lmv_current_stack = |{ iv_stack_name CASE = UPPER }|.

    IF io_model IS BOUND.
      lo_model ?= io_model.
      lo_model->set_stack_name( lmv_current_stack ).
    ELSE.
      IF _get_stack( lmv_current_stack )->model IS BOUND.
        lo_model ?= _get_stack( lmv_current_stack )->model.
        lo_model->set_stack_name( lmv_current_stack ).
      ENDIF.
    ENDIF.

    IF io_view IS BOUND.
      lo_view ?= io_view.
      lo_view->set_stack_name( lmv_current_stack ).
    ELSE.
      IF _get_stack( lmv_current_stack )->view IS BOUND.
        lo_view ?= _get_stack( lmv_current_stack )->view.
        lo_view->set_stack_name( lmv_current_stack ).
      ENDIF.
    ENDIF.

    IF iv_not_checked IS INITIAL.
      _build_stack( iv_name  = lmv_current_stack   "'MAIN'
                    io_model = lo_model
                    io_view  = lo_view ).
    ELSE.
      LOOP AT lmt_stack ASSIGNING FIELD-SYMBOL(<lfs_stack>).
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( lmt_stack ) THEN abap_true ).
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD set_view_action.
    ro_controller = me.

    IF ir_action->ucomm IS NOT INITIAL.
      ms_view_action-ucomm = ir_action->ucomm.
    ELSE.
      CLEAR ms_view_action-ucomm.
    ENDIF.
    IF ir_action->selfield IS NOT INITIAL.
      ms_view_action-selfield = ir_action->selfield.
    ELSE.
      CLEAR ms_view_action-selfield.
    ENDIF.
    IF ir_action->data_changed IS BOUND.
      ms_view_action-data_changed = ir_action->data_changed.
    ELSE.
      CLEAR ms_view_action-data_changed.
    ENDIF.
    IF ir_action->cl_dd IS BOUND.
      ms_view_action-cl_dd = ir_action->cl_dd.
    ELSE.
      CLEAR ms_view_action-cl_dd.
    ENDIF.
  ENDMETHOD.


  METHOD _build_stack.
    DATA: lo_view       TYPE REF TO zcl_mvcfw_base_lvc_view,
          lo_model      TYPE REF TO zcl_mvcfw_base_lvc_model,
          lo_controller TYPE REF TO zcl_mvcfw_base_lvc_controller.
    DATA: lv_line TYPE sy-index.

    DATA(lv_name) = |{ iv_name CASE = UPPER }|.

    IF NOT line_exists( lmt_stack[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR: lo_view, lo_model, lv_line.

      lo_view       ?= io_view.
      lo_model      ?= io_model.
      lo_controller ?= COND #( WHEN io_controller IS BOUND THEN io_controller ELSE lmo_current_controller ).
      lv_line        = lines( lmt_stack ) + 1.

      INSERT VALUE #( name       = COND #( WHEN lv_line EQ 1 THEN mc_stack_main ELSE lv_name )
                      view       = lo_view
                      model      = lo_model
                      controller = lo_controller
                      is_main    = COND #( WHEN lv_line EQ 1 THEN abap_true )
                      line       = lv_line
                    ) INTO TABLE lmt_stack.

      LOOP AT lmt_stack ASSIGNING FIELD-SYMBOL(<lfs_stack>).
        <lfs_stack>-is_current = COND #( WHEN sy-tabix EQ lines( lmt_stack ) THEN abap_true ).
      ENDLOOP.
    ENDIF.

    IF NOT line_exists( lmt_stack_called[ KEY k2 COMPONENTS name = lv_name ] ).
      CLEAR lv_line.

      lv_line = lines( lmt_stack_called ) + 1.

      INSERT VALUE #( line = lv_line
                      name = COND #( WHEN lv_line EQ 1 THEN mc_stack_main ELSE lv_name )
                    ) INTO TABLE lmt_stack_called.
    ENDIF.
  ENDMETHOD.


  METHOD _clear_view_action.
    CLEAR ms_view_action.
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


  METHOD _display_lvc_grid.
    DATA: lo_out TYPE REF TO data.

    lmv_current_stack = COND #( WHEN iv_stack_name IS NOT INITIAL THEN |{ iv_stack_name CASE = UPPER }|
                                WHEN lmv_current_stack IS INITIAL THEN mc_stack_main
                                ELSE lmv_current_stack ).

    me->_build_stack( iv_name       = lmv_current_stack   "'MAIN'
                      io_model      = lmo_current_model
                      io_view       = lmo_current_view
                      io_controller = lmo_current_controller ).

    DATA(lo_stack) = me->_get_stack( lmv_current_stack ).

    IF lo_stack IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Cannot display ALV'.
    ELSE.
      lmo_current_model ?= lo_stack->model.
      lmo_current_view  ?= lo_stack->view.
      lmo_static_controller  ?= lo_stack->controller.
      lmo_current_controller ?= lo_stack->controller.
    ENDIF.

    "Set Object name for Model
    _set_dynp_stack_name( EXPORTING io_stack       = lo_stack
                                    iv_object_name = lmc_obj_model
                                    iv_stack_name  = lmv_current_stack ).

    IF ct_data IS SUPPLIED
   AND ct_data IS NOT INITIAL.
      lo_out = REF #( ct_data ).
    ELSE.
      IF lo_stack->model IS BOUND.
        lo_out = lo_stack->model->get_controller_action( ms_view_action )->get_outtab( lmv_current_stack ).
      ENDIF.
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
              msgv1 = CONV #( lo_except->get_text( ) ).
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
*FORM set_pf_status USING rt_extab TYPE slis_t_extab.
*
*  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_pf_status( rt_extab ).
*
*ENDFORM.
*
*FORM user_command  USING up_ucomm    TYPE sy-ucomm
*                         us_selfield TYPE slis_selfield.
*
*  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_user_command( EXPORTING im_ucomm    = up_ucomm
*                                                                                     CHANGING  cs_selfield = us_selfield ).
*
*ENDFORM.
*
*FORM check_data_changed USING er_data_changed  TYPE REF TO cl_alv_changed_data_protocol.
*
*  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_check_changed_data( er_data_changed ).
*
*ENDFORM.
*
*FORM caller_exit USING is_data TYPE slis_data_caller_exit.
*
*  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_register_event( ).
*
*ENDFORM.
*
*FORM top_of_page.
*
*  CHECK zcl_mvcfw_base_lvc_controller=>check_routine_only( ) IS INITIAL.
*  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_top_of_page( ).
*
*ENDFORM.
*
*FORM top_of_page_html USING cl_dd TYPE REF TO cl_dd_document.
*
*  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_top_of_page_html( cl_dd ).
*
*ENDFORM.
*
*FORM end_of_page_html USING cl_dd TYPE REF TO cl_dd_document.
*
*  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_end_of_page_html( cl_dd ).
*
*ENDFORM.
  ENDMETHOD.


  METHOD _get_stack.
    TRY.
        rs_stack = REF #( lmt_stack[ KEY k2 COMPONENTS name = iv_name ] ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
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
