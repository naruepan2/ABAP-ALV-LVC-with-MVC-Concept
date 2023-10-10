*&---------------------------------------------------------------------*
*& Include          YDEMO_APP_CNTL
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Include          ZINCL_FORM_BASE_LVC_CONTROLLER
*&---------------------------------------------------------------------*
INCLUDE zincl_form_base_lvc_controller.
*&---------------------------------------------------------------------*

*----------------------------------------------------------------------*
* CLASS lcl_controller DEFINITION
*----------------------------------------------------------------------*
CLASS lcl_controller DEFINITION INHERITING FROM zcl_mvcfw_base_lvc_controller.
  PUBLIC SECTION.
    DATA o_lcl_model TYPE REF TO lcl_model.

    METHODS constructor.

  PROTECTED SECTION.


  PRIVATE SECTION.


ENDCLASS.

*----------------------------------------------------------------------*
* CLASS lcl_controller IMPLEMENTATION
*----------------------------------------------------------------------*
CLASS lcl_controller IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).

    IF o_model IS BOUND.
      o_lcl_model = CAST #( o_model ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
