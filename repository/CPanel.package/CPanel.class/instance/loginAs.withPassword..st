private
loginAs: username withPassword: password 

	| json |
	json := self client
		path: '/login/';
		queryAt: 'login_only' put: '1';
		formAt: 'user' put: username;
		formAt: 'pass' put: password;
		contentReader: [ :e | NeoJSONReader fromString: e contents ];
		post.
	securityToken := json at: 'security_token'