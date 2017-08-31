email
emailAddForwarderFrom: source to: target
	"From https://documentation.cpanel.net/display/SDK/UAPI+Functions+-+Email%3A%3Aadd_forwarder"
	| sourceUser sourceDomain addForwarderUrl doesExist |
	doesExist := self hasForwarderFrom: source to: target.
	doesExist ifTrue: [ CpError signal: 'Forwarder already exists from ', source, ' to ', target ].
	sourceUser := source copyUpTo: $@.
	sourceDomain := source copyAfter: $@.
	addForwarderUrl := self baseApiUrl / 'Email' / 'add_forwarder' ? ('email' -> sourceUser) & ('domain' -> sourceDomain) & ('fwdopt' -> 'fwd') & ('fwdemail' -> target).
	self client
		contentReader: nil;
		get: addForwarderUrl.
	doesExist := self hasForwarderFrom: source to: target.
	doesExist ifFalse: [ CpError signal: 'Failed to create forwarder from ', source, ' to ', target ].