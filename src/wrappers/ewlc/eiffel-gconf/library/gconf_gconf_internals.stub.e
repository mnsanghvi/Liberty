note
	description: "."
	copyright: "[
					Copyright (C) 2007 $EWLC_developer, $original_copyright_holder
					
					This library is free software; you can redistribute it and/or
					modify it under the terms of the GNU Lesser General Public License
					as published by the Free Software Foundation; either version 2.1 of
					the License, or (at your option) any later version.
					
					This library is distributed in the hope that it will be useful, but
					WITHOUT ANY WARRANTY; without even the implied warranty of
					MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
					Lesser General Public License for more details.

					You should have received a copy of the GNU Lesser General Public
					License along with this library; if not, write to the Free Software
					Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
					02110-1301 USA
			]"

	wrapped_version: "Unknown"

class GCONF_GCONF_INTERNALS

inherit
	(SHARED_?)C_STRUCT

insert
	GCONF_GCONF_INTERNALS_EXTERNALS

create {ANY} make, from_external_pointer

feature {} -- Creation

	--   Link: GConf Reference Manual (start)
	--   Link: Using the GConf library (parent)
	--   Link: GError (previous)
	--   Link: gconf-listeners (next)
	--   Link: Using the GConf library (chapter)
	--
	--   Prev Up Home                  GConf Reference Manual                  Next
	--   Top  |  Description
	--
	--   gconf-internals
	--
	--   gconf-internals
	--
	--Synopsis
	--
	--
	--
	--
	-- gchar*              gconf_key_directory                 (const gchar *key);
	-- const gchar*        gconf_key_key                       (const gchar *key);
	-- GConfValue*         gconf_value_from_corba_value        (const ConfigValue *value);
	-- GConfSchema*        gconf_schema_from_corba_schema      (const ConfigSchema *cs);
	-- const gchar*        gconf_value_type_to_string          (GConfValueType type);
	-- GConfValueType      gconf_value_type_from_string        (const gchar *str);
	-- GSList*             gconf_load_source_path              (const gchar *filename,
	--                                                          GError **err);
	-- void                gconf_shutdown_daemon               (GError **err);
	-- gboolean            gconf_ping_daemon                   (void);
	-- gboolean            gconf_spawn_daemon                  (GError **err);
	-- gulong              gconf_string_to_gulong              (const gchar *str);
	-- const gchar*        gconf_current_locale                (void);
	-- enum                GConfLogPriority;
	-- void                gconf_log                           (GConfLogPriority pri,
	--                                                          const gchar *format,
	--                                                          ...);
	-- gboolean            gconf_key_check                     (const gchar *key,
	--                                                          GError **err);
	-- GConfValue*         gconf_value_new_list_from_string    (GConfValueType list_type,
	--                                                          const gchar *str,
	--                                                          GError **err);
	-- GConfValue*         gconf_value_new_pair_from_string    (GConfValueType car_type,
	--                                                          GConfValueType cdr_type,
	--                                                          const gchar *str,
	--                                                          GError **err);
	-- gchar*              gconf_quote_string                  (const gchar *str);
	-- gchar*              gconf_unquote_string                (const gchar *str,
	--                                                          const gchar **end,
	--                                                          GError **err);
	-- void                gconf_unquote_string_inplace        (gchar *str,
	--                                                          gchar **end,
	--                                                          GError **err);
	-- GConfValue*         gconf_value_decode                  (const gchar *encoded);
	-- gchar*              gconf_value_encode                  (GConfValue *val);
	-- GConfValue*         gconf_value_list_from_primitive_list
	--                                                         (GConfValueType list_type,
	--                                                          GSList *list,
	--                                                          GError **err);
	-- GConfValue*         gconf_value_pair_from_primitive_pair
	--                                                         (GConfValueType car_type,
	--                                                          GConfValueType cdr_type,
	--                                                          gconstpointer address_of_car,
	--                                                          gconstpointer address_of_cdr,
	--                                                          GError **err);
	-- GSList*             gconf_value_list_to_primitive_list_destructive
	--                                                         (GConfValue *val,
	--                                                          GConfValueType list_type,
	--                                                          GError **err);
	-- gboolean            gconf_value_pair_to_primitive_pair_destructive
	--                                                         (GConfValue *val,
	--                                                          GConfValueType car_type,
	--                                                          GConfValueType cdr_type,
	--                                                          gpointer car_retloc,
	--                                                          gpointer cdr_retloc,
	--                                                          GError **err);
	-- void                gconf_set_daemon_mode               (gboolean setting);
	-- gboolean            gconf_handle_oaf_exception          (CORBA_Environment *ev,
	--                                                          GError **err);
	--
	--Description
	--
	--Details
	--
	--  gconf_key_directory ()
	--
	-- gchar*              gconf_key_directory                 (const gchar *key);
	--
	--   key :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_key_key ()
	--
	-- const gchar*        gconf_key_key                       (const gchar *key);
	--
	--   key :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_from_corba_value ()
	--
	-- GConfValue*         gconf_value_from_corba_value        (const ConfigValue *value);
	--
	--   value :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_schema_from_corba_schema ()
	--
	-- GConfSchema*        gconf_schema_from_corba_schema      (const ConfigSchema *cs);
	--
	--   cs :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_type_to_string ()
	--
	-- const gchar*        gconf_value_type_to_string          (GConfValueType type);
	--
	--   type :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_type_from_string ()
	--
	-- GConfValueType      gconf_value_type_from_string        (const gchar *str);
	--
	--   str :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_load_source_path ()
	--
	-- GSList*             gconf_load_source_path              (const gchar *filename,
	--                                                          GError **err);
	--
	--   filename :
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_shutdown_daemon ()
	--
	-- void                gconf_shutdown_daemon               (GError **err);
	--
	--   err :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_ping_daemon ()
	--
	-- gboolean            gconf_ping_daemon                   (void);
	--
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_spawn_daemon ()
	--
	-- gboolean            gconf_spawn_daemon                  (GError **err);
	--
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_string_to_gulong ()
	--
	-- gulong              gconf_string_to_gulong              (const gchar *str);
	--
	--   str :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_current_locale ()
	--
	-- const gchar*        gconf_current_locale                (void);
	--
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  enum GConfLogPriority
	--
	-- typedef enum {
	--   GCL_EMERG,
	--   GCL_ALERT,
	--   GCL_CRIT,
	--   GCL_ERR,
	--   GCL_WARNING,
	--   GCL_NOTICE,
	--   GCL_INFO,
	--   GCL_DEBUG
	-- } GConfLogPriority;
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_log ()
	--
	-- void                gconf_log                           (GConfLogPriority pri,
	--                                                          const gchar *format,
	--                                                          ...);
	--
	--   pri :
	--   format :
	--   ... :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_key_check ()
	--
	-- gboolean            gconf_key_check                     (const gchar *key,
	--                                                          GError **err);
	--
	--   key :
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_new_list_from_string ()
	--
	-- GConfValue*         gconf_value_new_list_from_string    (GConfValueType list_type,
	--                                                          const gchar *str,
	--                                                          GError **err);
	--
	--   This function does not work. Don't use it.
	--
	--   list_type :
	--   str :
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_new_pair_from_string ()
	--
	-- GConfValue*         gconf_value_new_pair_from_string    (GConfValueType car_type,
	--                                                          GConfValueType cdr_type,
	--                                                          const gchar *str,
	--                                                          GError **err);
	--
	--   This function does not work. Don't use it.
	--
	--   car_type :
	--   cdr_type :
	--   str :
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_quote_string ()
	--
	-- gchar*              gconf_quote_string                  (const gchar *str);
	--
	--   str :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_unquote_string ()
	--
	-- gchar*              gconf_unquote_string                (const gchar *str,
	--                                                          const gchar **end,
	--                                                          GError **err);
	--
	--   str :
	--   end :
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_unquote_string_inplace ()
	--
	-- void                gconf_unquote_string_inplace        (gchar *str,
	--                                                          gchar **end,
	--                                                          GError **err);
	--
	--   str :
	--   end :
	--   err :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_decode ()
	--
	-- GConfValue*         gconf_value_decode                  (const gchar *encoded);
	--
	--   encoded :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_encode ()
	--
	-- gchar*              gconf_value_encode                  (GConfValue *val);
	--
	--   val :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_list_from_primitive_list ()
	--
	-- GConfValue*         gconf_value_list_from_primitive_list
	--                                                         (GConfValueType list_type,
	--                                                          GSList *list,
	--                                                          GError **err);
	--
	--   list_type :
	--   list :
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_pair_from_primitive_pair ()
	--
	-- GConfValue*         gconf_value_pair_from_primitive_pair
	--                                                         (GConfValueType car_type,
	--                                                          GConfValueType cdr_type,
	--                                                          gconstpointer address_of_car,
	--                                                          gconstpointer address_of_cdr,
	--                                                          GError **err);
	--
	--   car_type :
	--   cdr_type :
	--   address_of_car :
	--   address_of_cdr :
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_list_to_primitive_list_destructive ()
	--
	-- GSList*             gconf_value_list_to_primitive_list_destructive
	--                                                         (GConfValue *val,
	--                                                          GConfValueType list_type,
	--                                                          GError **err);
	--
	--   val :
	--   list_type :
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_value_pair_to_primitive_pair_destructive ()
	--
	-- gboolean            gconf_value_pair_to_primitive_pair_destructive
	--                                                         (GConfValue *val,
	--                                                          GConfValueType car_type,
	--                                                          GConfValueType cdr_type,
	--                                                          gpointer car_retloc,
	--                                                          gpointer cdr_retloc,
	--                                                          GError **err);
	--
	--   val :
	--   car_type :
	--   cdr_type :
	--   car_retloc :
	--   cdr_retloc :
	--   err :
	--   Returns :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_set_daemon_mode ()
	--
	-- void                gconf_set_daemon_mode               (gboolean setting);
	--
	--   setting :
	--
	--   --------------------------------------------------------------------------
	--
	--  gconf_handle_oaf_exception ()
	--
	-- gboolean            gconf_handle_oaf_exception          (CORBA_Environment *ev,
	--                                                          GError **err);
	--
	--   ev :
	--   err :
	--   Returns :

end -- class GCONF_GCONF_INTERNALS