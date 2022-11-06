*----------------------------------------------------------------------*
* CLASS lcl_view DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_view DEFINITION INHERITING FROM zcl_mvcfw_base_view.

  PUBLIC SECTION.
    METHODS set_pf_status REDEFINITION.
    METHODS modify_fcat REDEFINITION.
    METHODS modify_layout REDEFINITION.
    METHODS modify_events REDEFINITION.
    METHODS user_command REDEFINITION.
    METHODS register_event REDEFINITION.
    METHODS handle_grid_toolbar REDEFINITION.
    METHODS handle_grid_user_command REDEFINITION.

  PROTECTED SECTION.
    METHODS _modify_grid_in_register_event REDEFINITION.

  PRIVATE SECTION.
    METHODS _call_secondary_alv
      CHANGING
        ct_data TYPE STANDARD TABLE OPTIONAL .

ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_view_alv IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_view IMPLEMENTATION.
  METHOD set_pf_status.
**    CHECK lmv_lastest_stack NE 'SUB01'.
*    IF iv_stack_name NE 'MAIN'.
*      super->set_pf_status( it_extab = it_extab ).
*    ELSE.
*      SET PF-STATUS 'YDEMO_APP_STAT' EXCLUDING it_extab.
*    ENDIF.

    super->set_pf_status( it_extab = it_extab ).
  ENDMETHOD.

  METHOD modify_fcat.
    super->modify_fcat( CHANGING ct_fcat = ct_fcat ).

    CASE _get_current_stack( ).
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
*              <lf_fcat>-edit = abap_true.
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
            CASE _get_current_stack( ).
              WHEN mc_stack_main.
                TRY.
                    create_new_view_to_controller(
                      iv_stack_name = 'SUB01'     "<-- pass any stack name
                      io_model      = io_model
                      io_cntlr      = io_cntlr
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

  METHOD _call_secondary_alv.
    CHECK lmo_cntlr IS BOUND.

    TRY.
        CALL METHOD lmo_cntlr->display
          CHANGING
            ct_data = ct_data.
      CATCH cx_sy_dyn_call_error INTO DATA(lo_dyn_except).
        DATA(lv_dyn_msg) = lo_dyn_except->get_text( ).
      CATCH zbcx_exception INTO DATA(lo_sys_except).
        DATA(lv_sys_msg) = lo_sys_except->get_text( ).
    ENDTRY.
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
