indexing

	description:

		"Objects that provide shared access to a singleton emitter factory."

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date: 2007-10-08 10:06:11 +0200 (Mon, 08 Oct 2007) $"
	revision: "$Revision: 6114 $"

class XM_XSLT_SHARED_EMITTER_FACTORY

feature -- Access

	emitter_factory: XM_XSLT_EMITTER_FACTORY is
			-- Singletom emitter factory
		once
			create Result.make
		ensure
			emitter_factory_not_void: Result /= Void
		end

end
	
