indexing

	description:

		"Eiffel labeled actual generic parameters followed by a semicolon"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class ET_LABELED_ACTUAL_PARAMETER_SEMICOLON

inherit

	ET_ACTUAL_PARAMETER_ITEM

create

	make

feature {NONE} -- Initialization

	make (a_parameter: like actual_parameter; a_semicolon: like semicolon) is
			-- Create a new labeled_actual_parameter-semicolon.
		require
			a_parameter_not_void: a_parameter /= Void
			a_semicolon_not_void: a_semicolon /= Void
		do
			actual_parameter := a_parameter
			semicolon := a_semicolon
		ensure
			actual_parameter_set: actual_parameter = a_parameter
			semicolon_set: semicolon = a_semicolon
		end

feature -- Access

	actual_parameter: ET_LABELED_ACTUAL_PARAMETER
			-- Labeled actual generic parameter in semicolon-separated list

	type: ET_TYPE is
			-- Type of `actual_parameter'
		do
			Result := actual_parameter.type
		end

	label: ET_IDENTIFIER is
			-- Label of `actual_parameter';
			-- Useful when part of a labeled tuple, Void if no label
		do
			Result := actual_parameter.label
		end

	semicolon: ET_SYMBOL
			-- Semicolon separator

	position: ET_POSITION is
			-- Position of first character of
			-- current node in source code
		do
			Result := actual_parameter.position
		end

	first_leaf: ET_AST_LEAF is
			-- First leaf node in current node
		do
			Result := actual_parameter.first_leaf
		end

	last_leaf: ET_AST_LEAF is
			-- Last leaf node in current node
		do
			Result := semicolon
		end

	break: ET_BREAK is
			-- Break which appears just after current node
		do
			Result := semicolon.break
		end

feature -- Type processing

	resolved_formal_parameters_with_type (a_type: ET_TYPE): ET_LABELED_ACTUAL_PARAMETER_SEMICOLON is
			-- Version of current actual parameter where its type
			-- is replaced by `a_type'
		local
			a_parameter: ET_LABELED_ACTUAL_PARAMETER
		do
			a_parameter := actual_parameter.resolved_formal_parameters_with_type (a_type)
			if a_parameter /= actual_parameter then
				create Result.make (a_parameter, semicolon)
			else
				Result := Current
			end
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR) is
			-- Process current node.
		do
			a_processor.process_labeled_actual_parameter_semicolon (Current)
		end

invariant

	semicolon_not_void: semicolon /= Void

end
