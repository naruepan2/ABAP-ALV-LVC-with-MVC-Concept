*&---------------------------------------------------------------------*
*& Include          YDEMO_APP_SELC
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&  S E L E C T I O N   S C R E E N                                    *
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK s01 WITH FRAME TITLE TEXT-s01.

  SELECT-OPTIONS: s_carrid FOR spfli-carrid.

SELECTION-SCREEN END   OF BLOCK s01.
