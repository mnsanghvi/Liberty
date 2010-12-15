-- This file is part of a Liberty Eiffel library.
-- See the full copyright at the end.
--
deferred class ABSTRACT_AVL_SET[E_]

inherit
	SET[E_]

insert
	AVL_TREE[E_]
		rename set_value_and_key as set_item
		end

feature {ANY}
	add (e: like item) is
		do
			item_memory := e
			root := do_insert(root)
		end

	fast_add (e: like item) is
		do
			item_memory := e
			root := fast_do_insert(root)
		end

	clear_count, clear_count_and_capacity is
		do
			if not is_empty then
				clear_nodes(root)
				root := Void
				count := 0
				map_dirty := True
			end
		end

	reference_at (e: like item): like item is
		local
			n: ABSTRACT_AVL_SET_NODE[E_]
		do
			if root /= Void then
				n := root.at(e)
				if n /= Void then
					Result := n.item
				end
			end
		end

	item (index: INTEGER): E_ is
		do
			if map_dirty then
				build_map
			end
			Result := map.item(index - 1).item
		end

feature {}
	set_item (n: like a_new_node) is
		do
			n.set(item_memory)
		end

	set_value (n: like a_new_node) is
		do
		end

	a_new_node: ABSTRACT_AVL_SET_NODE[E_] is
		deferred
		end

	exchange_and_discard (n1, n2: like a_new_node) is
		do
			map_dirty := True
			n1.set_item(n2.item)
			rebalance := True
			count := count - 1
			discard_node(n2)
		end

	discard_node (n: like a_new_node) is
		local
			i: like item
		do
			n.set(i)
			n.set_left(lost_nodes.item)
			lost_nodes.set_item(n)
		end

	common_lost_nodes: DICTIONARY[WEAK_REFERENCE[ANY_AVL_SET_NODE], STRING] is
		once
			create {HASHED_DICTIONARY[WEAK_REFERENCE[ANY_AVL_SET_NODE], STRING]} Result.make
		end

feature {}
	make is
		do
			if lost_nodes /= Void then
				clear_count
			else
				create map.make(0)
				lost_nodes ::= common_lost_nodes.reference_at(generating_type)
				if lost_nodes = Void then
					create lost_nodes.set_item(Void)
					common_lost_nodes.add(lost_nodes, generating_type)
				end
			end
		end

invariant
	lost_nodes /= Void
	lost_nodes = common_lost_nodes.at(generating_type)

end -- class ABSTRACT_AVL_SET
--
-- Copyright (c) 2009 by all the people cited in the AUTHORS file.
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.