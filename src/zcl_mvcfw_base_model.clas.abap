CLASS zcl_mvcfw_base_model DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_incl_outtab_ext,
        alv_traff   TYPE bkk_lightcode,  "1=Red, 2=Yellow, 3=Green
        alv_celltab TYPE lvc_t_styl,     "Style Table for Cells
        alv_s_color TYPE char04,         "Simple row color coding
        alv_c_color TYPE lvc_t_scol,     "Complex cell color coding
      END OF ty_incl_outtab_ext .

    CONSTANTS:
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
    CONSTANTS mc_stack_main TYPE dfies-tabname VALUE 'MAIN' ##NO_TEXT.
    CONSTANTS mc_deflt_outtab TYPE dfies-tabname VALUE 'MT_OUTTAB' ##NO_TEXT.
    CONSTANTS mc_deflt_model TYPE seoclsname VALUE 'LCL_MODEL' ##NO_TEXT.
    CONSTANTS mc_style_enabled TYPE raw4 VALUE cl_gui_alv_grid=>mc_style_enabled ##NO_TEXT.
    CONSTANTS mc_style_disabled TYPE raw4 VALUE cl_gui_alv_grid=>mc_style_disabled ##NO_TEXT.
    DATA mt_selopt_t TYPE rsparams_tt .
    DATA mt_selopt_t_long TYPE fmrpf_rsparamsl_255_t .
    CONSTANTS mc_expand_icon TYPE salv_de_tree_image VALUE '@FO@' ##NO_TEXT.
    CONSTANTS mc_collapse_icon TYPE salv_de_tree_image VALUE '@FN@' ##NO_TEXT.
    DATA ms_action TYPE zcl_mvcfw_base_controller=>ty_view_action .

    METHODS constructor .
    METHODS select_data
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_model
      RAISING
        zbcx_exception .
    METHODS process_data
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_model
      RAISING
        zbcx_exception .
    METHODS get_outtab
      IMPORTING
        !iv_stack_name TYPE dfies-tabname OPTIONAL
      RETURNING
        VALUE(ro_data) TYPE REF TO data .
    METHODS set_outtab
      IMPORTING
        !iv_stack_name TYPE dfies-tabname OPTIONAL
        !it_data       TYPE table .
    METHODS set_editable_cell
      IMPORTING
        !iv_fname       TYPE lvc_fname
        !iv_disabled    TYPE abap_bool DEFAULT abap_true
      CHANGING
        !ct_style       TYPE lvc_t_styl
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_model .
    METHODS set_style_cell
      IMPORTING
        !iv_fname       TYPE lvc_fname
        !iv_style       TYPE lvc_s_styl-style OPTIONAL
        !iv_style2      TYPE lvc_s_styl-style2 OPTIONAL
        !iv_style3      TYPE lvc_s_styl-style3 OPTIONAL
        !iv_style4      TYPE lvc_s_styl-style4 OPTIONAL
      CHANGING
        !ct_style       TYPE lvc_t_styl
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_model .
    METHODS set_color_cell
      IMPORTING
        !iv_fname       TYPE lvc_fname
        !is_color       TYPE lvc_s_colo OPTIONAL
        !iv_color       TYPE char04 OPTIONAL
        !iv_nokeycol    TYPE lvc_nokeyc OPTIONAL
      CHANGING
        !ct_color       TYPE lvc_t_scol
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_model .
    METHODS set_color_all_cells
      IMPORTING
        !is_data        TYPE any
        !is_color       TYPE lvc_s_colo OPTIONAL
        !iv_color       TYPE char04 OPTIONAL
        !iv_nokeycol    TYPE lvc_nokeyc OPTIONAL
      CHANGING
        !ct_color       TYPE lvc_t_scol
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_model .
    METHODS set_stack_name
      IMPORTING
        !iv_stack_name  TYPE dfies-tabname DEFAULT mc_stack_main
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_model .
    METHODS get_selectoptions_from_sscr
      IMPORTING
        !iv_repid           TYPE sy-cprog DEFAULT sy-cprog
      EXPORTING
        !et_selopt_tab      TYPE rsparams_tt
        !et_selopt_tab_long TYPE fmrpf_rsparamsl_255_t
      RETURNING
        VALUE(ro_model)     TYPE REF TO zcl_mvcfw_base_model .
    METHODS get_component_of_data
      IMPORTING
        !is_data            TYPE any OPTIONAL
        !it_data            TYPE table OPTIONAL
        !iv_no_client       TYPE flag DEFAULT abap_true
      RETURNING
        VALUE(rt_component) TYPE lvc_t_fcat .
    METHODS convert_data_to_internal
      CHANGING
        !cs_data        TYPE any OPTIONAL
        !ct_data        TYPE table OPTIONAL
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_model .
    METHODS convert_ext_int_or_int_ext
      IMPORTING
        VALUE(iv_input)  TYPE any
        !iv_flg_int2ext  TYPE eseboole OPTIONAL
      EXPORTING
        VALUE(ev_output) TYPE any .
    METHODS build_salv_tree_node
      IMPORTING
        !io_view TYPE REF TO zcl_mvcfw_base_lvc_view
      CHANGING
        !ct_data TYPE STANDARD TABLE OPTIONAL .
    CLASS-METHODS get_submit_data_directly
      IMPORTING
        !iv_program        TYPE rs38m-programm
        !it_rsparam        TYPE pivb_rsparamsl_255_t OPTIONAL
        !iv_custom_submit  TYPE flag OPTIONAL
      EXPORTING
        VALUE(eo_data_ref) TYPE REF TO data
        VALUE(et_data)     TYPE table
      RAISING
        zbcx_exception .
    CLASS-METHODS submit_program
      IMPORTING
        !iv_program TYPE rs38m-programm OPTIONAL .
    METHODS get_controller_action
      IMPORTING
        !is_action      TYPE zcl_mvcfw_base_controller=>ty_view_action
      RETURNING
        VALUE(ro_model) TYPE REF TO zcl_mvcfw_base_model .
    CLASS-METHODS read_text
      IMPORTING
        !iv_id          TYPE thead-tdid
        !iv_language    TYPE thead-tdspras DEFAULT sy-langu
        !iv_name        TYPE thead-tdname
        !iv_object      TYPE thead-tdobject
      EXPORTING
        !es_header      TYPE thead
        !et_tline       TYPE tline_t
        !et_text_stream TYPE srt_strings .
  PROTECTED SECTION.

    METHODS _get_current_stack
      RETURNING
        VALUE(re_current_stack) TYPE dfies-tabname .
  PRIVATE SECTION.

    DATA lmv_current_stack TYPE dfies-tabname .

    METHODS _try_conv_int_ext_int
      IMPORTING
        !i_fieldinfo   TYPE rsanu_s_fieldinfo
        VALUE(i_value) TYPE any
      EXPORTING
        VALUE(e_value) TYPE any
      EXCEPTIONS
        failed_with_message .
    METHODS _try_conv_ext_int_ext
      IMPORTING
        !i_fieldinfo   TYPE rsanu_s_fieldinfo
        VALUE(i_value) TYPE any
      EXPORTING
        VALUE(e_value) TYPE any
      EXCEPTIONS
        failed_with_message .
    METHODS _convert_to_intern
      IMPORTING
        !i_fieldinfo            TYPE rsanu_s_fieldinfo
        VALUE(i_external_value) TYPE any
      EXPORTING
        VALUE(e_internal_value) TYPE any
      EXCEPTIONS
        failed .
    METHODS _convert_to_extern
      IMPORTING
        !i_fieldinfo      TYPE rsanu_s_fieldinfo
        !i_internal_value TYPE any
      EXPORTING
        !e_external_value TYPE any .
    METHODS _number_convert_to_intern
      IMPORTING
        !i_fieldinfo            TYPE rsanu_s_fieldinfo
        VALUE(i_external_value) TYPE any
      EXPORTING
        VALUE(e_internal_value) TYPE any
      EXCEPTIONS
        failed .
    METHODS _number_convert_to_extern
      IMPORTING
        !i_fieldinfo            TYPE rsanu_s_fieldinfo
        VALUE(i_internal_value) TYPE any
      EXPORTING
        VALUE(e_external_value) TYPE any
      EXCEPTIONS
        failed .
ENDCLASS.



CLASS ZCL_MVCFW_BASE_MODEL IMPLEMENTATION.


  METHOD build_salv_tree_node.
*--------------------------------------------------------------------*
* Sample code
*--------------------------------------------------------------------*
* Row Style
*   IF_SALV_C_TREE_STYLE=>DEFAULT
*   IF_SALV_C_TREE_STYLE=>INHERITED
*   IF_SALV_C_TREE_STYLE=>INTENSIFIED
*   IF_SALV_C_TREE_STYLE=>INACTIVE
*   IF_SALV_C_TREE_STYLE=>INTENSIFIED_CRITICAL
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_NEGATIVE
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_POSITIVE
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_POSITIVE
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_A
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_B
*   IF_SALV_C_TREE_STYLE=>EMPHASIZED_C
*--------------------------------------------------------------------*
**    DATA: lo_out  TYPE REF TO tty_outtab,
**          lo_node	TYPE REF TO	cl_salv_node,
**          lo_item TYPE REF TO cl_salv_item.
**    FIELD-SYMBOLS: <lft_out> TYPE STANDARD TABLE,
**                   <lfs_out> TYPE any,
**                   <lf_val>  TYPE any.
**
**
**    lo_out = REF #( ct_data ).
**
**    LOOP AT lo_out->* REFERENCE INTO DATA(lr_out) GROUP BY ( carrid = lr_out->carrid )
**                                                  ASCENDING REFERENCE INTO DATA(lrg_carrid).
**      LOOP AT GROUP lrg_carrid REFERENCE INTO DATA(lrs_carrid). EXIT. ENDLOOP.
**
**      "Build Parent --> Carrid
**      CALL METHOD io_view->add_salv_tree_node
**        EXPORTING
**          iv_related_node = space
***         iv_relationship = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
**          is_data_row     = lrs_carrid->*
***         iv_collapsed_icon = MC_COLLAPSE_ICON
***         iv_expanded_icon  = MC_EXPAND_ICON
***         iv_row_style    = IF_SALV_C_TREE_STYLE=>DEFAULT
**          iv_text         = lrs_carrid->carrid
***         iv_visible      = ABAP_TRUE
***         iv_expander     =
***         iv_enabled      = ABAP_TRUE
***         iv_folder       =
**          io_tree         = io_view->get_salv_tree_instance( )
**        IMPORTING
**          ev_last_key     = DATA(lv_carrid_key)
**        RECEIVING
**          ro_node         = lo_node.
**
***  ... §0.2 if information should be displayed at
***    the hierarchy column set the carrid as text for this nod
***      lo_node->set_text( CONV #( lrs_carrid->carrid ) ).
**
***  ... §0.3 set the data for the nes node
***      lo_node->set_data_row( p_ls_data ).
**
**      LOOP AT GROUP lrg_carrid REFERENCE INTO lrs_carrid GROUP BY ( connid = lrs_carrid->connid )
**                                                         ASCENDING REFERENCE INTO DATA(lrg_connid).
**        LOOP AT GROUP lrg_connid REFERENCE INTO DATA(lrs_connid). EXIT. ENDLOOP.
**
**        "Build Sub Parent --> Connid
**        CALL METHOD io_view->add_salv_tree_node
**          EXPORTING
**            iv_related_node = lv_carrid_key
***           iv_relationship = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
**            is_data_row     = lrs_connid->*
***           iv_collapsed_icon = MC_COLLAPSE_ICON
***           iv_expanded_icon  = MC_EXPAND_ICON
***           iv_row_style    = IF_SALV_C_TREE_STYLE=>DEFAULT
**            iv_text         = lrs_connid->connid
***           iv_visible      = ABAP_TRUE
***           iv_expander     =
***           iv_enabled      = ABAP_TRUE
***           iv_folder       =
**            io_tree         = io_view->get_salv_tree_instance( )
**          IMPORTING
**            ev_last_key     = DATA(lv_connid_key)
**          RECEIVING
**            ro_node         = lo_node.
**
***  ... §0.2 if information should be displayed at
***    the hierarchy column set the carrid as text for this nod
***        lo_node->set_text( CONV #( lrs_connid->connid ) ).
**
***  ... §0.3 set the data for the nes node
***      lo_node->set_data_row( p_ls_data ).
**
**        LOOP AT GROUP lrg_connid REFERENCE INTO lrs_connid.
**          CALL METHOD io_view->add_salv_tree_node
**            EXPORTING
**              iv_related_node   = lv_connid_key
***             iv_relationship   = CL_GUI_COLUMN_TREE=>RELAT_LAST_CHILD
**              is_data_row       = lrs_connid->*
**              iv_collapsed_icon = space "MC_COLLAPSE_ICON
**              iv_expanded_icon  = space " MC_EXPAND_ICON
***             iv_row_style      = IF_SALV_C_TREE_STYLE=>DEFAULT
***             iv_text           =
***             iv_visible        = ABAP_TRUE
***             iv_expander       =
***             iv_enabled        = ABAP_TRUE
***             iv_folder         =
**              io_tree           = io_view->get_salv_tree_instance( )
***        IMPORTING
***             ev_last_key       = DATA(lv_last_key)
**            RECEIVING
**              ro_node           = lo_node.
**
**          "Set data setting
**          TRY.
***              lo_item = lo_node->get_item( 'CARRID' ).
***              lo_item->set_type(  if_salv_c_item_type=>button ).
***              lo_item->set_value( 'Button' ).
***
***              lo_item = lo_node->get_item( 'CITYFROM' ).
***              lo_item->set_font( if_salv_c_item_font=>fixed_size ).
***              lo_item->set_enabled( abap_false ).
**
**              lo_item = lo_node->get_item( 'CHKBOX' ).
**              lo_item->set_type(  if_salv_c_item_type=>checkbox ).
***              lo_item->set_checked( abap_true ).
**              lo_item->set_editable( abap_true ).
**
***              lo_item = lo_node->get_item( 'ACTIVE_ICON' ).
***              lo_item->set_icon( ' ' ).
**            CATCH cx_salv_msg.
**          ENDTRY.
**        ENDLOOP.
**      ENDLOOP.
**    ENDLOOP.
  ENDMETHOD.


  METHOD constructor.
  ENDMETHOD.


  METHOD convert_data_to_internal.
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

    ro_model = me.
  ENDMETHOD.


  METHOD convert_ext_int_or_int_ext.
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


  METHOD get_component_of_data.
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


  METHOD get_controller_action.
    ro_model  = me.
    ms_action = is_action.
  ENDMETHOD.


  METHOD get_outtab.
  ENDMETHOD.


  METHOD get_selectoptions_from_sscr.

    zcl_mvcfw_base_sscr=>get_selectoptions( EXPORTING iv_repid           = iv_repid
                                            IMPORTING et_selopt_tab      = mt_selopt_t
                                                      et_selopt_tab_long = mt_selopt_t_long ).

    et_selopt_tab      = mt_selopt_t.
    et_selopt_tab_long = mt_selopt_t_long.
    ro_model           = me.

  ENDMETHOD.


  METHOD get_submit_data_directly.
    DATA lo_data TYPE REF TO data.

    IF iv_program IS INITIAL.
      RAISE EXCEPTION TYPE zbcx_exception
        EXPORTING
          iv_msgv1 = 'Program is not found'.
    ENDIF.

    cl_salv_bs_runtime_info=>set( EXPORTING display  = space
                                            metadata = space
                                            data     = abap_true ).

    IF iv_custom_submit IS NOT INITIAL.
      submit_program( iv_program ).
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
            iv_msgv1 = lo_exct->get_text( ).
    ENDTRY.
  ENDMETHOD.


  METHOD process_data.
  ENDMETHOD.


  METHOD read_text.
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


  METHOD select_data.
  ENDMETHOD.


  METHOD set_color_all_cells.
*****************************************************************
* Colour code :                                                 *
* Colour is a 4-char field where :                              *
*              - 1st char = C (color property)                  *
*              - 2nd char = color code (from 0 to 7)            *
*                                  0 = background color         *
*                                  1 = blue                     *
*                                  2 = gray                     *
*                                  3 = yellow                   *
*                                  4 = blue/gray                *
*                                  5 = green                    *
*                                  6 = red                      *
*                                  7 = orange                   *
*              - 3rd char = intensified (0=off, 1=on)           *
*              - 4th char = inverse display (0=off, 1=on)       *
*                                                               *
* Colour overwriting priority :                                 *
*   1. Line                                                     *
*   2. Cell                                                     *
*   3. Column                                                   *
*****************************************************************
*****************************************************************
* Use of colours in ALV grid (cell, line and column)            *
*****************************************************************

    DATA ls_color LIKE LINE OF ct_color.
    DATA ls_scolo TYPE lvc_s_colo.
    FIELD-SYMBOLS <lfs_color> TYPE lvc_s_scol.

    ro_model = me.

    IF is_color IS SUPPLIED.
      ls_scolo = is_color.
    ELSEIF iv_color IS SUPPLIED.
      IF |{ iv_color+0(1) CASE = UPPER }| CA sy-abcde.
        DATA(lv_color) = iv_color+1.
      ENDIF.

      TRY.
          ls_scolo = VALUE #( col = lv_color+0(1)
                              int = lv_color+1(1)
                              inv = lv_color+2(1) ).
        CATCH cx_sy_range_out_of_bounds.
      ENDTRY.
    ELSE.
      RETURN.
    ENDIF.

    IF ls_scolo IS NOT INITIAL.
      DATA(lt_comp) = get_component_of_data( EXPORTING is_data = is_data ).

      LOOP AT lt_comp INTO DATA(ls_comp).
        READ TABLE ct_color ASSIGNING <lfs_color> BINARY SEARCH
          WITH KEY fname = ls_comp-fieldname.
        IF sy-subrc EQ 0.
          <lfs_color>-fname    = ls_comp-fieldname.
          <lfs_color>-color    = ls_scolo.
          <lfs_color>-nokeycol = iv_nokeycol.
        ELSE.
          CLEAR ls_color.
          ls_color-fname    = ls_comp-fieldname.
          ls_color-color    = ls_scolo.
          ls_color-nokeycol = iv_nokeycol.
          INSERT ls_color INTO TABLE ct_color.
          SORT ct_color BY fname.
        ENDIF.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.


  METHOD set_color_cell.
*****************************************************************
* Colour code :                                                 *
* Colour is a 4-char field where :                              *
*              - 1st char = C (color property)                  *
*              - 2nd char = color code (from 0 to 7)            *
*                                  0 = background color         *
*                                  1 = blue                     *
*                                  2 = gray                     *
*                                  3 = yellow                   *
*                                  4 = blue/gray                *
*                                  5 = green                    *
*                                  6 = red                      *
*                                  7 = orange                   *
*              - 3rd char = intensified (0=off, 1=on)           *
*              - 4th char = inverse display (0=off, 1=on)       *
*                                                               *
* Colour overwriting priority :                                 *
*   1. Line                                                     *
*   2. Cell                                                     *
*   3. Column                                                   *
*****************************************************************
*****************************************************************
* Use of colours in ALV grid (cell, line and column)            *
*****************************************************************
    DATA ls_color LIKE LINE OF ct_color.
    DATA ls_scolo TYPE lvc_s_colo.
    FIELD-SYMBOLS <lfs_color> TYPE lvc_s_scol.

    ro_model = me.

    IF is_color IS SUPPLIED.
      ls_scolo = is_color.
    ELSEIF iv_color IS SUPPLIED.
      IF |{ iv_color+0(1) CASE = UPPER }| CA sy-abcde.
        DATA(lv_color) = iv_color+1.
      ENDIF.

      TRY.
          ls_scolo = VALUE #( col = lv_color+0(1)
                              int = lv_color+1(1)
                              inv = lv_color+2(1) ).
        CATCH cx_sy_range_out_of_bounds.
      ENDTRY.
    ELSE.
      RETURN.
    ENDIF.

    IF ls_scolo IS NOT INITIAL.
      READ TABLE ct_color ASSIGNING <lfs_color> BINARY SEARCH
        WITH KEY fname = iv_fname.
      IF sy-subrc EQ 0.
        <lfs_color>-fname    = iv_fname.
        <lfs_color>-color    = ls_scolo.
        <lfs_color>-nokeycol = iv_nokeycol.
      ELSE.
        CLEAR ls_color.
        ls_color-fname    = iv_fname.
        ls_color-color    = ls_scolo.
        ls_color-nokeycol = iv_nokeycol.
        INSERT ls_color INTO TABLE ct_color.
        SORT ct_color BY fname.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD set_editable_cell.
*--------------------------------------------------------------------*
* Check text style with include <CL_ALV_CONTROL>
*--------------------------------------------------------------------*
*    INCLUDE <cl_alv_control>.

    DATA: ls_style LIKE LINE OF ct_style,
          l_style  TYPE lvc_style.

    ro_model = me.

    CHECK iv_fname IS NOT INITIAL.

    IF iv_disabled IS NOT INITIAL.
      l_style = cl_gui_alv_grid=>mc_style_disabled.
    ELSE.
      l_style = cl_gui_alv_grid=>mc_style_enabled.
    ENDIF.

    READ TABLE ct_style ASSIGNING FIELD-SYMBOL(<lfs_style>)
      WITH TABLE KEY fieldname = iv_fname.
    IF sy-subrc EQ 0.
      <lfs_style>-style  = l_style.
    ELSE.
      CLEAR ls_style.
      ls_style-fieldname = iv_fname.
      ls_style-style     = l_style.
      INSERT ls_style INTO TABLE ct_style.
    ENDIF.
  ENDMETHOD.


  METHOD set_outtab.
  ENDMETHOD.


  METHOD set_stack_name.
    lmv_current_stack = iv_stack_name.
    ro_model         = me.
  ENDMETHOD.


  METHOD set_style_cell.
*--------------------------------------------------------------------*
* Check text style with include <CL_ALV_CONTROL>
*--------------------------------------------------------------------*
    INCLUDE <cl_alv_control>.

    DATA: ls_style LIKE LINE OF ct_style,
          l_style  TYPE lvc_style.

    ro_model = me.

    CHECK iv_fname IS NOT INITIAL.

    READ TABLE ct_style ASSIGNING FIELD-SYMBOL(<lfs_style>)
      WITH TABLE KEY fieldname = iv_fname.
    IF sy-subrc EQ 0.
      <lfs_style>-style  = COND #( WHEN iv_style  IS NOT INITIAL THEN iv_style  ELSE <lfs_style>-style ).
      <lfs_style>-style2 = COND #( WHEN iv_style2 IS NOT INITIAL THEN iv_style2 ELSE <lfs_style>-style2 ).
      <lfs_style>-style3 = COND #( WHEN iv_style3 IS NOT INITIAL THEN iv_style3 ELSE <lfs_style>-style3 ).
      <lfs_style>-style4 = COND #( WHEN iv_style4 IS NOT INITIAL THEN iv_style4 ELSE <lfs_style>-style4 ).
    ELSE.
      CLEAR ls_style.
      ls_style-fieldname = iv_fname.
      ls_style-style     = iv_style.
      ls_style-style2    = iv_style2.
      ls_style-style3    = iv_style3.
      ls_style-style4    = iv_style4.
      INSERT ls_style INTO TABLE ct_style.
    ENDIF.
  ENDMETHOD.


  METHOD submit_program.
  ENDMETHOD.


  METHOD _convert_to_extern.
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


  METHOD _convert_to_intern.
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


  METHOD _get_current_stack.

    re_current_stack = lmv_current_stack.

  ENDMETHOD.


  METHOD _number_convert_to_extern.
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


  METHOD _number_convert_to_intern.
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


  METHOD _try_conv_ext_int_ext.
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


  METHOD _try_conv_int_ext_int.
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
