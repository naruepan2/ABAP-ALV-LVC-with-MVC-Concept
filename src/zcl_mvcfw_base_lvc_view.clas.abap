class ZCL_MVCFW_BASE_LVC_VIEW definition
  public
  create public .

public section.

  constants MC_STACK_MAIN type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  constants MC_DEFLT_CNTL type SEOCLSNAME value 'LCL_CONTROLLER' ##NO_TEXT.
  constants MC_DEFLT_VIEW type SEOCLSNAME value 'LCL_VIEW' ##NO_TEXT.
  constants MC_DOUBLE_CLICK_UCOMM type SYUCOMM value '&IC1' ##NO_TEXT.
  constants:
    BEGIN OF mc_callback_fname,
        set_pf_status      TYPE slis_formname VALUE 'SET_PF_STATUS',
        user_command       TYPE slis_formname VALUE 'USER_COMMAND',
        top_of_page        TYPE slis_formname VALUE 'TOP_OF_PAGE',
        top_of_page_html   TYPE slis_formname VALUE 'TOP_OF_PAGE_HTML',
        end_of_page_html   TYPE slis_formname VALUE 'END_OF_PAGE_HTML',
        check_changed_data TYPE slis_formname VALUE 'CHECK_CHANGED_DATA',
      END OF mc_callback_fname .
  constants:
    BEGIN OF mc_layout_fname,
        excp_fname TYPE lvc_fname VALUE 'ALV_TRAFF',
        stylefname TYPE lvc_fname VALUE 'ALV_CELLTAB',
        info_fname TYPE lvc_fname VALUE 'ALV_S_COLOR',
        ctab_fname TYPE lvc_fname VALUE 'ALV_C_COLOR',
      END OF mc_layout_fname .

  methods CONSTRUCTOR
    importing
      !IV_CNTL_NAME type SEOCLSNAME optional
      !IV_VIEW_NAME type SEOCLSNAME optional .
  methods PREPARE_DISPLAY
    importing
      !IV_REPID type SY-CPROG default SY-CPROG
      !IV_SET_PF_STATUS type FLAG default ABAP_TRUE
      !IV_USER_COMMAND type FLAG default ABAP_TRUE
      !IV_CALLBACK_TOP_OF_PAGE type FLAG optional
      !IV_CALLBACK_HTML_TOP_OF_PAGE type FLAG optional
      !IV_CALLBACK_HTML_END_OF_LIST type FLAG optional
      !IS_GRID_TITLE type LVC_TITLE optional
      !IS_GRID_SETTINGS type LVC_S_GLAY optional
      !IS_LAYOUT type LVC_S_LAYO optional
      !IT_FIELDCAT type LVC_T_FCAT optional
      !IT_EXCLUDING type SLIS_T_EXTAB optional
      !IT_SPECIAL_GROUPS type LVC_T_SGRP optional
      !IT_SORT type LVC_T_SORT optional
      !IT_FILTER type LVC_T_FILT optional
      !IV_DEFAULT type CHAR1 optional
      !IV_SAVE type CHAR1 optional
      !IS_VARIANT type DISVARIANT optional
      !IT_EVENT type SLIS_T_EVENT optional
      !IT_EVENT_EXIT type SLIS_T_EVENT_EXIT optional
      !IV_SCREEN_START_COLUMN type I optional
      !IV_SCREEN_START_LINE type I optional
      !IV_SCREEN_END_COLUMN type I optional
      !IV_SCREEN_END_LINE type I optional
      !IV_HTML_HEIGHT_TOP type I optional
      !IV_HTML_HEIGHT_END type I optional
    exporting
      !EV_SET_PF_STATUS type SLIS_FORMNAME
      !EV_USER_COMMAND type SLIS_FORMNAME
      !EV_CALLBACK_TOP_OF_PAGE type SLIS_FORMNAME
      !EV_CALLBACK_HTML_TOP_OF_PAGE type SLIS_FORMNAME
      !EV_CALLBACK_HTML_END_OF_LIST type SLIS_FORMNAME
      !ES_GRID_TITLE type LVC_TITLE
      !ES_GRID_SETTINGS type LVC_S_GLAY
      !ES_LAYOUT type LVC_S_LAYO
      !ET_FIELDCAT type LVC_T_FCAT
      !ET_EXCLUDING type SLIS_T_EXTAB
      !ET_SPECIAL_GROUPS type LVC_T_SGRP
      !ET_SORT type LVC_T_SORT
      !ET_FILTER type LVC_T_FILT
      !EV_DEFAULT type CHAR1
      !EV_SAVE type CHAR1
      !ES_VARIANT type DISVARIANT
      !ET_EVENT type SLIS_T_EVENT
      !ET_EVENT_EXIT type SLIS_T_EVENT_EXIT
      !EV_SCREEN_START_COLUMN type I
      !EV_SCREEN_START_LINE type I
      !EV_SCREEN_END_COLUMN type I
      !EV_SCREEN_END_LINE type I
      !EV_HTML_HEIGHT_TOP type I
      !EV_HTML_HEIGHT_END type I
    changing
      !CT_DATA type TABLE optional .
  methods DISPLAY
    importing
      value(IV_REPID) type SY-CPROG default SY-CPROG
      value(IV_SET_PF_STATUS) type FLAG default ABAP_TRUE
      value(IV_USER_COMMAND) type FLAG default ABAP_TRUE
      value(IV_CALLBACK_TOP_OF_PAGE) type FLAG optional
      value(IV_CALLBACK_HTML_TOP_OF_PAGE) type FLAG optional
      value(IV_CALLBACK_HTML_END_OF_LIST) type FLAG optional
      value(IS_GRID_TITLE) type LVC_TITLE optional
      value(IS_GRID_SETTINGS) type LVC_S_GLAY optional
      value(IS_LAYOUT) type LVC_S_LAYO optional
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(IT_EXCLUDING) type SLIS_T_EXTAB optional
      value(IT_SPECL_GRPS) type LVC_T_SGRP optional
      value(IT_SORT) type LVC_T_SORT optional
      value(IT_FILTER) type LVC_T_FILT optional
      value(IV_DEFAULT) type CHAR1 default ABAP_TRUE
      value(IV_SAVE) type CHAR1 default 'A'
      value(IS_VARIANT) type DISVARIANT optional
      value(IT_EVENT) type SLIS_T_EVENT optional
      value(IT_EVENT_EXIT) type SLIS_T_EVENT_EXIT optional
      value(IV_SCREEN_START_COLUMN) type I optional
      value(IV_SCREEN_START_LINE) type I optional
      value(IV_SCREEN_END_COLUMN) type I optional
      value(IV_SCREEN_END_LINE) type I optional
      value(IV_HTML_HEIGHT_TOP) type I optional
      value(IV_HTML_HEIGHT_END) type I optional
    changing
      !CT_DATA type TABLE
    raising
      ZBCX_EXCEPTION .
  methods SET_PF_STATUS
    importing
      value(IT_EXTAB) type SLIS_T_EXTAB optional
      !IV_STACK_NAME type DFIES-TABNAME optional .
  methods USER_COMMAND
    importing
      !IM_UCOMM type SY-UCOMM
      !IO_MODEL type ref to ZCL_MVCFW_BASE_LVC_MODEL optional
      !IO_CONTROLLER type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER optional
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CS_SELFIELD type SLIS_SELFIELD optional .
  methods CHECK_CHANGED_DATA
    importing
      !IO_DATA_CHANGED type ref to CL_ALV_CHANGED_DATA_PROTOCOL
    changing
      !CT_DATA type TABLE .
  methods SET_TOP_OF_PAGE_HTML
    importing
      !IR_DD_DOC type ref to CL_DD_DOCUMENT
      !IV_STACK_NAME type DFIES-TABNAME optional .
  methods SET_TOP_OF_PAGE
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional .
  methods SET_END_OF_PAGE_HTML
    importing
      !IR_DD_DOC type ref to CL_DD_DOCUMENT
      !IV_STACK_NAME type DFIES-TABNAME optional .
  methods REGISTER_EVENT
    importing
      !IV_EVT_MODIFIED type FLAG optional
      !IV_EVT_ENTER type FLAG optional
      !IV_SET_OO_TOOLBAR type FLAG optional
      !IV_STACK_NAME type DFIES-TABNAME optional
    exporting
      !EO_GRID type ref to CL_GUI_ALV_GRID
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW .
  methods REFRESH_TABLE_DISPLAY
    importing
      value(IS_STABLE) type LVC_S_STBL optional
      value(IV_SOFT_REFRESH) type CHAR01 optional .
  methods REFRESH_ALV_SELFIELD
    importing
      !IV_SOFT_REFRESH type CHAR01 optional
    changing
      !CS_SELFIELD type SLIS_SELFIELD .
  methods MODIFY_GRID_IN_REGISTER_EVENT .
  methods CREATE_NEW_VIEW_TO_CONTROLLER
    importing
      value(IV_STACK_NAME) type DFIES-TABNAME
      !IO_MODEL type ref to ZCL_MVCFW_BASE_LVC_MODEL optional
      !IO_CONTROLLER type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER optional
      !IR_ACTION type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER=>TS_LVC_VIEW_ACTION optional
    exporting
      !EO_CONTROLLER type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW
    raising
      ZBCX_EXCEPTION .
  methods DISPLAY_SUB_ALV
    importing
      value(IV_REPID) type SY-CPROG default SY-CPROG
      value(IV_SET_PF_STATUS) type FLAG default ABAP_TRUE
      value(IV_USER_COMMAND) type FLAG default ABAP_TRUE
      value(IV_CALLBACK_TOP_OF_PAGE) type FLAG optional
      value(IV_CALLBACK_HTML_TOP_OF_PAGE) type FLAG optional
      value(IV_CALLBACK_HTML_END_OF_LIST) type FLAG optional
      value(IS_GRID_TITLE) type LVC_TITLE optional
      value(IS_GRID_SETTINGS) type LVC_S_GLAY optional
      value(IS_LAYOUT) type LVC_S_LAYO optional
      value(IT_FIELDCAT) type LVC_T_FCAT optional
      value(IT_EXCLUDING) type SLIS_T_EXTAB optional
      value(IT_SPECL_GRPS) type LVC_T_SGRP optional
      value(IT_SORT) type LVC_T_SORT optional
      value(IT_FILTER) type LVC_T_FILT optional
      value(IV_DEFAULT) type CHAR1 default ABAP_TRUE
      value(IV_SAVE) type CHAR1 default ABAP_TRUE
      value(IS_VARIANT) type DISVARIANT optional
      value(IT_EVENT) type SLIS_T_EVENT optional
      value(IT_EVENT_EXIT) type SLIS_T_EVENT_EXIT optional
      value(IV_SCREEN_START_COLUMN) type I optional
      value(IV_SCREEN_START_LINE) type I optional
      value(IV_SCREEN_END_COLUMN) type I optional
      value(IV_SCREEN_END_LINE) type I optional
      value(IV_HTML_HEIGHT_TOP) type I optional
      value(IV_HTML_HEIGHT_END) type I optional
      value(IV_STACK_NAME) type DFIES-TABNAME optional
      value(IV_DESTROY_CURRENT_VIEW) type FLAG default ABAP_TRUE
    changing
      !CT_DATA type TABLE optional
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW
    raising
      ZBCX_EXCEPTION .
  methods SET_TOP_PAGE_HTML
    importing
      !IO_DD_DOC type ref to CL_DD_DOCUMENT .
  methods MODIFY_FCAT
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CT_FCAT type LVC_T_FCAT .
  methods MODIFY_LAYOUT
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CS_LAYO type LVC_S_LAYO .
  methods MODIFY_EVENTS
    importing
      !IT_FCAT type LVC_T_FCAT optional
      !IV_EVT_DATA_CHANGED type ABAP_BOOL optional
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CT_EVENT type SLIS_T_EVENT .
  methods MODIFY_SORT
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CT_SORT type LVC_T_SORT .
  methods MODIFY_ALV_SETTINGS
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CS_GRID_TITLE type LVC_TITLE optional
      !CS_GRID_SETTINGS type LVC_S_GLAY optional
      !CT_EXCLUDING type SLIS_T_EXTAB optional
      !CT_SPECIAL_GROUPS type LVC_T_SGRP optional
      !CT_SORT type LVC_T_SORT optional
      !CT_FILTER type LVC_T_FILT optional
      !CV_DEFAULT type CHAR1 optional
      !CV_SAVE type CHAR1 optional
      !CS_VARIANT type DISVARIANT optional .
  methods MODIFY_CALLBACK_ROUTINES
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CV_SET_PF_STATUS type FLAG optional
      !CV_USER_COMMAND type FLAG optional
      !CV_CALLBACK_TOP_OF_PAGE type FLAG optional
      !CV_CALLBACK_HTML_TOP_OF_PAGE type FLAG optional
      !CV_CALLBACK_HTML_END_OF_LIST type FLAG optional .
  methods MODIFY_POPUP_SCREEN
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CV_SCREEN_START_COLUMN type I optional
      !CV_SCREEN_START_LINE type I optional
      !CV_SCREEN_END_COLUMN type I optional
      !CV_SCREEN_END_LINE type I optional .
  methods MODIFY_HTML_HEIGHT
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CV_HTML_HEIGHT_TOP type I optional
      !CV_HTML_HEIGHT_END type I optional .
  methods GET_FIELDCAT
    returning
      value(RT_FIELDCAT_LVC) type LVC_T_FCAT .
  methods SET_FIELDCAT
    importing
      !IT_FIELDCAT_LVC type LVC_T_FCAT .
  methods GET_LAYOUT
    returning
      value(RS_LAYO) type LVC_S_LAYO .
  methods SET_LAYOUT
    importing
      !IS_LAYO type LVC_S_LAYO .
  methods SET_STACK_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME default MC_STACK_MAIN
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW .
  methods GET_STACK_NAME
    returning
      value(RV_STACK_NAME) type DFIES-TABNAME .
  methods SET_FCAT_TEXT
    importing
      !IV_TEXT type ANY optional
      !IV_SCRTEXT_L type LVC_S_FCAT-SCRTEXT_L optional
      !IV_SCRTEXT_M type LVC_S_FCAT-SCRTEXT_M optional
      !IV_SCRTEXT_S type LVC_S_FCAT-SCRTEXT_S optional
      !IV_REPTEXT type LVC_S_FCAT-REPTEXT optional
      !IV_FIELDNAME type LVC_S_FCAT-FIELDNAME optional
    changing
      !CS_FCAT type LVC_S_FCAT optional
      !CT_FCAT type LVC_T_FCAT optional .
  methods SET_FCAT_CHECKBOX
    importing
      !IV_FIELDNAME type LVC_S_FCAT-FIELDNAME optional
    changing
      !CS_FCAT type LVC_S_FCAT optional
      !CT_FCAT type LVC_T_FCAT optional .
  methods SET_FCAT_TECHNICAL
    importing
      !IV_FIELDNAME type LVC_S_FCAT-FIELDNAME optional
    changing
      !CS_FCAT type LVC_S_FCAT optional
      !CT_FCAT type LVC_T_FCAT optional .
  methods SET_FCAT_HIDDEN
    importing
      !IV_FIELDNAME type LVC_S_FCAT-FIELDNAME optional
    changing
      !CS_FCAT type LVC_S_FCAT optional
      !CT_FCAT type LVC_T_FCAT optional .
  methods SET_FCAT_KEY
    importing
      !IV_FIELDNAME type LVC_S_FCAT-FIELDNAME optional
    changing
      !CS_FCAT type LVC_S_FCAT optional
      !CT_FCAT type LVC_T_FCAT optional .
  methods SET_FCAT_FREEZE_COLUMN
    importing
      !IV_FIELDNAME type LVC_S_FCAT-FIELDNAME optional
    changing
      !CS_FCAT type LVC_S_FCAT optional
      !CT_FCAT type LVC_T_FCAT optional .
  methods SET_CHECKBOX_VALUE
    importing
      !IV_VALUE type CHAR01 optional
      !IV_FIELDNAME type LVC_S_FCAT-FIELDNAME
      !IV_TABINDEX type SY-TABIX
      !IO_MODEL type ref to ZCL_MVCFW_BASE_LVC_MODEL optional
    changing
      !CS_SELFIELD type SLIS_SELFIELD optional .
  methods GET_CURRENT_STACK_NAME
    returning
      value(RE_CURRENT_STACK) type DFIES-TABNAME .
  methods GET_GLOBALS_FROM_SLVC_FULLSCR
    exporting
      !ET_EXCLUDING type SLIS_T_EXTAB
      !EV_CALLBACK_PROGRAM type SY-REPID
      !EV_CALLBACK_ROUTINE type SLIS_FORMNAME
      !EO_GRID type ref to CL_GUI_ALV_GRID
      !ET_FIELDCAT type LVC_T_FCAT
      !EV_FLG_NO_HTML type C
      !ES_LAYOUT type LVC_S_LAYO
      !ES_SEL_HIDE type SLIS_SEL_HIDE_ALV
      !ET_EVENT_EXIT type KKBLO_T_EVENT_EXIT .
  methods CHECK_CHANGED_DATA_IN_UCOMM
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW .
  methods DESTROY_VIEW
    importing
      !IV_NAME type DFIES-TABNAME optional
      !IV_CURRENT_NAME type DFIES-TABNAME optional .
  class-methods TRANSFER_LVC_TO_SLIS
    importing
      !IT_FIELDCAT_LVC type LVC_T_FCAT optional
      !IT_SORT_LVC type LVC_T_SORT optional
      !IT_FILTER_LVC type LVC_T_FILT optional
      !IS_LAYOUT_LVC type LVC_S_LAYO optional
    exporting
      !ET_FIELDCAT_ALV type SLIS_T_FIELDCAT_ALV
      !ET_SORT_ALV type SLIS_T_SORTINFO_ALV
      !ET_FILTER_ALV type SLIS_T_FILTER_ALV
      !ES_LAYOUT_ALV type SLIS_LAYOUT_ALV
    changing
      !CT_DATA type STANDARD TABLE optional .
  class-methods EXPORT_VIEW_DATA_TO_XLS
    importing
      value(IT_DATA) type TABLE
      value(IV_FILENAME) type STRING optional
      value(IV_EXECUTE) type ABAP_BOOL default ABAP_TRUE
    raising
      ZBCX_EXCEPTION .
  methods SET_DEFAULT_GRID_HANDLER
    importing
      !IO_VIEW type ref to ZCL_MVCFW_BASE_LVC_VIEW optional .
  methods HANDLE_GRID_USER_COMMAND
    for event USER_COMMAND of CL_GUI_ALV_GRID
    importing
      !E_UCOMM .
  methods HANDLE_GRID_TOOLBAR
    for event TOOLBAR of CL_GUI_ALV_GRID
    importing
      !E_OBJECT
      !E_INTERACTIVE .
  methods HANDLE_GRID_DOUBLE_CLICK
    for event DOUBLE_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW
      !E_COLUMN
      !ES_ROW_NO .
  methods HANDLE_GRID_HOTSPOT_CLICK
    for event HOTSPOT_CLICK of CL_GUI_ALV_GRID
    importing
      !E_ROW_ID
      !E_COLUMN_ID
      !ES_ROW_NO .
  methods HANDLE_GRID_DATA_CHANGED
    for event DATA_CHANGED of CL_GUI_ALV_GRID
    importing
      !ER_DATA_CHANGED
      !E_ONF4
      !E_ONF4_BEFORE
      !E_ONF4_AFTER
      !E_UCOMM .
  methods HANDLE_GRID_CHANGED_FINISHED
    for event DATA_CHANGED_FINISHED of CL_GUI_ALV_GRID
    importing
      !E_MODIFIED
      !ET_GOOD_CELLS .
  methods HANDLE_GUI_ALV_GRID
    importing
      !IO_GRID type ref to CL_GUI_ALV_GRID .
  methods SET_GRID_HANDLER_BEFORE_DISP
    importing
      !IO_VIEW type ref to ZCL_MVCFW_BASE_LVC_VIEW optional
      value(IV_SET_OO_TOOLBAR) type FLAG optional
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW .
  methods SET_CONTROLLER_TO_VIEW
    importing
      !IO_CONTROLLER type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW .
  methods SET_MODEL_TO_VIEW
    importing
      !IO_MODEL type ref to ZCL_MVCFW_BASE_LVC_MODEL
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW .
  methods SET_VIEW_ATTRIBUTES
    importing
      !IO_MODEL type ref to ZCL_MVCFW_BASE_LVC_MODEL
      !IO_CONTROLLER type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER optional .
  methods GET_MODEL
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_LVC_MODEL .
  methods GET_VIEW_OUTTAB
    returning
      value(RT_OUTTAB) type ref to DATA .
  methods AUTO_GENERATE_STACK_NAME
    returning
      value(RV_STACK_NAME) type DFIES-TABNAME .
  methods GET_LVC_GUI_ALV_GRID
    returning
      value(RO_GRID) type ref to CL_GUI_ALV_GRID .
  methods REDRAW_ALV_GRID
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW .
protected section.

  data LMV_REPID type SY-CPROG .
  data LMT_FCAT type LVC_T_FCAT .
  data LMT_OUTTAB type ref to DATA .
  data LMO_MODEL type ref to ZCL_MVCFW_BASE_LVC_MODEL .
  data LMO_CONTROLLER type ref to ZCL_MVCFW_BASE_LVC_CONTROLLER .
  data LMV_CL_VIEW_NAME type CHAR30 .
  data LMV_CL_CNTL_NAME type CHAR30 .
  data LMV_CURRENT_STACK type DFIES-TABNAME value MC_STACK_MAIN ##NO_TEXT.

  methods _PREPARE_DEFAULT_ALV
    exporting
      !ET_FCAT type LVC_T_FCAT
      !ET_EVENT type SLIS_T_EVENT
      !ES_LAYO type LVC_S_LAYO
    changing
      !CT_DATA type STANDARD TABLE optional .
  methods _SET_DEFAULT_FCAT
    importing
      value(IT_TABLE) type STANDARD TABLE
    returning
      value(RT_FCAT) type LVC_T_FCAT .
  methods _SET_DEFAULT_EVENT
    returning
      value(RT_EVENT) type SLIS_T_EVENT .
  methods _SET_DEFAULT_LAYOUT
    returning
      value(RS_LAYO) type LVC_S_LAYO .
  methods _GENERATE_FCAT_FROM_ITAB
    importing
      value(IT_TABLE) type STANDARD TABLE
    returning
      value(RT_FCAT) type LVC_T_FCAT .
  methods _CALL_ALV_GRID_DISPLAY_LVC
    importing
      !I_CALLBACK_PROGRAM type SY-CPROG default SY-CPROG
      !I_CALLBACK_PF_STATUS_SET type SLIS_FORMNAME optional
      !I_CALLBACK_USER_COMMAND type SLIS_FORMNAME optional
      !I_CALLBACK_TOP_OF_PAGE type SLIS_FORMNAME optional
      !I_CALLBACK_HTML_TOP_OF_PAGE type SLIS_FORMNAME optional
      !I_CALLBACK_HTML_END_OF_LIST type SLIS_FORMNAME optional
      !I_GRID_TITLE type LVC_TITLE optional
      !I_GRID_SETTINGS type LVC_S_GLAY optional
      !IS_LAYOUT type LVC_S_LAYO optional
      !IT_FIELDCAT type LVC_T_FCAT optional
      !IT_EXCLUDING type SLIS_T_EXTAB optional
      !IT_SPECIAL_GROUPS type LVC_T_SGRP optional
      !IT_SORT type LVC_T_SORT optional
      !IT_FILTER type LVC_T_FILT optional
      !I_DEFAULT type CHAR1 optional
      !I_SAVE type CHAR1 optional
      !IS_VARIANT type DISVARIANT optional
      !IT_EVENTS type SLIS_T_EVENT optional
      !IT_EVENT_EXIT type SLIS_T_EVENT_EXIT optional
      !IV_SCREEN_START_COLUMN type I optional
      !IV_SCREEN_START_LINE type I optional
      !IV_SCREEN_END_COLUMN type I optional
      !IV_SCREEN_END_LINE type I optional
      !IV_HTML_HEIGHT_TOP type I optional
      !IV_HTML_HEIGHT_END type I optional
    changing
      !T_OUTTAB type TABLE
    exceptions
      PROGRAM_ERROR .
  methods _CHECK_PREPARE_BEFORE_DISPLAY
    changing
      !CV_SET_PF_STATUS type SLIS_FORMNAME optional
      !CV_USER_COMMAND type SLIS_FORMNAME optional
      !CV_CALLBACK_TOP_OF_PAGE type SLIS_FORMNAME optional
      !CV_CALLBACK_HTML_TOP_OF_PAGE type SLIS_FORMNAME optional
      !CV_CALLBACK_HTML_END_OF_LIST type SLIS_FORMNAME optional
      !CS_GRID_TITLE type LVC_TITLE optional
      !CS_GRID_SETTINGS type LVC_S_GLAY optional
      !CS_LAYOUT type LVC_S_LAYO optional
      !CT_FIELDCAT type LVC_T_FCAT optional
      !CT_EXCLUDING type SLIS_T_EXTAB optional
      !CT_SPECIAL_GROUPS type LVC_T_SGRP optional
      !CT_SORT type LVC_T_SORT optional
      !CT_FILTER type LVC_T_FILT optional
      !CV_DEFAULT type CHAR1 optional
      !CV_SAVE type CHAR1 optional
      !CS_VARIANT type DISVARIANT optional
      !CT_EVENT type SLIS_T_EVENT optional .
  methods _POPULATE_EVENTS
    importing
      !IT_EVENT type SLIS_T_EVENT
      !IV_STACK_NAME type DFIES-TABNAME optional
    changing
      !CT_EVENT type SLIS_T_EVENT .
  methods _CHECK_VARIANT_EXISTENCE
    importing
      value(IV_SAVE) type CHAR1
    changing
      value(CS_VARIANT) type DISVARIANT .
  methods _GET_GLOBALS_FULLSCREEN_GRID
    exporting
      !EO_GRID type ref to CL_GUI_ALV_GRID
      value(ES_LVC_LAYOUT) type LVC_S_LAYO
      value(ET_LVC_FIELDCAT) type LVC_T_FCAT
      value(ET_LVC_SORT) type LVC_T_SORT
      value(ET_LVC_FILTER) type LVC_T_FILT
      value(ET_EXCLUDING_LVC) type UI_FUNCTIONS .
  methods _SET_GLOBALS_FULLSCREEN_GRID
    importing
      !IS_LVC_LAYOUT type LVC_S_LAYO optional
      !IT_LVC_FIELDCAT type LVC_T_FCAT optional
      !IT_LVC_SORT type LVC_T_SORT optional
      !IT_LVC_FILTER type LVC_T_FILT optional
      !IT_EXCLUDING_LVC type UI_FUNCTIONS optional .
  methods _REGISTER_EDIT_EVENT
    importing
      !IV_EVT_MODIFIED type FLAG optional
      !IV_EVT_ENTER type FLAG optional
    changing
      !CO_GRID type ref to CL_GUI_ALV_GRID .
  methods _CHECK_GRID_OOPS_TOOLBAR
    importing
      !IO_VIEW type ref to ZCL_MVCFW_BASE_LVC_VIEW optional
    returning
      value(RO_VIEW) type ref to ZCL_MVCFW_BASE_LVC_VIEW .
  methods _SET_GRID_OOPS_TOOLBAR
    changing
      !CS_LVC_LAYOUT type LVC_S_LAYO .
  methods _EXCLUDE_DEFAULT_GRID_TOOLBAR
    importing
      !E_OBJECT type ref to CL_ALV_EVENT_TOOLBAR_SET
      !E_INTERACTIVE type CHAR01 .
private section.

  methods _POPULATE_LAYOUT
    importing
      !IT_FCAT type LVC_T_FCAT
    changing
      !CS_LAYO type LVC_S_LAYO .
  methods _POPULATE_FCAT
    importing
      !IT_FCAT type LVC_T_FCAT .
  methods _POPULATE_CALLBACK_ROUTINE
    importing
      !IV_SET_PF_STATUS type FLAG
      !IV_USER_COMMAND type FLAG
      !IV_CALLBACK_TOP_OF_PAGE type FLAG
      !IV_CALLBACK_HTML_TOP_OF_PAGE type FLAG
      !IV_CALLBACK_HTML_END_OF_LIST type FLAG
    changing
      !CV_SET_PF_STATUS type SLIS_FORMNAME
      !CV_USER_COMMAND type SLIS_FORMNAME
      !CV_CALLBACK_TOP_OF_PAGE type SLIS_FORMNAME
      !CV_CALLBACK_HTML_TOP_OF_PAGE type SLIS_FORMNAME
      !CV_CALLBACK_HTML_END_OF_LIST type SLIS_FORMNAME .
  methods _CHECK_ROUTINE
    importing
      !IV_FORMNAME type SLIS_FORMNAME
    exporting
      value(EV_FOUND) type FLAG .
  methods _CREATE_ANY_OBJECT
    importing
      value(IV_CLASS_NAME) type CHAR30 default MC_DEFLT_VIEW
    returning
      value(RO_CLASS) type ref to OBJECT .
  methods _CREATE_SALV_TREE_OBJECT
    importing
      !IV_CREATE_TREE_DIRECTLY type SAP_BOOL optional
    changing
      !CT_DATA type STANDARD TABLE optional
    returning
      value(RO_TREE) type ref to CL_SALV_TREE .
  methods _SET_LOCAL_LAYOUT_FULSCR_GRID .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_LVC_VIEW IMPLEMENTATION.


  METHOD check_changed_data.
*    DATA ls_modi TYPE lvc_s_modi.
*
*    BREAK-POINT.
*
** Check each modification:
*    LOOP AT io_data_changed->mt_mod_cells INTO ls_modi.
*      CASE ls_modi-fieldname.
*        WHEN ''.
*
*      ENDCASE.
*    ENDLOOP.
  ENDMETHOD.


  METHOD check_changed_data_in_ucomm.
    ro_view       = me.
    DATA(lo_grid) = get_lvc_gui_alv_grid( ).

    CHECK lo_grid IS BOUND.

    lo_grid->check_changed_data( ).
  ENDMETHOD.


  METHOD constructor.

    lmv_cl_cntl_name = COND #( WHEN iv_cntl_name IS INITIAL THEN mc_deflt_cntl ELSE iv_cntl_name ).
    lmv_cl_view_name = COND #( WHEN iv_view_name IS INITIAL THEN mc_deflt_view ELSE iv_view_name ).

  ENDMETHOD.


  METHOD create_new_view_to_controller.
    DATA: lo_controller	TYPE REF TO zcl_mvcfw_base_lvc_controller,
          lo_model      TYPE REF TO zcl_mvcfw_base_lvc_model.

    IF iv_stack_name IS INITIAL.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Please enter stack name'.
    ENDIF.

    ro_view        = me.
    lo_controller ?= COND #( WHEN io_controller IS BOUND THEN io_controller
                             ELSE zcl_mvcfw_base_lvc_controller=>get_static_control_instance( ) ).
    lo_model      ?= COND #( WHEN io_model IS BOUND THEN io_model
                             ELSE zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->mo_model ).

    TRY.
        me->set_controller_to_view( lo_controller )->set_model_to_view( lo_model ).

        zcl_mvcfw_base_lvc_controller=>get_static_control_instance(
                                        )->set_stack_name( iv_stack_name = |{ iv_stack_name CASE = UPPER }|
                                                           io_model      = lo_model
                                                           io_view       = me
                                        )->set_view_action( ir_action ).
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_dyn_msg) = lo_dyn_except->get_text( ).
    ENDTRY.

    eo_controller ?= lo_controller.
  ENDMETHOD.


  METHOD destroy_view.
    zcl_mvcfw_base_lvc_controller=>get_static_control_instance(
                                      )->destroy_stack( iv_name         = iv_name
                                                        iv_current_name = iv_current_name ).
  ENDMETHOD.


  METHOD display.
    "--------------------------------------------------------------------"
    " Prepare all parameter to display ALV
    "--------------------------------------------------------------------"
    prepare_display(
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
        it_special_groups            = it_specl_grps
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
      IMPORTING
        ev_set_pf_status             = DATA(lv_set_pf_status)
        ev_user_command              = DATA(lv_user_command)
        ev_callback_top_of_page      = DATA(lv_callback_top_of_page)
        ev_callback_html_top_of_page = DATA(lv_callback_html_top_of_page)
        ev_callback_html_end_of_list = DATA(lv_callback_html_end_of_list)
        es_grid_title                = DATA(ls_grid_title)
        es_grid_settings             = DATA(ls_grid_settings)
        es_layout                    = DATA(ls_layout)
        et_fieldcat                  = DATA(lt_fieldcat)
        et_excluding                 = DATA(lt_excluding)
        et_special_groups            = DATA(lt_special_groups)
        et_sort                      = DATA(lt_sort)
        et_filter                    = DATA(lt_filter)
        ev_default                   = DATA(lv_default)
        ev_save                      = DATA(lv_save)
        es_variant                   = DATA(ls_variant)
        et_event                     = DATA(lt_event)
        et_event_exit                = DATA(lt_event_exit)
        ev_screen_start_column       = DATA(lv_screen_start_column)
        ev_screen_start_line         = DATA(lv_screen_start_line)
        ev_screen_end_column         = DATA(lv_screen_end_column)
        ev_screen_end_line           = DATA(lv_screen_end_line)
        ev_html_height_top           = DATA(lv_html_height_top)
        ev_html_height_end           = DATA(lv_html_height_end)
      CHANGING
        ct_data                      = ct_data ).

    "--------------------------------------------------------------------"
    " Display ALV
    "--------------------------------------------------------------------"
    _call_alv_grid_display_lvc(
      EXPORTING
        i_callback_program          = lmv_repid
        i_callback_pf_status_set    = lv_set_pf_status
        i_callback_user_command     = lv_user_command
        i_callback_top_of_page      = lv_callback_top_of_page
        i_callback_html_top_of_page = lv_callback_html_top_of_page
        i_callback_html_end_of_list = lv_callback_html_end_of_list
        i_grid_title                = ls_grid_title
        i_grid_settings             = ls_grid_settings
        is_layout                   = ls_layout
        it_fieldcat                 = lt_fieldcat
        it_excluding                = lt_excluding
        it_special_groups           = lt_special_groups
        it_sort                     = lt_sort
        it_filter                   = lt_filter
        i_default                   = lv_default
        i_save                      = lv_save
        is_variant                  = ls_variant
        it_events                   = lt_event
        it_event_exit               = lt_event_exit
        iv_screen_start_column      = lv_screen_start_column
        iv_screen_start_line        = lv_screen_start_line
        iv_screen_end_column        = lv_screen_end_column
        iv_screen_end_line          = lv_screen_end_line
        iv_html_height_top          = lv_html_height_top
        iv_html_height_end          = lv_html_height_end
      CHANGING
        t_outtab                    = ct_data
      EXCEPTIONS
        program_error               = 1
        OTHERS                      = 2 ).
    IF sy-subrc NE 0.
      RAISE EXCEPTION TYPE zbcx_exception USING MESSAGE.
    ENDIF.
  ENDMETHOD.


  METHOD display_sub_alv.
    IF lmo_controller IS NOT BOUND.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Controller was not created'.
    ENDIF.

    ro_view = me.

    TRY.
        CALL METHOD lmo_controller->display
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
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_dyn_msg) = lo_dyn_except->get_text( ).
      CATCH zbcx_exception INTO DATA(lo_sys_except).
        DATA(lv_sys_msg) = lo_sys_except->get_text( ).
    ENDTRY.

    IF iv_destroy_current_view IS NOT INITIAL.
      me->destroy_view( ).
    ENDIF.
  ENDMETHOD.


  METHOD export_view_data_to_xls.
    DATA: table TYPE REF TO data.
    DATA: lt_bintab TYPE STANDARD TABLE OF solix,
          lt_tab    TYPE filetable.
    DATA: lv_title       TYPE string VALUE 'Save file',
          lv_default_ext TYPE string VALUE '.XLS',
          lv_filefilter  TYPE string VALUE 'Excel Files (*.xls)|*.xls'.
    DATA: lv_size     TYPE i,
          lv_filename TYPE string,
          lv_rc       TYPE i.

    TRY.
        CREATE DATA table LIKE it_data.

        IF table IS NOT BOUND.
          RAISE EXCEPTION TYPE zbcx_exception
            EXPORTING
              msgv1 = 'Cannot create SALV table'.
        ENDIF.

        ASSIGN table->* TO FIELD-SYMBOL(<table>).

        cl_salv_table=>factory( IMPORTING r_salv_table = DATA(lo_table)
                                CHANGING  t_table      = <table>  ).

        DATA(lr_columns) = lo_table->get_columns( ).
        lr_columns->get_column( 'MANDT' )->set_technical( ).
        lr_columns->get_column( 'ALV_TRAFF' )->set_technical( ).
        lr_columns->get_column( 'ALV_C_COLOR' )->set_technical( ).
        lr_columns->get_column( 'ALV_CELLTAB' )->set_technical( ).
        lr_columns->get_column( 'ALV_C_COLOR' )->set_technical( ).
      CATCH cx_salv_msg
            cx_salv_not_found.
    ENDTRY.

* Convert ALV Table Object to XML
    DATA(lv_xml) = lo_table->to_xml( xml_type = '02' ).
    CHECK lv_xml IS NOT INITIAL.

* Convert XTRING to Binary
    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer        = lv_xml
      IMPORTING
        output_length = lv_size
      TABLES
        binary_tab    = lt_bintab.

    IF iv_filename IS INITIAL.
      CALL METHOD cl_gui_frontend_services=>file_open_dialog
        EXPORTING
          window_title            = lv_title
          default_extension       = lv_default_ext
          file_filter             = lv_filefilter
        CHANGING
          file_table              = lt_tab
          rc                      = lv_rc
        EXCEPTIONS
          file_open_dialog_failed = 1
          cntl_error              = 2
          error_no_gui            = 3
          not_supported_by_gui    = 4
          OTHERS                  = 5.

      TRY.
          iv_filename = lt_tab[ 1 ]-filename.
        CATCH cx_sy_itab_line_not_found.
          RAISE EXCEPTION TYPE zbcx_exception
            EXPORTING
              msgv1 = 'File name is required'.
      ENDTRY.
    ENDIF.

    CALL METHOD cl_gui_frontend_services=>gui_download
      EXPORTING
        bin_filesize            = lv_size
        filename                = iv_filename
        filetype                = 'BIN'
      CHANGING
        data_tab                = lt_bintab
      EXCEPTIONS
        file_write_error        = 1
        no_batch                = 2
        gui_refuse_filetransfer = 3
        invalid_type            = 4
        no_authority            = 5
        unknown_error           = 6
        header_not_allowed      = 7
        separator_not_allowed   = 8
        filesize_not_allowed    = 9
        header_too_long         = 10
        dp_error_create         = 11
        dp_error_send           = 12
        dp_error_write          = 13
        unknown_dp_error        = 14
        access_denied           = 15
        dp_out_of_memory        = 16
        disk_full               = 17
        dp_timeout              = 18
        file_not_found          = 19
        dataprovider_exception  = 20
        control_flush_error     = 21
        not_supported_by_gui    = 22
        error_no_gui            = 23
        OTHERS                  = 24.
    IF sy-subrc EQ 0.
      IF iv_execute IS NOT INITIAL.
        CALL METHOD cl_gui_frontend_services=>file_exist
          EXPORTING
            file                 = iv_filename
          RECEIVING
            result               = DATA(lv_exists)
          EXCEPTIONS
            cntl_error           = 1
            error_no_gui         = 2
            wrong_parameter      = 3
            not_supported_by_gui = 4
            OTHERS               = 5.
        IF sy-subrc EQ 0 AND lv_exists IS NOT INITIAL.
          CALL METHOD cl_gui_frontend_services=>execute
            EXPORTING
              document               = iv_filename
            EXCEPTIONS
              cntl_error             = 1
              error_no_gui           = 2
              bad_parameter          = 3
              file_not_found         = 4
              path_not_found         = 5
              file_extension_unknown = 6
              error_execute_failed   = 7
              synchronous_failed     = 8
              not_supported_by_gui   = 9
              OTHERS                 = 10.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_fieldcat.

    get_globals_from_slvc_fullscr( IMPORTING et_fieldcat = lmt_fcat ).

  ENDMETHOD.


  METHOD get_globals_from_slvc_fullscr.
    CALL FUNCTION 'GET_GLOBALS_FROM_SLVC_FULLSCR'
      IMPORTING
        et_excluding       = et_excluding
        e_callback_program = ev_callback_program
        e_callback_routine = ev_callback_routine
        e_grid             = eo_grid
        et_fieldcat_lvc    = et_fieldcat
        e_flg_no_html      = ev_flg_no_html
*       es_layout_kkblo    =
        es_sel_hide        = es_sel_hide
        et_event_exit      = et_event_exit.

    IF eo_grid IS BOUND.
      eo_grid->get_frontend_layout( IMPORTING es_layout = es_layout ).
    ENDIF.
  ENDMETHOD.


  METHOD get_layout.

    get_globals_from_slvc_fullscr( IMPORTING es_layout = rs_layo ).

  ENDMETHOD.


  METHOD handle_grid_changed_finished.
  ENDMETHOD.


  METHOD handle_grid_data_changed.
  ENDMETHOD.


  METHOD handle_grid_double_click.
  ENDMETHOD.


  METHOD handle_grid_hotspot_click.
  ENDMETHOD.


  METHOD handle_grid_toolbar.
    CHECK e_object IS BOUND.

    get_globals_from_slvc_fullscr( IMPORTING et_fieldcat = DATA(lt_fcat)
                                             es_layout   = DATA(ls_layout) ).
    DELETE lt_fcat WHERE checkbox IS NOT INITIAL.

    IF ls_layout-edit IS NOT INITIAL
    OR NOT line_exists( lt_fcat[ edit = abap_true ] ).
      _exclude_default_grid_toolbar( EXPORTING e_object      = e_object
                                               e_interactive = e_interactive ).
    ENDIF.
  ENDMETHOD.


  METHOD handle_grid_user_command.
  ENDMETHOD.


  METHOD modify_alv_settings.
  ENDMETHOD.


  METHOD modify_events.
*--------------------------------------------------------------------*
*                        Events Lists
*--------------------------------------------------------------------*
*   slis_ev_item_data_expand      type slis_formname value 'ITEM_DATA_EXPAND',
*   slis_ev_reprep_sel_modify     type slis_formname value 'REPREP_SEL_MODIFY',
*   slis_ev_caller_exit_at_start  type slis_formname value 'CALLER_EXIT',
*   slis_ev_user_command          type slis_formname value 'USER_COMMAND',
*   slis_ev_top_of_page           type slis_formname value 'TOP_OF_PAGE',
*   slis_ev_data_changed          type slis_formname value 'DATA_CHANGED',
*   slis_ev_top_of_coverpage      type slis_formname value 'TOP_OF_COVERPAGE',
*   slis_ev_end_of_coverpage      type slis_formname value 'END_OF_COVERPAGE',
*   slis_ev_foreign_top_of_page   type slis_formname value 'FOREIGN_TOP_OF_PAGE',
*   slis_ev_foreign_end_of_page   type slis_formname value 'FOREIGN_END_OF_PAGE',
*   slis_ev_pf_status_set         type slis_formname value 'PF_STATUS_SET',
*   slis_ev_list_modify           type slis_formname value 'LIST_MODIFY',
*   slis_ev_top_of_list           type slis_formname value 'TOP_OF_LIST',
*   slis_ev_end_of_page           type slis_formname value 'END_OF_PAGE',
*   slis_ev_end_of_list           type slis_formname value 'END_OF_LIST',
*   slis_ev_after_line_output     type slis_formname value 'AFTER_LINE_OUTPUT',
*   slis_ev_before_line_output    type slis_formname value 'BEFORE_LINE_OUTPUT',
*   slis_ev_subtotal_text         type slis_formname value 'SUBTOTAL_TEXT',
*   slis_ev_grouplevel_change     type slis_formname value 'GROUPLEVEL_CHANGE',
*   slis_ev_context_menu          type slis_formname value 'CONTEXT_MENU'.
*--------------------------------------------------------------------*

    IF iv_evt_data_changed IS NOT INITIAL.
      ct_event = VALUE #( BASE ct_event
                          ( name = slis_ev_data_changed
                            form = 'CHECK_DATA_CHANGED' )
                          ( name = slis_ev_caller_exit_at_start
                            form = 'CALLER_EXIT' )
                        ).
    ENDIF.

*      TRY.
*          IF line_exists( it_fcat[ edit     = abap_true
*                                   checkbox = abap_false ] ).
*            IF NOT line_exists( ct_event[ name = slis_ev_data_changed ] ).
*              ct_event = VALUE #( BASE ct_event
*                                  ( name = slis_ev_data_changed
*                                    form = 'CHECK_DATA_CHANGED' )
*                                ).
*            ENDIF.
*            IF NOT line_exists( ct_event[ name = slis_ev_caller_exit_at_start ] ).
*              ct_event = VALUE #( BASE ct_event
*                                  ( name = slis_ev_caller_exit_at_start
*                                    form = 'CALLER_EXIT' )
*                                ).
*            ENDIF.
*          ENDIF.
*        CATCH cx_sy_itab_line_not_found.
*      ENDTRY.
  ENDMETHOD.


  METHOD modify_fcat.
*--------------------------------------------------------------------*
* ROW_POS       ALV control: Output line (INTERNAL USE)
* COL_POS       ALV control: Output column
* FIELDNAME     ALV control: Field name of internal table field
* TABNAME       LVC tab name
* CURRENCY      ALV control: Currency unit
* CFIELDNAME    ALV control: Field name for currency unit referenced
* QUANTITY      ALV control: Unit of measure
* QFIELDNAME    ALV control: Field name for unit of measure referenced
* IFIELDNAME    ALV control: Field name of internal table field
* ROUND         ALV control: ROUND value
* EXPONENT      ALV control: Exponent for float representation
* KEY           ALV control: Key field
* KEY_SEL       ALV control: Key column that may be hidden
* ICON          ALV control: Output as icon
* SYMBOL        ALV control: Output as symbol
* CHECKBOX      ALV control: Output as checkbox
* JUST          ALV control: Alignment
* LZERO         ALV control: Output leading zeros
* NO_SIGN       ALV Control: Suppress Signs for Output
* NO_ZERO       ALV control: Suppress zeros for output
* NO_CONVEXT    ALV control: Ignore conversion exit for output
* EDIT_MASK     ALV control: EditMask for output
* EMPHASIZE     ALV control: Highlight column with color
* FIX_COLUMN    ALV Control: Fix Column
* DO_SUM        ALV control: Aggregate values of column
* NO_SUM        ALV control: No aggregation over values of column
* NO_OUT        ALV control: Column is not output
* TECH          ALV control: Technical field
* OUTPUTLEN     ALV control: Column width in characters
* CONVEXIT      Conversion Routine
* SELTEXT       ALV control: Column identifier for dialog functions
* TOOLTIP       ALV control: Tooltip for column header
* ROLLNAME      ALV control: Data element for F1 help
* DATATYPE      Data Type in ABAP Dictionary
* INTTYPE       ABAP data type (C,D,N,...)
* INTLEN        Internal Length in Bytes
* LOWERCASE     Lowercase letters allowed/not allowed
* REPTEXT       Heading
* HIER_LEVEL    ALV control: Internal use
* REPREP        ALV control: Value is selection criterion for rep./rep.intf.
* DOMNAME       Domain name
* SP_GROUP      Group key
* HOTSPOT       ALV control: SingleClick-sensitive
* DFIELDNAME    ALV control: Field name for column group in database
* COL_ID        ALV control: Column ID
* F4AVAILABL    Does the field have an input help
* AUTO_VALUE    ALV control: Automatic value copy
* CHECKTABLE    Table Name
* VALEXI        Existence of fixed values
* WEB_FIELD     ALV control: Field name of internal table field
* STYLE         ALV control: Style
* STYLE2        ALV control: Style
* STYLE3        ALV control: Style
* STYLE4        ALV control: Style
* DRDN_HNDL     Natural number
* DRDN_FIELD    ALV control: Field name of internal table field
* NO_MERGING    Character Field Length 1
* H_FTYPE       ALV tree control: Functional type (sum, avg, max, min, ...)
* COL_OPT       Entry for Optional Column Optimization
* NO_INIT_CH    Character Field Length 1
* DRDN_ALIAS    Character Field Length 1
* DECFLOAT_STYLEDD: Output Style (Output Style) for Decfloat Types
* REF_FIELD     ALV control: Reference field name for internal table field
* REF_TABLE     ALV Control: Reference Table Name for Internal Table Field
* TXT_FIELD     ALV control: Field name of internal table field
* ROUNDFIELD    ALV control: Field name with ROUND specification
* DECIMALS_O    ALV control: Number of decimal places for output
* DECMLFIELD    ALV control: Field name with DECIMALS specification
* DD_OUTLEN     ALV control: Output length in characters
* DECIMALS      Number of Decimal Places
* COLTEXT       ALV control: Column heading
* SCRTEXT_L     Long Field Label
* SCRTEXT_M     Medium Field Label
* SCRTEXT_S     Short Field Label
* COLDDICTXT    ALV control: Determine DDIC text reference
* SELDDICTXT    ALV control: Determine DDIC text reference
* TIPDDICTXT    ALV control: Determine DDIC text reference
* EDIT          ALV control: Ready for input
* TECH_COL      ALV control: Internal use
* TECH_FORM     ALV control: Internal use
* TECH_COMP     ALV control: Internal use
* HIER_CPOS     ALV control: Hierarchical column position
* H_COL_KEY     Tree Control: Column Name / Item Name
* H_SELECT      Indicates if a column in the tree control can be selected
* DD_ROLL       Data element (semantic domain)
* DRAGDROPID    ALV control: Drag&Drop handle for DragDrop object
* MAC           Character Field Length 1
* GET_STYLE     Character Field Length 1
* MARK          Character Field Length 1
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD modify_layout.
*--------------------------------------------------------------------*
* ZEBRA           ALV control: Alternating line color (striped)
* EDIT            ALV control: Ready for input
* EDIT_MODE       ALV control: Edit mode
* NO_KEYFIX       ALV control: Do not fix key columns
* FRONTEND        ALV control: Excel, Crystal or ALV
* OBJECT_KEY      Business Document Service: Object key
* DOC_ID          Business Document Service: Document ID
* TEMPLATE        Business Document Service: File names
* LANGUAGE        Language ID
* GRAPHICS        GUID in 'CHAR' Format in Uppercase
* SMALLTITLE      ALV control: Title size
* NO_HGRIDLN      ALV control: Hide horizontal grid lines
* NO_VGRIDLN      ALV control: Hide vertical grid lines
* NO_HEADERS      ALV control: Hide column headings
* NO_MERGING      ALV control: Disable cell merging
* CWIDTH_OPT      ALV control: Optimize column width
* TOTALS_BEF      ALV control: Totals output before individual records
* NO_TOTARR       Character Field Length 1
* NO_TOTEXP       Character Field Length 1
* NO_ROWMOVE      Character Field Length 1
* NO_ROWINS       Character Field Length 1
* NO_COLEXPD      Character Field Length 1
* NO_F4           Character Field Length 1
* COUNTFNAME      ALV control: Field name of internal table field
* COL_OPT         Character Field Length 1
* VAL_DATA        Character Field Length 1
* BLOB_SCOPE      Identifier if BLOB is from SAP or Customer
* BLOB_FLAVOUR    Key Field for BLOB Store in SALV_BS_BLOB_...
* BLOB_NAME       Name for BLOB Store in SALV_BS_BLOB_...
* BLOB_KEY        Key Field for BLOB Storage
* BLOB_TYPE       ID from ALV Layout for BLOB Display Mode
* STYLEFNAME      ALV control: Field name of internal table field
* NO_ROWMARK      ALV control: Disable row selections
* NO_TOOLBAR      ALV control: Hide toolbar
* GRID_TITLE      ALV Control: Title bar text
* SEL_MODE        ALV control: SelectionMode
* BOX_FNAME       ALV control: Field name of internal table field
* SGL_CLK_HD      ALV control: SingleClick on column header
* NO_TOTLINE      ALV control: Do not output totals line
* NUMC_TOTAL      ALV control: Disallow NUMC field summation
* NO_UTSPLIT      ALV control: Split totals lines by unit
* EXCP_FNAME      ALV control: Field name with exception coding
* EXCP_ROLLN      ALV control: Data element for exception documentation
* EXCP_CONDS      ALV control: Aggregate exceptions
* EXCP_LED        ALV control: Exception as LED
* EXCP_GROUP      ALV Control: Exception Group
* DETAILINIT      ALV control: Display initial values on detail screen
* DETAILTITL      ALV control: Title bar of detail screen
* KEYHOT          ALV control: Key columns as hotspot
* NO_AUTHOR       ALV control: Do not perform ALV standard authority check
* XIFUNCKEY       SAP Query (S): Name of additional function
* XIDIRECT        General Flag
* S_DRAGDROP      ALV control: Drag&Drop control settings
* INFO_FNAME      ALV control: Field name with simple row color coding
* CTAB_FNAME      ALV control: Field name with complex cell color coding
* WEBLOOK         ALV control: Web look
* WEBSTYLE        ALV control: Style
* WEBROWS         ALV control: Number of lines to be displayed in the Web
* WEBXWIDTH       Natural Number
* WEBXHEIGHT      Natural Numbe
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD modify_sort.
*--------------------------------------------------------------------*
* SPOS        Sort sequence
* FIELDNAME	  ALV control: Field name of internal table field
* UP          Single-Character Indicator
* DOWN        Single-Character Indicator
* GROUP	      Control Break: Insert Page Break, Underlines
* SUBTOT      Output subtotal
* COMP        Single-Character Indicator
* EXPA        Single-Character Indicator
* SELTEXT	    Sort criterion
* OBLIGATORY  Single-Character Indicator
* LEVEL	      Natural Number
* NO_OUT      Single-Character Indicator
* INTOPT      ALV control: Internal optimization (INTERNAL USE)
*--------------------------------------------------------------------*
  ENDMETHOD.


  METHOD prepare_display.
    DATA: lv_set_pf_status             TYPE flag,
          lv_user_command              TYPE flag,
          lv_callback_top_of_page      TYPE flag,
          lv_callback_html_top_of_page TYPE flag,
          lv_callback_html_end_of_list TYPE flag.
    DATA: lv_found_routine TYPE flag.

    lmv_repid  = iv_repid.
    lmt_outtab =  COND #( WHEN ct_data   IS NOT INITIAL THEN REF #( ct_data )
                          WHEN lmo_model IS BOUND       THEN lmo_model->get_outtab( iv_stack_name = lmv_current_stack ) ).

    "ALV Fieldcatlog
    IF it_fieldcat[] IS NOT INITIAL.
      lmt_fcat = it_fieldcat.
    ELSE.
      _prepare_default_alv( IMPORTING et_fcat  = et_fieldcat
                            CHANGING  ct_data  = ct_data ).
    ENDIF.

    "ALV Layout
    IF is_layout IS NOT INITIAL.
      es_layout = is_layout.
    ELSE.
      _prepare_default_alv( IMPORTING es_layo  = es_layout ).
    ENDIF.

    "ALV Event
    IF it_event[] IS NOT INITIAL.
      et_event = it_event.
    ELSE.
*      _prepare_default_alv( IMPORTING et_event = et_event ).
    ENDIF.

    lv_set_pf_status              = iv_set_pf_status.
    lv_user_command               = iv_user_command.
    lv_callback_top_of_page       = iv_callback_top_of_page.
    lv_callback_html_top_of_page  = iv_callback_html_top_of_page.
    lv_callback_html_end_of_list  = iv_callback_html_end_of_list.


    "ALV Callback form-routines
    ev_set_pf_status             = COND #( WHEN lv_set_pf_status IS NOT INITIAL THEN 'SET_PF_STATUS' ).
    ev_user_command              = COND #( WHEN lv_user_command IS NOT INITIAL THEN 'USER_COMMAND' ).
    ev_callback_top_of_page      = COND #( WHEN lv_callback_top_of_page IS NOT INITIAL THEN 'TOP_OF_PAGE' ).
    ev_callback_html_top_of_page = COND #( WHEN lv_callback_html_top_of_page IS NOT INITIAL THEN 'TOP_OF_PAGE_HTML' ).
    ev_callback_html_end_of_list = COND #( WHEN lv_callback_html_end_of_list IS NOT INITIAL THEN 'END_OF_PAGE_HTML' ).

    "ALV Setting
    es_grid_title          = is_grid_title.
    es_grid_settings       = is_grid_settings.
    et_sort                = it_sort.
    et_filter              = it_filter.
    ev_default             = iv_default.
    ev_save                = iv_save.
    es_variant             = is_variant.
    et_event_exit          = it_event_exit.
    ev_screen_start_column = iv_screen_start_column.
    ev_screen_start_line   = iv_screen_start_line.
    ev_screen_end_column   = iv_screen_end_column.
    ev_screen_end_line     = iv_screen_end_line.
    ev_html_height_top     = iv_html_height_top.
    ev_html_height_end     = iv_html_height_end.

    IF es_variant IS NOT INITIAL.
      _check_variant_existence( EXPORTING iv_save    = iv_save
                                CHANGING  cs_variant = es_variant ).
    ENDIF.

    "--------------------------------------------------------------------*
    "                 Can redefine for changing any value
    "--------------------------------------------------------------------*
    modify_fcat( EXPORTING iv_stack_name = lmv_current_stack
                 CHANGING  ct_fcat       = et_fieldcat ).
    _populate_fcat( EXPORTING it_fcat = et_fieldcat ).

    modify_layout( EXPORTING iv_stack_name = lmv_current_stack
                   CHANGING  cs_layo       = es_layout ).
    _populate_layout( EXPORTING it_fcat = et_fieldcat
                      CHANGING  cs_layo = es_layout ).

    modify_events( EXPORTING it_fcat       = et_fieldcat
                             iv_stack_name = lmv_current_stack
                   CHANGING  ct_event      = et_event ).
    _populate_events( EXPORTING it_event      = et_event
                                iv_stack_name = lmv_current_stack
                      CHANGING  ct_event      = et_event ).

    modify_sort( EXPORTING iv_stack_name = lmv_current_stack
                 CHANGING ct_sort        = et_sort ).

    modify_callback_routines( EXPORTING iv_stack_name                = lmv_current_stack
                              CHANGING  cv_set_pf_status             = lv_set_pf_status
                                        cv_user_command              = lv_user_command
                                        cv_callback_top_of_page      = lv_callback_top_of_page
                                        cv_callback_html_top_of_page = lv_callback_html_top_of_page
                                        cv_callback_html_end_of_list = lv_callback_html_end_of_list ).
    _populate_callback_routine( EXPORTING iv_set_pf_status             = lv_set_pf_status
                                          iv_user_command              = lv_user_command
                                          iv_callback_top_of_page      = lv_callback_top_of_page
                                          iv_callback_html_top_of_page = lv_callback_html_top_of_page
                                          iv_callback_html_end_of_list = lv_callback_html_end_of_list
                                CHANGING  cv_set_pf_status             = ev_set_pf_status
                                          cv_user_command              = ev_user_command
                                          cv_callback_top_of_page      = ev_callback_top_of_page
                                          cv_callback_html_top_of_page = ev_callback_html_top_of_page
                                          cv_callback_html_end_of_list = ev_callback_html_end_of_list ).

    modify_alv_settings( EXPORTING iv_stack_name     = lmv_current_stack
                         CHANGING  cs_grid_title     = es_grid_title
                                   cs_grid_settings  = es_grid_settings
                                   ct_excluding      = et_excluding
                                   ct_special_groups = et_special_groups
                                   ct_sort           = et_sort
                                   ct_filter         = et_filter
                                   cv_default        = ev_default
                                   cv_save           = ev_save
                                   cs_variant        = es_variant ).

    modify_popup_screen( EXPORTING iv_stack_name          = lmv_current_stack
                         CHANGING  cv_screen_start_column = ev_screen_start_column
                                   cv_screen_start_line   = ev_screen_start_line
                                   cv_screen_end_column   = ev_screen_end_column
                                   cv_screen_end_line     = ev_screen_end_line ).

    modify_html_height( EXPORTING iv_stack_name      = lmv_current_stack
                        CHANGING  cv_html_height_top = ev_html_height_top
                                  cv_html_height_end = ev_html_height_end ).

    "Check PF_STATUS Routine
    IF ev_set_pf_status IS NOT INITIAL.
      _check_routine( EXPORTING iv_formname = ev_set_pf_status
                      IMPORTING ev_found    = lv_found_routine ).
      IF lv_found_routine IS INITIAL.
        CLEAR ev_set_pf_status.
      ENDIF.
    ENDIF.

    "Check USER_COMMAND Routine
    IF ev_user_command IS NOT INITIAL.
      _check_routine( EXPORTING iv_formname = ev_user_command
                      IMPORTING ev_found    = lv_found_routine ).
      IF lv_found_routine IS INITIAL.
        CLEAR ev_user_command.
      ENDIF.
    ENDIF.

    "Check TOP_OF_PAGE Routine
    IF ev_callback_top_of_page IS NOT INITIAL.
      _check_routine( EXPORTING iv_formname = ev_callback_top_of_page
                      IMPORTING ev_found    = lv_found_routine ).
      IF lv_found_routine IS INITIAL.
        CLEAR ev_callback_top_of_page.
      ENDIF.
    ELSEIF ev_callback_html_top_of_page IS NOT INITIAL.
      "Check HTML_TOP_OF_PAGE Routine
      _check_routine( EXPORTING iv_formname = ev_callback_html_top_of_page
                      IMPORTING ev_found    = lv_found_routine ).
      IF lv_found_routine IS INITIAL.
        CLEAR ev_callback_html_top_of_page.
      ENDIF.
    ENDIF.

    "Check HTML_END_OF_LIST Routine
    IF ev_callback_html_end_of_list IS NOT INITIAL.
      _check_routine( EXPORTING iv_formname = ev_callback_html_end_of_list
                      IMPORTING ev_found    = lv_found_routine ).
      IF lv_found_routine IS INITIAL.
        CLEAR ev_callback_html_end_of_list.
      ENDIF.
    ENDIF.

    _check_prepare_before_display(
      CHANGING
        cv_set_pf_status             = ev_set_pf_status
        cv_user_command              = ev_user_command
        cv_callback_top_of_page      = ev_callback_top_of_page
        cv_callback_html_top_of_page = ev_callback_html_top_of_page
        cv_callback_html_end_of_list = ev_callback_html_end_of_list
        cs_grid_title                = es_grid_title
        cs_grid_settings             = es_grid_settings
        cs_layout                    = es_layout
        ct_fieldcat                  = et_fieldcat
        ct_excluding                 = et_excluding
        ct_special_groups            = et_special_groups
        ct_sort                      = et_sort
        ct_filter                    = et_filter
        cv_default                   = ev_default
        cv_save                      = ev_save
        cs_variant                   = es_variant
        ct_event                     = et_event ).
  ENDMETHOD.


  METHOD refresh_alv_selfield.
    cs_selfield-row_stable =
    cs_selfield-col_stable = abap_true.
    cs_selfield-refresh    = COND #( WHEN iv_soft_refresh IS NOT INITIAL THEN 'S' ELSE abap_true ).
  ENDMETHOD.


  METHOD refresh_table_display.
    DATA: ls_stable	TYPE lvc_s_stbl.

    DATA(lo_grid) = get_lvc_gui_alv_grid( ).

    CHECK lo_grid IS BOUND.

    ls_stable = COND #( WHEN is_stable IS NOT SUPPLIED THEN 'XX' ELSE is_stable ).

    lo_grid->refresh_table_display( EXPORTING is_stable      = ls_stable
                                              i_soft_refresh = iv_soft_refresh ).
  ENDMETHOD.


  METHOD register_event.
    ro_view ?= me.

    "Set Modify/Enter event for editable
    _register_edit_event( EXPORTING iv_evt_modified = iv_evt_modified
                                    iv_evt_enter    = iv_evt_enter
                          CHANGING  co_grid         = eo_grid ).

    "Change Toolbar from fullscreen grid to OOPs Toolbar
    set_grid_handler_before_disp( EXPORTING io_view           = ro_view
                                            iv_set_oo_toolbar = iv_set_oo_toolbar ).
  ENDMETHOD.


  METHOD set_checkbox_value.
    DATA lo_out TYPE REF TO data.
    DATA ls_stable TYPE lvc_s_stbl.
    DATA l_len TYPE i.
    FIELD-SYMBOLS: <lft_out> TYPE STANDARD TABLE,
                   <lfs_out> TYPE any,
                   <lf_val>  TYPE any.

    IF io_model IS SUPPLIED
   AND io_model IS BOUND.
      lo_out = io_model->get_outtab( iv_stack_name = lmv_current_stack
                                     iv_from_event = abap_true
                                     iv_formname   = mc_callback_fname-user_command ).
    ELSEIF lmo_model IS BOUND.
      lo_out = lmo_model->get_outtab( iv_stack_name = lmv_current_stack
                                      iv_from_event = abap_true
                                      iv_formname   = mc_callback_fname-user_command ).
    ENDIF.

    IF lo_out IS BOUND.
      ASSIGN lo_out->* TO <lft_out>.
      CHECK <lft_out> IS ASSIGNED.

      READ TABLE <lft_out> ASSIGNING <lfs_out> INDEX iv_tabindex.
      IF sy-subrc EQ 0.
        ASSIGN COMPONENT iv_fieldname OF STRUCTURE <lfs_out> TO <lf_val>.
        IF sy-subrc EQ 0.
          DESCRIBE FIELD <lf_val> LENGTH l_len IN CHARACTER MODE.
          CHECK l_len EQ 1.

          IF iv_value IS SUPPLIED.
            <lf_val> = iv_value.
          ELSE.
            <lf_val> = COND #( WHEN <lf_val> IS INITIAL THEN abap_on ELSE abap_off ).
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

    IF cs_selfield IS SUPPLIED.
      cs_selfield-col_stable = cs_selfield-row_stable = abap_true.
      cs_selfield-refresh    = 'S'.   " 'S' = Soft refresh, 'X' = Full refresh
    ELSE.
      DATA(lo_grid) = get_lvc_gui_alv_grid( ).

      IF lo_grid IS BOUND.
        ls_stable-col = ls_stable-row = abap_true.

        lo_grid->refresh_table_display( EXPORTING is_stable      = ls_stable
                                                  i_soft_refresh = abap_true ).
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD set_controller_to_view.
    ro_view = me.

    TRY.
        IF io_controller IS BOUND.
          lmo_controller ?= io_controller.
        ENDIF.
      CATCH cx_sy_move_cast_error.
    ENDTRY.
  ENDMETHOD.


  METHOD set_default_grid_handler.
    DATA: lo_events TYPE REF TO zcl_mvcfw_base_lvc_view.

    DATA(lo_grid) = get_lvc_gui_alv_grid( ).

    CHECK lo_grid IS BOUND.

    IF io_view IS SUPPLIED
   AND io_view IS BOUND.
      lo_events ?= io_view.
    ELSE.
      lo_events = NEW #( ).
    ENDIF.

    IF lo_events IS BOUND
   AND lo_grid   IS BOUND.
      SET HANDLER lo_events->handle_grid_user_command
                  lo_events->handle_grid_toolbar
                  lo_events->handle_grid_double_click
                  lo_events->handle_grid_hotspot_click
                  lo_events->handle_grid_data_changed
                  lo_events->handle_grid_changed_finished
              FOR lo_grid.
    ENDIF.
  ENDMETHOD.


  METHOD set_fcat_checkbox.
    IF cs_fcat IS SUPPLIED.
      cs_fcat-checkbox = abap_true.
      cs_fcat-edit     = abap_true.
    ELSEIF ct_fcat      IS SUPPLIED
       AND iv_fieldname IS SUPPLIED.
      READ TABLE ct_fcat ASSIGNING FIELD-SYMBOL(<lfs_fcat>) WITH KEY fieldname = |{ iv_fieldname CASE = UPPER }|.
      IF sy-subrc EQ 0.
        <lfs_fcat>-checkbox = abap_true.
        <lfs_fcat>-edit     = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_fcat_freeze_column.
    IF cs_fcat IS SUPPLIED.
      cs_fcat-fix_column = abap_true.
    ELSEIF ct_fcat      IS SUPPLIED
       AND iv_fieldname IS SUPPLIED.
      READ TABLE ct_fcat ASSIGNING FIELD-SYMBOL(<lfs_fcat>) WITH KEY fieldname = |{ iv_fieldname CASE = UPPER }|.
      IF sy-subrc EQ 0.
        <lfs_fcat>-fix_column = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_fcat_hidden.
    IF cs_fcat IS SUPPLIED.
      cs_fcat-no_out = abap_true.
    ELSEIF ct_fcat      IS SUPPLIED
       AND iv_fieldname IS SUPPLIED.
      READ TABLE ct_fcat ASSIGNING FIELD-SYMBOL(<lfs_fcat>) WITH KEY fieldname = |{ iv_fieldname CASE = UPPER }|.
      IF sy-subrc EQ 0.
        <lfs_fcat>-no_out = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_fcat_key.
    IF cs_fcat IS SUPPLIED.
      cs_fcat-key = abap_true.
    ELSEIF ct_fcat      IS SUPPLIED
       AND iv_fieldname IS SUPPLIED.
      READ TABLE ct_fcat ASSIGNING FIELD-SYMBOL(<lfs_fcat>) WITH KEY fieldname = |{ iv_fieldname CASE = UPPER }|.
      IF sy-subrc EQ 0.
        <lfs_fcat>-key = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_fcat_technical.
    IF cs_fcat IS SUPPLIED.
      cs_fcat-tech = abap_true.
    ELSEIF ct_fcat      IS SUPPLIED
       AND iv_fieldname IS SUPPLIED.
      READ TABLE ct_fcat ASSIGNING FIELD-SYMBOL(<lfs_fcat>) WITH KEY fieldname = |{ iv_fieldname CASE = UPPER }|.
      IF sy-subrc EQ 0.
        <lfs_fcat>-tech = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_fcat_text.
    IF cs_fcat IS SUPPLIED.
      cs_fcat-reptext   = COND #( WHEN iv_text    IS NOT INITIAL THEN iv_text
                                  WHEN iv_reptext IS NOT INITIAL THEN iv_reptext
                                  ELSE cs_fcat-reptext ).
      cs_fcat-scrtext_l = COND #( WHEN iv_text      IS NOT INITIAL THEN iv_text
                                  WHEN iv_scrtext_l IS NOT INITIAL THEN iv_scrtext_l
                                  ELSE cs_fcat-scrtext_l ).
      cs_fcat-scrtext_m = COND #( WHEN iv_text      IS NOT INITIAL THEN iv_text
                                  WHEN iv_scrtext_m IS NOT INITIAL THEN iv_scrtext_m
                                  ELSE cs_fcat-scrtext_m ).
      cs_fcat-scrtext_s = COND #( WHEN iv_text      IS NOT INITIAL THEN iv_text
                                  WHEN iv_scrtext_s IS NOT INITIAL THEN iv_scrtext_s
                                  ELSE cs_fcat-scrtext_s ).
    ELSEIF ct_fcat      IS SUPPLIED
       AND iv_fieldname IS SUPPLIED.
      READ TABLE ct_fcat ASSIGNING FIELD-SYMBOL(<lfs_fcat>) WITH KEY fieldname = |{ iv_fieldname CASE = UPPER }|.
      IF sy-subrc EQ 0.
        <lfs_fcat>-reptext   = COND #( WHEN iv_text    IS NOT INITIAL THEN iv_text
                                       WHEN iv_reptext IS NOT INITIAL THEN iv_reptext
                                       ELSE <lfs_fcat>-reptext ).
        <lfs_fcat>-scrtext_l = COND #( WHEN iv_text      IS NOT INITIAL THEN iv_text
                                       WHEN iv_scrtext_l IS NOT INITIAL THEN iv_scrtext_l
                                       ELSE <lfs_fcat>-scrtext_l ).
        <lfs_fcat>-scrtext_m = COND #( WHEN iv_text      IS NOT INITIAL THEN iv_text
                                       WHEN iv_scrtext_m IS NOT INITIAL THEN iv_scrtext_m
                                       ELSE <lfs_fcat>-scrtext_m ).
        <lfs_fcat>-scrtext_s = COND #( WHEN iv_text      IS NOT INITIAL THEN iv_text
                                       WHEN iv_scrtext_s IS NOT INITIAL THEN iv_scrtext_s
                                       ELSE <lfs_fcat>-scrtext_s ).
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_fieldcat.

    DATA(lo_grid) = get_lvc_gui_alv_grid( ).

    CHECK lo_grid IS BOUND.

    lmt_fcat = it_fieldcat_lvc.
    lo_grid->set_frontend_fieldcatalog( lmt_fcat ).

  ENDMETHOD.


  METHOD set_grid_handler_before_disp.

    ro_view ?= COND #( WHEN io_view IS BOUND THEN io_view ELSE me ).

    IF iv_set_oo_toolbar IS NOT INITIAL.
      _set_local_layout_fulscr_grid( ).
      _check_grid_oops_toolbar( ro_view ).
    ENDIF.

  ENDMETHOD.


  METHOD set_layout.

    DATA(lo_grid) = get_lvc_gui_alv_grid( ).

    CHECK lo_grid IS BOUND.

    lo_grid->set_frontend_layout( is_layo ).

  ENDMETHOD.


  METHOD set_model_to_view.
    ro_view = me.

    TRY.
        IF io_model IS BOUND.
          lmo_model ?= io_model.
        ENDIF.
      CATCH cx_sy_move_cast_error.
    ENDTRY.
  ENDMETHOD.


  METHOD set_pf_status.
    _get_globals_fullscreen_grid( IMPORTING eo_grid          = DATA(lo_grid)
                                            es_lvc_layout    = DATA(ls_lvc_layout) ).
    CASE ls_lvc_layout-no_toolbar.
      WHEN space.
        SET PF-STATUS 'APPEND' OF PROGRAM 'SAPLKKBL' EXCLUDING it_extab.
      WHEN OTHERS.
        DATA(lt_extab) = it_extab[].

        "Excluding
        lt_extab = VALUE #( BASE lt_extab
                            ( fcode = '&XPA' )    "Expand
                            ( fcode = '&OMP' )    "Collapse
                            ( fcode = '&AQW' )    "Word
                            ( fcode = '%SL'  )    "Email
                            ( fcode = '&ABC' )    "ABC
                          ).
        SET PF-STATUS 'STANDARD' OF PROGRAM 'SAPLKKBL' EXCLUDING lt_extab.
    ENDCASE.
  ENDMETHOD.


  METHOD set_stack_name.
    lmv_current_stack = iv_stack_name.
    ro_view           = me.
  ENDMETHOD.


  METHOD set_top_page_html.
  ENDMETHOD.


  METHOD transfer_lvc_to_slis.
    CALL FUNCTION 'LVC_TRANSFER_TO_SLIS'
      EXPORTING
        it_fieldcat_lvc         = it_fieldcat_lvc
        it_sort_lvc             = it_sort_lvc
        it_filter_lvc           = it_filter_lvc
        is_layout_lvc           = is_layout_lvc
      IMPORTING
        et_fieldcat_alv         = et_fieldcat_alv
        et_sort_alv             = et_sort_alv
        et_filter_alv           = et_filter_alv
        es_layout_alv           = es_layout_alv
      TABLES
        it_data                 = ct_data
      EXCEPTIONS
        it_data_missing         = 1
        it_fieldcat_lvc_missing = 2
        OTHERS                  = 3.
  ENDMETHOD.


  METHOD user_command.
  ENDMETHOD.


  METHOD _call_alv_grid_display_lvc.
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program          = i_callback_program
        i_callback_pf_status_set    = i_callback_pf_status_set
        i_callback_user_command     = i_callback_user_command
        i_callback_top_of_page      = i_callback_top_of_page
        i_callback_html_top_of_page = i_callback_html_top_of_page
        i_callback_html_end_of_list = i_callback_html_end_of_list
        i_grid_title                = i_grid_title
        i_grid_settings             = i_grid_settings
        is_layout_lvc               = is_layout
        it_fieldcat_lvc             = it_fieldcat
        it_excluding                = it_excluding
        it_special_groups_lvc       = it_special_groups
        it_sort_lvc                 = it_sort
        it_filter_lvc               = it_filter
        i_default                   = i_default
        i_save                      = i_save
        is_variant                  = is_variant
        it_events                   = it_events
        it_event_exit               = it_event_exit
        i_screen_start_column       = iv_screen_start_column
        i_screen_start_line         = iv_screen_start_line
        i_screen_end_column         = iv_screen_end_column
        i_screen_end_line           = iv_screen_end_line
        i_html_height_top           = iv_html_height_top
        i_html_height_end           = iv_html_height_end
      TABLES
        t_outtab                    = t_outtab
      EXCEPTIONS
        program_error               = 1
        OTHERS                      = 2.
    IF sy-subrc NE 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
         WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
      RAISING program_error.
    ENDIF.
  ENDMETHOD.


  METHOD _check_grid_oops_toolbar.
    DATA: lo_event_receiver TYPE REF TO zcl_mvcfw_base_lvc_view.

    ro_view ?= COND #( WHEN io_view IS BOUND THEN io_view ELSE me ).

    _get_globals_fullscreen_grid( IMPORTING eo_grid       = DATA(lo_grid)
                                            es_lvc_layout = DATA(ls_lvc_layout) ).
    IF ls_lvc_layout-no_toolbar IS INITIAL.
      lo_event_receiver ?= ro_view.

      IF lo_event_receiver IS BOUND AND lo_grid IS BOUND.
        SET HANDLER lo_event_receiver->handle_grid_toolbar
                    lo_event_receiver->handle_grid_user_command
                FOR lo_grid.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _check_prepare_before_display.
    DATA: ls_variant TYPE disvariant.

    "--------------------------------------------------------------------*
    "   Adjust layout parameter
    "--------------------------------------------------------------------*
    IF cs_layout-info_fname IS NOT INITIAL.
      CLEAR cs_layout-ctab_fname.
    ELSEIF cs_layout-ctab_fname IS NOT INITIAL.
      CLEAR cs_layout-info_fname.
    ENDIF.

    IF cs_layout-info_fname IS NOT INITIAL.
      IF NOT line_exists( ct_fieldcat[ fieldname = |{ cs_layout-info_fname CASE = UPPER }| ] ).
        CLEAR cs_layout-info_fname.
      ELSE.
        ct_fieldcat[ fieldname = |{ cs_layout-info_fname CASE = UPPER }| ]-tech = abap_true.
      ENDIF.
    ENDIF.

    IF cs_layout-ctab_fname IS NOT INITIAL.
      IF NOT line_exists( ct_fieldcat[ fieldname = |{ cs_layout-ctab_fname CASE = UPPER }| ] ).
        CLEAR cs_layout-ctab_fname.
      ELSE.
        ct_fieldcat[ fieldname = |{ cs_layout-ctab_fname CASE = UPPER }| ]-tech = abap_true.
      ENDIF.
    ENDIF.

    IF cs_layout-excp_fname IS NOT INITIAL.
      IF NOT line_exists( ct_fieldcat[ fieldname = |{ cs_layout-excp_fname CASE = UPPER }| ] ).
        CLEAR cs_layout-excp_fname.
      ELSE.
        ct_fieldcat[ fieldname = |{ cs_layout-excp_fname CASE = UPPER }| ]-tech = abap_true.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _check_routine.
    DATA: lv_formname TYPE slis_formname.

    DATA(lo_controller) = zcl_mvcfw_base_lvc_controller=>get_static_control_instance( ).
    CHECK lo_controller IS BOUND.

    TRY.
        lv_formname = |{ iv_formname CASE = UPPER }|.
        lo_controller->check_routine( EXPORTING iv_set_value = abap_true ).
        PERFORM (lv_formname) IN PROGRAM (lmv_repid).
      CATCH cx_sy_dyn_call_illegal_form.
        ev_found = abap_false.
        lo_controller->check_routine( EXPORTING iv_set_value = abap_false ).
        RETURN.
      CATCH cx_sy_dyn_call_param_missing.
        ev_found = abap_true.
        lo_controller->check_routine( EXPORTING iv_set_value = abap_false ).
        RETURN.
      CATCH cx_sy_dyn_call_param_not_found.
        ev_found = abap_true.
        lo_controller->check_routine( EXPORTING iv_set_value = abap_false ).
        RETURN.
      CATCH cx_sy_program_not_found.
        ev_found = abap_false.
        lo_controller->check_routine( EXPORTING iv_set_value = abap_false ).
        RETURN.
      CATCH cx_sy_no_handler.
        ev_found = abap_false.
        lo_controller->check_routine( EXPORTING iv_set_value = abap_false ).
        RETURN.
    ENDTRY.

    lo_controller->check_routine( EXPORTING iv_get_value = abap_true
                                  IMPORTING ev_value     = ev_found ).
    lo_controller->check_routine( EXPORTING iv_set_value = abap_false ).
  ENDMETHOD.


  METHOD _check_variant_existence.
    IF cs_variant-report IS INITIAL.
      cs_variant-report = sy-cprog.
    ENDIF.

    CALL FUNCTION 'LVC_VARIANT_EXISTENCE_CHECK'
      EXPORTING
        i_save        = iv_save
      CHANGING
        cs_variant    = cs_variant
      EXCEPTIONS
        wrong_input   = 1
        not_found     = 2
        program_error = 3
        OTHERS        = 4.
    IF sy-subrc <> 0.
      CLEAR cs_variant.
    ENDIF.
  ENDMETHOD.


  METHOD _create_any_object.
    DATA: lv_object TYPE string.

    IF iv_class_name    IS INITIAL
   AND lmv_cl_view_name IS INITIAL.
      iv_class_name = mc_deflt_view.
    ELSEIF lmv_cl_view_name IS NOT INITIAL.
      iv_class_name = lmv_cl_view_name.
    ENDIF.

    lv_object = |\\PROGRAM={ sy-cprog }\\CLASS={ iv_class_name CASE = UPPER }|.

    TRY.
        CREATE OBJECT ro_class TYPE (lv_object).
      CATCH cx_sy_create_object_error INTO DATA(lo_except).
        ro_class = me.
    ENDTRY.
  ENDMETHOD.


  METHOD _create_salv_tree_object.
    DATA: lo_tree TYPE REF TO data.
    FIELD-SYMBOLS: <lft_data> TYPE STANDARD TABLE.

    IF iv_create_tree_directly IS NOT INITIAL.
      TRY.
          CREATE DATA lo_tree LIKE ct_data.
          CHECK lo_tree IS BOUND.

          ASSIGN lo_tree->* TO <lft_data>.
          CHECK <lft_data> IS ASSIGNED.
        CATCH cx_sy_create_data_error.
          RETURN.
      ENDTRY.
    ELSE.
      TRY.
          IF ct_data IS NOT INITIAL
         AND ct_data IS SUPPLIED.
            CREATE DATA lo_tree LIKE ct_data.
            CHECK lo_tree IS BOUND.

            ASSIGN lo_tree->* TO <lft_data>.
            CHECK <lft_data> IS ASSIGNED.
          ELSEIF lmo_model IS BOUND.
            DATA(lo_out) = lmo_model->get_outtab( ).
            ASSIGN lo_out->* TO FIELD-SYMBOL(<lft_out>).
            CHECK <lft_out> IS ASSIGNED.

            CREATE DATA lo_tree LIKE <lft_out>.
            CHECK lo_tree IS BOUND.

            ASSIGN lo_tree->* TO <lft_data>.
            CHECK <lft_data> IS ASSIGNED.
          ELSE.
            RETURN.
          ENDIF.
        CATCH cx_sy_create_data_error.
          RETURN.
      ENDTRY.
    ENDIF.

    TRY.
        cl_salv_tree=>factory( IMPORTING r_salv_tree = ro_tree
                               CHANGING  t_table     = <lft_data> ).
      CATCH cx_salv_no_new_data_allowed
            cx_salv_error.
        RETURN.
    ENDTRY.
  ENDMETHOD.


  METHOD _exclude_default_grid_toolbar.
    CHECK e_object IS BOUND.

    DELETE e_object->mt_toolbar WHERE function EQ cl_gui_alv_grid=>mc_fc_loc_append_row
                                   OR function EQ cl_gui_alv_grid=>mc_fc_loc_copy
                                   OR function EQ cl_gui_alv_grid=>mc_fc_loc_copy_row
                                   OR function EQ cl_gui_alv_grid=>mc_fc_loc_cut
                                   OR function EQ cl_gui_alv_grid=>mc_fc_loc_delete_row
                                   OR function EQ cl_gui_alv_grid=>mc_fc_loc_insert_row
                                   OR function EQ cl_gui_alv_grid=>mc_fc_loc_move_row
                                   OR function EQ cl_gui_alv_grid=>mc_fc_loc_paste
                                   OR function EQ cl_gui_alv_grid=>mc_fc_loc_paste_new_row
                                   OR function EQ cl_gui_alv_grid=>mc_fc_loc_undo
                                   OR function EQ cl_gui_alv_grid=>mc_fc_data_save
                                   OR function EQ cl_gui_alv_grid=>mc_fc_graph
                                   OR function EQ cl_gui_alv_grid=>mc_fc_call_abc
                                   OR function EQ cl_gui_alv_grid=>mc_fc_refresh
                                   OR function EQ cl_gui_alv_grid=>mc_fc_check
                                   OR function EQ cl_gui_alv_grid=>mc_fc_info.
  ENDMETHOD.


  METHOD _generate_fcat_from_itab.
    CONSTANTS lc_mandt TYPE datatype_d VALUE 'CLNT'.
    DATA: table TYPE REF TO data.

    TRY.
        CREATE DATA table LIKE it_table.
        CHECK table IS BOUND.

        ASSIGN table->* TO FIELD-SYMBOL(<table>).

        cl_salv_table=>factory( IMPORTING r_salv_table = DATA(lo_table)
                                CHANGING  t_table      = <table>  ).

        rt_fcat = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
            r_columns      = lo_table->get_columns( )         " ALV Filter
            r_aggregations = lo_table->get_aggregations( ) ). " ALV Aggregations

        IF line_exists( rt_fcat[ datatype = lc_mandt ] ).
          rt_fcat[ datatype = lc_mandt ]-tech = abap_true.
        ENDIF.

        set_fcat_technical( EXPORTING iv_fieldname = mc_layout_fname-excp_fname
                            CHANGING  ct_fcat      = rt_fcat ).
        set_fcat_technical( EXPORTING iv_fieldname = mc_layout_fname-stylefname
                            CHANGING  ct_fcat      = rt_fcat ).
        set_fcat_technical( EXPORTING iv_fieldname = mc_layout_fname-info_fname
                            CHANGING  ct_fcat      = rt_fcat ).
        set_fcat_technical( EXPORTING iv_fieldname = mc_layout_fname-ctab_fname
                            CHANGING  ct_fcat      = rt_fcat ).
      CATCH cx_salv_msg.
    ENDTRY.
  ENDMETHOD.


  METHOD _get_globals_fullscreen_grid.
    IF eo_grid IS  SUPPLIED.
      ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-GRID') TO FIELD-SYMBOL(<o_grid>).
      IF sy-subrc EQ 0 AND <o_grid> IS ASSIGNED.
        eo_grid = <o_grid>.
      ENDIF.
    ENDIF.

    IF es_lvc_layout IS SUPPLIED.
      ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-S_LVC_LAYOUT') TO FIELD-SYMBOL(<s_lvc_layout>).
      IF sy-subrc EQ 0 AND <s_lvc_layout> IS ASSIGNED.
        es_lvc_layout = <s_lvc_layout>.
      ENDIF.
    ENDIF.

    IF et_lvc_fieldcat IS SUPPLIED.
      ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-T_LVC_FIELDCAT') TO FIELD-SYMBOL(<t_lvc_fieldcat>).
      IF sy-subrc EQ 0 AND <t_lvc_fieldcat> IS ASSIGNED.
        et_lvc_fieldcat = <t_lvc_fieldcat>.
      ENDIF.
    ENDIF.

    IF et_lvc_sort IS SUPPLIED.
      ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-T_LVC_SORT') TO FIELD-SYMBOL(<t_lvc_sort>).
      IF sy-subrc EQ 0 AND <t_lvc_sort> IS ASSIGNED.
        et_lvc_sort = <t_lvc_sort>.
      ENDIF.
    ENDIF.

    IF et_lvc_filter IS SUPPLIED.
      ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-T_LVC_FILTER') TO FIELD-SYMBOL(<t_lvc_filter>).
      IF sy-subrc EQ 0 AND <t_lvc_filter> IS ASSIGNED.
        et_lvc_filter = <t_lvc_filter>.
      ENDIF.
    ENDIF.

    ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-T_EXCLUDING_LVC') TO FIELD-SYMBOL(<t_excluding_lvc>).
    IF sy-subrc EQ 0 AND <t_excluding_lvc> IS ASSIGNED.
      et_excluding_lvc = <t_excluding_lvc>.
    ENDIF.
  ENDMETHOD.


  METHOD _populate_events.
    DATA: lt_event     TYPE slis_t_event,
          lt_event_add TYPE slis_t_event.

*--------------------------------------------------------------------*
*                        Events Lists
*--------------------------------------------------------------------*
*   slis_ev_item_data_expand      type slis_formname value 'ITEM_DATA_EXPAND',
*   slis_ev_reprep_sel_modify     type slis_formname value 'REPREP_SEL_MODIFY',
*   slis_ev_caller_exit_at_start  type slis_formname value 'CALLER_EXIT',
*   slis_ev_user_command          type slis_formname value 'USER_COMMAND',
*   slis_ev_top_of_page           type slis_formname value 'TOP_OF_PAGE',
*   slis_ev_data_changed          type slis_formname value 'DATA_CHANGED',
*   slis_ev_top_of_coverpage      type slis_formname value 'TOP_OF_COVERPAGE',
*   slis_ev_end_of_coverpage      type slis_formname value 'END_OF_COVERPAGE',
*   slis_ev_foreign_top_of_page   type slis_formname value 'FOREIGN_TOP_OF_PAGE',
*   slis_ev_foreign_end_of_page   type slis_formname value 'FOREIGN_END_OF_PAGE',
*   slis_ev_pf_status_set         type slis_formname value 'PF_STATUS_SET',
*   slis_ev_list_modify           type slis_formname value 'LIST_MODIFY',
*   slis_ev_top_of_list           type slis_formname value 'TOP_OF_LIST',
*   slis_ev_end_of_page           type slis_formname value 'END_OF_PAGE',
*   slis_ev_end_of_list           type slis_formname value 'END_OF_LIST',
*   slis_ev_after_line_output     type slis_formname value 'AFTER_LINE_OUTPUT',
*   slis_ev_before_line_output    type slis_formname value 'BEFORE_LINE_OUTPUT',
*   slis_ev_subtotal_text         type slis_formname value 'SUBTOTAL_TEXT',
*   slis_ev_grouplevel_change     type slis_formname value 'GROUPLEVEL_CHANGE',
*   slis_ev_context_menu          type slis_formname value 'CONTEXT_MENU'.
*--------------------------------------------------------------------*

    lt_event = ct_event.
    CLEAR ct_event.

    IF it_event[] IS NOT INITIAL.
      LOOP AT lt_event ASSIGNING FIELD-SYMBOL(<lfs_event>).
        READ TABLE it_event INTO DATA(ls_evt) WITH KEY name = <lfs_event>-name.
        IF sy-subrc EQ 0.
          <lfs_event>-form = ls_evt-form.
        ELSE.
          lt_event_add = VALUE #( BASE lt_event_add ( ls_evt ) ).
        ENDIF.
      ENDLOOP.
    ENDIF.

    "Check subroutine exist
    IF lt_event_add[] IS NOT INITIAL.
      lt_event = VALUE #( BASE lt_event ( LINES OF lt_event_add ) ).
    ENDIF.

    DELETE lt_event WHERE name IS INITIAL
                       OR form IS INITIAL.
    CHECK lt_event IS NOT INITIAL.

    LOOP AT lt_event INTO ls_evt.
      _check_routine( EXPORTING iv_formname = ls_evt-form
                      IMPORTING ev_found    = DATA(lv_form_exist) ).
      IF lv_form_exist IS NOT INITIAL.
        ct_event = VALUE #( BASE ct_event ( ls_evt ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD _prepare_default_alv.

    IF et_event IS SUPPLIED.
      et_event = _set_default_event( ).
    ENDIF.
    IF es_layo IS SUPPLIED.
      es_layo  = _set_default_layout( ).
    ENDIF.
    IF et_fcat IS SUPPLIED.
      et_fcat  = lmt_fcat = _generate_fcat_from_itab( ct_data ).
    ENDIF.

  ENDMETHOD.


  METHOD _register_edit_event.
    DATA: lt_fcat TYPE lvc_t_fcat.
    DATA: lv_evt_modified TYPE flag,
          lv_evt_enter    TYPE flag.

    get_globals_from_slvc_fullscr( IMPORTING eo_grid     = DATA(lo_grid)
                                             es_layout   = DATA(ls_layout)
                                             et_fieldcat = lt_fcat ).

    CHECK lo_grid IS BOUND.

    co_grid         = lo_grid.
    lt_fcat         = COND #( WHEN lt_fcat  IS NOT INITIAL THEN lt_fcat
                              WHEN lmt_fcat IS NOT INITIAL THEN lmt_fcat ).
    lv_evt_modified = iv_evt_modified.
    lv_evt_enter    = iv_evt_enter.

    DELETE lt_fcat WHERE: tech IS NOT INITIAL,
                          edit IS INITIAL.

    IF lv_evt_modified  IS NOT INITIAL
    OR ls_layout-edit   IS NOT INITIAL
    OR lines( lt_fcat ) GT 0.
      CALL METHOD lo_grid->register_edit_event
        EXPORTING
          i_event_id = cl_gui_alv_grid=>mc_evt_modified
        EXCEPTIONS
          OTHERS     = 99.
    ENDIF.

    IF lv_evt_enter     IS NOT INITIAL
    OR ls_layout-edit   IS NOT INITIAL
    OR lines( lt_fcat ) GT 0.
      CALL METHOD lo_grid->register_edit_event
        EXPORTING
          i_event_id = cl_gui_alv_grid=>mc_evt_enter
        EXCEPTIONS
          OTHERS     = 99.
    ENDIF.
  ENDMETHOD.


  METHOD _set_default_event.
*--------------------------------------------------------------------*
*                        Events Lists
*--------------------------------------------------------------------*
*   slis_ev_item_data_expand      type slis_formname value 'ITEM_DATA_EXPAND',
*   slis_ev_reprep_sel_modify     type slis_formname value 'REPREP_SEL_MODIFY',
*   slis_ev_caller_exit_at_start  type slis_formname value 'CALLER_EXIT',
*   slis_ev_user_command          type slis_formname value 'USER_COMMAND',
*   slis_ev_top_of_page           type slis_formname value 'TOP_OF_PAGE',
*   slis_ev_data_changed          type slis_formname value 'DATA_CHANGED',
*   slis_ev_top_of_coverpage      type slis_formname value 'TOP_OF_COVERPAGE',
*   slis_ev_end_of_coverpage      type slis_formname value 'END_OF_COVERPAGE',
*   slis_ev_foreign_top_of_page   type slis_formname value 'FOREIGN_TOP_OF_PAGE',
*   slis_ev_foreign_end_of_page   type slis_formname value 'FOREIGN_END_OF_PAGE',
*   slis_ev_pf_status_set         type slis_formname value 'PF_STATUS_SET',
*   slis_ev_list_modify           type slis_formname value 'LIST_MODIFY',
*   slis_ev_top_of_list           type slis_formname value 'TOP_OF_LIST',
*   slis_ev_end_of_page           type slis_formname value 'END_OF_PAGE',
*   slis_ev_end_of_list           type slis_formname value 'END_OF_LIST',
*   slis_ev_after_line_output     type slis_formname value 'AFTER_LINE_OUTPUT',
*   slis_ev_before_line_output    type slis_formname value 'BEFORE_LINE_OUTPUT',
*   slis_ev_subtotal_text         type slis_formname value 'SUBTOTAL_TEXT',
*   slis_ev_grouplevel_change     type slis_formname value 'GROUPLEVEL_CHANGE',
*   slis_ev_context_menu          type slis_formname value 'CONTEXT_MENU'.
*--------------------------------------------------------------------*

    TRY.
        rt_event = VALUE #( ( name = slis_ev_data_changed
                              form = 'CHECK_DATA_CHANGED' )
                            ( name = slis_ev_caller_exit_at_start
                              form = 'CALLER_EXIT' )
                          ).
      CATCH cx_sy_itab_line_not_found.
    ENDTRY.
  ENDMETHOD.


  METHOD _set_default_fcat.
    rt_fcat = _generate_fcat_from_itab( it_table ).
  ENDMETHOD.


  METHOD _set_default_layout.
    rs_layo-cwidth_opt = abap_true.
    rs_layo-zebra      = abap_true.

    " A         – Multiple columns, multiple rows with selection buttons.
    " B, Blank  – Simple selection, listbox, Single row/column
    " C         – Multiple rows without buttons
    " D         – Multiple rows with buttons and select all ICON
    rs_layo-sel_mode   = ''.

    rs_layo-no_rowmark = abap_true.
    rs_layo-no_rowins  = abap_true.
    rs_layo-no_rowmove = abap_true.

*    rs_layo-stylefname = 'ALV_CELL'.
*    rs_layo-ctab_fname = 'ALV_COLOR'.
*    rs_layo-excp_fname = 'ALV_TRAFF'.

  ENDMETHOD.


  METHOD _set_globals_fullscreen_grid.
    ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-S_LVC_LAYOUT') TO FIELD-SYMBOL(<s_lvc_layout>).
    IF sy-subrc EQ 0 AND <s_lvc_layout> IS ASSIGNED AND is_lvc_layout IS SUPPLIED.
      <s_lvc_layout> = is_lvc_layout.
    ENDIF.

    ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-T_LVC_FIELDCAT') TO FIELD-SYMBOL(<t_lvc_fieldcat>).
    IF sy-subrc EQ 0 AND <t_lvc_fieldcat> IS ASSIGNED AND it_lvc_fieldcat IS SUPPLIED.
      <t_lvc_fieldcat> = it_lvc_fieldcat.
    ENDIF.

    ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-T_LVC_SORT') TO FIELD-SYMBOL(<t_lvc_sort>).
    IF sy-subrc EQ 0 AND <t_lvc_sort> IS ASSIGNED AND it_lvc_sort IS SUPPLIED.
      <t_lvc_sort> = it_lvc_sort.
    ENDIF.

    ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-T_LVC_FILTER') TO FIELD-SYMBOL(<t_lvc_filter>).
    IF sy-subrc EQ 0 AND <t_lvc_filter> IS ASSIGNED AND it_lvc_filter IS SUPPLIED.
      <t_lvc_filter> = it_lvc_filter.
    ENDIF.

    ASSIGN ('(SAPLSLVC_FULLSCREEN)GT_GRID-T_EXCLUDING_LVC') TO FIELD-SYMBOL(<t_excluding_lvc>).
    IF sy-subrc EQ 0 AND <t_excluding_lvc> IS ASSIGNED AND it_excluding_lvc IS SUPPLIED.
      <t_excluding_lvc> = it_excluding_lvc.
    ENDIF.
  ENDMETHOD.


  METHOD _set_grid_oops_toolbar.

    cs_lvc_layout-no_toolbar = space.

  ENDMETHOD.


  METHOD _set_local_layout_fulscr_grid.
    "Get Fullscreen Layout
    _get_globals_fullscreen_grid( IMPORTING es_lvc_layout = DATA(ls_lvc_layout) ).

    "Change Layout Paramter ( Can be redefine )
    _set_grid_oops_toolbar( CHANGING cs_lvc_layout = ls_lvc_layout ).

    "Set Fullscreen Layout
    _set_globals_fullscreen_grid( EXPORTING is_lvc_layout = ls_lvc_layout ).
  ENDMETHOD.


  METHOD auto_generate_stack_name.
    DATA: lc_stack_sub_init TYPE dfies-tabname VALUE 'SUB01',
          lc_stack_sub      TYPE dfies-tabname VALUE 'SUB'.
    DATA: lv_next_stack TYPE n LENGTH 2,
          lv_htype      TYPE dd01v-datatype.

    DATA(lt_stack) = zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->get_all_stack( ).

    IF NOT line_exists( lt_stack[ KEY k2 COMPONENTS name = mc_stack_main ] ).
      rv_stack_name = mc_stack_main.
    ELSE.
      LOOP AT lt_stack INTO DATA(ls_stack) WHERE name CP |{ lc_stack_sub }*|.
        EXIT.
      ENDLOOP.
      IF sy-subrc EQ 0.
        DELETE lt_stack WHERE NOT name CP |{ lc_stack_sub }*|.
        SORT lt_stack BY name DESCENDING.

        TRY.
            lv_next_stack = substring_after( val = lt_stack[ 1 ]-name  sub = lc_stack_sub ).

            CALL FUNCTION 'NUMERIC_CHECK'
              EXPORTING
                string_in = lv_next_stack
              IMPORTING
                htype     = lv_htype.

            lv_next_stack = COND #( WHEN lv_htype EQ 'NUMC' THEN lv_next_stack + 1 ELSE '01' ).
            rv_stack_name = |{ lc_stack_sub }{ lv_next_stack }|.
          CATCH cx_sy_itab_line_not_found.
            rv_stack_name = lc_stack_sub_init.
        ENDTRY.
      ELSE.
        rv_stack_name = lc_stack_sub_init.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD get_stack_name.
    rv_stack_name = lmv_current_stack.
  ENDMETHOD.


  METHOD modify_callback_routines.
  ENDMETHOD.


  method MODIFY_HTML_HEIGHT.
  endmethod.


  METHOD modify_popup_screen.
  ENDMETHOD.


  METHOD set_end_of_page_html.
  ENDMETHOD.


  METHOD set_top_of_page.
*CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
*  EXPORTING
*    it_list_commentary       =
**   I_LOGO                   =
**   I_END_OF_LIST_GRID       =
**   I_ALV_FORM               =
*
  ENDMETHOD.


  METHOD set_top_of_page_html.
  ENDMETHOD.


  METHOD _populate_layout.
    DATA: lo_struct TYPE REF TO cl_abap_structdescr,
          lo_table  TYPE REF TO cl_abap_tabledescr.
    DATA: lt_comp TYPE abap_compdescr_tab.

    lo_table  ?= cl_abap_structdescr=>describe_by_data_ref( lmt_outtab ).
    lo_struct ?= lo_table->get_table_line_type( ).
    lt_comp    = lo_struct->components.

    IF cs_layo-stylefname IS NOT INITIAL
   AND NOT line_exists( lt_comp[ name = |{ cs_layo-stylefname CASE = UPPER }| ] ).
      CLEAR cs_layo-stylefname.
    ENDIF.

    IF cs_layo-ctab_fname IS NOT INITIAL
   AND NOT line_exists( lt_comp[ name = |{ cs_layo-ctab_fname CASE = UPPER }| ] ).
      CLEAR cs_layo-ctab_fname.
    ENDIF.

    IF cs_layo-excp_fname IS NOT INITIAL
   AND NOT line_exists( lt_comp[ name = |{ cs_layo-excp_fname CASE = UPPER }| ] ).
      CLEAR cs_layo-excp_fname.
    ENDIF.
  ENDMETHOD.


  METHOD _populate_fcat.
    lmt_fcat = it_fcat.
  ENDMETHOD.


  METHOD _populate_callback_routine.
    "ALV Callback form-routines
    cv_set_pf_status             = COND #( WHEN iv_set_pf_status IS NOT INITIAL THEN mc_callback_fname-set_pf_status ).
    cv_user_command              = COND #( WHEN iv_user_command IS NOT INITIAL THEN mc_callback_fname-user_command ).
    cv_callback_top_of_page      = COND #( WHEN iv_callback_top_of_page IS NOT INITIAL THEN mc_callback_fname-top_of_page ).
    cv_callback_html_top_of_page = COND #( WHEN iv_callback_html_top_of_page IS NOT INITIAL THEN mc_callback_fname-top_of_page_html ).
    cv_callback_html_end_of_list = COND #( WHEN iv_callback_html_end_of_list IS NOT INITIAL THEN mc_callback_fname-end_of_page_html ).
  ENDMETHOD.


  METHOD redraw_alv_grid.
    ro_view = me.

    get_globals_from_slvc_fullscr( IMPORTING eo_grid     = DATA(lo_grid)
                                             et_fieldcat = DATA(lt_fcat)
                                             es_layout   = DATA(ls_layout) ).

    CHECK lo_grid IS BOUND.

    ls_layout-cwidth_opt = abap_true.

    lo_grid->set_frontend_layout( EXPORTING is_layout = ls_layout ).
  ENDMETHOD.


  METHOD set_view_attributes.
    get_globals_from_slvc_fullscr( IMPORTING ev_callback_program = lmv_repid
                                             et_fieldcat         = lmt_fcat ).

    lmt_outtab     = io_model->get_outtab( iv_stack_name = lmv_current_stack ).
    lmo_model      = io_model.
    lmo_controller = COND #( WHEN io_controller IS SUPPLIED AND io_controller IS BOUND THEN io_controller
                             ELSE lmo_controller ).
  ENDMETHOD.


  METHOD get_lvc_gui_alv_grid.
    get_globals_from_slvc_fullscr( IMPORTING eo_grid = ro_grid ).
  ENDMETHOD.


  METHOD handle_gui_alv_grid.
  ENDMETHOD.


  METHOD get_current_stack_name.
    re_current_stack = lmv_current_stack.
  ENDMETHOD.


  METHOD get_model.
    ro_model ?= lmo_model.
  ENDMETHOD.


  METHOD get_view_outtab.
    rt_outtab = lmt_outtab.
  ENDMETHOD.


  METHOD MODIFY_GRID_IN_REGISTER_EVENT.
*    "--------------------------------------------------------------------"
*    " Get global fullscreen ALV Grid from REUSE_ALV_GRID_DISPLAY_LVC
*    "--------------------------------------------------------------------"
*    _get_globals_fullscreen_grid( IMPORTING es_lvc_layout   = DATA(ls_layout)
*                                            et_lvc_fieldcat = DATA(lt_fcat)
*                                            et_lvc_sort     = DATA(lt_sort)
*                                            et_lvc_filter   = DATA(lt_filter) ).
*
*    "--------------------------------------------------------------------"
*    " Change any parameters
*    "--------------------------------------------------------------------"
*
*
*    "--------------------------------------------------------------------"
*    " Set new global fullscreen ALV Grid to REUSE_ALV_GRID_DISPLAY_LVC
*    "--------------------------------------------------------------------"
*    _set_globals_fullscreen_grid( EXPORTING is_lvc_layout   = ls_layout
*                                            it_lvc_fieldcat = lt_fcat
*                                            it_lvc_sort     = lt_sort
*                                            it_lvc_filter   = lt_filter ).
  ENDMETHOD.
ENDCLASS.
