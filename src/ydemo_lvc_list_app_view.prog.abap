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
    METHODS handle_grid_toolbar REDEFINITION.
    METHODS handle_grid_user_command REDEFINITION.

  PROTECTED SECTION.
    METHODS _modify_grid_in_register_event REDEFINITION.

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
  ENDMETHOD.

  METHOD set_top_of_page.
    DATA: lt_listheader TYPE slis_t_listheader,
          ls_listheader TYPE slis_listheader.

    IF lmv_current_stack EQ mc_stack_main.
*  Type H is used to display headers i.e. big font
      ls_listheader-typ  = 'H'.
      ls_listheader-info ='Flight Details'.
      APPEND ls_listheader TO lt_listheader.
      CLEAR ls_listheader.

*  Type S is used to display key and value pairs
      ls_listheader-typ = 'S'.
      ls_listheader-key = 'Date :' .
      CONCATENATE  sy-datum+6(2)
                   sy-datum+4(2)
                   sy-datum(4)
                   INTO ls_listheader-info
                   SEPARATED BY '/'.
      APPEND ls_listheader TO lt_listheader.
      CLEAR ls_listheader.

*  Type A is used to display italic font
      ls_listheader-typ = 'A'.
      ls_listheader-info ='SAP ALV Report'.
      APPEND ls_listheader TO lt_listheader.
      CLEAR ls_listheader.

      CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
        EXPORTING
          it_list_commentary = lt_listheader
          i_logo             = 'ENJOYSAP_LOGO'.
    ENDIF.
  ENDMETHOD.

  METHOD modify_fcat.
    super->modify_fcat( CHANGING ct_fcat = ct_fcat ).

    CASE lmv_current_stack. "_get_current_stack( ).
      WHEN 'MAIN'.
        LOOP AT ct_fcat ASSIGNING FIELD-SYMBOL(<lf_fcat>).
          CASE <lf_fcat>-fieldname.
            WHEN 'CHKBOX'.
*              set_fcat_technical( CHANGING cs_fcat = <lf_fcat> ).
              set_fcat_text( EXPORTING iv_text = 'Checkbox'
                             CHANGING  cs_fcat = <lf_fcat> ).
              set_fcat_checkbox( CHANGING cs_fcat = <lf_fcat> ).
*              <lf_fcat>-hotspot = abap_true.
*              <lf_fcat>-fix_column = abap_true.
*              <lf_fcat>-key = abap_true.
            WHEN 'CARRID'.
              <lf_fcat>-edit = abap_true.
*              <lf_fcat>-fix_column = abap_true.
            WHEN OTHERS.
              IF sy-tabix GT 30.
                set_fcat_hidden( CHANGING cs_fcat = <lf_fcat> ).
              ENDIF.
          ENDCASE.
        ENDLOOP.
    ENDCASE.

  ENDMETHOD.

  METHOD modify_layout.
*    CHECK lmv_lastest_stack NE 'SUB01'.

    super->modify_layout( CHANGING cs_layo = cs_layo ).

    cs_layo-stylefname = 'ALV_CELLTAB'.
*    cs_layo-ctab_fname = 'ALV_C_COLOR'.
    cs_layo-excp_fname = 'ALV_TRAFF'.

  ENDMETHOD.

  METHOD modify_events.
    super->modify_events( EXPORTING iv_evt_data_changed = abap_true
                          CHANGING  ct_event            = ct_event ).
  ENDMETHOD.

  METHOD modify_callback_routines.
    CHECK iv_stack_name EQ mc_stack_main.

    cv_callback_top_of_page = 'TOP_OF_PAGE'.
  ENDMETHOD.

  METHOD modify_html_height.
*    CHECK iv_stack_name EQ mc_stack_main.
*
*    cv_html_height_top = 20.
  ENDMETHOD.

  METHOD register_event.
    super->register_event( ).
    _modify_grid_in_register_event( ).
  ENDMETHOD.

  METHOD user_command.

    check_changed_data_in_ucomm( ).

    CASE im_ucomm.
      WHEN '&IC1'.
        CASE cs_selfield-fieldname.
          WHEN 'CHKBOX'.
*            BREAK-POINT.
            set_checkbox_value( EXPORTING iv_fieldname = cs_selfield-fieldname
                                          iv_tabindex  = cs_selfield-tabindex
                                          io_model     = io_model
                                CHANGING  cs_selfield  = cs_selfield ).
          WHEN OTHERS.
            CASE lmv_current_stack. "_get_current_stack( ).
              WHEN mc_stack_main.
                TRY.
                    create_new_view_to_controller(
                      iv_stack_name = 'SUB01'     "<-- pass any stack name
*                      io_model      = io_model
*                      io_controller = io_controller
                      ir_action     = NEW #( ucomm    = im_ucomm
                                             selfield = cs_selfield ) )->display_sub_alv( ).

*                    "Call deep-down ALV
*                    _call_secondary_alv( ).
*
*                    "Destroy
*                    destroy_view( ).
                  CATCH zbcx_exception.
                    RETURN.
                ENDTRY.
              WHEN OTHERS.
            ENDCASE.
        ENDCASE.
      WHEN OTHERS.
    ENDCASE.

*    me->refresh_alv( CHANGING cs_selfield = cs_selfield ).
  ENDMETHOD.

  METHOD handle_grid_toolbar.
    BREAK-POINT.

    super->handle_grid_toolbar( EXPORTING e_object      = e_object
                                          e_interactive = e_interactive ).
  ENDMETHOD.

  METHOD handle_grid_user_command.
    BREAK-POINT.
  ENDMETHOD.

  METHOD _modify_grid_in_register_event.
*    DATA: event_receiver TYPE REF TO lcl_view.
*
*    DATA(lo_grid) = super->register_event( ).
*
*    "--------------------------------------------------------------------"
*    " Get global fullscreen ALV Grid from REUSE_ALV_GRID_DISPLAY_LVC
*    "--------------------------------------------------------------------"
*    _get_globals_fullscreen_grid( IMPORTING es_lvc_layout = DATA(ls_layout) ).
*
*    "--------------------------------------------------------------------"
*    " Change any parameters
*    "--------------------------------------------------------------------"
*    ls_layout-no_toolbar = space.
*
*    "--------------------------------------------------------------------"
*    " Set new global fullscreen ALV Grid to REUSE_ALV_GRID_DISPLAY_LVC
*    "--------------------------------------------------------------------"
*    _set_globals_fullscreen_grid( EXPORTING is_lvc_layout = ls_layout ).
*
*    CREATE OBJECT event_receiver.
*    SET HANDLER event_receiver->handle_user_command_test FOR lo_grid.
*    SET HANDLER event_receiver->handle_toolbar_test FOR lo_grid.
*    CALL METHOD lo_grid->set_toolbar_interactive.
  ENDMETHOD.
ENDCLASS.
