-- This file is part of Liberty Eiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
deferred class EFFECTIVE_ARG_LIST
   --
   -- For an effective arguments list (for a routine call).
   --

inherit
   VISITABLE
      undefine out_in_tagged_out_memory
      end
   TRAVERSABLE[EXPRESSION]

insert
   GLOBALS
      undefine out_in_tagged_out_memory
      end

feature {ANY}
   expression (i: INTEGER): EXPRESSION is
      require
         i.in_range(1, count)
      deferred
      ensure
         Result /= Void
      end

   start_position, end_position: POSITION is
      deferred
      end

   specialize_in (type: TYPE): like Current is
      require
         type /= Void
      deferred
      ensure
         Result.has_been_specialized
      end

   specialize_thru (parent_type: TYPE; parent_edge: PARENT_EDGE; new_type: TYPE): like Current is
      require
         parent_type /= Void
         new_type /= Void
         parent_type /= new_type
         has_been_specialized
      deferred
      ensure
         has_been_specialized
         Result.has_been_specialized
      end

   specialize_and_check (t: TYPE; af: ANONYMOUS_FEATURE; target_type: TYPE; allow_tuple: BOOLEAN): EFFECTIVE_ARG_LIST is
         -- Checks the validity of argument passing (i.e. assignments) from the effective arguments list into
         -- the formal arguments list from `af'.
      require
         has_been_specialized
         af.arguments /= Void implies af.arguments.has_been_specialized
      deferred
      ensure
         Result.count = count
      end

   has_been_specialized: BOOLEAN is
      deferred
      ensure
         Result
      end

   simplify (type: TYPE): like Current is
      deferred
      ensure
         (Result /= Current or Result = Void) implies (smart_eiffel.magic_count > old smart_eiffel.magic_count);
         (Result = Current) implies (smart_eiffel.magic_count = old smart_eiffel.magic_count)
      end

   static_simplify is
      deferred
      end

   side_effect_free (type: TYPE): BOOLEAN is
      deferred
      end

   safety_check (type: TYPE) is
      deferred
      end

   use_current (type: TYPE): BOOLEAN is
      deferred
      end

   pretty (indent_level: INTEGER) is
      deferred
      end

   short (type: TYPE) is
      deferred
      end

   is_static: BOOLEAN is
         -- Is True when only `is_static' expression are used.
      deferred
      end

feature {EIFFEL_PARSER, EFFECTIVE_ARG_LIST}
   set_end_position (p: POSITION) assign end_position is
      deferred
      ensure
         end_position = p
      end

feature {ANY} -- Implementation of TRAVERSABLE:
   lower: INTEGER is 1

   upper: INTEGER is
      do
         Result := count
      end

feature {ANY}
   new_iterator: ITERATOR[EXPRESSION] is
      do
         check
            False -- Just use the usual pattern instead please.
         end
      end

feature {FUNCTION_CALL, PROCEDURE_CALL}
   unused_expression_inline (code_accumulator: CODE_ACCUMULATOR; type: TYPE) is
      local
         i: INTEGER; exp: EXPRESSION
      do
         from
            i := lower
         until
            i > upper
         loop
            exp := item(i)
            if not exp.side_effect_free(type) then
               code_accumulator.current_context.add_last(create {UNUSED_EXPRESSION}.make(exp))
            end
            i := i + 1
         end
      end

feature {E_PROCEDURE}
   unused_expression_in (inline_memo: INLINE_MEMO; type: TYPE) is
      local
         i: INTEGER; exp: EXPRESSION; memo: INSTRUCTION; compound: COMPOUND
      do
         from
            i := lower
         until
            i > upper
         loop
            exp := item(i)
            if not exp.side_effect_free(type) then
               memo := inline_memo.instruction
               if memo = Void then
                  inline_memo.set_instruction(create {UNUSED_EXPRESSION}.make(exp))
               elseif {COMPOUND} ?:= memo then
                  compound ::= memo
                  compound.add_last(create {UNUSED_EXPRESSION}.make(exp))
               else
                  inline_memo.set_instruction(create {COMPOUND}.make_2(memo,create {UNUSED_EXPRESSION}.make(exp)))
               end
            end
            i := i + 1
         end
      end

feature {CODE}
   inline_dynamic_dispatch (code_accumulator: CODE_ACCUMULATOR; type: TYPE): like Current is
      deferred
      ensure
         Result.count = Current.count
      end

feature {CREATE_EXPRESSION, MANIFEST_TUPLE}
   specialize_and_check_on_expressions (type: TYPE): like Current is
      require
         type /= Void
         has_been_specialized
         not smart_eiffel.status.is_specializing
      deferred
      ensure
         has_been_specialized
         Result.has_been_specialized
      end

feature {FEATURE_CALL, PRECURSOR_CALL, AGENT_INSTRUCTION}
   adapt_for (t: TYPE): like Current is
      deferred
      ensure
         Result.count = count
      end

feature {FEATURE_CALL}
   --|*** Pourquoi le collect n'est il pas appele' depuis PRECURSOR_CALL ????
   --| Dom feb 7th 2004
   --|***
   collect (t: TYPE; fs: FEATURE_STAMP; feature_type: TYPE) is
         -- arguments are written in `t' and the feature stamp `fs' is used with a target of type `feature_type'.
      require
         count = fs.anonymous_feature(feature_type).arguments.count
      deferred
      end

feature {PRECURSOR_CALL}
   simple_collect (t: TYPE; fal: FORMAL_ARG_LIST) is
         -- arguments are written in `t' and the formal arguments list is `fal'.
      require
         count = fal.count
      local
         i: INTEGER; arg_type: TYPE; expr: EXPRESSION
      do
         from
            i := 1
         until
            i > count
         loop
            expr := expression(i)
            arg_type := expr.collect(t)
            assignment_handler.collect_normal(arg_type, fal.type_mark(i).resolve_in(t))
            i := i + 1
         end
      end

feature {AGENT_INSTRUCTION, AGENT_EXPRESSION}
   to_fake_tuple (type: TYPE): FAKE_TUPLE is
      require
         count = 1
      deferred
      end

feature {EFFECTIVE_ARG_LIST, FAKE_TUPLE, CALL_1}
   put (e: EXPRESSION; index: INTEGER) is
      require
         valid_index(index)
      deferred
      end

feature {PROCEDURE_CALL_N}
   create_inline: like Current is
      deferred
      ensure
         Result.count = count
      end

feature {AGENT_CREATION}
   replace_item (index: INTEGER; closed_operand: CLOSED_OPERAND) is
      require
         valid_index(index)
         closed_operand /= Void
      do
         put(closed_operand, index)
      ensure
         item(index) = closed_operand
      end

feature {}
   synthetic_tuple: BOOLEAN

   synthetic_tuple_arg (index: INTEGER; type: TYPE; fal: FORMAL_ARG_LIST; formal_tuple_type: NON_EMPTY_TUPLE_TYPE_MARK): EXPRESSION is
      require
         fal.count <= count
         index >= 0
         index < count - fal.count
      local
         actual_type, formal_type: TYPE; e: EXPRESSION
      do
         check
            formal_tuple_type.generic_list.lower = 1
         end
         formal_type := formal_tuple_type.generic_list.item(index + 1).resolve_in(type)

         e := expression(fal.count + index).specialize_and_check(type)
         actual_type := e.resolve_in(type)

         Result := assignment_handler.implicit_cast(e, actual_type, formal_type)
      end

   synthetize_tuple (target_type, t: TYPE; fal: FORMAL_ARG_LIST): EXPRESSION is
      require
         fal /= Void and then fal.count > 0
         count >= fal.count - 1
         not synthetic_tuple
      local
         ftt: NON_EMPTY_TUPLE_TYPE_MARK
         tup: MANIFEST_TUPLE; rem: FAST_ARRAY[EXPRESSION]
         eal: EFFECTIVE_ARG_LIST_N
         i, fal_count: INTEGER
         mhf: MEMORY_HANDLER_FACTORY
      do
         fal_count := fal.count
         if count < fal_count then
            create tup.make(start_position, Void)
         else
            ftt ::= fal.type_mark(fal_count).resolve_in(target_type).canonical_type_mark
            if count = fal_count then
               create eal.make_1(start_position, synthetic_tuple_arg(0, t, fal, ftt))
            elseif count = fal_count + 1 then
               create eal.make_2(start_position, synthetic_tuple_arg(0, t, fal, ftt), synthetic_tuple_arg(1, t, fal, ftt))
            else
               check
                  count >= fal_count + 2
               end
               from
                  create rem.with_capacity(count - fal_count - 2)
                  i := 0
               until
                  i >= count - fal_count
               loop
                  rem.add_last(synthetic_tuple_arg(i, t, fal, ftt))
                  i := i + 1
               end
               create eal.make_n(start_position, synthetic_tuple_arg(0, t, fal, ftt), rem)
            end
            create tup.make(expression(fal_count).start_position, eal)
         end

         tup := tup.specialize_and_check(t)

         error_handler.append(once "Synthetizing ")
         error_handler.add_type(tup.resolve_in(t))
         error_handler.append(once " for extra arguments.")
         error_handler.add_position(fal.name(fal_count).start_position)
         if fal_count > count then
            error_handler.add_position(end_position)
         else
            error_handler.add_position(expression(fal_count).start_position)
         end
         if mhf.is_no_gc then
            error_handler.append(once " May lose memory.")
            error_handler.print_as_warning
         else
            error_handler.print_as_style_warning
         end

         synthetic_tuple := True
         Result := tup
      ensure
         Result.resolve_in(t).is_tuple
         synthetic_tuple
      end

end -- class EFFECTIVE_ARG_LIST
--
-- ------------------------------------------------------------------------------------------------------------------------------
-- Copyright notice below. Please read.
--
-- Liberty Eiffel is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License,
-- as published by the Free Software Foundation; either version 2, or (at your option) any later version.
-- Liberty Eiffel is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY; without even the implied warranty
-- of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have
-- received a copy of the GNU General Public License along with Liberty Eiffel; see the file COPYING. If not, write to the Free
-- Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
--
-- Copyright(C) 2011-2014: Cyril ADRIAN, Paolo REDAELLI, Raphael MACK
--
-- http://www.gnu.org/software/liberty-eiffel/
--
--
-- Liberty Eiffel is based on SmartEiffel (Copyrights below)
--
-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
-- Copyright(C) 2003-2006: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- ------------------------------------------------------------------------------------------------------------------------------
