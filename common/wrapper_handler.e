indexing
	description: "A class that can handle WRAPPER's internals"
	copyright: "(C) 2005 Paolo Redaelli "
	license: "LGPL v2 or later"
	date: "$Date:$"
	revision "$REvision:$"

deferred class WRAPPER_HANDLER

inherit
	ANY
		undefine
			is_equal,
			copy,
			fill_tagged_out_memory
		end

insert
	EXCEPTIONS
		export {} all
		undefine
			is_equal,
			copy,
			fill_tagged_out_memory
		end

feature
	null_or (a_wrapper: WRAPPER): POINTER is
			-- The handle of `a_wrapper', or the default_pointer if 
			-- `a_wrapper' is Void
		do
			if a_wrapper/=Void then Result:=a_wrapper.handle end
		ensure
			definition: Result = default_pointer or else
			            a_wrapper/=Void implies Result = a_wrapper.handle
		end

	null_or_string(a_string: STRING): POINTER is
			-- 
		do
			if a_string/=Void 
			 then Result:=a_string.to_external
			else
				check Result.is_null end 
			end
		ensure definition:
			definition: ((Result = default_pointer) or
							 (a_string/=Void implies Result=a_string.to_external))
		end
feature {} -- Wrapper related exceptions
	pointer_to_unwrapped_deferred_object: STRING is
		"A C function returned a pointer to an unwrapped object which is wrapped by a deferred class. It is not possible to create a correct wrapper."
	retrieved_object_mismatch: STRING is
		"Retrieved_object_mismatch: the Eiffel wrapper associated with a pointer is not an actual wrapper for the object referred by that pointer "

end
