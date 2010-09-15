class TEST_CLI_04

insert
	ARGUMENTS
	EIFFELTEST_TOOLS
	COMMAND_LINE_ARGUMENT_FACTORY

creation {}
	make

feature {}
	make is
		local
			foo_option: COMMAND_LINE_TYPED_ARGUMENT[STRING]
			bar_option: COMMAND_LINE_TYPED_ARGUMENT[INTEGER]
		do
			foo_option := option_string("f", "foo", "foo", "The foo string")
			bar_option := option_integer("b", "bar", "bar", "The bar integer")
			create args.make(+foo_option and bar_option) -- see TEST_CLI_03; also works written like this

			-- an empty command line is not valid
			setup
			assert(not args.parse_command_line)

			-- a bar option alone is not valid
			setup
			command_arguments.add_last("--bar=42")
			assert(not args.parse_command_line)

			-- must have at least foo, bar is optional
			setup
			command_arguments.add_last("--foo=the foo z'option")
			command_arguments.add_last("--bar=42")
			assert(args.parse_command_line)
			assert(foo_option.item.is_equal("the foo z'option"))
			assert(bar_option.item = 42)
		end

	setup is
		do
			command_arguments.make(1)
		end

	args: COMMAND_LINE_ARGUMENTS

end