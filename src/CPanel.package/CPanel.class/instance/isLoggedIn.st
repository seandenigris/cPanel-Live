testing
isLoggedIn

	securityToken ifNil: [ ^ false ].

	"Implementation note: There doesn't seem to be an easy way to test for this via the API. As a workaround, when a function is called with an invalid security token, it returns HTML instead of the usual valid JSON response. We picked #contactusIsEnabled because it seemed to be a very simple call."
	^ [ self contactusIsEnabled. true ] 
			on: NeoJSONParseError
			do: [ false ].