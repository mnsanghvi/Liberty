-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

expanded class BIN_OP_ENUM

insert ENUM

creation {ANY} default_create
feature {ANY} -- Validity
    is_valid_value (a_value: INTEGER): BOOLEAN
        do
            Result := ((a_value = add_low_level)  or else
				(a_value = and_external_low_level)  or else
				(a_value = bad_binop_low_level)  or else
				(a_value = first_binop_low_level)  or else
				(a_value = last_binop_low_level)  or else
				(a_value = max_low_level)  or else
				(a_value = min_low_level)  or else
				(a_value = nand_low_level)  or else
				(a_value = or_external_low_level)  or else
				(a_value = sub_low_level)  or else
				(a_value = umax_low_level)  or else
				(a_value = umin_low_level)  or else
				(a_value = xchg_low_level)  or else
				(a_value = xor_external_low_level) )
		end

feature {ANY} -- Setters
	default_create,
	set_add
		do
			value := add_low_level
		end

	set_and_external
		do
			value := and_external_low_level
		end

	set_bad_binop
		do
			value := bad_binop_low_level
		end

	set_first_binop
		do
			value := first_binop_low_level
		end

	set_last_binop
		do
			value := last_binop_low_level
		end

	set_max
		do
			value := max_low_level
		end

	set_min
		do
			value := min_low_level
		end

	set_nand
		do
			value := nand_low_level
		end

	set_or_external
		do
			value := or_external_low_level
		end

	set_sub
		do
			value := sub_low_level
		end

	set_umax
		do
			value := umax_low_level
		end

	set_umin
		do
			value := umin_low_level
		end

	set_xchg
		do
			value := xchg_low_level
		end

	set_xor_external
		do
			value := xor_external_low_level
		end

feature {ANY} -- Queries
	is_add: BOOLEAN
		do
			Result := (value=add_low_level)
		end

	is_and_external: BOOLEAN
		do
			Result := (value=and_external_low_level)
		end

	is_bad_binop: BOOLEAN
		do
			Result := (value=bad_binop_low_level)
		end

	is_first_binop: BOOLEAN
		do
			Result := (value=first_binop_low_level)
		end

	is_last_binop: BOOLEAN
		do
			Result := (value=last_binop_low_level)
		end

	is_max: BOOLEAN
		do
			Result := (value=max_low_level)
		end

	is_min: BOOLEAN
		do
			Result := (value=min_low_level)
		end

	is_nand: BOOLEAN
		do
			Result := (value=nand_low_level)
		end

	is_or_external: BOOLEAN
		do
			Result := (value=or_external_low_level)
		end

	is_sub: BOOLEAN
		do
			Result := (value=sub_low_level)
		end

	is_umax: BOOLEAN
		do
			Result := (value=umax_low_level)
		end

	is_umin: BOOLEAN
		do
			Result := (value=umin_low_level)
		end

	is_xchg: BOOLEAN
		do
			Result := (value=xchg_low_level)
		end

	is_xor_external: BOOLEAN
		do
			Result := (value=xor_external_low_level)
		end

feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	add_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Add"
 			}"
 		end

	and_external_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "And"
 			}"
 		end

	bad_binop_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "BAD_BINOP"
 			}"
 		end

	first_binop_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "FIRST_BINOP"
 			}"
 		end

	last_binop_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "LAST_BINOP"
 			}"
 		end

	max_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Max"
 			}"
 		end

	min_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Min"
 			}"
 		end

	nand_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Nand"
 			}"
 		end

	or_external_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Or"
 			}"
 		end

	sub_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Sub"
 			}"
 		end

	umax_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "UMax"
 			}"
 		end

	umin_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "UMin"
 			}"
 		end

	xchg_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Xchg"
 			}"
 		end

	xor_external_low_level: INTEGER
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "Xor"
 			}"
 		end


end -- class BIN_OP_ENUM
