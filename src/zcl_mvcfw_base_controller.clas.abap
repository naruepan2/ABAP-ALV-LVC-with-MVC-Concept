class ZCL_MVCFW_BASE_CONTROLLER definition
  public
  create public .

public section.

  types:
    BEGIN OF ty_stack,
        name       TYPE dfies-tabname,
        view       TYPE REF TO zcl_mvcfw_base_view,
        model      TYPE REF TO zcl_mvcfw_base_model,
        controller TYPE REF TO zcl_mvcfw_base_controller,
        is_main    TYPE flag,
        is_current TYPE flag,
        line       TYPE sy-index,
      END OF ty_stack .
  types:
    BEGIN OF ty_stack_name,
        line TYPE sy-index,
        name TYPE dfies-tabname,
      END OF ty_stack_name .
  types:
    BEGIN OF ty_view_action,
        ucomm        TYPE sy-ucomm,
        selfield     TYPE slis_selfield,
        data_changed TYPE REF TO cl_alv_changed_data_protocol,
        cl_dd        TYPE REF TO cl_dd_document,
      END OF ty_view_action .
  types:
    tty_stack TYPE TABLE OF ty_stack WITH EMPTY KEY
                                             WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .
  types:
    tty_stack_name TYPE TABLE OF ty_stack_name WITH EMPTY KEY
                                            WITH NON-UNIQUE SORTED KEY k2 COMPONENTS name .

  constants MC_STACK_MAIN type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  constants MC_DEFLT_CNTL type SEOCLSNAME value 'LCL_CONTROLLER' ##NO_TEXT.
  constants MC_DEFLT_MODEL type SEOCLSNAME value 'LCL_MODEL' ##NO_TEXT.
  constants MC_DEFLT_VIEW type SEOCLSNAME value 'LCL_VIEW' ##NO_TEXT.
  constants MC_DEFLT_SSCR type SEOCLSNAME value 'ZCL_MVCFW_BASE_SSCR' ##NO_TEXT.
  constants MC_DEFLT_OUTTAB type DFIES-TABNAME value 'MT_OUTTAB' ##NO_TEXT.
  data MO_SSCR type ref to ZCL_MVCFW_BASE_SSCR .
  data MO_MODEL type ref to ZCL_MVCFW_BASE_MODEL .
  data MO_VIEW type ref to ZCL_MVCFW_BASE_VIEW .
  class-data MS_VIEW_ACTION type TY_VIEW_ACTION .

  events EVT_PF_STATUS
    exporting
      value(IT_EXTAB) type SLIS_T_EXTAB optional .
  events EVT_USER_COMMAND
    exporting
      value(IM_UCOMM) type SY-UCOMM optional
      value(IS_SELFIELD) type SLIS_SELFIELD optional .
  events EVT_CHECK_CHANGED_DATA
    exporting
      value(IO_DATA_CHANGED) type ref to CL_ALV_CHANGED_DATA_PROTOCOL optional .
  events EVT_REGISTER_EVENT .
  events EVT_TOP_OF_PAGE .
  events EVT_TOP_OF_PAGE_HTML
    exporting
      value(IO_DD_DOC) type ref to CL_DD_DOCUMENT optional .
  events EVT_END_OF_PAGE_HTML
    exporting
      value(IO_DD_DOC) type ref to CL_DD_DOCUMENT optional .

  methods CONSTRUCTOR
    importing
      !IV_CNTL_NAME type SEOCLSNAME default MC_DEFLT_CNTL
      !IV_MODL_NAME type SEOCLSNAME default MC_DEFLT_MODEL
      !IV_VIEW_NAME type SEOCLSNAME default MC_DEFLT_VIEW
      !IV_SSCR_NAME type SEOCLSNAME default MC_DEFLT_SSCR
      !IV_SET_HANDLER type ABAP_BOOL default ABAP_TRUE .
  methods DISPLAY
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
      !IV_SAVE type CHAR1 default ABAP_TRUE
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
      !IT_EXCPT type ABAP_EXCPBIND_TAB optional
    raising
      ZBCX_EXCEPTION .
  methods HANDLE_SSCR_PBO
    importing
      !IV_DYNNR type SY-DYNNR default SY-DYNNR .
  methods HANDLE_SSCR_PAI
    importing
      !IV_DYNNR type SY-DYNNR default SY-DYNNR .
  methods HANDLE_PF_STATUS
    for event EVT_PF_STATUS of ZCL_MVCFW_BASE_CONTROLLER
    importing
      !IT_EXTAB .
  methods HANDLE_USER_COMMAND
    for event EVT_USER_COMMAND of ZCL_MVCFW_BASE_CONTROLLER
    importing
      !IM_UCOMM
      !IS_SELFIELD .
  methods HANDLE_CHECK_CHANGED_DATA
    for event EVT_CHECK_CHANGED_DATA of ZCL_MVCFW_BASE_CONTROLLER
    importing
      !IO_DATA_CHANGED .
  methods HANDLE_REGISTER_EVENT
    for event EVT_REGISTER_EVENT of ZCL_MVCFW_BASE_CONTROLLER .
  methods HANDLE_TOP_OF_PAGE
    for event EVT_TOP_OF_PAGE of ZCL_MVCFW_BASE_CONTROLLER .
  methods HANDLE_TOP_OF_PAGE_HTML
    for event EVT_TOP_OF_PAGE_HTML of ZCL_MVCFW_BASE_CONTROLLER
    importing
      !IO_DD_DOC .
  methods HANDLE_END_OF_PAGE_HTML
    for event EVT_END_OF_PAGE_HTML of ZCL_MVCFW_BASE_CONTROLLER
    importing
      !IO_DD_DOC .
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
      !IO_DD_DOC type ref to CL_DD_DOCUMENT optional .
  methods RAISE_END_OF_PAGE_HTML
    importing
      !IO_DD_DOC type ref to CL_DD_DOCUMENT optional .
  class-methods GET_CONTROL_INSTANCE
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_CONTROLLER .
  class-methods SET_STACK_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME
      !IO_MODEL type ref to ZCL_MVCFW_BASE_MODEL optional
      !IO_VIEW type ref to ZCL_MVCFW_BASE_VIEW optional
      !IV_NOT_CHECKED type FLAG default SPACE .
  class-methods CHECK_ROUTINE
    importing
      !IV_SET_VALUE type FLAG optional
      !IV_GET_VALUE type FLAG optional
    exporting
      value(EV_VALUE) type FLAG .
  class-methods CHECK_ROUTINE_ONLY
    returning
      value(RV_CHECK_ONLY) type FLAG .
  class-methods DESTROY_STACK
    importing
      value(IV_NAME) type DFIES-TABNAME optional
      value(IV_CURRENT_NAME) type DFIES-TABNAME optional .
  class-methods GET_STACK_BY_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME
    returning
      value(RS_STACK) type ref to TY_STACK .
  class-methods GET_ALL_STACK
    returning
      value(RT_STACK) type TTY_STACK .
  class-methods GET_CURRENT_STACK
    returning
      value(RV_CURRENT_STACK) type DFIES-TABNAME .
  class-methods SET_VIEW_ACTION
    importing
      !IR_ACTION type ref to TY_VIEW_ACTION .
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
private section.

  types:
    BEGIN OF lty_class_type,
        sscr       TYPE flag,
        model      TYPE flag,
        view       TYPE flag,
        controller TYPE flag,
      END OF lty_class_type .

  class-data LMV_CURRENT_STACK type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  data LMO_CURRENT_MODEL type ref to ZCL_MVCFW_BASE_MODEL .
  data LMO_CURRENT_VIEW type ref to ZCL_MVCFW_BASE_VIEW .
  class-data LMV_ROUTINE_CHECK type FLAG .
  constants LMC_BASE_CNTL type SEOCLSNAME value 'ZCL_MVCFW_BASE_CONTROLLER' ##NO_TEXT.
  constants LMC_BASE_MODEL type SEOCLSNAME value 'ZCL_MVCFW_BASE_MODEL' ##NO_TEXT.
  constants LMC_BASE_VIEW type SEOCLSNAME value 'ZCL_MVCFW_BASE_VIEW' ##NO_TEXT.
  constants LMC_BASE_SSCR type SEOCLSNAME value 'ZCL_MVCFW_BASE_SSCR' ##NO_TEXT.

  methods _CREATE_ANY_OBJECT
    importing
      !IV_CLASS_NAME type SEOCLSNAME
      !IS_CLASS_TYPE type LTY_CLASS_TYPE
    exporting
      !EV_CLASS_NAME type SEOCLSNAME
    returning
      value(RO_CLASS) type ref to OBJECT .
  class-methods _CHECK_STACK
    importing
      !IV_NAME type DFIES-TABNAME
      !IO_MODEL type ref to ZCL_MVCFW_BASE_MODEL
      !IO_VIEW type ref to ZCL_MVCFW_BASE_VIEW .
  class-methods _GET_STACK
    importing
      !IV_NAME type DFIES-TABNAME
    returning
      value(RS_STACK) type ref to TY_STACK .
  methods _SET_DYNP_STACK_NAME
    importing
      !IO_STACK type ref to TY_STACK
      !IV_OBJECT_NAME type DFIES-TABNAME
      !IV_STACK_NAME type DFIES-TABNAME
    returning
      value(RO_CONTROLLER) type ref to ZCL_MVCFW_BASE_CONTROLLER .
  class-methods _INCL_FORM_BASE_CONTROLLER .
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
      IF lo_stack->model IS BOUND.
        lo_out = lo_stack->model->get_controller_action( ms_view_action )->get_outtab( iv_stack_name = lmv_current_stack ).
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


  METHOD set_view_action.
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
