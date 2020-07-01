private
baseApiUrl
	^ self url / self securityToken / 'execute'