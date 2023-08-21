class ZCL_MVCFW_BASE_LVC_UTILITIES definition
  public
  final
  create public .

public section.

  class-methods F4_ALV_VARIANT
    importing
      !IV_REPORT type SY-CPROG optional
      !IV_USNAME type SY-UNAME optional
      !IV_SAVE type CHAR1 optional
    changing
      !CV_VARIANT type DISVARIANT-VARIANT .
  class-methods F4_SALV_LAYOUTS
    importing
      !IS_KEY type SALV_S_LAYOUT_KEY
      !IV_LAYOUT type SLIS_VARI optional
      !IV_RESTRICT type SALV_DE_LAYOUT_RESTRICTION optional
    exporting
      !ES_LAYOUT_INFO type SALV_S_LAYOUT_INFO
    changing
      !CV_LAYOUT type SALV_S_LAYOUT_INFO-LAYOUT optional .
  class-methods GET_ALV_VARIANT_DEFAULT
    importing
      !IV_REPORT type SY-CPROG optional
      !IV_USNAME type SY-UNAME optional
      !IV_SAVE type CHAR1 optional
    returning
      value(RV_VARIANT) type DISVARIANT-VARIANT .
  class-methods GET_FCAT_FROM_INTERNAL_TABLE
    importing
      !IT_TABLE type TABLE
    exporting
      !ET_SLIS_FCAT type SLIS_T_FIELDCAT_ALV
      !ET_LVC_FCAT type LVC_T_FCAT .
protected section.
private section.
ENDCLASS.



CLASS ZCL_MVCFW_BASE_LVC_UTILITIES IMPLEMENTATION.


  METHOD F4_ALV_VARIANT.
    DATA: ls_variant TYPE disvariant.
    DATA: lv_exit TYPE c.

    ls_variant = VALUE #( report   = COND #( WHEN iv_report IS NOT INITIAL THEN iv_report ELSE sy-cprog )
                          username = iv_usname ).

    CALL FUNCTION 'LVC_VARIANT_F4'
      EXPORTING
        is_variant    = ls_variant
        i_save        = iv_save
      IMPORTING
        e_exit        = lv_exit
        es_variant    = ls_variant
      EXCEPTIONS
        not_found     = 1
        program_error = 2
        OTHERS        = 3.
    IF sy-subrc EQ 0.
      CHECK lv_exit EQ space.
      cv_variant = ls_variant-variant.
    ENDIF.
  ENDMETHOD.


  METHOD F4_SALV_LAYOUTS.
    DATA: ls_layout TYPE salv_s_layout_info,
          ls_key    TYPE salv_s_layout_key.

    ls_key = is_key.

    IF ls_key-report IS INITIAL.
      ls_key-report = sy-cprog.
    ENDIF.

    es_layout_info = cl_salv_layout_service=>f4_layouts( s_key    = ls_key
                                                         layout   = iv_layout
                                                         restrict = iv_restrict  ).
    cv_layout = es_layout_info-layout.
  ENDMETHOD.


  METHOD GET_ALV_VARIANT_DEFAULT.
    DATA: ls_variant TYPE disvariant.

    ls_variant = VALUE #( report   = COND #( WHEN iv_report IS NOT INITIAL THEN iv_report ELSE sy-cprog )
                          username = iv_usname ).

    CALL FUNCTION 'LVC_VARIANT_DEFAULT_GET'
      EXPORTING
        i_save        = iv_save
      CHANGING
        cs_variant    = ls_variant
      EXCEPTIONS
        wrong_input   = 1
        not_found     = 2
        program_error = 3
        OTHERS        = 4.
    IF sy-subrc EQ 0.
      rv_variant = ls_variant-variant.
    ENDIF.
  ENDMETHOD.


  METHOD GET_FCAT_FROM_INTERNAL_TABLE.
    DATA: table TYPE REF TO data.

    CHECK it_table IS NOT INITIAL.

    CREATE DATA table LIKE it_table.
    ASSIGN table->* TO FIELD-SYMBOL(<table>).

    CHECK <table> IS ASSIGNED.

    IF et_slis_fcat IS SUPPLIED
    OR et_lvc_fcat  IS SUPPLIED.
      TRY.
          cl_salv_table=>factory( IMPORTING r_salv_table = DATA(salv_table)
                                  CHANGING  t_table      = <table> ).

          IF et_lvc_fcat IS SUPPLIED.
            et_lvc_fcat = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
                r_columns      = salv_table->get_columns( )         " ALV Filter
                r_aggregations = salv_table->get_aggregations( ) ). " ALV Aggregations
          ELSEIF et_slis_fcat IS SUPPLIED.
            et_slis_fcat = cl_salv_controller_metadata=>get_slis_fieldcatalog(
                r_columns      = salv_table->get_columns( )         " ALV Filter
                r_aggregations = salv_table->get_aggregations( ) ). " ALV Aggregations
          ENDIF.
        CATCH cx_root.
      ENDTRY.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
