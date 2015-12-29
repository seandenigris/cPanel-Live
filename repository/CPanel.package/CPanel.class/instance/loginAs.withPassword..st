private
loginAs: username withPassword: password 

	| json rawSecurityToken |
	json := self client
		path: '/login/';
		queryAt: 'login_only' put: '1';
		formAt: 'user' put: username;
		formAt: 'pass' put: password;
		contentReader: [ :e | NeoJSONReader fromString: e contents ];
		post.
	rawSecurityToken := json at: 'security_token'.
	securityToken := rawSecurityToken allButFirst: '/' size.