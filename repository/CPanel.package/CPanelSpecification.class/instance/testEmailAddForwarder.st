as yet unclassified
testEmailAddForwarder

	| sourceUser sourceDomain sourceEmail targetEmail expectedUrl |
	sourceUser := 'dummyuser'.
	sourceDomain := 'mydomain.com'.
	sourceEmail := sourceUser, '@', sourceDomain.
	targetEmail := 'sean@mydomain.com'.
	expectedUrl := url / securityToken / 'execute' / 'Email' / 'add_forwarder' ? ('email' -> sourceUser) & ('domain' -> sourceDomain) & ('fwdopt' -> 'fwd') & ('fwdemail' -> targetEmail).
	client shouldGet: expectedUrl.
	cPanel emailAddForwarderFrom: sourceEmail to: targetEmail.