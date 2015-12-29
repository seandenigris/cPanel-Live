as yet unclassified
testEmailAddForwarderAlreadyExists

	| sourceUser sourceDomain sourceEmail targetEmail expectedUrl |
	sourceUser := 'fakeaddress1'.
	sourceDomain := 'mydomain.com'.
	sourceEmail := sourceUser, '@', sourceDomain.
	targetEmail := 'target@mydomain.com'.
	expectedUrl := url / securityToken / 'execute' / 'Email' / 'add_forwarder' ? ('email' -> sourceUser) & ('domain' -> sourceDomain) & ('fwdopt' -> 'fwd') & ('fwdemail' -> targetEmail).
	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	[ cPanel emailAddForwarderFrom: sourceEmail to: targetEmail ] should signal: Error.