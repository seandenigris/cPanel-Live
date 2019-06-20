email
emailListForwardersFor: domain
	" 
	Example:
		self emailListForwardersFor: 'clipperadams.com'.
	
	API Reference: https://documentation.cpanel.net/display/SDK/UAPI+Functions+-+Email%3A%3Alist_forwarders"
	^ self client
		contentReader: [ :e | 
			| json |
			json := NeoJSONReader fromString: e contents.
			json at: 'data' ];
		get: self baseApiUrl / 'Email' / 'list_forwarders' ? ('domain' -> domain)