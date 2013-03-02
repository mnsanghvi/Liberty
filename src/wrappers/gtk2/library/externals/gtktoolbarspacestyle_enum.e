-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

expanded class GTKTOOLBARSPACESTYLE_ENUM

-- TODO emit_description(class_descriptions.reference_at(an_enum_name))

insert ENUM

creation default_create
feature -- Validity
    is_valid_value (a_value: INTEGER): BOOLEAN is
        do
            Result := ((a_value = gtk_toolbar_space_empty_low_level)  or else
				(a_value = gtk_toolbar_space_line_low_level) )
		end

feature -- Setters
	default_create,
	set_gtk_toolbar_space_empty is
		do
			value := gtk_toolbar_space_empty_low_level
		end

	set_gtk_toolbar_space_line is
		do
			value := gtk_toolbar_space_line_low_level
		end

feature -- Queries
	is_gtk_toolbar_space_empty: BOOLEAN is
		do
			Result := (value=gtk_toolbar_space_empty_low_level)
		end

	is_gtk_toolbar_space_line: BOOLEAN is
		do
			Result := (value=gtk_toolbar_space_line_low_level)
		end

feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	gtk_toolbar_space_empty_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "GTK_TOOLBAR_SPACE_EMPTY"
 			}"
 		end

	gtk_toolbar_space_line_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "GTK_TOOLBAR_SPACE_LINE"
 			}"
 		end


end -- class GTKTOOLBARSPACESTYLE_ENUM
