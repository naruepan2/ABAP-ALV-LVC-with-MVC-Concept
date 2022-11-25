CLASS zcl_mvcfw_base_sscr DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS mc_filter_gui_file TYPE string VALUE 'Excel Files (*.XLSX)|*.XLSX|Excel Files (*..XLS)|*.XLS|Text Files (*.TXT)|*.TXT' ##NO_TEXT.

    CLASS-METHODS f4_gui_dialog_applserv
      IMPORTING
        !iv_option            TYPE char01 DEFAULT '1'
        !iv_default_extension TYPE string OPTIONAL
        !iv_default_filename  TYPE string OPTIONAL
        !iv_filter            TYPE string DEFAULT mc_filter_gui_file
        !iv_dir               TYPE any OPTIONAL
        !iv_filemask          TYPE string DEFAULT '*.*'
      EXPORTING
        !ev_file              TYPE string
      CHANGING
        !cv_filename          TYPE any .
    CLASS-METHODS f4_alv_variant
      IMPORTING
        !iv_report  TYPE sy-cprog DEFAULT sy-cprog
        !iv_usname  TYPE sy-uname DEFAULT sy-uname
        !iv_save    TYPE char1 DEFAULT abap_true
      CHANGING
        !cv_variant TYPE disvariant-variant .
    CLASS-METHODS get_alv_variant_default
      IMPORTING
        !iv_report  TYPE sy-cprog DEFAULT sy-cprog
        !iv_usname  TYPE sy-uname DEFAULT sy-uname
        !iv_save    TYPE char1 DEFAULT abap_true
      CHANGING
        !cv_variant TYPE disvariant-variant .
    METHODS pbo
      IMPORTING
        !iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr .
    METHODS pai
      IMPORTING
        !iv_dynnr TYPE sy-dynnr DEFAULT sy-dynnr .
    CLASS-METHODS get_selectoptions
      IMPORTING
        !iv_repid           TYPE sy-cprog DEFAULT sy-cprog
      EXPORTING
        !et_selopt_tab      TYPE rsparams_tt
        !et_selopt_tab_long TYPE fmrpf_rsparamsl_255_t .
  PROTECTED SECTION.

    METHODS _pbo_1000 .
    METHODS _pai_1000
      IMPORTING
        !iv_ucomm TYPE sy-ucomm .
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_MVCFW_BASE_SSCR IMPLEMENTATION.


  METHOD f4_alv_variant.
    DATA: ls_variant TYPE disvariant.
    DATA: lv_exit TYPE c.

    ls_variant = VALUE #( report   = iv_report
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


  METHOD f4_gui_dialog_applserv.
    DATA: lt_file  TYPE filetable.
    DATA: lv_pcpath     TYPE string,
          lv_subrc      TYPE i,
          lv_filter     TYPE string,
          lv_serverfile TYPE string.

    CASE iv_option.
      WHEN '1'.     "F4 for PC
        CALL METHOD cl_gui_frontend_services=>file_open_dialog
          EXPORTING
            window_title            = 'Select text file to upload'    " Title Of File Open Dialog
            default_extension       = iv_default_extension            " Default Extension
            default_filename        = iv_default_filename             " Default File Name
            file_filter             = iv_filter                       " Multiple selections poss.
          CHANGING
            file_table              = lt_file                         " Table Holding Selected Files
            rc                      = lv_subrc
          EXCEPTIONS
            file_open_dialog_failed = 1
            cntl_error              = 2
            error_no_gui            = 3
            not_supported_by_gui    = 4
            OTHERS                  = 5.
        IF sy-subrc EQ 0.
          IF lt_file[] IS NOT INITIAL.
            READ TABLE lt_file INTO DATA(ls_file) INDEX 1 .
            cv_filename = ls_file.
          ENDIF.
        ENDIF.
      WHEN '2'.     "F4 for server application
        CALL FUNCTION '/SAPDMC/LSM_F4_SERVER_FILE'
          EXPORTING
            directory        = iv_dir
            filemask         = iv_filemask
          IMPORTING
            serverfile       = lv_serverfile
          EXCEPTIONS
            canceled_by_user = 1
            OTHERS           = 2.
        IF sy-subrc EQ 0.
          cv_filename = lv_serverfile.
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD get_alv_variant_default.
    DATA: ls_variant TYPE disvariant.

    ls_variant = VALUE #( report   = iv_report
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
      cv_variant = ls_variant-variant.
    ENDIF.
  ENDMETHOD.


  METHOD get_selectoptions.
    CALL FUNCTION 'RS_REFRESH_FROM_SELECTOPTIONS'
      EXPORTING
        curr_report         = iv_repid
      TABLES
        selection_table     = et_selopt_tab
        selection_table_255 = et_selopt_tab_long
      EXCEPTIONS
        not_found           = 1
        no_report           = 2
        OTHERS              = 3.
  ENDMETHOD.


  METHOD pai.
    DATA: lv_method TYPE string.

    CONCATENATE 'PAI_' iv_dynnr INTO lv_method.

    TRY.
        CASE iv_dynnr.
          WHEN 1000.
            lv_method  = |_{ lv_method }|.
            DATA(ptab) = VALUE abap_parmbind_tab( ( name  = 'IV_UCOMM'
                                                    kind  = cl_abap_objectdescr=>exporting
                                                    value = REF #( sy-ucomm ) ) ).

            CALL METHOD (lv_method)
              PARAMETER-TABLE ptab.
          WHEN OTHERS.
            CALL METHOD (lv_method).
        ENDCASE.
      CATCH cx_sy_dyn_call_error.
    ENDTRY.
  ENDMETHOD.


  METHOD pbo.
    DATA: lv_method TYPE string.

    CONCATENATE 'PBO_' iv_dynnr INTO lv_method.

    TRY.
        CASE iv_dynnr.
          WHEN 1000.
            lv_method = |_{ lv_method }|.
            CALL METHOD (lv_method).
          WHEN OTHERS.
            CALL METHOD (lv_method).
        ENDCASE.
      CATCH cx_sy_dyn_call_error.
    ENDTRY.
  ENDMETHOD.


  METHOD _pai_1000.
    CASE iv_ucomm.
      WHEN 'ONLI'   "Execute
        OR 'PRIN'.  "Execute and Print

    ENDCASE.
  ENDMETHOD.


  METHOD _pbo_1000.
  ENDMETHOD.
ENDCLASS.
