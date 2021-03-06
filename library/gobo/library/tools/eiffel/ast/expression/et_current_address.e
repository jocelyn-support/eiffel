indexing

	description:

		"Eiffel addresses of Current"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 199-2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class ET_CURRENT_ADDRESS

inherit

	ET_ADDRESS_EXPRESSION

create

	make

feature {NONE} -- Initialization

	make is
			-- Create a new address of 'Current'.
		do
			dollar := tokens.dollar_symbol
			current_keyword := tokens.current_keyword
		end

feature -- Access

	current_keyword: ET_CURRENT
			-- 'Current' keyword

	last_leaf: ET_AST_LEAF is
			-- Last leaf node in current node
		do
			Result := current_keyword
		end

	break: ET_BREAK is
			-- Break which appears just after current node
		do
			Result := current_keyword.break
		end

feature -- Setting

	set_current_keyword (a_current: like current_keyword) is
			-- Set `current_keyword' to `a_current'.
		require
			a_current_not_void: a_current /= Void
		do
			current_keyword := a_current
		ensure
			current_keyword_set: current_keyword = a_current
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR) is
			-- Process current node.
		do
			a_processor.process_current_address (Current)
		end

invariant

	current_keyword_not_void: current_keyword /= Void

end
