*&---------------------------------------------------------------------*
*& Include          ZINCL_FORM_BASE_LVC_CONTROLLER
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&
*& !!! Don't Change Any Code for this Include
*&
*&---------------------------------------------------------------------*
FORM set_pf_status USING rt_extab TYPE slis_t_extab.

  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_pf_status( rt_extab ).

ENDFORM.

FORM user_command  USING up_ucomm    TYPE sy-ucomm
                         us_selfield TYPE slis_selfield.

  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_user_command( EXPORTING im_ucomm    = up_ucomm
                                                                                     CHANGING  cs_selfield = us_selfield ).

ENDFORM.

FORM check_changed_data USING er_data_changed	TYPE REF TO	cl_alv_changed_data_protocol.

  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_check_changed_data( er_data_changed ).

ENDFORM.

FORM caller_exit USING is_data TYPE slis_data_caller_exit.

  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_register_event( CHANGING cs_data = is_data ).

ENDFORM.

FORM top_of_page.

  CHECK zcl_mvcfw_base_lvc_controller=>check_routine_only( ) IS INITIAL.
  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_top_of_page( ).

ENDFORM.

FORM top_of_page_html USING cl_dd TYPE REF TO cl_dd_document.

  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_top_of_page_html( cl_dd ).

ENDFORM.

FORM end_of_page_html USING cl_dd TYPE REF TO cl_dd_document.

  zcl_mvcfw_base_lvc_controller=>get_static_control_instance( )->raise_end_of_page_html( cl_dd ).

ENDFORM.
