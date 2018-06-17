private
refreshLoginStatus
	self isLoggedIn ifFalse: [ self securityToken: nil ]