class ZCL_MVCFW_BASE_LVC_MODEL definition
  public
  create public .

public section.

  types:
    BEGIN OF ts_incl_outtab_ext,
        alv_traff   TYPE bkk_lightcode,  "1=Red, 2=Yellow, 3=Green
        alv_celltab TYPE lvc_t_styl,     "Style Table for Cells
        alv_s_color TYPE char04,         "Simple row color coding
        alv_c_color TYPE lvc_t_scol,     "Complex cell color coding
      END OF ts_incl_outtab_ext .

  constants:
    BEGIN OF color,
        blue                         TYPE char04 VALUE 'C100',
        blue_intensified             TYPE char04 VALUE 'C110',
        blue_intensified_inversed    TYPE char04 VALUE 'C111',
        blue_inversed                TYPE char04 VALUE 'C101',
        gray                         TYPE char04 VALUE 'C200',
        gray_itensified              TYPE char04 VALUE 'C210',
        gray_intesified_invers       TYPE char04 VALUE 'C211',
        gray_inversed                TYPE char04 VALUE 'C201',
        yellow                       TYPE char04 VALUE 'C300',
        yellow_intensified           TYPE char04 VALUE 'C310',
        yellow_intensified_inversed  TYPE char04 VALUE 'C311',
        yellow_inversed              TYPE char04 VALUE 'C301',
        light_blue                   TYPE char04 VALUE 'C400',
        light_blue_itensified        TYPE char04 VALUE 'C410',
        light_blue_intesified_invers TYPE char04 VALUE 'C411',
        light_blue_inversed          TYPE char04 VALUE 'C401',
        green                        TYPE char04 VALUE 'C500',
        green_intensified            TYPE char04 VALUE 'C510',
        green_intensified_inversed   TYPE char04 VALUE 'C511',
        green_inversed               TYPE char04 VALUE 'C501',
        red                          TYPE char04 VALUE 'C600',
        red_intensified              TYPE char04 VALUE 'C610',
        red_intensified_inversed     TYPE char04 VALUE 'C611',
        red_inversed                 TYPE char04 VALUE 'C601',
        orange                       TYPE char04 VALUE 'C700',
        orange_intensified           TYPE char04 VALUE 'C710',
        orange_intensified_inversed  TYPE char04 VALUE 'C711',
        orange_inversed              TYPE char04 VALUE 'C701',
      END OF color .
  constants C_STACK_MAIN type DFIES-TABNAME value 'MAIN' ##NO_TEXT.
  constants C_DEFLT_OUTTAB type DFIES-TABNAME value 'MT_OUTTAB' ##NO_TEXT.
  constants C_DEFLT_MODEL type SEOCLSNAME value 'LCL_MODEL' ##NO_TEXT.
  constants C_STYLE_ENABLED type RAW4 value CL_GUI_ALV_GRID=>MC_STYLE_ENABLED ##NO_TEXT.
  constants C_STYLE_DISABLED type RAW4 value CL_GUI_ALV_GRID=>MC_STYLE_DISABLED ##NO_TEXT.
  data O_MODEL_UTILS type ref to ZCL_MVCFW_BASE_UTILS_MODEL read-only .
  data S_ACTION type ZCL_MVCFW_BASE_LVC_CONTROLLER=>TS_LVC_VIEW_ACTION read-only .

  methods CONSTRUCTOR .
  methods SELECT_DATA
    raising
      ZBCX_EXCEPTION .
  methods PROCESS_DATA
    raising
      ZBCX_EXCEPTION .
  methods GET_OUTTAB
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
      !IV_FROM_EVENT type FLAG default SPACE
      !IV_FORMNAME type SLIS_FORMNAME optional
    returning
      value(RO_DATA) type ref to DATA .
  methods SET_OUTTAB
    importing
      !IV_STACK_NAME type DFIES-TABNAME optional
      !IT_DATA type TABLE .
  methods CLEAR_OUTTAB
    importing
      !IV_STACK_NAME type DFIES-TABNAME .
  methods SET_EDITABLE_CELL
    importing
      !IV_FNAME type LVC_FNAME
      !IV_DISABLED type ABAP_BOOL optional
    changing
      !CT_STYLE type LVC_T_STYL
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_LVC_MODEL .
  methods SET_STYLE_CELL
    importing
      !IV_FNAME type LVC_FNAME
      !IV_STYLE type LVC_S_STYL-STYLE optional
      !IV_STYLE2 type LVC_S_STYL-STYLE2 optional
      !IV_STYLE3 type LVC_S_STYL-STYLE3 optional
      !IV_STYLE4 type LVC_S_STYL-STYLE4 optional
    changing
      !CT_STYLE type LVC_T_STYL
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_LVC_MODEL .
  methods SET_COLOR_CELL
    importing
      !IV_FNAME type LVC_FNAME
      !IS_COLOR type LVC_S_COLO optional
      !IV_COLOR type CHAR04 optional
      !IV_NOKEYCOL type LVC_NOKEYC optional
    changing
      !CT_COLOR type LVC_T_SCOL
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_LVC_MODEL .
  methods SET_COLOR_ALL_CELLS
    importing
      !IS_DATA type ANY
      !IS_COLOR type LVC_S_COLO optional
      !IV_COLOR type CHAR04 optional
      !IV_NOKEYCOL type LVC_NOKEYC optional
    changing
      !CT_COLOR type LVC_T_SCOL
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_LVC_MODEL .
  methods SET_STACK_NAME
    importing
      !IV_STACK_NAME type DFIES-TABNAME default C_STACK_MAIN
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_LVC_MODEL .
  methods GET_STACK_NAME
    returning
      value(RV_STACK_NAME) type DFIES-TABNAME .
  methods GET_CONTROLLER_ACTION
    importing
      !IS_ACTION type ZCL_MVCFW_BASE_LVC_CONTROLLER=>TS_LVC_VIEW_ACTION
    returning
      value(RO_MODEL) type ref to ZCL_MVCFW_BASE_LVC_MODEL .
protected section.

  data MV_CURRENT_STACK type DFIES-TABNAME value c_stack_main ##NO_TEXT.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MVCFW_BASE_LVC_MODEL IMPLEMENTATION.


  METHOD constructor.
    IF o_model_utils IS NOT BOUND.
      o_model_utils = NEW #( ).
    ENDIF.
  ENDMETHOD.


  METHOD get_controller_action.
    ro_model = me.
    s_action = is_action.
  ENDMETHOD.


  METHOD get_outtab.
  ENDMETHOD.


  METHOD set_color_all_cells.
*****************************************************************
* Colour code :                                                 *
* Colour is a 4-char field where :                              *
*              - 1st char = C (color property)                  *
*              - 2nd char = color code (from 0 to 7)            *
*                                  0 = background color         *
*                                  1 = blue                     *
*                                  2 = gray                     *
*                                  3 = yellow                   *
*                                  4 = blue/gray                *
*                                  5 = green                    *
*                                  6 = red                      *
*                                  7 = orange                   *
*              - 3rd char = intensified (0=off, 1=on)           *
*              - 4th char = inverse display (0=off, 1=on)       *
*                                                               *
* Colour overwriting priority :                                 *
*   1. Line                                                     *
*   2. Cell                                                     *
*   3. Column                                                   *
*****************************************************************
*****************************************************************
* Use of colours in ALV grid (cell, line and column)            *
*****************************************************************

    DATA ls_color LIKE LINE OF ct_color.
    DATA ls_scolo TYPE lvc_s_colo.
    FIELD-SYMBOLS <lfs_color> TYPE lvc_s_scol.

    ro_model = me.

    IF is_color IS SUPPLIED.
      ls_scolo = is_color.
    ELSEIF iv_color IS SUPPLIED.
      IF |{ iv_color+0(1) CASE = UPPER }| CA sy-abcde.
        DATA(lv_color) = iv_color+1.
      ENDIF.

      TRY.
          ls_scolo = VALUE #( col = lv_color+0(1)
                              int = lv_color+1(1)
                              inv = lv_color+2(1) ).
        CATCH cx_sy_range_out_of_bounds.
      ENDTRY.
    ELSE.
      RETURN.
    ENDIF.

    IF ls_scolo IS NOT INITIAL.
      IF o_model_utils IS NOT BOUND.
        o_model_utils = NEW #( ).
      ENDIF.

      DATA(lt_comp) = o_model_utils->get_component_of_data( EXPORTING is_data = is_data ).

      LOOP AT lt_comp INTO DATA(ls_comp).
        READ TABLE ct_color ASSIGNING <lfs_color> BINARY SEARCH
          WITH KEY fname = ls_comp-fieldname.
        IF sy-subrc EQ 0.
          <lfs_color>-fname    = ls_comp-fieldname.
          <lfs_color>-color    = ls_scolo.
          <lfs_color>-nokeycol = iv_nokeycol.
        ELSE.
          CLEAR ls_color.
          ls_color-fname    = ls_comp-fieldname.
          ls_color-color    = ls_scolo.
          ls_color-nokeycol = iv_nokeycol.
          INSERT ls_color INTO TABLE ct_color.
          SORT ct_color BY fname.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD set_color_cell.
*****************************************************************
* Colour code :                                                 *
* Colour is a 4-char field where :                              *
*              - 1st char = C (color property)                  *
*              - 2nd char = color code (from 0 to 7)            *
*                                  0 = background color         *
*                                  1 = blue                     *
*                                  2 = gray                     *
*                                  3 = yellow                   *
*                                  4 = blue/gray                *
*                                  5 = green                    *
*                                  6 = red                      *
*                                  7 = orange                   *
*              - 3rd char = intensified (0=off, 1=on)           *
*              - 4th char = inverse display (0=off, 1=on)       *
*                                                               *
* Colour overwriting priority :                                 *
*   1. Line                                                     *
*   2. Cell                                                     *
*   3. Column                                                   *
*****************************************************************
*****************************************************************
* Use of colours in ALV grid (cell, line and column)            *
*****************************************************************
    DATA ls_color LIKE LINE OF ct_color.
    DATA ls_scolo TYPE lvc_s_colo.
    FIELD-SYMBOLS <lfs_color> TYPE lvc_s_scol.

    ro_model = me.

    IF is_color IS SUPPLIED.
      ls_scolo = is_color.
    ELSEIF iv_color IS SUPPLIED.
      IF |{ iv_color+0(1) CASE = UPPER }| CA sy-abcde.
        DATA(lv_color) = iv_color+1.
      ENDIF.

      TRY.
          ls_scolo = VALUE #( col = lv_color+0(1)
                              int = lv_color+1(1)
                              inv = lv_color+2(1) ).
        CATCH cx_sy_range_out_of_bounds.
      ENDTRY.
    ELSE.
      RETURN.
    ENDIF.

    IF ls_scolo IS NOT INITIAL.
      READ TABLE ct_color ASSIGNING <lfs_color> BINARY SEARCH
        WITH KEY fname = iv_fname.
      IF sy-subrc EQ 0.
        <lfs_color>-fname    = iv_fname.
        <lfs_color>-color    = ls_scolo.
        <lfs_color>-nokeycol = iv_nokeycol.
      ELSE.
        CLEAR ls_color.
        ls_color-fname    = iv_fname.
        ls_color-color    = ls_scolo.
        ls_color-nokeycol = iv_nokeycol.
        INSERT ls_color INTO TABLE ct_color.
        SORT ct_color BY fname.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_editable_cell.
*--------------------------------------------------------------------*
* Check text style with include <CL_ALV_CONTROL>
*--------------------------------------------------------------------*
*    INCLUDE <cl_alv_control>.

    DATA: ls_style LIKE LINE OF ct_style,
          l_style  TYPE lvc_style.

    ro_model = me.

    CHECK iv_fname IS NOT INITIAL.

    IF iv_disabled IS NOT INITIAL.
      l_style = cl_gui_alv_grid=>mc_style_disabled.
    ELSE.
      l_style = cl_gui_alv_grid=>mc_style_enabled.
    ENDIF.

    READ TABLE ct_style ASSIGNING FIELD-SYMBOL(<lfs_style>)
      WITH TABLE KEY fieldname = iv_fname.
    IF sy-subrc EQ 0.
      <lfs_style>-style  = l_style.
    ELSE.
      CLEAR ls_style.
      ls_style-fieldname = iv_fname.
      ls_style-style     = l_style.
      INSERT ls_style INTO TABLE ct_style.
    ENDIF.
  ENDMETHOD.


  METHOD set_outtab.
  ENDMETHOD.


  METHOD set_stack_name.
    mv_current_stack = iv_stack_name.
    ro_model          = me.
  ENDMETHOD.


  METHOD set_style_cell.
*--------------------------------------------------------------------*
* Check text style with include <CL_ALV_CONTROL>
*--------------------------------------------------------------------*
    INCLUDE <cl_alv_control>.

    DATA: ls_style LIKE LINE OF ct_style,
          l_style  TYPE lvc_style.

    ro_model = me.

    CHECK iv_fname IS NOT INITIAL.

    READ TABLE ct_style ASSIGNING FIELD-SYMBOL(<lfs_style>)
      WITH TABLE KEY fieldname = iv_fname.
    IF sy-subrc EQ 0.
      <lfs_style>-style  = COND #( WHEN iv_style  IS NOT INITIAL THEN iv_style  ELSE <lfs_style>-style ).
      <lfs_style>-style2 = COND #( WHEN iv_style2 IS NOT INITIAL THEN iv_style2 ELSE <lfs_style>-style2 ).
      <lfs_style>-style3 = COND #( WHEN iv_style3 IS NOT INITIAL THEN iv_style3 ELSE <lfs_style>-style3 ).
      <lfs_style>-style4 = COND #( WHEN iv_style4 IS NOT INITIAL THEN iv_style4 ELSE <lfs_style>-style4 ).
    ELSE.
      CLEAR ls_style.
      ls_style-fieldname = iv_fname.
      ls_style-style     = iv_style.
      ls_style-style2    = iv_style2.
      ls_style-style3    = iv_style3.
      ls_style-style4    = iv_style4.
      INSERT ls_style INTO TABLE ct_style.
    ENDIF.
  ENDMETHOD.


  METHOD get_stack_name.
    rv_stack_name = mv_current_stack.
  ENDMETHOD.


  METHOD clear_outtab.
  ENDMETHOD.


  method PROCESS_DATA.
  endmethod.


  method SELECT_DATA.
  endmethod.
ENDCLASS.
