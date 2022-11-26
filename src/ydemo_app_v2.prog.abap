*&---------------------------------------------------------------------*
*& Report YDEMO_APP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ydemo_app_v2.

*&---------------------------------------------------------------------*
*&  I N C L U D E  P R O G R A M                                       *
*&---------------------------------------------------------------------*
INCLUDE ydemo_app_topz_v2.
INCLUDE ydemo_app_selc_v2.
INCLUDE ydemo_app_sscr_v2.
INCLUDE ydemo_app_modl_v2.
INCLUDE ydemo_app_view_v2.
INCLUDE ydemo_app_cntl_v2.

*&---------------------------------------------------------------------*
*&  I N I T I A L I Z A T I O N                                        *
*&---------------------------------------------------------------------*
INITIALIZATION.
  go_control = NEW #( ).

*&---------------------------------------------------------------------*
*&  A T  S E L E C T I O N   S C R E E N   O U T P U T                 *
*&---------------------------------------------------------------------*
AT SELECTION-SCREEN OUTPUT.
  go_control->handle_sscr_pbo( sy-dynnr ).

*----------------------------------------------------------------------*
*   A T  S E L E C T I O N   S C R E E N   O N   V A L U E ...         *
*----------------------------------------------------------------------*
*AT SELECTION-SCREEN ON VALUE-REQUEST FOR .

*&---------------------------------------------------------------------*
*&  A T  S E L E C T I O N   S C R E E N                               *
*&---------------------------------------------------------------------*
AT SELECTION-SCREEN.
  go_control->handle_sscr_pai( sy-dynnr ).

*&---------------------------------------------------------------------*
*&  S T A R T - O F - S E L E C T I O N                                *
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  TRY.
* Get selection data
      go_control->mo_model->select_data( ).
** Process data
      go_control->mo_model->process_data( ).
* Display result
      go_control->display( ).
    CATCH zbcx_exception INTO DATA(go_except).
      go_except->display_msg( ).
  ENDTRY.
