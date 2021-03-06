indexing

	description:

		"Eiffel dynamic type sets of agent operands pushing types to supersets (type sets of argument of features 'call' and 'item')"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-04-03 23:47:03 +0200 (Thu, 03 Apr 2008) $"
	revision: "$Revision: 6332 $"

class ET_DYNAMIC_AGENT_OPERAND_PUSH_TYPE_SET

inherit

	ET_DYNAMIC_EXTENDIBLE_TYPE_SET
		redefine
			put_type_from_type_set
		end

create

	make

feature {NONE} -- Initialization

	make (a_type: like static_type; an_agent_type: like agent_type) is
			-- Create a new empty dynamic type set.
			-- Set `first_type' to `a_type' if it is expanded.
		require
			a_type_not_void: a_type /= Void
			an_agent_type_not_void: an_agent_type /= Void
		do
			static_type := a_type
			if a_type.is_expanded then
				put_type (a_type)
			end
			agent_type := an_agent_type
		ensure
			static_type_set: static_type = a_type
			first_expanded_type: a_type.is_expanded implies (count = 1 and then dynamic_type (1) = a_type)
			agent_type_set: agent_type = an_agent_type
		end

feature -- Access

	agent_type: ET_DYNAMIC_ROUTINE_TYPE
			-- Type of agent

feature -- Element change

	put_type_from_type_set (a_type: ET_DYNAMIC_TYPE; a_type_set: ET_DYNAMIC_TYPE_SET; a_system: ET_DYNAMIC_SYSTEM) is
			-- Add `a_type' coming from `a_type_set' to current target.
		local
			old_count: INTEGER
			i, nb: INTEGER
			l_tuple_type: ET_DYNAMIC_TUPLE_TYPE
			l_item_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_open_operand_type_sets: ET_DYNAMIC_TYPE_SET_LIST
			l_builder: ET_DYNAMIC_TYPE_SET_BUILDER
		do
			old_count := count
			precursor (a_type, a_type_set, a_system)
			if old_count < count then
				l_tuple_type ?= a_type
				if l_tuple_type /= Void then
					l_item_type_sets := l_tuple_type.item_type_sets
					l_open_operand_type_sets := agent_type.open_operand_type_sets
					nb := l_open_operand_type_sets.count
					if l_item_type_sets.count < nb then
							-- Internal error: missing open operands.
						l_builder := a_system.dynamic_type_set_builder
						l_builder.set_fatal_error
						l_builder.error_handler.report_giaaa_error
					else
						from i := 1 until i > nb loop
							l_item_type_sets.item (i).put_target (l_open_operand_type_sets.item (i), a_system)
							i := i + 1
						end
					end
				end
			elseif a_system.current_system.is_ise and then not has_type (a_type) then
					-- ISE Eiffel does not type-check the tuple operand of Agent calls even at
					-- execution time. It only checks whether the tuple has enough items and
					-- these items are of the expected types, regardless of the type of the tuple
					-- itself. For example it is OK to pass a "TUPLE [ANY]" to an Agent which expects
					-- a "TUPLE [STRING]" provided that the dynamic type of the item of this tuple
				 	-- conforms to type STRING.
				l_tuple_type ?= a_type
				if l_tuple_type /= Void then
					l_item_type_sets := l_tuple_type.item_type_sets
					l_open_operand_type_sets := agent_type.open_operand_type_sets
					nb := l_open_operand_type_sets.count
					if l_item_type_sets.count >= nb then
						from i := 1 until i > nb loop
							l_item_type_sets.item (i).put_target (l_open_operand_type_sets.item (i), a_system)
							i := i + 1
						end
					end
				end
			end
		end

invariant

	agent_type_not_void: agent_type /= Void

end
