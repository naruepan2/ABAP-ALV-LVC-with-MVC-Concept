class ZCL_MVCFW_BASE_SSCR definition
  public
  create public .

public section.

  types TY_D020S type D020S .
  types:
    tty_d020s TYPE HASHED TABLE OF d020s WITH UNIQUE KEY prog dnum .

  constants MC_FILTER_GUI_FILE type STRING value 'Excel Files (*.XLSX)|*.XLSX|Excel Files (*..XLS)|*.XLS|Text Files (*.TXT)|*.TXT' ##NO_TEXT.

  methods CONSTRUCTOR .
  class-methods F4_GUI_DIALOG_APPLSERV
    importing
      !IV_OPTION type CHAR01 default '1'
      !IV_DEFAULT_EXTENSION type STRING optional
      !IV_DEFAULT_FILENAME type STRING optional
      !IV_FILTER type STRING default MC_FILTER_GUI_FILE
      !IV_DIR type ANY optional
      !IV_FILEMASK type STRING default '*.*'
    exporting
      !EV_FILE type STRING
    changing
      !CV_FILENAME type ANY .
  methods PBO
    importing
      !IV_DYNNR type SY-DYNNR default SY-DYNNR .
  methods PAI
    importing
      !IV_DYNNR type SY-DYNNR default SY-DYNNR .
  class-methods GET_SELECTOPTIONS
    importing
      !IV_REPID type SY-CPROG default SY-CPROG
    exporting
      !ET_SELOPT_TAB type RSPARAMS_TT
      !ET_SELOPT_TAB_LONG type FMRPF_RSPARAMSL_255_T .
  PROTECTED SECTION.

    METHODS _pbo_1000 .
    METHODS _pai_1000
      IMPORTING
        !iv_ucomm TYPE sy-ucomm .
private section.
ENDCLASS.



CLASS ZCL_MVCFW_BASE_SSCR IMPLEMENTATION.


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


  METHOD constructor.
  ENDMETHOD.
ENDCLASS.
