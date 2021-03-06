-- This file have been created by eiffel-gcc-xml.
-- Any change will be lost by the next execution of the tool.
expanded class SQL_ORDERTYPE
insert ENUM

create {ANY} default_create
feature {ANY} -- Validity
	is_valid_value (a_value: INTEGER): BOOLEAN
		do
			Result := ((a_value = sql_asc) or else 
				(a_value = sql_desc))
		end


feature {ANY} -- Setters
	default_create, set_sql_asc
		do
			value := sql_asc
		end

	set_sql_desc
		do
			value := sql_desc
		end


feature {ANY} -- Queries
	is_sql_asc: BOOLEAN
		do
			Result := (value=sql_asc)
		end

	is_sql_desc: BOOLEAN
		do
			Result := (value=sql_desc)
		end


feature {WRAPPER, WRAPPER_HANDLER} -- Low level values
	sql_asc: INTEGER
		external "C macro use <libgda/libgda.h>"
		alias "SQL_asc"
		end

	sql_desc: INTEGER
		external "C macro use <libgda/libgda.h>"
		alias "SQL_desc"
		end


end

