as yet unclassified
testEmailAddForwarder

	| sourceUser sourceDomain sourceEmail targetEmail expectedUrl |
	sourceUser := 'dummyuser'.
	sourceDomain := 'mydomain.com'.
	sourceEmail := sourceUser, '@', sourceDomain.
	targetEmail := 'target@mydomain.com'.
	expectedUrl := url / securityToken / 'execute' / 'Email' / 'add_forwarder' ? ('email' -> sourceUser) & ('domain' -> sourceDomain) & ('fwdopt' -> 'fwd') & ('fwdemail' -> targetEmail).
	client shouldGet: expectedUrl andReturn: self genericResponse.
	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	cPanel emailAddForwarderFrom: sourceEmail to: targetEmail