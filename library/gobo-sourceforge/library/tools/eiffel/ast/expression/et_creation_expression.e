indexing

	description:

		"Eiffel creation expressions"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2008, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2008-07-02 01:17:09 +0200 (Wed, 02 Jul 2008) $"
	revision: "$Revision: 6441 $"

deferred class ET_CREATION_EXPRESSION

inherit

	ET_EXPRESSION
		redefine
			is_never_void
		end

feature -- Access

	type: ET_TYPE is
			-- Creation type
		deferred
		ensure
			type_not_void: Result /= Void
		end

	name: ET_FEATURE_NAME is
			-- Creation procedure name
		deferred
		end

	arguments: ET_ACTUAL_ARGUMENTS is
			-- Arguments of creation call
		deferred
		end

	type_position: ET_POSITION is
			-- Position of `type'
		deferred
		ensure
			type_position_not_void: Result /= Void
		end

feature -- Status report

	is_never_void: BOOLEAN is True
			-- Can current expression never be void?

invariant

	no_call_constraint: name = Void implies arguments = Void

end
