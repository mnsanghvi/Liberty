-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

deferred class GVERSION_EXTERNALS


insert ANY undefine is_equal, copy end

		-- TODO: insert typedefs class
feature {} -- External calls

	glib_binary_age: NATURAL_32 is
 		-- glib_binary_age
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "glib_binary_age"
		}"
		end

	address_of_glib_binary_age: POINTER is
 		-- Address of glib_binary_age
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "&glib_binary_age"
		}"
		end

	set_glib_binary_age (a_value: NATURAL_32) is
		-- Set variable glib_binary_age value
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "set_glib_binary_age"
		}"
		end

	glib_check_version (a_required_major: NATURAL_32; a_required_minor: NATURAL_32; a_required_micro: NATURAL_32): POINTER is
 		-- glib_check_version
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "glib_check_version"
		}"
		end

	glib_interface_age: NATURAL_32 is
 		-- glib_interface_age
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "glib_interface_age"
		}"
		end

	address_of_glib_interface_age: POINTER is
 		-- Address of glib_interface_age
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "&glib_interface_age"
		}"
		end

	set_glib_interface_age (a_value: NATURAL_32) is
		-- Set variable glib_interface_age value
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "set_glib_interface_age"
		}"
		end

	glib_major_version: NATURAL_32 is
 		-- glib_major_version
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "glib_major_version"
		}"
		end

	address_of_glib_major_version: POINTER is
 		-- Address of glib_major_version
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "&glib_major_version"
		}"
		end

	set_glib_major_version (a_value: NATURAL_32) is
		-- Set variable glib_major_version value
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "set_glib_major_version"
		}"
		end

	glib_micro_version: NATURAL_32 is
 		-- glib_micro_version
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "glib_micro_version"
		}"
		end

	address_of_glib_micro_version: POINTER is
 		-- Address of glib_micro_version
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "&glib_micro_version"
		}"
		end

	set_glib_micro_version (a_value: NATURAL_32) is
		-- Set variable glib_micro_version value
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "set_glib_micro_version"
		}"
		end

	glib_minor_version: NATURAL_32 is
 		-- glib_minor_version
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "glib_minor_version"
		}"
		end

	address_of_glib_minor_version: POINTER is
 		-- Address of glib_minor_version
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "&glib_minor_version"
		}"
		end

	set_glib_minor_version (a_value: NATURAL_32) is
		-- Set variable glib_minor_version value
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "set_glib_minor_version"
		}"
		end


end -- class GVERSION_EXTERNALS
