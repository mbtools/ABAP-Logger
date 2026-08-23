CLASS zcl_logger_ui DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_logger_ui.

  PRIVATE SECTION.
    DATA control_handle TYPE balcnthndl.
ENDCLASS.

CLASS zcl_logger_ui IMPLEMENTATION.
  METHOD zif_logger_ui~display_as_popup.
    DATA relevant_profile TYPE bal_s_prof.
    DATA log_handles      TYPE bal_t_logh.

    INSERT logger->get_handle( ) INTO TABLE log_handles.
    IF profile IS SUPPLIED AND profile IS NOT INITIAL.
      relevant_profile = profile.
    ELSE.
      CALL FUNCTION 'BAL_DSP_PROFILE_POPUP_GET'
        IMPORTING e_s_display_profile = relevant_profile
        EXCEPTIONS OTHERS              = 1.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_logger.
      ENDIF.
    ENDIF.
    CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
      EXPORTING i_s_display_profile = relevant_profile
                i_t_log_handle      = log_handles
      EXCEPTIONS OTHERS              = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_logger.
    ENDIF.
  ENDMETHOD.

  METHOD zif_logger_ui~display_fullscreen.
    DATA relevant_profile TYPE bal_s_prof.
    DATA log_handles      TYPE bal_t_logh.

    INSERT logger->get_handle( ) INTO TABLE log_handles.
    IF profile IS SUPPLIED AND profile IS NOT INITIAL.
      relevant_profile = profile.
    ELSE.
      CALL FUNCTION 'BAL_DSP_PROFILE_SINGLE_LOG_GET'
        IMPORTING e_s_display_profile = relevant_profile
        EXCEPTIONS OTHERS              = 1.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_logger.
      ENDIF.
    ENDIF.
    CALL FUNCTION 'BAL_DSP_LOG_DISPLAY'
      EXPORTING i_s_display_profile = relevant_profile
                i_t_log_handle      = log_handles
      EXCEPTIONS OTHERS              = 1.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_logger.
    ENDIF.
  ENDMETHOD.

  METHOD zif_logger_ui~display_in_container.
    DATA relevant_profile TYPE bal_s_prof.
    DATA log_handles      TYPE bal_t_logh.

    INSERT logger->get_handle( ) INTO TABLE log_handles.
    IF control_handle IS INITIAL.
      IF profile IS SUPPLIED AND profile IS NOT INITIAL.
        relevant_profile = profile.
      ELSE.
        CALL FUNCTION 'BAL_DSP_PROFILE_NO_TREE_GET'
          IMPORTING e_s_display_profile = relevant_profile
          EXCEPTIONS OTHERS              = 1.
        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE zcx_logger.
        ENDIF.
      ENDIF.
      CALL FUNCTION 'BAL_CNTL_CREATE'
        EXPORTING i_container         = container
                  i_s_display_profile = relevant_profile
                  i_t_log_handle      = log_handles
        IMPORTING e_control_handle    = control_handle
        EXCEPTIONS profile_inconsistent = 1
                   internal_error       = 2
                   OTHERS               = 3.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_logger.
      ENDIF.
    ELSE.
      CALL FUNCTION 'BAL_CNTL_REFRESH'
        EXPORTING i_control_handle = control_handle
                  i_t_log_handle   = log_handles
        EXCEPTIONS control_not_found = 1
                   internal_error    = 2
                   OTHERS            = 3.
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_logger.
      ENDIF.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
