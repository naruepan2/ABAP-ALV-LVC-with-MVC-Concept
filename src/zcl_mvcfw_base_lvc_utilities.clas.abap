CLASS zcl_mvcfw_base_lvc_utilities DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS f4_lvc_variant
      IMPORTING
        !iv_report  TYPE sy-cprog OPTIONAL
        !iv_usname  TYPE sy-uname OPTIONAL
        !iv_save    TYPE char1 OPTIONAL
      CHANGING
        !cv_variant TYPE disvariant-variant .
    CLASS-METHODS get_lvc_variant_default
      IMPORTING
        !iv_report        TYPE sy-cprog OPTIONAL
        !iv_usname        TYPE sy-uname OPTIONAL
        !iv_save          TYPE char1 OPTIONAL
      RETURNING
        VALUE(rv_variant) TYPE disvariant-variant .
    CLASS-METHODS get_fcat_from_internal_table
      IMPORTING
        !it_table      TYPE table
        !iv_table_name TYPE lvc_tname OPTIONAL
      EXPORTING
        !et_slis_fcat  TYPE slis_t_fieldcat_alv
        !et_lvc_fcat   TYPE lvc_t_fcat .
    CLASS-METHODS download_alv_as_excel
      IMPORTING
        VALUE(it_table) TYPE table .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MVCFW_BASE_LVC_UTILITIES IMPLEMENTATION.


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

* Convert ALV Table Object to XML
    DATA(lv_xml) = lo_alv->to_xml( xml_type = if_salv_bs_xml=>c_type_xlsx ).

* Convert XTRING to Binary
    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer        = lv_xml
      IMPORTING
        output_length = lv_size
      TABLES
        binary_tab    = lt_bintab.

* Download File
    CALL METHOD cl_gui_frontend_services=>gui_download
      EXPORTING
        bin_filesize            = lv_size
        filename                = lv_fullpath
        filetype                = 'BIN'
      CHANGING
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
        not_supported_by_gui    = 22
        error_no_gui            = 23
        OTHERS                  = 24.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.
  ENDMETHOD.


  METHOD f4_lvc_variant.
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


  METHOD get_lvc_variant_default.
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
ENDCLASS.
