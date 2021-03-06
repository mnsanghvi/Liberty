-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
class TEST_EXPANDED17

create {ANY}
   make

feature {ANY}
   a2: AUX_EXPANDED16A

   make
      local
         a1: AUX_EXPANDED16A; elt: AUX_EXPANDED16B; i: INTEGER
      do
         create a1.make(3)
         elt.set_all_with(1.5)
         from
            i := a1.upper
         until
            i < a1.lower
         loop
            if elt = a1.item(0) then
               error
            end
            i := i - 1
         end

         a1.set_all_with(elt)
         from
            i := a1.upper
         until
            i < a1.lower
         loop
            if elt /= a1.item(0) then
               error
            end
            i := i - 1
         end

         create a2.make(3)
         elt.set_all_with(1.5)
         from
            i := a2.upper
         until
            i < a2.lower
         loop
            if elt = a2.item(0) then
               error
            end
            i := i - 1
         end

         a2.set_all_with(elt)
         from
            i := a2.upper
         until
            i < a2.lower
         loop
            if elt /= a2.item(0) then
               error
            end
            i := i - 1
         end
      end

   error
      do
         std_output.put_string("TEST_EXPANDED17: ERROR%N")
      end

end -- class TEST_EXPANDED17
--
-- ------------------------------------------------------------------------------------------------------------------------------
-- Copyright notice below. Please read.
--
-- SmartEiffel is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License,
-- as published by the Free Software Foundation; either version 2, or (at your option) any later version.
-- SmartEiffel is distributed in the hope that it will be useful but WITHOUT ANY WARRANTY; without even the implied warranty
-- of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. You should have
-- received a copy of the GNU General Public License along with SmartEiffel; see the file COPYING. If not, write to the Free
-- Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
--
-- Copyright(C) 1994-2002: INRIA - LORIA (INRIA Lorraine) - ESIAL U.H.P.       - University of Nancy 1 - FRANCE
-- Copyright(C) 2003-2006: INRIA - LORIA (INRIA Lorraine) - I.U.T. Charlemagne - University of Nancy 2 - FRANCE
--
-- Authors: Dominique COLNET, Philippe RIBET, Cyril ADRIAN, Vincent CROIZIER, Frederic MERIZEN
--
-- http://SmartEiffel.loria.fr - SmartEiffel@loria.fr
-- ------------------------------------------------------------------------------------------------------------------------------
