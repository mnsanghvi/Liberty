-- This file have been created by wrapper-generator.
-- Any change will be lost by the next execution of the tool.

expanded class DATEORDER_ENUM

-- TODO emit_description(class_descriptions.reference_at(an_enum_name))

insert ENUM

create {ANY} default_create
feature {ANY} -- Validity
	is_valid_value (a_value: INTEGER): BOOLEAN is
		do
			Result := ((a_value = no_order_low_level)  or else
				(a_value = dmy_low_level)  or else
				(a_value = mdy_low_level)  or else
				(a_value = ymd_low_level)  or else
				(a_value = ydm_low_level) )
		end

feature {ANY} -- Setters
	default_create,
	set_no_order is
		do
			value := no_order_low_level
		end

	set_dmy is
		do
			value := dmy_low_level
		end

	set_mdy is
		do
			value := mdy_low_level
		end

	set_ymd is
		do
			value := ymd_low_level
		end

	set_ydm is
		do
			value := ydm_low_level
		end

feature {ANY} -- Queries
	no_order: BOOLEAN is
		do
			Result := (value=no_order_low_level)
		end

	dmy: BOOLEAN is
		do
			Result := (value=dmy_low_level)
		end

	mdy: BOOLEAN is
		do
			Result := (value=mdy_low_level)
		end

	ymd: BOOLEAN is
		do
			Result := (value=ymd_low_level)
		end

	ydm: BOOLEAN is
		do
			Result := (value=ydm_low_level)
		end

feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	no_order_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "no_order"
 			}"
 		end

	dmy_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "dmy"
 			}"
 		end

	mdy_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "mdy"
 			}"
 		end

	ymd_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "ymd"
 			}"
 		end

	ydm_low_level: INTEGER is
		external "plug_in"
 		alias "{
 			location: "."
 			module_name: "plugin"
 			feature_name: "ydm"
 			}"
 		end


end -- class DATEORDER_ENUM