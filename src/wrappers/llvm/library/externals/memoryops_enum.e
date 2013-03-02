-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

expanded class MEMORYOPS_ENUM

-- TODO emit_description(class_descriptions.reference_at(an_enum_name))

insert ENUM

creation default_create
feature -- Validity
    is_valid_value (a_value: INTEGER): BOOLEAN is
        do
            Result := ((a_value = alloca_low_level)  or else
				(a_value = get_element_ptr_low_level)  or else
				(a_value = load_low_level)  or else
				(a_value = memory_ops_begin_low_level)  or else
				(a_value = memory_ops_end_low_level)  or else
				(a_value = store_low_level) )
		end

feature -- Setters
	default_create,
	set_alloca is
		do
			value := alloca_low_level
		end

	set_get_element_ptr is
		do
			value := get_element_ptr_low_level
		end

	set_load is
		do
			value := load_low_level
		end

	set_memory_ops_begin is
		do
			value := memory_ops_begin_low_level
		end

	set_memory_ops_end is
		do
			value := memory_ops_end_low_level
		end

	set_store is
		do
			value := store_low_level
		end

feature -- Queries
	is_alloca: BOOLEAN is
		do
			Result := (value=alloca_low_level)
		end

	is_get_element_ptr: BOOLEAN is
		do
			Result := (value=get_element_ptr_low_level)
		end

	is_load: BOOLEAN is
		do
			Result := (value=load_low_level)
		end

	is_memory_ops_begin: BOOLEAN is
		do
			Result := (value=memory_ops_begin_low_level)
		end

	is_memory_ops_end: BOOLEAN is
		do
			Result := (value=memory_ops_end_low_level)
		end

	is_store: BOOLEAN is
		do
			Result := (value=store_low_level)
		end

feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	alloca_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Alloca"
 			}"
 		end

	get_element_ptr_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "GetElementPtr"
 			}"
 		end

	load_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Load"
 			}"
 		end

	memory_ops_begin_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "MemoryOpsBegin"
 			}"
 		end

	memory_ops_end_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "MemoryOpsEnd"
 			}"
 		end

	store_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Store"
 			}"
 		end


end -- class MEMORYOPS_ENUM
