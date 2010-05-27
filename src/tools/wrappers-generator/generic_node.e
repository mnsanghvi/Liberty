class GENERIC_NODE
	-- A generic XML node generated by gccxml, i.e. not handled as a specific type.

inherit XML_COMPOSITE_NODE
insert 
	SHARED_SETTINGS
	--DESCRIPTIONS
feature 
	register_into (a_tree: GCCXML_TREE) is
	do -- Nothing   
	end

	do_all (a_procedure: PROCEDURE[TUPLE[GCCXML_NODE]]) is
		local i: INTEGER; node: GCCXML_NODE
		do
			from i:=1 until i>children_count loop
				node ?= child(i)
				if node/=Void then 
					a_procedure.call([node])
				end
				i:=i+1
			end
		end
end

-- Copyright 2008,2009,2010 Paolo Redaelli

-- wrappers-generator  is free software: you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the Free
-- Software Foundation, either version 2 of the License, or (at your option)
-- any later version.

-- wrappers-generator is distributed in the hope that it will be useful, but
-- WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-- more details.

-- You should have received a copy of the GNU General Public License along with
-- this program.  If not, see <http://www.gnu.org/licenses/>.
