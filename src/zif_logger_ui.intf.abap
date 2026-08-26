INTERFACE zif_logger_ui PUBLIC.

  METHODS display_fullscreen
    IMPORTING
      logger  TYPE REF TO zif_logger
      profile TYPE bal_s_prof OPTIONAL.

  METHODS display_as_popup
    IMPORTING
      logger  TYPE REF TO zif_logger
      profile TYPE bal_s_prof OPTIONAL.

  METHODS display_in_container
    IMPORTING
      logger    TYPE REF TO zif_logger
      container TYPE REF TO cl_gui_container
      profile   TYPE bal_s_prof OPTIONAL.

ENDINTERFACE.
