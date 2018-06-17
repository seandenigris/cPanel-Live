email
emailListForwardersFor: domain
	"From https://documentation.cpanel.net/display/SDK/UAPI+Functions+-+Email%3A%3Alist_forwarders"
	^ self client
		contentReader: [ :e | 
			| json |
			json := NeoJSONReader fromString: e contents.
			json at: 'data' ];
		get: self baseApiUrl / 'Email' / 'list_forwarders' ? ('domain' -> domain)