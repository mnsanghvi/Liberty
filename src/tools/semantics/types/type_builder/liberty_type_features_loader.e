-- This file is part of Liberty Eiffel.
--
-- Liberty Eiffel is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, version 3 of the License.
--
-- Liberty Eiffel is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with Liberty Eiffel.  If not, see <http://www.gnu.org/licenses/>.
--
class LIBERTY_TYPE_FEATURES_LOADER
	--
	-- Loads the type's own features.
	--
	-- Also loads the type's invariant.
	--

insert
	LIBERTY_TYPE_BUILDER_TOOLS

creation {LIBERTY_TYPE_BUILDER}
	make

feature {}
	make (a_builder: like builder; a_current_entity: like current_entity; a_universe: like universe;
		a_effective_generic_parameters: like effective_generic_parameters; a_redefined_features: like redefined_features) is
		require
			a_builder /= Void
			a_current_entity /= Void
			a_universe /= Void
			a_redefined_features /= Void
		do
			builder := a_builder
			current_entity := a_current_entity
			type := a_current_entity.result_type
			universe := a_universe
			effective_generic_parameters := a_effective_generic_parameters
			redefined_features := a_redefined_features
			create {HASHED_DICTIONARY[LIBERTY_WRITABLE_FEATURE, FIXED_STRING]} feature_writables.with_capacity(3)
		ensure
			builder = a_builder
			current_entity = a_current_entity
			universe = a_universe
			effective_generic_parameters = a_effective_generic_parameters
			redefined_features = a_redefined_features
		end

feature {LIBERTY_TYPE_BUILDER}
	load is
		local
			ast: LIBERTY_AST_ONE_CLASS
		do
			ast := type.ast
			add_features(ast.features)
			check_that_all_redefined_features_were_redefined
			if not errors.has_error then
				add_creations(ast.creations)
				if not errors.has_error then
					type.set_invariant(class_invariant(ast.invariant_clause))
				end
			end
		end

feature {}
	add_features (features: EIFFEL_LIST_NODE) is
		local
			i, j: INTEGER; clients: COLLECTION[LIBERTY_TYPE]
			f: LIBERTY_AST_FEATURE; fd: LIBERTY_AST_FEATURE_DEFINITION
		do
			from
				i := features.lower
			until
				i > features.upper
			loop
				f ::= features.item(i)
				clients := list_clients(f.clients)
				from
					j := f.definition_list.lower
				until
					errors.has_error or else j > f.definition_list.upper
				loop
					fd ::= f.definition_list.item(j)
					add_feature(clients, fd)
					j := j + 1
				end
				i := i + 1
			end
		end

	add_feature (clients: COLLECTION[LIBERTY_TYPE]; a_feature: LIBERTY_AST_FEATURE_DEFINITION) is
		local
			result_type: LIBERTY_TYPE
			the_feature: LIBERTY_FEATURE
			local_context: LIBERTY_FEATURE_LOCAL_CONTEXT
			type_resolver: LIBERTY_TYPE_RESOLVER_IN_FEATURE
			fn: LIBERTY_AST_FEATURE_NAME
		do
			create local_context.make(type)
			if a_feature.signature.has_result_type then
				result_type := type_lookup.resolver.type(a_feature.signature.result_type)
				local_context.set_result_type(result_type)
			end
			local_context.set_feature_names(a_feature.signature.feature_names)
			fn ::= a_feature.signature.feature_names.first
			create type_resolver.make(fn, local_context)
			type_lookup.push(type_resolver)

			if a_feature.has_routine_definition then
				if a_feature.signature.has_parameters then
					list_parameters(a_feature.signature.parameters, local_context)
				end
				the_feature := routine_definition(a_feature.routine_definition, local_context)
			else
				if a_feature.signature.has_parameters then
					errors.add_position(semantics_position_at(a_feature.signature.node_at(1)))
					errors.set(level_error, once "Unexpected parameters")
				elseif not a_feature.signature.has_result_type then
					errors.add_position(semantics_position_after(fn.feature_name_or_alias.node_at(fn.feature_name_or_alias.upper)))
					errors.set(level_error, once "Missing entity type")
				else
					if a_feature.is_constant then
						the_feature := feature_constant(a_feature.constant, local_context)
					elseif a_feature.is_unique then
						create {LIBERTY_FEATURE_UNIQUE} the_feature.make(type)
					else
						if a_feature.signature.has_parameters then
							--|*** TODO: error: an attribute cannot have parameters!
							not_yet_implemented
						end
						create {LIBERTY_FEATURE_ATTRIBUTE} the_feature.make(type)
					end
				end
			end
			if not errors.has_error then
				the_feature.set_context(local_context)
				add_feature_definition(the_feature, a_feature.signature.feature_names, clients)
			end

			the_feature.set_type_resolver(type_resolver)

			type_lookup.pop
		end

	routine_definition (routine_def: LIBERTY_AST_ROUTINE_DEFINITION; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_FEATURE is
		require
			local_context /= Void
		local
			obsolete_message: STRING
			routine_execution: LIBERTY_AST_ROUTINE_EXECUTION
			do_block: LIBERTY_AST_DO_BLOCK
			routine: LIBERTY_FEATURE_ROUTINE; ext: LIBERTY_FEATURE_EXTERNAL
			comp: LIBERTY_INSTRUCTION
		do
			if routine_def.obsolete_clause.count > 0 then
				obsolete_message := decoded_string(routine_def.obsolete_clause.string)
			end
			routine_execution := routine_def.execution
			if routine_execution.is_external then
				if routine_execution.external_clause.alias_clause.has_alias then
					create ext.make(type,
										 decoded_string(routine_execution.external_clause.definition).intern,
										 decoded_string(routine_execution.external_clause.alias_clause.definition).intern,
										 local_context.best_accelerator)
				else
					create ext.make(type,
										 decoded_string(routine_execution.external_clause.definition).intern,
										 Void,
										 local_context.best_accelerator)
				end
				if not routine_def.rescue_block.is_empty then
					ext.set_rescue(compound(routine_def.rescue_block.list, local_context))
				end
				Result := ext
			else
				check routine_execution.is_regular end
				do_block := routine_execution.do_block
				if do_block.is_deferred then
					create {LIBERTY_FEATURE_DEFERRED} Result.make(type)
				elseif do_block.is_attribute then
					create {LIBERTY_FEATURE_ATTRIBUTE} Result.make(type)
				else
					list_locals(routine_execution.local_block, local_context)
					comp := compound(routine_execution.do_block.list, local_context)
					if not errors.has_error then
						if do_block.is_do then
							create {LIBERTY_FEATURE_DO} routine.make(type, comp, local_context.best_accelerator)
						else
							check do_block.is_once end
							create {LIBERTY_FEATURE_ONCE} routine.make(type, comp, local_context.best_accelerator)
						end
						if not routine_def.rescue_block.is_empty then
							routine.set_rescue(compound(routine_def.rescue_block.list, local_context))
						end
						Result := routine
					end
				end
			end
			if not errors.has_error then
				Result.set_precondition(feature_precondition(routine_def.require_clause, local_context))
				Result.set_postcondition(feature_postcondition(routine_def.ensure_clause, local_context))
				if not errors.has_error then
					local_context.reconcile_retry_instructions(Result)
				end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	feature_precondition (precondition: LIBERTY_AST_REQUIRE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_REQUIRE is
		require
			precondition /= Void
			local_context /= Void
		local
			assertions: COLLECTION[LIBERTY_ASSERTION]
		do
			assertions := feature_assertions(precondition, local_context)
			if not errors.has_error then
				if precondition.count = 0 then
					create Result.make(assertions)
				elseif precondition.require_else.is_require_else then
					create {LIBERTY_REQUIRE_ELSE} Result.make(assertions)
				elseif precondition.require_else.is_require_then then
					create {LIBERTY_REQUIRE_THEN} Result.make(assertions)
				else
					create Result.make(assertions)
				end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	feature_postcondition (postcondition: LIBERTY_AST_ENSURE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_ENSURE is
		require
			postcondition /= Void
			local_context /= Void
		local
			assertions: COLLECTION[LIBERTY_ASSERTION]
		do
			assertions := feature_assertions(postcondition, local_context)
			if not errors.has_error then
				if postcondition.count = 0 then
					create Result.make(assertions)
				elseif postcondition.ensure_then.is_ensure_then then
					create {LIBERTY_ENSURE_THEN} Result.make(assertions)
				else
					create Result.make(assertions)
				end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	empty_feature_assertions: COLLECTION[LIBERTY_ASSERTION] is
		once
			create {FAST_ARRAY[LIBERTY_ASSERTION]} Result.with_capacity(0)
		end

	feature_assertions (assertions: LIBERTY_AST_LIST[LIBERTY_AST_ASSERTION]; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): COLLECTION[LIBERTY_ASSERTION] is
		require
			assertions /= Void
			local_context /= Void
		local
			i: INTEGER; assertion: LIBERTY_AST_ASSERTION
			tag: FIXED_STRING; exp: LIBERTY_EXPRESSION
		do
			if assertions.list_count = 0 then
				Result := empty_feature_assertions
			else
				create {FAST_ARRAY[LIBERTY_ASSERTION]} Result.with_capacity(assertions.list_count)
				from
					i := assertions.list_lower
				until
					errors.has_error or else i > assertions.list_upper
				loop
					assertion := assertions.list_item(i)
					if assertion.expression.has_expression then
						if assertion.tag.has_tag then
							tag := assertion.tag.tag.image.image.intern
						else
							tag := Void
						end
						if assertion.expression.has_expression then
							exp := expression(assertion.expression.expression, local_context)
							Result.add_last(create {LIBERTY_ASSERTION}.make(tag, exp))
						end
					end
					i := i + 1
				end
			end
		end

	feature_constant (constant: LIBERTY_AST_MANIFEST_OR_TYPE_TEST; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_FEATURE_CONSTANT is
		require
			local_context.result_type /= Void
		local
			tm: like typed_manifest_or_type_test
		do
			if constant.is_assignment_test then
				errors.add_position(semantics_position_at(constant.node_at(0)))
				errors.set(level_error, once "Unexpected assignment test")
			elseif constant.is_typed_open_argument then
				errors.add_position(semantics_position_at(constant.node_at(0)))
				errors.set(level_error, once "Unexpected open argument")
			else
				tm := typed_manifest_or_type_test(constant, local_context)
				if not errors.has_error then
					create Result.make(type, tm)
				end
			end
		end

	add_feature_definition (a_feature: LIBERTY_FEATURE; names: EIFFEL_LIST_NODE; clients: COLLECTION[LIBERTY_TYPE]) is
		local
			i: INTEGER; name: LIBERTY_AST_FEATURE_NAME; feature_name: LIBERTY_FEATURE_NAME
			fd_parent, fd: LIBERTY_FEATURE_DEFINITION
			name_or_alias: LIBERTY_AST_FEATURE_NAME_OR_ALIAS
			redefined: LIBERTY_FEATURE_REDEFINED
		do
			from
				i := names.lower
			until
				i > names.upper
			loop
				name ::= names.item(i)
				create feature_name.make_from_ast(name.feature_name_or_alias, type.ast, type.file)
				if type.has_feature(feature_name) then
					if redefined_features = Void then
						redefined := Void
					else
						redefined := redefined_features.reference_at(feature_name)
					end
					if redefined = Void then
						fd_parent := type.feature_definition(feature_name)
						check
							{LIBERTY_FEATURE_DEFERRED} ?:= fd_parent.the_feature
						end
						if fd_parent.the_feature.definition_type = type then
							--|*** TODO: warning or error?? an undefined feature should not be defined
						end
						create fd.make(feature_name, clients, name.is_frozen, feature_name.position)
						fd.set_the_feature(a_feature)

						if i = names.lower then
							debug
								std_output.put_string(once " <=>  late binding down to ")
								std_output.put_string(type.full_name)
								std_output.put_string(once " of defined feature ")
								std_output.put_line(feature_name.full_name)
							end
							fd_parent.the_feature.bind(a_feature, type)
						else
							check
								fd_parent.the_feature.bound(type) = a_feature
							end
						end

						type.replace_feature(fd)
					elseif redefined.redefined_feature = Void then
						redefined.set_redefined_feature(a_feature)
					elseif redefined.redefined_feature = a_feature then
						-- Nothing, just another name for the same feature
					else
						name_or_alias := name.feature_name_or_alias
						errors.add_position(semantics_position_at(name_or_alias.node_at(0)))
						errors.set(level_error, once "Duplicate feature: " + feature_name.name)
					end
				else
					create fd.make(feature_name, clients, name.is_frozen, feature_name.position)
					fd.set_the_feature(a_feature)
					type.add_feature(fd)
				end
				i := i + 1
			end
		end

	check_that_all_redefined_features_were_redefined is
		local
			i: INTEGER; feature_name: LIBERTY_FEATURE_NAME
		do
			if redefined_features /= Void then
				from
					i := redefined_features.lower
				until
					i > redefined_features.upper
				loop
					if redefined_features.item(i).redefined_feature = Void then
						feature_name := redefined_features.key(i)
						errors.add_position(feature_name.position)
						errors.set(level_error, once "Missing redefinition for " + feature_name.name + once " in " + type.out)
					end
					i := i + 1
				end
			end
		end

feature {}
	add_creations (creations: EIFFEL_LIST_NODE) is
		local
			i, j: INTEGER; clients: COLLECTION[LIBERTY_TYPE]
			c: LIBERTY_AST_CLASS_CREATION; fn: LIBERTY_AST_FEATURE_NAME
		do
			from
				i := creations.lower
			until
				i > creations.upper
			loop
				c ::= creations.item(i)
				clients := list_clients(c.clients)
				from
					j := c.feature_names.lower
				until
					errors.has_error or else j > c.feature_names.upper
				loop
					fn ::= c.feature_names.item(j)
					add_creation(clients, fn)
					j := j + 1
				end
				i := i + 1
			end
		end

	add_creation (a_clients: COLLECTION[LIBERTY_TYPE]; fn: LIBERTY_AST_FEATURE_NAME) is
		local
			the_feature: LIBERTY_FEATURE_DEFINITION
			feature_name: LIBERTY_FEATURE_NAME
		do
			create feature_name.make_from_ast(fn.feature_name_or_alias, type.ast, type.file)
			if type.has_feature(feature_name) then
				the_feature := type.feature_definition(feature_name)
				the_feature.set_creation_clients(a_clients)
				torch.burn
			else
				--|*** TODO: error: unknown feature
				not_yet_implemented
			end
		end

feature {}
	class_invariant (invariant_clause: LIBERTY_AST_INVARIANT): LIBERTY_INVARIANT is
		do
			--|*** TODO
		end

feature {} -- Instructions
	empty_instruction: LIBERTY_EMPTY is
		once
			create Result.make
		end

	compound (insts: EIFFEL_LIST_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_INSTRUCTION is
		require
			insts /= Void
			local_context /= Void
		local
			i, n: INTEGER; inst: LIBERTY_AST_INSTRUCTION
			instructions: COLLECTION[LIBERTY_INSTRUCTION]
		do
			n := insts.count
			inspect
				n
			when 0 then
				Result := empty_instruction
			when 1 then
				inst ::= insts.first
				Result := instruction(inst, local_context)
			else
				create {FAST_ARRAY[LIBERTY_INSTRUCTION]} instructions.with_capacity(n)
				from
					i := insts.lower
				until
					i > insts.upper
				loop
					inst ::= insts.item(i)
					instructions.add_last(instruction(inst, local_context))
					i := i + 1
				end
				create {LIBERTY_COMPOUND} Result.make(instructions, instructions.first.position)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	instruction (inst: LIBERTY_AST_INSTRUCTION; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_INSTRUCTION is
		require
			inst /= Void
			local_context /= Void
		local
			assignment_or_call: LIBERTY_AST_ASSIGNMENT_OR_CALL
		do
			inspect
				inst.instruction.name
			when "Assignment_Or_Call" then
				assignment_or_call ::= inst.instruction
				if assignment_or_call.is_assignment then
					Result := instruction_assignment(assignment_or_call, local_context)
				else
					Result := instruction_call(assignment_or_call, local_context)
				end
			when "If_Then_Else" then
				Result := instruction_ifthenelse(inst.instruction, local_context)
			when "Inspect" then
				Result := instruction_inspect(inst.instruction, local_context)
			when "Loop" then
				Result := instruction_loop(inst.instruction, local_context)
			when "Check" then
				Result := instruction_check(inst.instruction, local_context)
			when "Debug" then
				Result := instruction_debug(inst.instruction, local_context)
			when "Creation", "Old_Creation" then
				Result := instruction_creation(inst.instruction, local_context)
			when "Retry" then
				Result := instruction_retry(inst.instruction, local_context)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	instruction_assignment (a_assignment: LIBERTY_AST_ASSIGNMENT_OR_CALL; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_ASSIGNMENT is
		require
			a_assignment.is_assignment
		local
			w: LIBERTY_WRITABLE
			exp: LIBERTY_EXPRESSION
		do
			w := writable(a_assignment.writable, local_context)
			exp := expression(a_assignment.expression, local_context)
			if a_assignment.is_regular_assignment then
				create {LIBERTY_ASSIGNMENT_REGULAR} Result.make(w, exp, w.position)
			elseif a_assignment.is_forced_assignment then
				create {LIBERTY_ASSIGNMENT_FORCED} Result.make(w, exp, w.position)
			elseif a_assignment.is_assignment_attempt then
				create {LIBERTY_ASSIGNMENT_ATTEMPT} Result.make(w, exp, w.position)
			else
				check False end
			end
		end

	instruction_call (a_call: LIBERTY_AST_ASSIGNMENT_OR_CALL; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_INSTRUCTION is
		require
			a_call.is_call
		local
			tgt: LIBERTY_EXPRESSION
			fe: LIBERTY_FEATURE_ENTITY
			fa: COLLECTION[LIBERTY_EXPRESSION]
			r10: LIBERTY_AST_R10
		do
			r10 := a_call.r10
			if r10.is_empty then
				Result := implicit_feature_call_instruction(a_call.target, local_context)
			else
				from
					tgt := target_or_implicit_feature_call_expression(a_call.target, local_context)
				until
					errors.has_error or else Result /= Void
				loop
					fe ::= entity(tgt.result_type, r10.feature_name, Void)
					fa := actuals(r10.actuals, local_context)
					r10 := r10.remainder
					if r10.is_empty then
						Result := create_instruction_call(tgt, fe, fa, tgt.position)
					else
						tgt := create_expression_call(tgt, fe, fa, tgt.position)
					end
				end
			end
			check
				errors.has_error or else r10.is_empty
			end
		end

	instruction_ifthenelse (a_cond: LIBERTY_AST_NON_TERMINAL_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_CONDITIONAL is
		require
			a_cond /= Void
			{LIBERTY_AST_IF_THEN_ELSE} ?:= a_cond
		local
			ifthenelse: LIBERTY_AST_IF_THEN_ELSE
			ifthen: LIBERTY_AST_IF
			conditional: LIBERTY_CONDITIONAL
			i: INTEGER
		do
			ifthenelse ::= a_cond
			create conditional.make(semantics_position_at(ifthenelse.then_clause.node_at(0)))
			conditional.add_condition(condition(ifthenelse.then_clause, local_context))
			from
				i := ifthenelse.elseif_list.lower
			until
				i > ifthenelse.elseif_list.upper
			loop
				ifthen ::= ifthenelse.elseif_list.item(i)
				conditional.add_condition(condition(ifthen, local_context))
				i := i + 1
			end
			conditional.set_else_clause(else_clause(ifthenelse.else_clause, local_context))
			Result := conditional
		end

	condition (a_if: LIBERTY_AST_IF; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_CONDITION is
		do
			create Result.make(expression(a_if.expression, local_context), compound(a_if.instructions, local_context),
									 semantics_position_at(a_if.node_at(0)))
		end

	else_clause (a_else: LIBERTY_AST_ELSE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_DEFAULT is
		do
			if not a_else.is_empty then
				create Result.make(compound(a_else.list, local_context),
										 semantics_position_at(a_else.node_at(0)))
			end
		end

	instruction_inspect (a_inspect: LIBERTY_AST_NON_TERMINAL_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_INSPECT is
		require
			a_inspect /= Void
			{LIBERTY_AST_INSPECT} ?:= a_inspect
		local
			inspct: LIBERTY_AST_INSPECT
			insp: LIBERTY_INSPECT
			i: INTEGER
		do
			inspct ::= a_inspect
			create insp.make(expression(inspct.expression, local_context), semantics_position_at(inspct.node_at(0)))
			from
				i := inspct.when_list.lower
			until
				i > inspct.when_list.upper
			loop
				insp.add_clause(inspect_clause(inspct.when_list.item(i), local_context))
				i := i + 1
			end
			insp.set_else_clause(else_clause(inspct.else_clause, local_context))
			Result := insp
		end

	inspect_clause (a_clause: EIFFEL_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_INSPECT_CLAUSE is
		require
			{LIBERTY_AST_WHEN} ?:= a_clause
		local
			when_clause: LIBERTY_AST_WHEN
			when_slice: LIBERTY_AST_WHEN_SLICE
			i: INTEGER
			low, up: LIBERTY_EXPRESSION
		do
			when_clause ::= a_clause
			create Result.make(compound(when_clause.instructions, local_context), semantics_position_at(when_clause.node_at(0)))
			from
				i := when_clause.when_slices.lower
			until
				i > when_clause.when_slices.upper
			loop
				when_slice ::= when_clause.when_slices.item(i)
				low := when_value(when_slice.low_value, local_context)
				if when_slice.has_up_value then
					up := when_value(when_slice.up_value, local_context)
				else
					up := Void
				end
				Result.add_value(create {LIBERTY_INSPECT_SLICE}.make(low, up, low.position))
				i := i + 1
			end
		end

	when_value (value: LIBERTY_AST_WHEN_VALUE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			e: LIBERTY_FEATURE_ENTITY; entity_name: LIBERTY_AST_ENTITY_NAME; name: FIXED_STRING
		do
			if value.is_number then
				Result := number(value.number.image)
			elseif value.is_character then
				Result := character(value.character.image)
			elseif value.is_string then
				create {LIBERTY_STRING_MANIFEST} Result.make(universe.type_string, decoded_string(value.string), True, semantics_position_at(value.node_at(0)))
			elseif value.is_entity_name then
				entity_name := value.entity_name
				name := entity_name.image.image.intern
				-- may be a local or a parameter of a regular feature name
				if local_context.is_local(name) then
					create {LIBERTY_ENTITY_EXPRESSION} Result.make(local_context.local_var(name), errors.semantics_position(entity_name.image.index, type.ast, type.file))
				elseif local_context.is_parameter(name) then
					create {LIBERTY_ENTITY_EXPRESSION} Result.make(local_context.parameter(name), errors.semantics_position(entity_name.image.index, type.ast, type.file))
				else
					e := feature_entity(type, create {LIBERTY_FEATURE_NAME}.make_regular(name, errors.semantics_position(entity_name.image.index, type.ast, type.file)))
					Result := create_implicit_expression_call(e, empty_actuals, errors.semantics_position(entity_name.image.index, type.ast, type.file))
				end
			else
				check False end
			end
		ensure
			Result /= Void
		end

	instruction_loop (a_loop: LIBERTY_AST_NON_TERMINAL_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_LOOP is
		require
			a_loop /= Void
			{LIBERTY_AST_LOOP} ?:= a_loop
		local
			l00p: LIBERTY_AST_LOOP
			init, body: like compound
			exp, variant_clause: LIBERTY_EXPRESSION
			invariant_clause: LIBERTY_INVARIANT
		do
			l00p ::= a_loop
			init := compound(l00p.from_clause.instructions, local_context)
			invariant_clause := loop_invariant(l00p.invariant_clause, local_context)
			if l00p.variant_clause.has_expression then
				variant_clause := expression(l00p.variant_clause.expression, local_context)
			end
			exp := expression(l00p.expression, local_context)
			body := compound(l00p.instructions, local_context)
			create Result.make(init, invariant_clause, variant_clause, exp, body, init.position)
		end

	loop_invariant (invariant_clause: LIBERTY_AST_INVARIANT; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_INVARIANT is
		require
			invariant_clause /= Void
			local_context /= Void
		local
			assertions: COLLECTION[LIBERTY_ASSERTION]
		do
			assertions := feature_assertions(invariant_clause, local_context)
			if not errors.has_error then
				create Result.make(assertions)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	instruction_check (a_check: LIBERTY_AST_NON_TERMINAL_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_CHECK_INSTRUCTION is
		require
			a_check /= Void
			{LIBERTY_AST_CHECK} ?:= a_check
		local
			chk: LIBERTY_AST_CHECK; ck: LIBERTY_CHECK
		do
			chk ::= a_check
			create ck.make(feature_assertions(chk, local_context))
			create Result.make(ck, semantics_position_at(chk.node_at(0)))
		end

	instruction_debug (a_debug: LIBERTY_AST_NON_TERMINAL_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_DEBUG is
		require
			a_debug /= Void
			{LIBERTY_AST_DEBUG} ?:= a_debug
		local
			dbg: LIBERTY_AST_DEBUG
			keys: COLLECTION[FIXED_STRING]; inst: like compound
			i: INTEGER
		do
			dbg ::= a_debug
			if dbg.debug_keys.list_count = 0 then
				keys := empty_debug_keys
			else
				create {FAST_ARRAY[FIXED_STRING]} keys.with_capacity(dbg.debug_keys.list_count)
				from
					i := dbg.debug_keys.list_lower
				until
					i > dbg.debug_keys.list_upper
				loop
					keys.add_last(decoded_string(dbg.debug_keys.list_item(i)).intern)
					i := i + 1
				end
			end
			inst := compound(dbg.instructions, local_context)
			create Result.make(keys, inst, semantics_position_at(dbg.node_at(0)))
		ensure
			Result /= Void
		end

	empty_debug_keys: COLLECTION[FIXED_STRING] is
		once
			create {FAST_ARRAY[FIXED_STRING]} Result.with_capacity(0)
		end

	instruction_creation (a_creation: LIBERTY_AST_NON_TERMINAL_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_CREATION_INSTRUCTION is
		require
			a_creation /= Void
			{LIBERTY_AST_CREATION} ?:= a_creation
		local
			creat: LIBERTY_AST_CREATION
			w: LIBERTY_WRITABLE
			creation_type: LIBERTY_TYPE
			fe: LIBERTY_FEATURE_ENTITY
			fa: COLLECTION[LIBERTY_EXPRESSION]
		do
			creat ::= a_creation
			w := writable(creat.writable, local_context)
			if creat.has_type_definition then
				creation_type := type_lookup.resolver.type(creat.type_definition)
			else
				creation_type := w.result_type
			end
			if creat.has_creation_feature_call then
				fe := feature_entity(creation_type, create {LIBERTY_FEATURE_NAME}.make_regular(creat.creation_feature_name.image.image.intern, errors.semantics_position(creat.creation_feature_name.image.index, type.ast, type.file)))
				fa := actuals(creat.creation_feature_actuals, local_context)
			else
				fe := feature_entity(creation_type, default_create_name)
				fa := empty_actuals
			end
			create Result.make(w, creation_type, fe, fa, semantics_position_at(creat.node_at(0)))
		end

	default_create_name: LIBERTY_FEATURE_NAME is
		once
			create Result.make_regular("default_create".intern, errors.unknown_position)
		end

	instruction_retry (a_retry: LIBERTY_AST_NON_TERMINAL_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_RETRY is
		require
			a_retry /= Void
			{LIBERTY_AST_RETRY} ?:= a_retry
		local
			re: LIBERTY_AST_RETRY
		do
			re ::= a_retry
			Result := local_context.retry_instruction(semantics_position_at(re.node_at(0)))
		end

feature {} -- Entities and writables
	writable (a_writable: LIBERTY_AST_WRITABLE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_WRITABLE is
		local
			name: FIXED_STRING
		do
			if a_writable.is_result then
				Result := local_context.result_entity
			else
				name := a_writable.entity_name.image.image.intern
				if local_context.is_local(name) then
					Result := local_context.local_var(name)
				elseif local_context.is_parameter(name) then
					--|*** TODO: error! (not writable)
					not_yet_implemented
				else
					Result := feature_writable(name, errors.semantics_position(a_writable.entity_name.image.index, type.ast, type.file))
				end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	entity (target_type: LIBERTY_TYPE; a_entity: LIBERTY_AST_ENTITY_NAME; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_ENTITY is
		require
			(target_type = Void) /= (local_context = Void)
		local
			name: FIXED_STRING
		do
			name := a_entity.image.image.intern
			if local_context = Void then
				Result := feature_entity(target_type, create {LIBERTY_FEATURE_NAME}.make_regular(name, errors.semantics_position(a_entity.image.index, type.ast, type.file)))
			else
				if name.is_equal(once "Current") then
					Result := current_entity
				elseif name.is_equal(once "Result") then
					Result := local_context.result_entity
				elseif local_context.is_local(name) then
					Result := local_context.local_var(name)
				elseif local_context.is_parameter(name) then
					Result := local_context.parameter(name)
				else
					Result := feature_entity(type, create {LIBERTY_FEATURE_NAME}.make_regular(name, errors.semantics_position(a_entity.image.index, type.ast, type.file)))
				end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	implicit_feature_call_instruction (a_target: LIBERTY_AST_TARGET; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_INSTRUCTION is
		local
			e: LIBERTY_FEATURE_ENTITY; entity_name: LIBERTY_AST_ENTITY_NAME; name: FIXED_STRING
			f: LIBERTY_FEATURE; precursor_type: LIBERTY_ACTUAL_TYPE
			tn: LIBERTY_AST_TERMINAL_NODE
		do
			if a_target.is_current then
				--| TODO: error
				not_yet_implemented
			elseif a_target.is_result then
				--| TODO: error
				not_yet_implemented
			elseif a_target.is_implicit_feature_call then
				entity_name := a_target.implicit_feature_name
				name := entity_name.image.image.intern
				-- may be a local or a parameter of a regular feature name
				if local_context.is_local(name) then
					--| TODO: error
					not_yet_implemented
				elseif local_context.is_parameter(name) then
					--| TODO: error
					not_yet_implemented
				else
					e := feature_entity(type, create {LIBERTY_FEATURE_NAME}.make_regular(name, errors.semantics_position(entity_name.image.index, type.ast, type.file)))
					Result := create_implicit_instruction_call(e, actuals(a_target.actuals, local_context), errors.semantics_position(entity_name.image.index, type.ast, type.file))
				end
			elseif a_target.is_precursor then
				if a_target.precursor_type_mark.count /= 0 then
					precursor_type ::= type_lookup.resolver.type(a_target.precursor_type_mark.type_definition)
				end
				f := local_context.find_precursor(precursor_type, redefined_features, type.ast, type.file)
				if f = Void then
					tn ::= a_target.node_at(0)
					errors.add_position(errors.semantics_position(tn.image.index, type.ast, type.file))
					if precursor_type /= Void then
						errors.add_position(type_lookup.resolver.position(a_target.precursor_type_mark.type_definition))
						errors.set(level_error, once "Could not find any Precursor of " + local_context.written_feature_names + once " in " + precursor_type.out)
					else
						errors.set(level_error, once "Could not find any Precursor of " + local_context.written_feature_names + once " in any parent of " + type.out)
					end
				else
					create {LIBERTY_PRECURSOR_INSTRUCTION} Result.make(f, actuals(a_target.actuals, local_context), semantics_position_at(a_target.node_at(0)))
				end
			elseif a_target.is_parenthesized_expression then
				--| TODO: error
				not_yet_implemented
			else
				check False end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	target_or_implicit_feature_call_expression (a_target: LIBERTY_AST_TARGET; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			e: LIBERTY_FEATURE_ENTITY; entity_name: LIBERTY_AST_ENTITY_NAME; name: FIXED_STRING
			f: LIBERTY_FEATURE; precursor_type: LIBERTY_ACTUAL_TYPE
		do
			if a_target.is_current then
				create {LIBERTY_ENTITY_EXPRESSION} Result.make(current_entity, semantics_position_at(a_target.node_at(0)))
			elseif a_target.is_result then
				create {LIBERTY_ENTITY_EXPRESSION} Result.make(local_context.result_entity, semantics_position_at(a_target.node_at(0)))
			elseif a_target.is_manifest_or_type_test then
				Result := typed_manifest_or_type_test(a_target.manifest_or_type_test, local_context)
			elseif a_target.is_implicit_feature_call then
				entity_name := a_target.implicit_feature_name
				name := entity_name.image.image.intern
				-- may be a local or a parameter of a regular feature name
				if local_context.is_local(name) then
					create {LIBERTY_ENTITY_EXPRESSION} Result.make(local_context.local_var(name), errors.semantics_position(entity_name.image.index, type.ast, type.file))
					--| TODO: check no actuals
				elseif local_context.is_parameter(name) then
					create {LIBERTY_ENTITY_EXPRESSION} Result.make(local_context.parameter(name), errors.semantics_position(entity_name.image.index, type.ast, type.file))
					--| TODO: check no actuals
				else
					e := feature_entity(type, create {LIBERTY_FEATURE_NAME}.make_regular(name, errors.semantics_position(entity_name.image.index, type.ast, type.file)))
					Result := create_implicit_expression_call(e, actuals(a_target.actuals, local_context), errors.semantics_position(entity_name.image.index, type.ast, type.file))
				end
			elseif a_target.is_precursor then
				if a_target.precursor_type_mark.count /= 0 then
					precursor_type ::= type_lookup.resolver.type(a_target.precursor_type_mark.type_definition)
				end
				f := local_context.find_precursor(precursor_type, redefined_features, type.ast, type.file)
				create {LIBERTY_PRECURSOR_EXPRESSION} Result.make(f, actuals(a_target.actuals, local_context), semantics_position_at(a_target.node_at(0)))
			elseif a_target.is_parenthesized_expression then
				Result := expression(a_target.parenthesized_expression, local_context)
			else
				check False end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	feature_writable (name: FIXED_STRING; position: LIBERTY_POSITION): LIBERTY_WRITABLE_FEATURE is
		require
			name = name.intern
		do
			Result := feature_writables.reference_at(name)
			if Result = Void then
				create {LIBERTY_WRITABLE_FEATURE} Result.make(feature_entity(type, create {LIBERTY_FEATURE_NAME}.make_regular(name, position)), position)
				feature_writables.put(Result, name)
				torch.burn
			end
		ensure
			Result.name = name
		end

	feature_entity (target_type: LIBERTY_TYPE; name: LIBERTY_FEATURE_NAME): LIBERTY_FEATURE_ENTITY is
		require
			name /= Void
		do
			create {LIBERTY_FEATURE_ENTITY} Result.make(name, target_type, create {LIBERTY_DELAYED_FEATURE_TYPE}.make(target_type, name))
		ensure
			Result.feature_name.is_equal(name)
		end

	current_entity: LIBERTY_CURRENT
	feature_writables: DICTIONARY[LIBERTY_WRITABLE_FEATURE, FIXED_STRING]

feature {} -- Expressions
	actuals (a_actuals: LIBERTY_AST_ACTUALS; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): COLLECTION[LIBERTY_EXPRESSION] is
		local
			i: INTEGER
			act: LIBERTY_AST_ACTUAL
		do
			if a_actuals.list_count= 0 then
				Result := empty_actuals
			else
				create {FAST_ARRAY[LIBERTY_EXPRESSION]} Result.with_capacity(a_actuals.list_count)
				from
					i := a_actuals.list_lower
				until
					i > a_actuals.list_upper
				loop
					act := a_actuals.list_item(i)
					if act.is_expression then
						Result.add_last(expression(act.expression, local_context))
					else
						check act.is_ref_to_entity end
						Result.add_last(create {LIBERTY_ENTITY_REFERENCE}.make(universe.type_pointer,
																								 entity(Void, act.ref_entity_name, local_context),
																								 semantics_position_at(act.node_at(0))))
					end
					i := i + 1
				end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	empty_actuals: COLLECTION[LIBERTY_EXPRESSION] is
		once
			create {FAST_ARRAY[LIBERTY_EXPRESSION]} Result.make(0)
		end

	expression (exp: LIBERTY_AST_EXPRESSION; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			exp /= Void
			local_context /= Void
		do
			if exp.is_array then
				Result := expression_array(exp.array, local_context)
			else
				Result := expression_no_array(exp.no_array, local_context)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	expression_array (array: LIBERTY_AST_ARRAY; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_ARRAY_MANIFEST is
		require
			array /= Void
			local_context /= Void
		local
			i: INTEGER; content: COLLECTION[LIBERTY_EXPRESSION]
			exp: LIBERTY_AST_EXPRESSION; t: LIBERTY_TYPE
		do
			create {FAST_ARRAY[LIBERTY_EXPRESSION]} content.with_capacity(array.content.count)
			from
				i := array.content.lower
			until
				i > array.content.upper or else errors.has_error
			loop
				exp ::= array.content.item(i)
				content.add_last(expression(exp, local_context))
				i := i + 1
			end
			if not errors.has_error then
				t := common_conformant_type(content)
				create Result.make_array(t, content, semantics_position_at(array.node_at(0)))
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	common_conformant_type (a_contents: COLLECTION[LIBERTY_EXPRESSION]): LIBERTY_TYPE is
		local
			i: INTEGER
		do
			if a_contents.is_empty then
				Result := universe.type_any
			else
				from
					Result := a_contents.first.result_type
					i := a_contents.lower + 1
				until
					i > a_contents.upper
				loop
					Result := a_contents.item(i).result_type.actual_type.common_conformant_parent_with(Result.actual_type)
					if Result = Void then
						--| *** TODO fatal error
						not_yet_implemented
					end
					i := i + 1
				end
			end
		ensure
			no_common_parent_is_fatal: Result /= Void
		end

	expression_no_array (exp: LIBERTY_AST_EXPRESSION_NO_ARRAY; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			exp /= Void
			local_context /= Void
		do
			if exp.is_binary_expression then
				Result := binary_expression_1(exp.binary_expression, local_context)
			else
				Result := expression_1(exp.simple_expression, local_context)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	binary_expression_1 (exp1: LIBERTY_AST_EXP1; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			left, right: LIBERTY_EXPRESSION
		do
			if exp1.is_binary then
				left := binary_expression_1(exp1.left_binary, local_context)
			else
				left := expression_1(exp1.left_expression, local_context)
			end
			right := expression_1(exp1.right_expression, local_context)

			if exp1.is_implies then
				create {LIBERTY_IMPLIES} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp1.operator1))
			end
		end

	expression_1 (exp: LIBERTY_AST_E1; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			exp /= Void
			local_context /= Void
		do
			if exp.is_binary_expression then
				Result := binary_expression_2(exp.binary_expression, local_context)
			else
				Result := expression_2(exp.simple_expression, local_context)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	binary_expression_2 (exp2: LIBERTY_AST_EXP2; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			left, right: LIBERTY_EXPRESSION
		do
			if exp2.is_binary then
				left := binary_expression_2(exp2.left_binary, local_context)
			else
				left := expression_2(exp2.left_expression, local_context)
			end
			right := expression_2(exp2.right_expression, local_context)

			if exp2.is_or_else then
				create {LIBERTY_OR_ELSE} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp2.operator1))
			elseif exp2.is_or then
				create {LIBERTY_OR} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp2.operator1))
			elseif exp2.is_xor then
				create {LIBERTY_XOR} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp2.operator1))
			end
		end

	expression_2 (exp: LIBERTY_AST_E2; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			exp /= Void
			local_context /= Void
		do
			if exp.is_binary_expression then
				Result := binary_expression_3(exp.binary_expression, local_context)
			else
				Result := expression_3(exp.simple_expression, local_context)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	binary_expression_3 (exp3: LIBERTY_AST_EXP3; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			left, right: LIBERTY_EXPRESSION
		do
			if exp3.is_binary then
				left := binary_expression_3(exp3.left_binary, local_context)
			else
				left := expression_3(exp3.left_expression, local_context)
			end
			right := expression_3(exp3.right_expression, local_context)

			if exp3.is_and_then then
				create {LIBERTY_AND_THEN} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp3.operator1))
			elseif exp3.is_and then
				create {LIBERTY_AND} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp3.operator1))
			end
		end

	expression_3 (exp: LIBERTY_AST_E3; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			exp /= Void
			local_context /= Void
		do
			if exp.is_binary_expression then
				Result := binary_expression_4(exp.binary_expression, local_context)
			else
				Result := expression_4(exp.simple_expression, local_context)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	binary_expression_4 (exp4: LIBERTY_AST_EXP4; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			left, right: LIBERTY_EXPRESSION
		do
			if exp4.is_binary then
				left := binary_expression_4(exp4.left_binary, local_context)
			else
				left := expression_4(exp4.left_expression, local_context)
			end
			right := expression_4(exp4.right_expression, local_context)

			if exp4.is_eq then
				create {LIBERTY_EQUALS} Result.make(left, right, universe.type_boolean, image_semantics_position_at(exp4.operator1))
			elseif exp4.is_ne then
				create {LIBERTY_NOT_EQUALS} Result.make(left, right, universe.type_boolean, image_semantics_position_at(exp4.operator1))
			elseif exp4.is_le then
				create {LIBERTY_LESS_OR_EQUAL} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp4.operator1))
			elseif exp4.is_lt then
				create {LIBERTY_LESS_THAN} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp4.operator1))
			elseif exp4.is_ge then
				create {LIBERTY_GREATER_OR_EQUAL} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp4.operator1))
			elseif exp4.is_gt then
				create {LIBERTY_GREATER_THAN} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp4.operator1))
			end
		end

	expression_4 (exp: LIBERTY_AST_E4; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			exp /= Void
			local_context /= Void
		do
			if exp.is_binary_expression then
				Result := binary_expression_5(exp.binary_expression, local_context)
			else
				Result := expression_5(exp.simple_expression, local_context)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	binary_expression_5 (exp5: LIBERTY_AST_EXP5; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			left, right: LIBERTY_EXPRESSION
		do
			if exp5.is_binary then
				left := binary_expression_5(exp5.left_binary, local_context)
			else
				left := expression_5(exp5.left_expression, local_context)
			end
			right := expression_5(exp5.right_expression, local_context)

			if exp5.is_plus then
				create {LIBERTY_ADD} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp5.operator1))
			elseif exp5.is_minus then
				create {LIBERTY_SUBTRACT} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp5.operator1))
			end
		end

	expression_5 (exp: LIBERTY_AST_E5; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			exp /= Void
			local_context /= Void
		do
			if exp.is_binary_expression then
				Result := binary_expression_6(exp.binary_expression, local_context)
			else
				Result := expression_6(exp.simple_expression, local_context)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	binary_expression_6 (exp6: LIBERTY_AST_EXP6; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			left, right: LIBERTY_EXPRESSION
		do
			if exp6.is_binary then
				left := binary_expression_6(exp6.left_binary, local_context)
			else
				left := expression_6(exp6.left_expression, local_context)
			end
			right := expression_6(exp6.right_expression, local_context)

			if exp6.is_times then
				create {LIBERTY_TIMES} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp6.operator1))
			elseif exp6.is_divide then
				create {LIBERTY_DIVIDE} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp6.operator1))
			elseif exp6.is_int_divide then
				create {LIBERTY_INT_DIVIDE} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp6.operator1))
			elseif exp6.is_int_remainder then
				create {LIBERTY_INT_REMAINDER} Result.make(left, right, agent feature_entity, image_semantics_position_at(exp6.operator1))
			end
		end

	expression_6 (exp: LIBERTY_AST_E6; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			exp /= Void
			local_context /= Void
		do
			Result := expression_7(exp.e7, exp.r7, local_context)
		ensure
			not errors.has_error implies Result /= Void
		end

	expression_7 (e7: LIBERTY_AST_E7; r7: LIBERTY_AST_R7; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		do
			Result := expression_8(e7.e8, e7.r8, local_context)
			if r7.is_power then
				create {LIBERTY_POWER} Result.make(Result, expression_7(r7.expression, r7.remainder, local_context), agent feature_entity, Result.position)
			end
		end

	expression_8 (e8: LIBERTY_AST_E8; r8: LIBERTY_AST_R8; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			fn: LIBERTY_FEATURE_NAME
		do
			if e8.has_prefix_operator then
				inspect
					e8.prefix_operator.name
				when "KW +" then
					create {LIBERTY_POSITIVE} Result.make(expression_8(e8.prefixed_expression, r8, local_context), agent feature_entity, semantics_position_at(e8.prefix_operator))
				when "KW -" then
					create {LIBERTY_NEGATIVE} Result.make(expression_8(e8.prefixed_expression, r8, local_context), agent feature_entity, semantics_position_at(e8.prefix_operator))
				when "KW not" then
					create {LIBERTY_NOT} Result.make(expression_8(e8.prefixed_expression, r8, local_context), agent feature_entity, semantics_position_at(e8.prefix_operator))
				else
					create fn.make_prefix(e8.prefix_operator.image.image.intern, errors.semantics_position(e8.prefix_operator.image.index, type.ast, type.file))
					Result := expression_8(e8.prefixed_expression, r8, local_context)
					create {LIBERTY_PREFIX_OPERATOR} Result.make(Result, feature_entity(Result.result_type, fn), semantics_position_at(e8.prefix_operator))
				end
			else
				Result := expression_9(e8.e9, local_context)
			end
			if r8.is_free_operator then
				create fn.make_infix(r8.free_operator.image.image.intern, errors.semantics_position(r8.free_operator.image.index, type.ast, type.file))
				create {LIBERTY_INFIX_OPERATOR} Result.make(Result, expression_8(r8.expression, r8.remainder, local_context), feature_entity(Result.result_type, fn), Result.position)
			end
		end

	expression_9 (e9: LIBERTY_AST_E9; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		do
			Result := expression_10(e9.e10, local_context)
			if e9.has_old then
				create {LIBERTY_OLD} Result.make(Result, semantics_position_at(e9.node_at(0)))
			end
		end

	expression_10 (e10: LIBERTY_AST_E10; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		local
			exp: LIBERTY_EXPRESSION; agent_expression: LIBERTY_CALL_EXPRESSION
		do
			if e10.is_call then
				Result := expression_call(e10.call, local_context)
			elseif e10.is_tuple then
				Result := expression_tuple(e10.tuple_actuals, local_context, semantics_position_at(e10.node_at(0)))
			elseif e10.is_open_argument then
				create {LIBERTY_OPEN_ARGUMENT} Result.make(semantics_position_at(e10.node_at(0)))
			elseif e10.is_inline_agent then
				--|*** TODO
				not_yet_implemented
			elseif e10.is_agent_creation then
				exp := expression(e10.agent_creation_expression, local_context)
				if not agent_expression ?:= exp then
					--|*** TODO: error: not a call
					not_yet_implemented
				end
				agent_expression ::= exp
				create {LIBERTY_AGENT} Result.make(agent_expression, semantics_position_at(e10.node_at(0)))
			elseif e10.is_creation_expression then
				Result := expression_creation(e10.creation_expression, local_context)
			elseif e10.is_void then
				create {LIBERTY_VOID} Result.make(semantics_position_at(e10.node_at(0)))
			else
				check False end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	expression_creation (a_creation: LIBERTY_AST_CREATION_EXPRESSION; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			a_creation /= Void
		local
			entity_type: LIBERTY_TYPE
			creation_type: LIBERTY_ACTUAL_TYPE
			tgt: LIBERTY_EXPRESSION
			fe: LIBERTY_FEATURE_ENTITY
			fa: COLLECTION[LIBERTY_EXPRESSION]
		do
			entity_type := type_lookup.resolver.type(a_creation.type_definition)
			if creation_type ?:= entity_type then
				creation_type ::= entity_type
				if a_creation.r10.is_empty then
					fe := feature_entity(creation_type, default_create_name)
					fa := empty_actuals
					create {LIBERTY_CREATION_EXPRESSION} Result.make(creation_type, fe, fa, semantics_position_at(a_creation.node_at(0)))
				else
					fe := feature_entity(creation_type, create {LIBERTY_FEATURE_NAME}.make_regular(a_creation.r10.feature_name.image.image.intern, errors.semantics_position(a_creation.r10.feature_name.image.index, type.ast, type.file)))
					fa := actuals(a_creation.r10.actuals, local_context)
					create {LIBERTY_CREATION_EXPRESSION} tgt.make(creation_type, fe, fa, semantics_position_at(a_creation.node_at(0)))
					Result := expression_remainder(tgt, a_creation.r10.remainder, local_context)
				end
			else
				--|*** TODO: error: no anchor in creation type
				not_yet_implemented
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	expression_call (a_call: LIBERTY_AST_CALL; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			a_call /= Void
		do
			if a_call.is_call then
				Result := target_or_implicit_feature_call_expression(a_call.call_target, local_context)
				Result := expression_remainder(Result, a_call.call_r10, local_context)
			else
				check
					a_call.is_assignment_test
				end
				create {LIBERTY_ASSIGNMENT_TEST} Result.test_entity(entity(Void, a_call.assignment_test_entity_name, local_context),
																					 expression(a_call.assignment_test_expression, local_context),
																					 universe.type_boolean, semantics_position_at(a_call.assignment_test_entity_name))
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	expression_remainder (a_target: LIBERTY_EXPRESSION; a_remainder: LIBERTY_AST_R10; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			a_target /= Void
			a_remainder /= Void
		local
			tgt: LIBERTY_EXPRESSION
			fe: LIBERTY_FEATURE_ENTITY
			fa: COLLECTION[LIBERTY_EXPRESSION]
		do
			-- We may derecursivate this thing (algorithm similar to `instruction_call')
			-- but I guess modern compilers are smart enough to do that anyway :-)
			if not errors.has_error then
				if a_remainder.is_empty then
					Result := a_target
				else
					fe ::= entity(a_target.result_type, a_remainder.feature_name, Void)
					fa := actuals(a_remainder.actuals, local_context)
					tgt := create_expression_call(a_target, fe, fa, a_target.position) --|*** or semantics_position_at(a_remainder.node_at(0)) ??
					Result := expression_remainder(tgt, a_remainder.remainder, local_context)
				end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	expression_tuple (a_tuple: EIFFEL_LIST_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT; a_position: LIBERTY_POSITION): LIBERTY_TUPLE is
		local
			exp: LIBERTY_AST_ACTUAL
			expr: LIBERTY_EXPRESSION
			expressions: COLLECTION[LIBERTY_EXPRESSION]
			exp_types: COLLECTION[LIBERTY_TYPE]
			i: INTEGER
		do
			if a_tuple = Void then
				create {FAST_ARRAY[LIBERTY_EXPRESSION]} expressions.with_capacity(0)
				create {FAST_ARRAY[LIBERTY_TYPE]} exp_types.with_capacity(0)
			else
				from
					create {FAST_ARRAY[LIBERTY_EXPRESSION]} expressions.with_capacity(a_tuple.count)
					create {FAST_ARRAY[LIBERTY_TYPE]} exp_types.with_capacity(a_tuple.count)
					i := a_tuple.lower
				until
					errors.has_error or else i > a_tuple.upper
				loop
					exp ::= a_tuple.item(i)
					if exp.is_expression then
						expr := expression(exp.expression, local_context)
					else
						--| "$entity" expressions
						not_yet_implemented
					end
					if not errors.has_error then
						expressions.add_last(expr)
						exp_types.add_last(expr.result_type)
					end
					i := i + 1
				end
			end
			if not errors.has_error then
				create Result.make(universe.type_tuple(exp_types, a_position), expressions, a_position)
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	typed_manifest_or_type_test (constant: LIBERTY_AST_MANIFEST_OR_TYPE_TEST; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT): LIBERTY_EXPRESSION is
		require
			constant /= Void
			local_context /= Void
		local
			openarg: LIBERTY_OPEN_ARGUMENT
			entity_type: LIBERTY_TYPE
			actual_type: LIBERTY_ACTUAL_TYPE
		do
			if constant.is_assignment_test then
				entity_type := type_lookup.resolver.type(constant.assignment_test_type)
				if actual_type ?:= entity_type then
					actual_type ::= entity_type
					create {LIBERTY_ASSIGNMENT_TEST} Result.test_type(actual_type,
																					  expression(constant.assignment_test_expression, local_context),
																					  universe.type_boolean, semantics_position_at(constant.node_at(0)))
				else
					--|*** TODO: error: cannot use an anchor for assignment test
					not_yet_implemented
				end
			elseif constant.is_typed_open_argument then
				create openarg.make(semantics_position_at(constant.node_at(0)))
				openarg.set_result_type(type_lookup.resolver.type(constant.open_argument_type))
				Result := openarg
			elseif constant.is_number then
				Result := number(constant.number.image)
			elseif constant.is_true then
				create {LIBERTY_BOOLEAN_MANIFEST} Result.make(universe.type_boolean, True, semantics_position_at(constant.node_at(0)))
			elseif constant.is_false then
				create {LIBERTY_BOOLEAN_MANIFEST} Result.make(universe.type_boolean, False, semantics_position_at(constant.node_at(0)))
			elseif constant.is_character then
				Result := character(constant.character.image)
			elseif constant.is_string then
				create {LIBERTY_STRING_MANIFEST} Result.make(universe.type_string, decoded_string(constant.string), False, semantics_position_at(constant.node_at(0)))
			elseif constant.is_once_string then
				create {LIBERTY_STRING_MANIFEST} Result.make(universe.type_string, decoded_string(constant.string), True, semantics_position_at(constant.node_at(0)))
			elseif constant.is_number_typed_manifest then
				entity_type := type_lookup.resolver.type(constant.typed_manifest_type)
				if actual_type ?:= entity_type then
					actual_type ::= entity_type
					Result := number_typed_manifest(actual_type,
															  constant.typed_manifest_number.image)
				else
					--|*** TODO: error: cannot use an anchor for array type definition
					not_yet_implemented
				end
			elseif constant.is_string_typed_manifest then
				entity_type := type_lookup.resolver.type(constant.typed_manifest_type)
				if actual_type ?:= entity_type then
					actual_type ::= entity_type
					create {LIBERTY_STRING_TYPED_MANIFEST} Result.make(actual_type,
																					   decoded_string(constant.typed_manifest_string), semantics_position_at(constant.node_at(0)))
				else
					--|*** TODO: error: cannot use an anchor for array type definition
					not_yet_implemented
				end
			elseif constant.is_array_typed_manifest then
				entity_type := type_lookup.resolver.type(constant.typed_manifest_type)
				if actual_type ?:= entity_type then
					actual_type ::= entity_type
					Result := array_typed_manifest(actual_type,
															 constant.typed_manifest_array_parameters, constant.typed_manifest_array,
															 local_context, semantics_position_at(constant.node_at(0)))
				else
					--|*** TODO: error: cannot use an anchor for array type definition
					not_yet_implemented
				end
			else
				check False end
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	number (number_image: EIFFEL_IMAGE): LIBERTY_EXPRESSION is
		require
			({TYPED_EIFFEL_IMAGE[INTEGER_64]} ?:= number_image)
				or else ({TYPED_EIFFEL_IMAGE[REAL]} ?:= number_image)
		local
			i: TYPED_EIFFEL_IMAGE[INTEGER_64]
			r: TYPED_EIFFEL_IMAGE[REAL]
			i64: INTEGER_64
		do
			-- That's not pretty! but doing without all those type tests would incur big changes and code
			-- duplication in the eiffel parser :-/
			if i ?:= number_image then
				i ::= number_image
				i64 := i.decoded
				if i64.fit_integer_8 then
					create {LIBERTY_INTEGER_8_MANIFEST} Result.make(universe.type_integer_64, i64.to_integer_8, image_semantics_position_at(number_image))
				elseif i64.fit_integer_16 then
					create {LIBERTY_INTEGER_16_MANIFEST} Result.make(universe.type_integer_64, i64.to_integer_16, image_semantics_position_at(number_image))
				elseif i64.fit_integer_32 then
					create {LIBERTY_INTEGER_32_MANIFEST} Result.make(universe.type_integer_64, i64.to_integer_32, image_semantics_position_at(number_image))
				else
					create {LIBERTY_INTEGER_64_MANIFEST} Result.make(universe.type_integer_64, i64, image_semantics_position_at(number_image))
				end
			else
				check
					r ?:= number_image
				end
				r ::= number_image
				create {LIBERTY_REAL_MANIFEST} Result.make(universe.type_real, r.decoded, image_semantics_position_at(number_image))
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	character (character_image: EIFFEL_IMAGE): LIBERTY_EXPRESSION is
		require
			{TYPED_EIFFEL_IMAGE[CHARACTER]} ?:= character_image
		local
			c: TYPED_EIFFEL_IMAGE[CHARACTER]
		do
			c ::= character_image
			create {LIBERTY_CHARACTER_MANIFEST} Result.make(universe.type_character, c.decoded, image_semantics_position_at(character_image))
		ensure
			not errors.has_error implies Result /= Void
		end

	number_typed_manifest (manifest_type: LIBERTY_ACTUAL_TYPE; number_image: EIFFEL_IMAGE): LIBERTY_EXPRESSION is
		require
			({TYPED_EIFFEL_IMAGE[INTEGER_64]} ?:= number_image)
				or else ({TYPED_EIFFEL_IMAGE[REAL]} ?:= number_image)
		local
			i: TYPED_EIFFEL_IMAGE[INTEGER_64]
			r: TYPED_EIFFEL_IMAGE[REAL]
		do
			if i ?:= number_image then
				i ::= number_image
				create {LIBERTY_INTEGER_TYPED_MANIFEST} Result.make(manifest_type, i.decoded, image_semantics_position_at(number_image))
			else
				check
					r ?:= number_image
				end
				r ::= number_image
				create {LIBERTY_REAL_TYPED_MANIFEST} Result.make(manifest_type, r.decoded, image_semantics_position_at(number_image))
			end
		ensure
			not errors.has_error implies Result /= Void
		end

	array_typed_manifest (manifest_type: LIBERTY_ACTUAL_TYPE; array_parameters: EIFFEL_LIST_NODE; array: LIBERTY_AST_ARRAY;
		local_context: LIBERTY_FEATURE_LOCAL_CONTEXT;
		a_position: LIBERTY_POSITION): LIBERTY_ARRAY_MANIFEST is
		require
			local_context /= Void
		local
			i: INTEGER; ena: LIBERTY_AST_EXPRESSION_NO_ARRAY; exp: LIBERTY_AST_EXPRESSION
		do
			create Result.make(manifest_type, a_position)
			from
				i := array_parameters.lower
			until
				i > array_parameters.upper
			loop
				ena ::= array_parameters.item(i)
				Result.add_parameter(expression_no_array(ena, local_context))
				i := i + 1
			end
			from
				i := array.content.lower
			until
				i > array.content.upper
			loop
				exp ::= array.content.item(i)
				Result.add_content(expression(exp, local_context))
				i := i + 1
			end
		ensure
			not errors.has_error implies Result /= Void
		end

feature {}
	list_parameters (parameters: EIFFEL_LIST_NODE; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT) is
		local
			i, j: INTEGER; declaration: LIBERTY_AST_DECLARATION; variable: LIBERTY_AST_VARIABLE
			typedef: LIBERTY_TYPE; parameter: LIBERTY_PARAMETER
		do
			if not parameters.is_empty then
				from
					i := parameters.lower
				until
					i > parameters.upper
				loop
					declaration ::= parameters.item(i)
					typedef := type_lookup.resolver.type(declaration.type_definition)
					if typedef /= Void then
						from
							j := declaration.variables.lower
						until
							j > declaration.variables.upper
						loop
							variable ::= declaration.variables.item(j)
							create parameter.make(variable.variable.image.image.intern, typedef, errors.semantics_position(variable.variable.image.index, type.ast, type.file))
							local_context.add_parameter(parameter)
							j := j + 1
						end
					end
					i := i + 1
				end
			end
		end

	list_locals (locals: LIBERTY_AST_LOCAL_BLOCK; local_context: LIBERTY_FEATURE_LOCAL_CONTEXT) is
		local
			i, j: INTEGER; declaration: LIBERTY_AST_DECLARATION; variable: LIBERTY_AST_VARIABLE
			typedef: LIBERTY_TYPE; localdef: LIBERTY_LOCAL
		do
			if locals.list_count > 0 then
				from
					i := locals.list_lower
				until
					i > locals.list_upper
				loop
					declaration := locals.list_item(i)
					typedef := type_lookup.resolver.type(declaration.type_definition)
					if typedef /= Void then
						from
							j := declaration.variables.lower
						until
							j > declaration.variables.upper
						loop
							variable ::= declaration.variables.item(j)
							create localdef.make(variable.variable.image.image.intern, typedef, errors.semantics_position(variable.variable.image.index, type.ast, type.file))
							local_context.add_local(localdef)
							j := j + 1
						end
					end
					i := i + 1
				end
			end
		end

feature {}
	create_instruction_call (a_target: LIBERTY_EXPRESSION; a_entity: LIBERTY_FEATURE_ENTITY; a_actuals: COLLECTION[LIBERTY_EXPRESSION]; a_position: LIBERTY_POSITION): LIBERTY_CALL_INSTRUCTION is
		do
			create Result.make(a_target, a_entity, a_actuals, a_position)
		end

	create_implicit_instruction_call (a_entity: LIBERTY_FEATURE_ENTITY; a_actuals: COLLECTION[LIBERTY_EXPRESSION]; a_position: LIBERTY_POSITION): LIBERTY_CALL_INSTRUCTION is
		do
			create Result.implicit_current(a_entity, a_actuals, a_position)
		end

	create_expression_call (a_target: LIBERTY_EXPRESSION; a_entity: LIBERTY_FEATURE_ENTITY; a_actuals: COLLECTION[LIBERTY_EXPRESSION]; a_position: LIBERTY_POSITION): LIBERTY_CALL_EXPRESSION is
		do
			create Result.make(a_target, a_entity, a_actuals, a_position)
		end

	create_implicit_expression_call (a_entity: LIBERTY_FEATURE_ENTITY; a_actuals: COLLECTION[LIBERTY_EXPRESSION]; a_position: LIBERTY_POSITION): LIBERTY_CALL_EXPRESSION is
		do
			create Result.implicit_current(a_entity, a_actuals, a_position)
		end

feature {}
	redefined_features: DICTIONARY[LIBERTY_FEATURE_REDEFINED, LIBERTY_FEATURE_NAME]

invariant
	feature_writables /= Void
	redefined_features /= Void

end -- class LIBERTY_TYPE_FEATURES_LOADER
