-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

deferred class GTKTARGETENTRY_STRUCT

insert STANDARD_C_LIBRARY_TYPES

	GTK_TYPES
feature {} -- Low-level setters

	gtktargetentry_struct_set_target (a_structure: POINTER; a_value: POINTER) is
			-- Setter for target field of GTKTARGETENTRY_STRUCT structure.
			-- TODO: setter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "gtktargetentry_struct_set_target"
		}"
		end

	gtktargetentry_struct_set_flags (a_structure: POINTER; a_value: NATURAL_32) is
			-- Setter for flags field of GTKTARGETENTRY_STRUCT structure.
			-- TODO: setter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "gtktargetentry_struct_set_flags"
		}"
		end

	gtktargetentry_struct_set_info (a_structure: POINTER; a_value: NATURAL_32) is
			-- Setter for info field of GTKTARGETENTRY_STRUCT structure.
			-- TODO: setter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "gtktargetentry_struct_set_info"
		}"
		end

feature {} -- Low-level queries

	gtktargetentry_struct_get_target (a_structure: POINTER): POINTER is
			-- Query for target field of GTKTARGETENTRY_STRUCT structure.
			-- TODO: getter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "gtktargetentry_struct_get_target"
		}"
		end

	gtktargetentry_struct_get_flags (a_structure: POINTER): NATURAL_32 is
			-- Query for flags field of GTKTARGETENTRY_STRUCT structure.
			-- TODO: getter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "gtktargetentry_struct_get_flags"
		}"
		end

	gtktargetentry_struct_get_info (a_structure: POINTER): NATURAL_32 is
			-- Query for info field of GTKTARGETENTRY_STRUCT structure.
			-- TODO: getter description

		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "gtktargetentry_struct_get_info"
		}"
		end

feature -- Structure size
	struct_size: like size_t is
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "sizeof__GtkTargetEntry"
		}"
		end

end -- class GTKTARGETENTRY_STRUCT
-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

