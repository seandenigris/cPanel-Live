accessing
securityToken
	^ securityToken ifNil: [ 
		self logIn. 
		securityToken ]