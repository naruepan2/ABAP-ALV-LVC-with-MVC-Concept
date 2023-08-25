*&---------------------------------------------------------------------*
*& Include          YDEMO_APP_VIEW
*&---------------------------------------------------------------------*
*----------------------------------------------------------------------*
* CLASS lcl_view DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_view DEFINITION INHERITING FROM zcl_mvcfw_base_lvc_view.
  PUBLIC SECTION.
    METHODS set_pf_status REDEFINITION.
    METHODS set_top_of_page REDEFINITION.
    METHODS modify_fcat REDEFINITION.
    METHODS modify_layout REDEFINITION.
    METHODS modify_events REDEFINITION.
    METHODS modify_callback_routines REDEFINITION.
    METHODS modify_html_height REDEFINITION.
    METHODS user_command REDEFINITION.
    METHODS register_event REDEFINITION.

  PROTECTED SECTION.

  PRIVATE SECTION.


ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_view_alv IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_view IMPLEMENTATION.
  METHOD set_pf_status.
*    IF iv_stack_name NE 'MAIN'.
*      super->set_pf_status( it_extab = it_extab ).
*    ELSE.
*      SET PF-STATUS 'YDEMO_APP_STAT' EXCLUDING it_extab.
*    ENDIF.

    super->set_pf_status( it_extab = it_extab ).

*    SET PF-STATUS 'YDEMO_LVC_GUI_PROG01' EXCLUDING it_extab.
  ENDMETHOD.

  METHOD set_top_of_page.
*    DATA: lt_listheader TYPE slis_t_listheader,
*          ls_listheader TYPE slis_listheader.
*
*    IF lmv_current_stack EQ mc_stack_main.
**  Type H is used to display headers i.e. big font
*      ls_listheader-typ  = 'H'.
*      ls_listheader-info ='Flight Details'.
*      APPEND ls_listheader TO lt_listheader.
*      CLEAR ls_listheader.
*
**  Type S is used to display key and value pairs
*      ls_listheader-typ = 'S'.
*      ls_listheader-key = 'Date :' .
*      CONCATENATE  sy-datum+6(2)
*                   sy-datum+4(2)
*                   sy-datum(4)
*                   INTO ls_listheader-info
*                   SEPARATED BY '/'.
*      APPEND ls_listheader TO lt_listheader.
*      CLEAR ls_listheader.
*
**  Type A is used to display italic font
*      ls_listheader-typ = 'A'.
*      ls_listheader-info ='SAP ALV Report'.
*      APPEND ls_listheader TO lt_listheader.
*      CLEAR ls_listheader.
*
*      CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
*        EXPORTING
*          it_list_commentary = lt_listheader
*          i_logo             = 'ENJOYSAP_LOGO'.
*    ENDIF.
  ENDMETHOD.

  METHOD modify_fcat.
    super->modify_fcat( CHANGING ct_fcat = ct_fcat ).

*    CASE lmv_current_stack. "_get_current_stack( ).
*      WHEN 'MAIN'.
*        LOOP AT ct_fcat ASSIGNING FIELD-SYMBOL(<lf_fcat>).
*          CASE <lf_fcat>-fieldname.
*            WHEN 'CHKBOX'.
**              set_fcat_technical( CHANGING cs_fcat = <lf_fcat> ).
*              set_fcat_text( EXPORTING iv_text = 'Checkbox'
*                             CHANGING  cs_fcat = <lf_fcat> ).
*              set_fcat_checkbox( CHANGING cs_fcat = <lf_fcat> ).
**              <lf_fcat>-hotspot = abap_true.
**              <lf_fcat>-fix_column = abap_true.
**              <lf_fcat>-key = abap_true.
*            WHEN 'CARRID'.
*              <lf_fcat>-edit = abap_true.
**              <lf_fcat>-fix_column = abap_true.
*            WHEN OTHERS.
*              IF sy-tabix GT 30.
*                set_fcat_hidden( CHANGING cs_fcat = <lf_fcat> ).
*              ENDIF.
*          ENDCASE.
*        ENDLOOP.
*    ENDCASE.

  ENDMETHOD.

  METHOD modify_layout.
*    CHECK lmv_lastest_stack NE 'SUB01'.

    super->modify_layout( CHANGING cs_layo = cs_layo ).

*    CLEAR cs_layo.
    cs_layo-sel_mode   = 'A'.
    cs_layo-no_rowmark = space.

*    cs_layo-stylefname = 'ALV_CELLTAB'.
*    cs_layo-ctab_fname = 'ALV_C_COLOR'.
*    cs_layo-excp_fname = 'ALV_TRAFF'.

  ENDMETHOD.

  METHOD modify_events.
    super->modify_events( EXPORTING iv_evt_data_changed = abap_true
                          CHANGING  ct_event            = ct_event ).
  ENDMETHOD.

  METHOD modify_callback_routines.
    CHECK iv_stack_name EQ mc_stack_main.

*    cv_callback_top_of_page = 'TOP_OF_PAGE'.
  ENDMETHOD.

  METHOD modify_html_height.
*    CHECK iv_stack_name EQ mc_stack_main.
*
*    cv_html_height_top = 20.
  ENDMETHOD.

  METHOD register_event.
    super->register_event( ).
    modify_grid_in_register_event( ).
  ENDMETHOD.

  METHOD user_command.

    check_changed_data_in_ucomm( ).


*    me->refresh_alv( CHANGING cs_selfield = cs_selfield ).
  ENDMETHOD.
ENDCLASS.
