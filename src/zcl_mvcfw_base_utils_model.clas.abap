class ZCL_MVCFW_BASE_UTILS_MODEL definition
  public
  create public .

public section.

  types:
    BEGIN OF ty_worksheets,
        sheet_name TYPE string,
        data_ref   TYPE REF TO data,
      END OF ty_worksheets .
  types:
    tt_worksheets TYPE TABLE OF ty_worksheets WITH DEFAULT KEY .

  constants:
    BEGIN OF color,
        blue                         TYPE char04 VALUE 'C100',
        blue_intensified             TYPE char04 VALUE 'C110',
        blue_intensified_inversed    TYPE char04 VALUE 'C111',
        blue_inversed                TYPE char04 VALUE 'C101',
        gray                         TYPE char04 VALUE 'C200',
        gray_itensified              TYPE char04 VALUE 'C210',
        gray_intesified_invers       TYPE char04 VALUE 'C211',
        gray_inversed                TYPE char04 VALUE 'C201',
        yellow                       TYPE char04 VALUE 'C300',
        yellow_intensified           TYPE char04 VALUE 'C310',
        yellow_intensified_inversed  TYPE char04 VALUE 'C311',
        yellow_inversed              TYPE char04 VALUE 'C301',
        light_blue                   TYPE char04 VALUE 'C400',
        light_blue_itensified        TYPE char04 VALUE 'C410',
        light_blue_intesified_invers TYPE char04 VALUE 'C411',
        light_blue_inversed          TYPE char04 VALUE 'C401',
        green                        TYPE char04 VALUE 'C500',
        green_intensified            TYPE char04 VALUE 'C510',
        green_intensified_inversed   TYPE char04 VALUE 'C511',
        green_inversed               TYPE char04 VALUE 'C501',
        red                          TYPE char04 VALUE 'C600',
        red_intensified              TYPE char04 VALUE 'C610',
        red_intensified_inversed     TYPE char04 VALUE 'C611',
        red_inversed                 TYPE char04 VALUE 'C601',
        orange                       TYPE char04 VALUE 'C700',
        orange_intensified           TYPE char04 VALUE 'C710',
        orange_intensified_inversed  TYPE char04 VALUE 'C711',
        orange_inversed              TYPE char04 VALUE 'C701',
      END OF color .
  constants:
    BEGIN OF cell_type,
        text             TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>text,
        checkbox         TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>checkbox,
        button           TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>button,
        dropdown         TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>dropdown,
        link             TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>link,
        hotspot          TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>hotspot,
        checkbox_hotspot TYPE  salv_de_celltype VALUE if_salv_c_cell_type=>checkbox_hotspot,
      END OF cell_type .

  methods GET_SELECTOPTIONS_FROM_SSCR
    importing
      !IV_REPID type SY-CPROG default SY-CPROG
    exporting
      !ET_SELOPT_TAB type RSPARAMS_TT
      !ET_SELOPT_TAB_LONG type FMRPF_RSPARAMSL_255_T .
  methods GET_COMPONENT_OF_DATA
    importing
      !IS_DATA type ANY optional
      !IT_DATA type TABLE optional
      !IV_NO_CLIENT type FLAG default ABAP_TRUE
    returning
      value(RT_COMPONENT) type LVC_T_FCAT .
  methods CONVERT_DATA_TO_INTERNAL
    changing
      !CS_DATA type ANY optional
      !CT_DATA type TABLE optional .
  methods CONVERT_EXT_INT_OR_INT_EXT
    importing
      value(IV_INPUT) type ANY
      !IV_FLG_INT2EXT type ESEBOOLE optional
    exporting
      value(EV_OUTPUT) type ANY .
  methods GET_SUBMIT_DATA_DIRECTLY
    importing
      !IV_PROGRAM type RS38M-PROGRAMM
      !IT_RSPARAM type PIVB_RSPARAMSL_255_T optional
      !IV_CUSTOM_SUBMIT type FLAG optional
      !IV_CLASS_NAME type SEOCLSNAME optional
    exporting
      !EO_DATA_REF type ref to DATA
      !ET_DATA type TABLE
    raising
      ZBCX_EXCEPTION .
  methods READ_TEXT
    importing
      !IV_ID type THEAD-TDID
      !IV_LANGUAGE type THEAD-TDSPRAS default SY-LANGU
      !IV_NAME type THEAD-TDNAME
      !IV_OBJECT type THEAD-TDOBJECT
    exporting
      !ES_HEADER type THEAD
      !ET_TLINE type TLINE_T
      !ET_TEXT_STREAM type SRT_STRINGS .
  methods READ_DATA_FROM_AL11
    importing
      !IV_FILE type EPS2FILNAM
    returning
      value(RV_XSTR) type XSTRING
    raising
      ZBCX_EXCEPTION .
  methods CONVERT_ITAB_TO_XSTRING
    importing
      !IT_DATA type TABLE optional
      !IR_DATA_REF type ref to DATA optional
    returning
      value(RV_XSTRING) type XSTRING .
  methods READ_SPREADSHEET_DATA
    importing
      !IV_DOCUMENT_NAME type STRING
      !IV_XDOCUMENT type XSTRING
      !IV_MIME_TYPE type STRING optional
      !IR_SHEETNAME type TDT_RG_STRING optional
    exporting
      !EO_XLS type ref to CL_FDT_XL_SPREADSHEET
      !ET_DOCUMENT_DATA type TT_WORKSHEETS
    raising
      ZBCX_EXCEPTION .
protected section.
private section.

  methods _TRY_CONV_INT_EXT_INT
    importing
      !I_FIELDINFO type RSANU_S_FIELDINFO
      value(I_VALUE) type ANY
    exporting
      value(E_VALUE) type ANY
    exceptions
      FAILED_WITH_MESSAGE .
  methods _TRY_CONV_EXT_INT_EXT
    importing
      !I_FIELDINFO type RSANU_S_FIELDINFO
      value(I_VALUE) type ANY
    exporting
      value(E_VALUE) type ANY
    exceptions
      FAILED_WITH_MESSAGE .
  methods _CONVERT_TO_INTERN
    importing
      !I_FIELDINFO type RSANU_S_FIELDINFO
      value(I_EXTERNAL_VALUE) type ANY
    exporting
      value(E_INTERNAL_VALUE) type ANY
    exceptions
      FAILED .
  methods _CONVERT_TO_EXTERN
    importing
      !I_FIELDINFO type RSANU_S_FIELDINFO
      !I_INTERNAL_VALUE type ANY
    exporting
      !E_EXTERNAL_VALUE type ANY .
  methods _NUMBER_CONVERT_TO_INTERN
    importing
      !I_FIELDINFO type RSANU_S_FIELDINFO
      value(I_EXTERNAL_VALUE) type ANY
    exporting
      value(E_INTERNAL_VALUE) type ANY
    exceptions
      FAILED .
  methods _NUMBER_CONVERT_TO_EXTERN
    importing
      !I_FIELDINFO type RSANU_S_FIELDINFO
      value(I_INTERNAL_VALUE) type ANY
    exporting
      value(E_EXTERNAL_VALUE) type ANY
    exceptions
      FAILED .
  methods _CREATE_ANY_OBJECT
    importing
      !IV_CLASS_NAME type SEOCLSNAME
    exporting
      !EV_CLASS_NAME type SEOCLSNAME
    returning
      value(RO_CLASS) type ref to OBJECT .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_UTILS_MODEL IMPLEMENTATION.


  METHOD CONVERT_DATA_TO_INTERNAL.
    DATA: lt_comp TYPE abap_compdescr_tab.
    DATA: ls_data TYPE REF TO data,
          ls_comp LIKE LINE OF lt_comp.
    FIELD-SYMBOLS: <lf_value> TYPE any.

    IF cs_data IS SUPPLIED.
      lt_comp = get_component_of_data( EXPORTING is_data = cs_data ).

      LOOP AT lt_comp INTO ls_comp WHERE type_kind NE cl_abap_datadescr=>typekind_class
                                     AND type_kind NE cl_abap_datadescr=>typekind_struct1
                                     AND type_kind NE cl_abap_datadescr=>typekind_struct2
                                     AND type_kind NE cl_abap_datadescr=>typekind_table
                                     AND type_kind NE cl_abap_datadescr=>typekind_any
                                     AND type_kind NE cl_abap_datadescr=>typekind_dref
                                     AND type_kind NE cl_abap_datadescr=>typekind_oref.
        ASSIGN COMPONENT ls_comp-name OF STRUCTURE cs_data TO <lf_value>.
        IF sy-subrc   EQ 0
       AND <lf_value> IS ASSIGNED
       AND <lf_value> IS NOT INITIAL.
          convert_ext_int_or_int_ext( EXPORTING iv_input  = <lf_value>
                                      IMPORTING ev_output = <lf_value> ).
        ENDIF.
      ENDLOOP.
    ELSEIF ct_data IS SUPPLIED.
      CREATE DATA ls_data LIKE LINE OF ct_data.
      CHECK ls_data IS BOUND.

      ASSIGN ls_data->* TO FIELD-SYMBOL(<lfs_data>).
      CHECK <lfs_data> IS ASSIGNED.

      lt_comp = get_component_of_data( EXPORTING is_data = <lfs_data> ).

      LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<lfs_out>).
        LOOP AT lt_comp INTO ls_comp WHERE type_kind NE cl_abap_datadescr=>typekind_class
                                       AND type_kind NE cl_abap_datadescr=>typekind_struct1
                                       AND type_kind NE cl_abap_datadescr=>typekind_struct2
                                       AND type_kind NE cl_abap_datadescr=>typekind_table
                                       AND type_kind NE cl_abap_datadescr=>typekind_any
                                       AND type_kind NE cl_abap_datadescr=>typekind_dref
                                       AND type_kind NE cl_abap_datadescr=>typekind_oref.
          ASSIGN COMPONENT ls_comp-name OF STRUCTURE <lfs_out> TO <lf_value>.
          IF sy-subrc   EQ 0
         AND <lf_value> IS ASSIGNED
         AND <lf_value> IS NOT INITIAL.
            convert_ext_int_or_int_ext( EXPORTING iv_input  = <lf_value>
                                        IMPORTING ev_output = <lf_value> ).
          ENDIF.
        ENDLOOP.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD CONVERT_EXT_INT_OR_INT_EXT.
    DATA: lo_elem      TYPE REF TO cl_abap_elemdescr,
          lo_type      TYPE REF TO cl_abap_typedescr,
          ls_fieldinfo TYPE rsanu_s_fieldinfo.

    "Set initial output value to input value. This allows to exit in failure conditions.
    IF iv_input IS INITIAL.
      ev_output = iv_input.
      RETURN.
    ENDIF.

    ev_output = iv_input.

    lo_elem ?= cl_abap_elemdescr=>describe_by_data( iv_input ).

    "If the data has no DDIC structure, exit
    IF lo_elem->is_ddic_type( ) <> abap_true.
      RETURN.
    ENDIF.

    DATA(ls_dfies) = lo_elem->get_ddic_field( sy-langu ).

    "If DDIC structure has no conversion exit, exit.
    IF ls_dfies-convexit IS INITIAL.
      RETURN.
    ENDIF.

    "If alpha just convert right away and return
    IF ls_dfies-convexit = 'ALPHA'.
      IF iv_flg_int2ext IS INITIAL.
        ev_output = |{ iv_input ALPHA = IN }|.
      ELSE.
        ev_output = |{ iv_input ALPHA = OUT }|.
      ENDIF.
      RETURN.
    ENDIF.

    MOVE-CORRESPONDING ls_dfies TO ls_fieldinfo.

    TRY.
        IF iv_flg_int2ext IS INITIAL.
          CALL METHOD _try_conv_int_ext_int
            EXPORTING
              i_fieldinfo         = ls_fieldinfo
              i_value             = iv_input
            IMPORTING
              e_value             = ev_output
            EXCEPTIONS
              failed_with_message = 1
              OTHERS              = 99.
        ELSE.
          CALL METHOD _try_conv_ext_int_ext
            EXPORTING
              i_fieldinfo         = ls_fieldinfo
              i_value             = iv_input
            IMPORTING
              e_value             = ev_output
            EXCEPTIONS
              failed_with_message = 1
              OTHERS              = 99.
        ENDIF.
      CATCH cx_root INTO DATA(lv_exc).
        CLEAR ev_output.
        RETURN.
    ENDTRY.
  ENDMETHOD.


  METHOD CONVERT_ITAB_TO_XSTRING.
    DATA: lr_data_ref TYPE REF TO data.
    FIELD-SYMBOLS: <fs_data> TYPE ANY TABLE.

    IF it_data IS SUPPLIED.
      CREATE DATA lr_data_ref LIKE it_data.
    ELSEIF ir_data_ref IS SUPPLIED.
      lr_data_ref = ir_data_ref.
    ELSE.
      RETURN.
    ENDIF.

    CHECK lr_data_ref IS BOUND.

    ASSIGN ir_data_ref->* TO <fs_data>.

    TRY.
        cl_salv_table=>factory(
          IMPORTING r_salv_table = DATA(lo_table)
          CHANGING  t_table      = <fs_data> ).

        DATA(lt_fcat) =
          cl_salv_controller_metadata=>get_lvc_fieldcatalog(
            r_columns      = lo_table->get_columns( )
            r_aggregations = lo_table->get_aggregations( ) ).

        DATA(lo_result) =
          cl_salv_ex_util=>factory_result_data_table(
            r_data         = ir_data_ref
            t_fieldcatalog = lt_fcat ).

        cl_salv_bs_tt_util=>if_salv_bs_tt_util~transform(
          EXPORTING
            xml_type      = if_salv_bs_xml=>c_type_xlsx
            xml_version   = cl_salv_bs_a_xml_base=>get_version( )
            r_result_data = lo_result
            xml_flavour   = if_salv_bs_c_tt=>c_tt_xml_flavour_export
            gui_type      = if_salv_bs_xml=>c_gui_type_gui
          IMPORTING
            xml           = rv_xstring ).
      CATCH cx_root.
        CLEAR rv_xstring.
    ENDTRY.
  ENDMETHOD.


  METHOD GET_COMPONENT_OF_DATA.
    DATA: lo_stru TYPE REF TO cl_abap_structdescr,
          lo_data TYPE REF TO data,
          lo_dref TYPE REF TO data.
    DATA: lt_comp TYPE STANDARD TABLE OF abap_componentdescr.
    FIELD-SYMBOLS <table> TYPE ANY TABLE.

    IF is_data IS SUPPLIED.
      lo_stru ?= cl_abap_typedescr=>describe_by_data( is_data ).
    ELSEIF it_data IS SUPPLIED.
      CREATE DATA lo_data LIKE LINE OF it_data.
      IF lo_data IS BOUND.
        ASSIGN lo_data->* TO FIELD-SYMBOL(<lfs_data>).
        CHECK <lfs_data> IS ASSIGNED.
        lo_stru ?= cl_abap_typedescr=>describe_by_data( <lfs_data> ).
      ENDIF.
    ELSE.
      RETURN.
    ENDIF.

    CHECK lo_stru IS BOUND.

    DATA(table_desc) = cl_abap_tabledescr=>create( p_line_type  = CAST #( lo_stru )
                                                   p_table_kind = cl_abap_tabledescr=>tablekind_std
                                                   p_unique     = abap_false ).
    CHECK table_desc IS BOUND.

    CREATE DATA lo_dref TYPE HANDLE table_desc.
    CHECK lo_dref IS BOUND.

    ASSIGN lo_dref->* TO <table>.

    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table = DATA(salv_table)
                                CHANGING  t_table      = <table> ).

        DATA(lt_fcat) = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
            r_columns      = salv_table->get_columns( )         " ALV Filter
            r_aggregations = salv_table->get_aggregations( ) ). " ALV Aggregations

        DELETE lt_fcat WHERE fieldname EQ 'ALV_CELLSTYL'
                          OR fieldname EQ 'ALV_CELLTYPE'
                          OR fieldname EQ 'ALV_S_COLOR'
                          OR fieldname EQ 'ALV_C_COLOR'.

        IF iv_no_client IS NOT INITIAL.
          DELETE lt_fcat WHERE datatype EQ 'CLNT'.
        ENDIF.

        rt_component = lt_fcat.
      CATCH cx_root.
    ENDTRY.
  ENDMETHOD.


  METHOD get_selectoptions_from_sscr.
    zcl_mvcfw_base_sscr=>get_selectoptions( EXPORTING iv_repid           = iv_repid
                                            IMPORTING et_selopt_tab      = et_selopt_tab
                                                      et_selopt_tab_long = et_selopt_tab_long ).
  ENDMETHOD.


  METHOD get_submit_data_directly.
    DATA lo_data TYPE REF TO data.
    DATA lo_class TYPE REF TO object.

    IF iv_program IS INITIAL.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = 'Program is not found'.
    ENDIF.

    cl_salv_bs_runtime_info=>set( EXPORTING display  = space
                                            metadata = space
                                            data     = abap_true ).

    IF iv_custom_submit IS NOT INITIAL.
      lo_class ?= _create_any_object( iv_class_name ).
      IF lo_class IS BOUND.
        TRY.
            DATA(lt_tab) = VALUE abap_parmbind_tab( ( name  = 'IV_PROGRAM'
                                                      kind  = cl_abap_objectdescr=>exporting
                                                      value = REF #( iv_program ) ) ).
            CALL METHOD lo_class->('SUBMIT_PROGRAM')
              PARAMETER-TABLE lt_tab.
          CATCH cx_sy_dyn_call_error.
            TRY.
                CALL METHOD lo_class->('SUBMIT_PROGRAM').
              CATCH cx_sy_dyn_call_error.
            ENDTRY.
        ENDTRY.
      ENDIF.
    ELSEIF it_rsparam IS NOT INITIAL.
      SUBMIT (iv_program) AND RETURN
                          WITH SELECTION-TABLE it_rsparam.
    ELSE.
      SUBMIT (iv_program) AND RETURN.
    ENDIF.

    TRY.
        " get data from SALV model
        cl_salv_bs_runtime_info=>get_data_ref( IMPORTING r_data = eo_data_ref ).
        IF eo_data_ref IS BOUND
       AND et_data     IS SUPPLIED.
          CREATE DATA lo_data LIKE et_data.
          IF lo_data IS BOUND.
            ASSIGN lo_data->* TO FIELD-SYMBOL(<lft_tab>).
            IF sy-subrc EQ 0 AND <lft_tab> IS ASSIGNED.
              et_data = CORRESPONDING #( DEEP <lft_tab> ).
            ENDIF.
          ENDIF.
        ENDIF.

        cl_salv_bs_runtime_info=>clear_all( ).
      CATCH cx_salv_bs_sc_runtime_info INTO DATA(lo_exct).
        cl_salv_bs_runtime_info=>clear_all( ).

        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = CONV #( lo_exct->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD READ_DATA_FROM_AL11.
    DATA lv_error TYPE flag.

    CLEAR rv_xstr.

    OPEN DATASET iv_file FOR INPUT IN BINARY MODE.
    IF sy-subrc EQ 0.
      READ DATASET iv_file INTO rv_xstr.
      IF sy-subrc NE 0.
        lv_error = abap_true.
      ENDIF.
    ELSE.
      lv_error = abap_true.
    ENDIF.
    CLOSE DATASET iv_file.

    IF lv_error IS NOT INITIAL.
      CLEAR rv_xstr.

      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          msgv1 = CONV #( iv_file )
          msgv2 = 'was not found'.
    ENDIF.
  ENDMETHOD.


  METHOD READ_SPREADSHEET_DATA.
    DATA: ls_document_data LIKE LINE OF et_document_data.

    TRY.
        CLEAR: eo_xls, et_document_data.

        "Create object for cl_fdt_xl_spreadsheet
        DATA(lo_xls) = NEW cl_fdt_xl_spreadsheet( document_name = iv_document_name
                                                  xdocument     = iv_xdocument ).
        CHECK lo_xls IS BOUND.

        IF eo_xls IS SUPPLIED.
          eo_xls = lo_xls.
        ENDIF.

        IF et_document_data IS SUPPLIED.
          "Get work sheets
          lo_xls->if_fdt_doc_spreadsheet~get_worksheet_names( IMPORTING worksheet_names = DATA(lt_sheets) ).

          IF ir_sheetname IS NOT INITIAL.
            DELETE lt_sheets WHERE NOT table_line IN ir_sheetname.
          ENDIF.

          "Loop at sheets & get data using a method from the class
          LOOP AT lt_sheets INTO DATA(ls_sheet).
            CLEAR ls_document_data.

            ls_document_data-sheet_name = ls_sheet.
            ls_document_data-data_ref   = lo_xls->if_fdt_doc_spreadsheet~get_itab_from_worksheet( ls_sheet ).
            APPEND ls_document_data TO et_document_data.
          ENDLOOP.
        ENDIF.
      CATCH cx_fdt_excel_core INTO DATA(lo_excpt).
        RAISE EXCEPTION TYPE zbcx_exception
          EXPORTING
            msgv1 = CONV #( lo_excpt->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD READ_TEXT.
    DATA: lt_tline  TYPE tline_t,
          lt_stream TYPE dba_dbcon_rawdata,
          lt_string TYPE srt_strings.
    DATA: lv_split TYPE char02.

    CALL FUNCTION 'READ_TEXT'
      EXPORTING
        client                  = sy-mandt
        id                      = iv_id
        language                = iv_language
        name                    = iv_name
        object                  = iv_object
      IMPORTING
        header                  = es_header
      TABLES
        lines                   = lt_tline
      EXCEPTIONS
        id                      = 1
        language                = 2
        name                    = 3
        not_found               = 4
        object                  = 5
        reference_check         = 6
        wrong_access_to_archive = 7
        OTHERS                  = 8.
    IF lt_tline[] IS NOT INITIAL.
      CALL FUNCTION 'CONVERT_ITF_TO_STREAM_TEXT'
        EXPORTING
          language    = iv_language
        TABLES
          itf_text    = lt_tline
          text_stream = lt_stream.

      CALL FUNCTION 'CONVERT_STREAM_TO_ITF_TEXT'
        EXPORTING
          language    = iv_language
        TABLES
          text_stream = lt_stream
          itf_text    = et_tline.

      IF et_text_stream IS SUPPLIED.
        lv_split+0(1) = cl_abap_char_utilities=>cr_lf.
        lv_split+1(1) = cl_abap_char_utilities=>newline.

        LOOP AT lt_stream INTO DATA(ls_stream) WHERE table_line IS NOT INITIAL.
          CLEAR lt_string.

          SPLIT ls_stream AT lv_split INTO TABLE lt_string.

          IF lt_string IS NOT INITIAL.
            APPEND LINES OF lt_string TO et_text_stream.
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD _CONVERT_TO_EXTERN.
    IF i_fieldinfo IS INITIAL.
* MESSAGE e003 RAISING failed.
* in case of unknown field info -> just try simple move logic - don't catch some exceptions when moving !
      e_external_value = i_internal_value.
      EXIT.
    ENDIF.

    CLEAR e_external_value.

    CASE i_fieldinfo-inttype.                           "#EC CI_INT8_OK

      WHEN 'F' OR 'P' OR 'I'.
*       Numeric field
        TRY.
            CALL METHOD _number_convert_to_extern
              EXPORTING
                i_fieldinfo      = i_fieldinfo
                i_internal_value = i_internal_value
              IMPORTING
                e_external_value = e_external_value
              EXCEPTIONS
                failed           = 1.
            IF sy-subrc <> 0.
              e_external_value = i_internal_value.
*            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                       WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
*            RAISING failed.
            ELSE.
*         when moving field type P,I,F to character field -> it's right justified - so condense it
              CONDENSE e_external_value.
            ENDIF.
*
          CATCH cx_sy_conversion_error.
            e_external_value = i_internal_value.
*          MESSAGE e002(rsan_ut) RAISING failed.
          CATCH cx_root.
            e_external_value = i_internal_value.
*          MESSAGE e002(rsan_ut) RAISING failed.
        ENDTRY.

      WHEN 'X'.
*       raw field

*     XSTRING and others raw fields
*     -> correct internal representation is same as external representation - just move value
*      TRY.
*
        e_external_value = i_internal_value.
*
*        CATCH cx_sy_conversion_error.
*          MESSAGE e002(rsan_ut) RAISING failed.
*      ENDTRY.

      WHEN OTHERS.
*       other fields (character like)
        DATA l_value_in  TYPE rsanu_t_fieldvalue.
        DATA l_value_out TYPE rsanu_t_fieldvalue.

        l_value_in = i_internal_value.

* rc - comment:
* special case for DATE - 00-00-0000 is invalid date but is also internal value of initial
* other types as TIME, NUMC ... internal initial value is valid external value
        DATA l_date TYPE d.

        IF     l_value_in IS INITIAL
           OR  ( i_fieldinfo-inttype = 'D' AND l_value_in = l_date ).

*     BW conversion of initial value for character like fields
          e_external_value = '#'.                           "#EC NOTEXT
        ELSE.
*     normal conversion
          TRY.

*        clear system message number to be able to identify if exception from following call was raised with message
*        to be able to provide message text
              CLEAR sy-msgno.

              CALL FUNCTION 'G_CONVERT_OUTPUT'
                EXPORTING
                  convexit          = i_fieldinfo-convexit
                  datatype          = i_fieldinfo-datatype
                  length_to_convert = i_fieldinfo-length
                  output_length     = i_fieldinfo-outputlen
                  value_to_convert  = l_value_in
                IMPORTING
                  output_value      = l_value_out
                EXCEPTIONS
                  error_message     = 1
                  OTHERS            = 2.                      "#EC *

              IF sy-subrc NE 0 AND sy-msgno IS NOT INITIAL.
*         exception raised with message -> propagate original message rather then the general one
                sy-subrc = 1.
              ENDIF.

            CATCH cx_sy_conversion_error.
              sy-subrc = 2.
          ENDTRY.

          CASE sy-subrc.
            WHEN 0.
*            all ok
              e_external_value = l_value_out.
            WHEN 1.
*            error message thrown by conversion function module -> rethrow the message
              e_external_value = i_internal_value.
*            MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*                       WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
*            RAISING failed.
            WHEN OTHERS.
*            some exception occured - throw general error message
              e_external_value = i_internal_value.
*            MESSAGE e002(rsan_ut) RAISING failed.
          ENDCASE.
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD _CONVERT_TO_INTERN.
    IF i_fieldinfo IS INITIAL.
* MESSAGE e003 RAISING failed.
* in case of unknown field info -> just try simple move logic - don't catch some exceptions when moving !
      e_internal_value = i_external_value.
      EXIT.
    ENDIF.

    CLEAR e_internal_value.

    CASE i_fieldinfo-inttype.                           "#EC CI_INT8_OK

      WHEN 'F' OR 'P' OR 'I'.
*       numeric field
        TRY.
            CALL METHOD _number_convert_to_intern
              EXPORTING
                i_fieldinfo      = i_fieldinfo
                i_external_value = i_external_value
              IMPORTING
                e_internal_value = e_internal_value
              EXCEPTIONS
                failed           = 1.
            IF sy-subrc <> 0.
              CLEAR e_internal_value.
              MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                         WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
              RAISING failed.
            ENDIF.

*         when moving field type F,P,I to character field -> it's right justified - so condense it
*            CONDENSE e_internal_value.

          CATCH cx_sy_conversion_error.
            CLEAR e_internal_value.
            MESSAGE e002(rsan_ut) RAISING failed.
          CATCH cx_root.
            CLEAR e_internal_value.
            MESSAGE e002(rsan_ut) RAISING failed.
        ENDTRY.

      WHEN 'X'.
*       raw field

* convert to uppercase
        TRANSLATE i_external_value TO UPPER CASE.

        DATA l_x_field TYPE x LENGTH 255.

        TRY.

            l_x_field(i_fieldinfo-length) = i_external_value.
            e_internal_value = l_x_field(i_fieldinfo-length).

          CATCH cx_sy_conversion_error.
            CLEAR e_internal_value.
            MESSAGE e002(rsan_ut) RAISING failed.
        ENDTRY.

      WHEN OTHERS.
*         other fields (character like)
        DATA l_value_in  TYPE rsanu_t_fieldvalue.
        DATA l_value_out TYPE rsanu_t_fieldvalue.

        l_value_in = i_external_value.

        IF l_value_in = '#'.                                "#EC NOTEXT

*   BW conversion of '#' to initial value for character like fields

          CASE i_fieldinfo-inttype.
            WHEN 'D'.
*          initial date
              TRY.
                  DATA l_date TYPE d.
                  e_internal_value = l_date.

                CATCH cx_sy_conversion_error.
                  CLEAR e_internal_value.
                  MESSAGE e002(rsan_ut) RAISING failed.
              ENDTRY.

            WHEN 'T'.
*          initial time
              TRY.
                  DATA l_time TYPE t.
                  e_internal_value = l_time.

                CATCH cx_sy_conversion_error.
                  CLEAR e_internal_value.
                  MESSAGE e002(rsan_ut) RAISING failed.
              ENDTRY.

            WHEN 'N'.
*             initial NUMC field
              TRY.
                  DATA l_numc TYPE n LENGTH 255.
                  e_internal_value = l_numc(i_fieldinfo-length).

                CATCH cx_sy_conversion_error.
                  CLEAR e_internal_value.
                  MESSAGE e002(rsan_ut) RAISING failed.
              ENDTRY.

            WHEN OTHERS.
              CLEAR e_internal_value.
          ENDCASE.

        ELSE.
*   normal conversion
          TRY.

*        clear ssytem message number to be able to identify if exception from following call was raised with message
*        to be able to provide message text
              CLEAR sy-msgno.

              CALL FUNCTION 'G_CONVERT_INPUT'
                EXPORTING
                  converted_length = i_fieldinfo-length
                  convexit         = i_fieldinfo-convexit
                  datatype         = i_fieldinfo-datatype
                  input_length     = i_fieldinfo-outputlen
                  input_value      = l_value_in
                IMPORTING
                  converted_value  = l_value_out
                EXCEPTIONS
                  error_message    = 1
                  OTHERS           = 2.                       "#EC *

              IF sy-subrc NE 0 AND sy-msgno IS NOT INITIAL.
*         exception raised with message -> propagate original message rather then the general one
                sy-subrc = 1.
              ENDIF.

            CATCH cx_sy_conversion_error.
              sy-subrc = 2.
          ENDTRY.

          CASE sy-subrc.
            WHEN 0.
*            all ok
              e_internal_value = l_value_out.

            WHEN 1.
*            error message thrown by conversion function module -> rethrow the message
              CLEAR e_internal_value.
              MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                         WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
              RAISING failed.
            WHEN OTHERS.
*            some exception occured - throw general error message
              CLEAR e_internal_value.
              MESSAGE e002(rsan_ut) RAISING failed.
          ENDCASE.

*   convert to uppercase if necessary
          IF i_fieldinfo-lowercase IS INITIAL
             AND i_fieldinfo-datatype EQ 'CHAR'.
            TRANSLATE e_internal_value TO UPPER CASE.
          ENDIF.
        ENDIF.
    ENDCASE.
  ENDMETHOD.


  METHOD _create_any_object.
    DATA: lv_object     TYPE string,
          lv_class_name TYPE string.

    lv_class_name = |{ iv_class_name CASE = UPPER }|.
    lv_object     = |\\PROGRAM={ sy-cprog }\\CLASS={ lv_class_name }|.

    TRY.
        CREATE OBJECT ro_class TYPE (lv_object).
        ev_class_name = lv_class_name.
      CATCH cx_sy_create_object_error.
    ENDTRY.
  ENDMETHOD.


  METHOD _NUMBER_CONVERT_TO_EXTERN.
    DATA: p(16)  TYPE p DECIMALS 6.
    DATA l_value TYPE rsanu_t_fieldvalue.

    CLEAR e_external_value.

    TRY.
        CASE i_fieldinfo-inttype.                       "#EC CI_INT8_OK
          WHEN 'P'.
            p = i_internal_value.
          WHEN 'F' OR 'I'.
            DATA: f TYPE f.
            f = i_internal_value.
            p = f.
          WHEN OTHERS.
            MESSAGE x001(rsan_ut) WITH 'INT_EXT_TYPE_INVALID' '' '' ''.
        ENDCASE.

        WRITE p TO l_value(i_fieldinfo-outputlen)
              DECIMALS i_fieldinfo-decimals.
*        write p to e_external_number using edit mask i_fieldinfo-edit_mask.

      CATCH cx_sy_conversion_error.
        sy-subrc = 1.
    ENDTRY.

    IF sy-subrc NE 0.
      MESSAGE e002(rsan_ut) RAISING failed.
    ENDIF.

    e_external_value = l_value.
  ENDMETHOD.


  METHOD _NUMBER_CONVERT_TO_INTERN.
    DATA: f TYPE float.
    DATA: i TYPE i.
    DATA: p TYPE p LENGTH 16.
    DATA: dec_int(4) TYPE p DECIMALS 1 VALUE '0.5'.
    DATA: dec_ext(4) TYPE c.
    DATA: char40(40) TYPE c.
    FIELD-SYMBOLS: <p> TYPE p.

    CLEAR e_internal_value.

* (1) format "1.000.000,00" => remove points, replace comma with point
* (2) format "1,000,000.00" => remove commas
    WRITE dec_int TO dec_ext.
    IF dec_ext CA ','.
      TRANSLATE i_external_value USING '+ . '.
      TRANSLATE i_external_value USING ',.'.
    ELSE.
      TRANSLATE i_external_value USING '+ , '.
    ENDIF.
    CONDENSE i_external_value NO-GAPS.

* Move to output field through a correctly typed field
    TRY.
        CASE i_fieldinfo-inttype.                       "#EC CI_INT8_OK
          WHEN 'P'.
            ASSIGN p TO <p> CASTING DECIMALS i_fieldinfo-decimals.
            <p> = i_external_value.
*         check max. length
            WRITE <p> TO char40(i_fieldinfo-outputlen).
            IF char40 CA '*'.
              MESSAGE e002(rsan_ut) RAISING failed.
            ENDIF.
            e_internal_value = <p>.
          WHEN 'F'.
            f = i_external_value.
            e_internal_value = f.
          WHEN 'I'.
            i = i_external_value.
            e_internal_value = i.
          WHEN OTHERS.
            MESSAGE x001(rsan_ut) WITH 'EXT_INT_TYPE_INVALID' '' '' ''.
        ENDCASE.

      CATCH cx_sy_conversion_error.
        MESSAGE e002(rsan_ut) RAISING failed.
    ENDTRY.
  ENDMETHOD.


  METHOD _TRY_CONV_EXT_INT_EXT.
    FIELD-SYMBOLS: <ls_in_value>  TYPE any.
    FIELD-SYMBOLS: <ls_out_value> TYPE any.

    DATA l_value TYPE rsanu_t_fieldvalue.

    ASSIGN i_value TO <ls_in_value>.
    ASSIGN e_value TO <ls_out_value>.

    CALL METHOD _convert_to_intern
      EXPORTING
        i_fieldinfo      = i_fieldinfo
        i_external_value = i_value
      IMPORTING
        e_internal_value = l_value
      EXCEPTIONS
        failed           = 1.

    IF sy-subrc NE 0.
* return empty value
      CLEAR e_value.

* if requested -> propagate error with given type to caller
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                 RAISING failed_with_message.
    ELSE.
      CALL METHOD _convert_to_extern
        EXPORTING
          i_fieldinfo      = i_fieldinfo
          i_internal_value = l_value
        IMPORTING
          e_external_value = e_value.
    ENDIF.
  ENDMETHOD.


  METHOD _TRY_CONV_INT_EXT_INT.
    FIELD-SYMBOLS: <ls_in_value>  TYPE any.
    FIELD-SYMBOLS: <ls_out_value> TYPE any.

    DATA l_value TYPE rsanu_t_fieldvalue.

    ASSIGN i_value TO <ls_in_value>.
    ASSIGN e_value TO <ls_out_value>.

    CALL METHOD _convert_to_extern
      EXPORTING
        i_fieldinfo      = i_fieldinfo
        i_internal_value = i_value
      IMPORTING
        e_external_value = l_value.

    CALL METHOD _convert_to_intern
      EXPORTING
        i_fieldinfo      = i_fieldinfo
        i_external_value = l_value
      IMPORTING
        e_internal_value = e_value
      EXCEPTIONS
        failed           = 1.

    IF sy-subrc NE 0.
* return original value as output value
      <ls_out_value> = <ls_in_value>.

* if requested -> propagate error with given type to caller
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
                 RAISING failed_with_message.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
