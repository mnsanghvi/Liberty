-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

deferred class GDKWINDOWREDIRECT_STRUCT

insert STANDARD_C_LIBRARY_TYPES

	GDK_TYPES
	-- Fieldless structure
feature -- Structure size
	struct_size: like size_t is
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "sizeof__GdkWindowRedirect"
		}"
		end

end -- class GDKWINDOWREDIRECT_STRUCT
-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.
