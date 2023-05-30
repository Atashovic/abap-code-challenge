CLASS zcl_demo_mustache_test_app_j DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES:

        BEGIN OF ty_club,
            name    TYPE string,
            city    TYPE string,
        END OF ty_club,

        tt_club TYPE STANDARD TABLE OF ty_club WITH DEFAULT KEY,

        BEGIN OF ty_country,
            c_name    TYPE string,
            clubs   TYPE tt_club,
        END OF ty_country.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_demo_mustache_test_app_j IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA:
            lo_mustache TYPE REF TO zcl_mustache,
            lt_data TYPE STANDARD TABLE OF ty_country,
            lr_data TYPE REF TO ty_country.

    DATA(c_nl) = cl_abap_char_utilities=>newline.


    APPEND INITIAL LINE TO lt_data REFERENCE INTO lr_data.
    lr_data->c_name = 'Azerbaijan'.
    lr_data->clubs = VALUE tt_club(
                                     ( name = 'Sabah' city = 'Baku'  )
                                     ( name = 'Qabala' city = 'Qabala'  )
                                  ).

    APPEND INITIAL LINE TO lt_data REFERENCE INTO lr_data.
    lr_data->c_name = 'Russia'.
    lr_data->clubs = VALUE tt_club(
                                     ( name = 'Rubin' city = 'Kazan'  )
                                     ( name = 'CSKA'  city = 'Qabala'  )
                                  ).

    TRY.

            lo_mustache = zcl_mustache=>create(

                ' Football Clubs of {{c_name}}:'                  && c_nl &&
                '{{#clubs}}'                                      && c_nl &&
                '     {{name}} FC represents {{city}} city'       && c_nl &&
                '{{/clubs}}'                                      && c_nl

                                                    ).
             out->write( lo_mustache->render( lt_data ) ).

    CATCH ZCX_MUSTACHE_ERROR.

        out->write( 'error in mustache' ).

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
