email
emailAddForwarderFrom: source to: target
	"From https://documentation.cpanel.net/display/SDK/UAPI+Functions+-+Email%3A%3Aadd_forwarder"
	| sourceUser sourceDomain addForwarderUrl |
	sourceUser := source copyTo: $@.
	sourceDomain := source copyAfter: $@.
	addForwarderUrl := url
		addPath: securityToken;
		addPath: 'execute/Email/add_forwarder?email=', sourceUser, '&domain=', sourceDomain, '&fwdopt=fwd&fwdemail=', target.
	self client get: addForwarderUrl