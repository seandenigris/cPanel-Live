contactus
contactusIsEnabled
	"From https://documentation.cpanel.net/display/DD/UAPI+Functions+-+Contactus%3A%3Ais_enabled
	
	URL:
	https://hostname.example.com:2083/cpsess##########/execute/Contactus/is_enabled"
	^ self client
		contentReader: [ :e | 
			| json |
			json := NeoJSONReader fromString: e contents.
			json at: 'data' ];
		get: self baseApiUrl / 'Contactus' / 'is_enabled'