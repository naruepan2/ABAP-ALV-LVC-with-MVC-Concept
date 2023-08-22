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
      !IV_TABLE_NAME type LVC_TNAME optional
    exporting
      !ET_SLIS_FCAT type SLIS_T_FIELDCAT_ALV
      !ET_LVC_FCAT type LVC_T_FCAT .
  class-methods DOWNLOAD_ALV_AS_EXCEL
    importing
      value(IT_TABLE) type TABLE .
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


  METHOD get_fcat_from_internal_table.
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

            IF iv_table_name IS NOT INITIAL.
              LOOP AT et_lvc_fcat ASSIGNING FIELD-SYMBOL(<lfs_lvc_fcat>).
                <lfs_lvc_fcat>-tabname = |{ iv_table_name CASE = UPPER }|.
              ENDLOOP.
            ENDIF.
          ELSEIF et_slis_fcat IS SUPPLIED.
            et_slis_fcat = cl_salv_controller_metadata=>get_slis_fieldcatalog(
                r_columns      = salv_table->get_columns( )         " ALV Filter
                r_aggregations = salv_table->get_aggregations( ) ). " ALV Aggregations

            IF iv_table_name IS NOT INITIAL.
              LOOP AT et_slis_fcat ASSIGNING FIELD-SYMBOL(<lfs_slis_fcat>).
                <lfs_slis_fcat>-tabname = |{ iv_table_name CASE = UPPER }|.
              ENDLOOP.
            ENDIF.
          ENDIF.
        CATCH cx_root.
      ENDTRY.
    ENDIF.
  ENDMETHOD.


  METHOD download_alv_as_excel.
    DATA: table TYPE REF TO data.
    DATA: lt_bintab      TYPE STANDARD TABLE OF solix,
          lv_size        TYPE i,
          lv_filename    TYPE string,
          lv_path        TYPE string,
          lv_fullpath    TYPE string,
          lv_user_action TYPE i.

    CHECK it_table IS NOT INITIAL.

* Get New Instance for ALV Table Object
    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table   = DATA(lo_alv)
          CHANGING
            t_table        = it_table ).
      CATCH cx_salv_msg.
        RETURN.
    ENDTRY.

    CALL METHOD cl_gui_frontend_services=>file_save_dialog
      EXPORTING
        window_title         = 'File Save Dialog'
        default_extension    = 'C:\'
        file_filter          = cl_gui_frontend_services=>filetype_excel
      CHANGING
        filename             = lv_filename
        path                 = lv_path
        fullpath             = lv_fullpath
        user_action          = lv_user_action
      EXCEPTIONS
        cntl_error           = 1
        error_no_gui         = 2
        not_supported_by_gui = 3
        OTHERS               = 4.
    IF sy-subrc <> 0
    OR lv_user_action = cl_gui_frontend_services=>action_cancel.
      RETURN.
    ENDIF.

* Convert ALV Table Object to XML
    DATA(lv_xml) = lo_alv->to_xml( xml_type = '02' ).

* Convert XTRING to Binary
    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer        = lv_xml
      IMPORTING
        output_length = lv_size
      TABLES
        binary_tab    = lt_bintab.

* Download File
    CALL FUNCTION 'GUI_DOWNLOAD'
      EXPORTING
        bin_filesize            = lv_size
        filename                = lv_fullpath
        filetype                = 'BIN'
      TABLES
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
        OTHERS                  = 22.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
