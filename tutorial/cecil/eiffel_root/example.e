class EXAMPLE
--
-- The Eiffel program is running first, then call the C program which is in charge to call the 
-- Eiffel feature `show_values'.
-- Note that the Eiffel root object is not passed to the C world. Thus, the C code uses 
-- predefined `eiffel_root_object' to access the very first created Eiffel object.
--
-- To compile this example, use command:
--
--  se c -cecil cecil.se example c_prog.c
--

creation {ANY}
	make

feature {ANY}
	make is
		do
			do_it
			call_c_prog
		end

	do_it is
		do
			io.put_string("Hi from Eiffel world.%N")
		end

feature {}
	call_c_prog is
		external "C"
		alias "c_prog"
		end

end -- class EXAMPLE