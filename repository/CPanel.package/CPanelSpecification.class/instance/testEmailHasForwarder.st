as yet unclassified
testEmailHasForwarder

	| result |
	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	result := cPanel hasForwarderFrom: 'fakeaddress1@', domain to: 'target@', domain.
	result should beTrue.