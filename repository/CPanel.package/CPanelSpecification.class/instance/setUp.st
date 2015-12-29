as yet unclassified
setUp

	url := 'https://my.domain.com/' asUrl.
	securityToken := 'securityToken'.
	domain := 'mydomain.com'.
	urlListingForwarders := url / securityToken / 'execute' / 'Email' / 'list_forwarders' ? ('domain' -> domain).
	client := CpClientDouble new.
	"Short circuit the usual creation method, which includes authentication, because it's hard to test"
	cPanel := CPanel new
		client: client;
		url: url;
		securityToken: securityToken;
		yourself