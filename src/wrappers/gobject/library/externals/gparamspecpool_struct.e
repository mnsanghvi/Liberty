-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

deferred class GPARAMSPECPOOL_STRUCT

insert STANDARD_C_LIBRARY_TYPES

	GOBJECT_TYPES
	-- Fieldless structure
feature -- Structure size
	struct_size: like size_t is
		external "plug_in"
		alias "{
			location: "."
			module_name: "plugin"
			feature_name: "sizeof__GParamSpecPool"
		}"
		end

end -- class GPARAMSPECPOOL_STRUCT
-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

