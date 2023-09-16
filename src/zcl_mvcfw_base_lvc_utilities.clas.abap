class ZCL_MVCFW_BASE_LVC_UTILITIES definition
  public
  final
  create public .

public section.

  class-methods F4_LVC_VARIANT
    importing
      !IV_REPORT type SY-CPROG optional
      !IV_USNAME type SY-UNAME optional
      !IV_SAVE type CHAR1 optional
    changing
      !CV_VARIANT type DISVARIANT-VARIANT .
  class-methods GET_LVC_VARIANT_DEFAULT
    importing
      !IV_REPORT type SY-CPROG optional
      !IV_USNAME type SY-UNAME optional
      !IV_SAVE type CHAR1 optional
    returning
      value(RV_VARIANT) type DISVARIANT-VARIANT .
  class-methods GET_FCAT_FROM_INTERNAL_TABLE
    importing
      !IT_TABLE type TABLE optional
      !IV_STRUCTURE_NAME type DD02L-TABNAME optional
      !IV_TABLE_NAME type LVC_TNAME optional
    exporting
      !ET_SLIS_FCAT type SLIS_T_FIELDCAT_ALV
      !ET_LVC_FCAT type LVC_T_FCAT .
  class-methods DOWNLOAD_ALV_AS_EXCEL
    importing
      !IT_TABLE type TABLE .
  class-methods GET_EXCLUDING_EDITABLE_TOOLBAR
    returning
      value(RT_EXCLUDE) type UI_FUNCTIONS .
  class-methods DEBUGGER_FOR_BACKGROUND_JOB .
  class-methods CREATE_BACKGROUND_JOB
    importing
      !IV_JOBNAME type TBTCJOB-JOBNAME optional
      !IV_REPORT type SY-REPID default SY-REPID
      !IV_VARIANT type RALDB-VARIANT default SY-SLSET
      !IV_SDLSTRTDT type TBTCJOB-SDLSTRTDT optional
      !IV_SDLSTRTTM type TBTCJOB-SDLSTRTTM optional
      !IV_STRTIMMED type BTCH0000-CHAR1 optional
    exporting
      !EV_SUBRC type SY-SUBRC
      !EV_MSG type STRING .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MVCFW_BASE_LVC_UTILITIES IMPLEMENTATION.


  METHOD get_fcat_from_internal_table.
    DATA: table TYPE REF TO data.
    DATA: lv_structure_name   TYPE dd02l-tabname,
          lv_internal_tabname TYPE dd02l-tabname.

    IF it_table IS SUPPLIED.
      CREATE DATA table LIKE it_table.
      CHECK table IS BOUND.

      ASSIGN table->* TO FIELD-SYMBOL(<table>).
      CHECK <table> IS ASSIGNED.

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
          ENDIF.

          IF et_slis_fcat IS SUPPLIED.
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
    ELSEIF iv_structure_name IS SUPPLIED.
      lv_structure_name   = |{ iv_structure_name CASE = UPPER }|.
      lv_internal_tabname = |{ iv_table_name CASE = UPPER }|.

      IF et_lvc_fcat IS SUPPLIED.
        CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
          EXPORTING
            i_structure_name       = lv_structure_name
            i_client_never_display = abap_true
            i_internal_tabname     = lv_internal_tabname
          CHANGING
            ct_fieldcat            = et_lvc_fcat
          EXCEPTIONS
            inconsistent_interface = 1
            program_error          = 2
            OTHERS                 = 3.

      ENDIF.

      IF et_slis_fcat IS SUPPLIED.
        CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
          EXPORTING
            i_internal_tabname     = lv_internal_tabname
            i_structure_name       = lv_structure_name
            i_client_never_display = abap_true
          CHANGING
            ct_fieldcat            = et_slis_fcat
          EXCEPTIONS
            inconsistent_interface = 1
            program_error          = 2
            OTHERS                 = 3.
      ENDIF.
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
    FIELD-SYMBOLS: <lft_table> TYPE table.

    CHECK it_table IS NOT INITIAL.

    CREATE DATA table LIKE it_table.
    CHECK table IS BOUND.

    ASSIGN table->* TO <lft_table>.
    CHECK <lft_table> IS ASSIGNED.

    <lft_table> = it_table.

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
            t_table        = <lft_table> ).
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


  METHOD get_excluding_editable_toolbar.
    DATA ls_exclude TYPE ui_func.

    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_copy_row.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_delete_row.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_append_row.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_insert_row.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_move_row.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_copy.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_cut.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_paste.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_paste_new_row.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_loc_undo.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_refresh.
    APPEND ls_exclude TO rt_exclude.
    ls_exclude = cl_gui_alv_grid=>mc_fc_check.
    APPEND ls_exclude TO rt_exclude.
  ENDMETHOD.


  METHOD create_background_job.
    DATA: lv_jobname  TYPE tbtcjob-jobname,
          lv_jobcount TYPE tbtcjob-jobcount.
    DATA: lv_report  TYPE sy-repid,
          lv_variant TYPE raldb-variant.
    DATA: lv_sdlstrtdt    TYPE tbtcjob-sdlstrtdt,
          lv_sdlstrttm    TYPE tbtcjob-sdlstrttm,
          lv_strtimmed    TYPE btch0000-char1,
          lv_direct_start TYPE btch0000-char1.

    lv_jobname = iv_jobname.

    IF lv_jobname IS INITIAL.
      GET TIME STAMP FIELD DATA(ts).
      lv_jobname = |{ sy-repid }_{ sy-uname }_{ ts }|.
    ENDIF.

    lv_report  = iv_report.
    lv_variant = iv_variant.

    CALL FUNCTION 'JOB_OPEN'
      EXPORTING
        jobname          = lv_jobname
      IMPORTING
        jobcount         = lv_jobcount
      EXCEPTIONS
        cant_create_job  = 1
        invalid_job_data = 2
        jobname_missing  = 3
        OTHERS           = 4.
    IF sy-subrc <> 0.
      ev_subrc = sy-subrc.

      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
         WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
         INTO ev_msg.
      RETURN.
    ENDIF.

    CALL FUNCTION 'JOB_SUBMIT'
      EXPORTING
        authcknam               = sy-uname
        jobcount                = lv_jobcount
        jobname                 = lv_jobname
        report                  = lv_report
        variant                 = lv_variant
      EXCEPTIONS
        bad_priparams           = 1
        bad_xpgflags            = 2
        invalid_jobdata         = 3
        jobname_missing         = 4
        job_notex               = 5
        job_submit_failed       = 6
        lock_failed             = 7
        program_missing         = 8
        prog_abap_and_extpg_set = 9
        OTHERS                  = 10.
    IF sy-subrc <> 0.
      ev_subrc = sy-subrc.

      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
         WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
         INTO ev_msg.
      RETURN.
    ENDIF.

    IF iv_sdlstrtdt IS NOT INITIAL
   AND iv_sdlstrttm IS NOT INITIAL.
      lv_sdlstrtdt = iv_sdlstrtdt.
      lv_sdlstrttm = iv_sdlstrttm.
    ELSEIF iv_strtimmed IS NOT INITIAL.
      lv_strtimmed    =
      lv_direct_start = iv_strtimmed.
    ENDIF.

    CALL FUNCTION 'JOB_CLOSE'
      EXPORTING
        jobcount             = lv_jobcount
        jobname              = lv_jobname
        sdlstrtdt            = lv_sdlstrtdt
        sdlstrttm            = lv_sdlstrttm
        strtimmed            = lv_strtimmed
      EXCEPTIONS
        cant_start_immediate = 1
        invalid_startdate    = 2
        jobname_missing      = 3
        job_close_failed     = 4
        job_nosteps          = 5
        job_notex            = 6
        lock_failed          = 7
        invalid_target       = 8
        invalid_time_zone    = 9
        OTHERS               = 10.
    IF sy-subrc <> 0.
      ev_subrc = sy-subrc.

      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
         WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
         INTO ev_msg.
      RETURN.
    ENDIF.
  ENDMETHOD.


  METHOD debugger_for_background_job.
    DATA: lv_debugger TYPE flag VALUE abap_true.

    IF sy-batch IS INITIAL.
      RETURN.
    ENDIF.

*--------------------------------------------------------------------*
* Delete lv_debugger value to avoid infinty loop when run background job
*--------------------------------------------------------------------*
    WHILE lv_debugger IS NOT INITIAL.
    ENDWHILE.
  ENDMETHOD.
ENDCLASS.
