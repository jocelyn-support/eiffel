indexing

	description:

		"Eiffel attachments in built-in features at run-time"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2004, Eric Bezault and others"
	license: "MIT License"
	date: "$Date: 2007-01-26 19:55:25 +0100 (Fri, 26 Jan 2007) $"
	revision: "$Revision: 5877 $"

class ET_DYNAMIC_BUILTIN_ATTACHMENT

inherit

	ET_DYNAMIC_ATTACHMENT

create

	make

feature {NONE} -- Initialization

	make (a_type_set: like source_type_set; a_current_feature: like current_feature; a_current_type: like current_type) is
			-- Create a new attachment in built-in feature.
		require
			a_type_set_not_void: a_type_set /= Void
			a_current_feature_not_void: a_current_feature /= Void
			a_current_type_not_void: a_current_type /= Void
		do
			source_type_set := a_type_set
			current_feature := a_current_feature
			current_type := a_current_type
		ensure
			source_type_set_set: source_type_set = a_type_set
			current_feature_set: current_feature = a_current_feature
			current_type_set: current_type = a_current_type
		end

feature -- Access

	attachment: ET_AST_NODE is
			-- Attachment
		do
			Result := current_feature.static_feature
		end

	position: ET_POSITION is
			-- Position of attachment
		do
			Result := current_feature.static_feature.position
		end

	description: STRING is "built-in"
			-- Kind of attachment

end
