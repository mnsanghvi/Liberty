-- This file is part of SmartEiffel The GNU Eiffel Compiler Tools and Libraries.
-- See the Copyright notice at the end of this file.
--
class TEST_BUBBLE_SORT2

create {}
   make

feature {}
   make
      local
         tab: ARRAY[CHARACTER]; s: COLLECTION_SORTER[CHARACTER]
      do
         tab := {ARRAY[CHARACTER] 1, << 'z', 'r', 'a', '7', 'l', '=', ';', '5', '$', ',' >> }
         s.bubble_sort(tab)
         assert(tab.is_equal({ARRAY[CHARACTER] 1, << '$', ',', '5', '7', ';', '=', 'a', 'l', 'r', 'z' >> }))
         tab.add_first('*')
         s.bubble_sort(tab)
         assert(tab.is_equal({ARRAY[CHARACTER] 1, << '$', '*', ',', '5', '7', ';', '=', 'a', 'l', 'r', 'z' >> }))
      end

   assert (b: BOOLEAN)
      do
         cpt := cpt + 1
         if not b then
            std_output.put_string("TEST_BUBBLE_SORT2: ERROR Test # ")
            std_output.put_integer(cpt)
            std_output.put_string("%N")
         end
      end

   cpt: INTEGER

end -- class TEST_BUBBLE_SORT2
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
