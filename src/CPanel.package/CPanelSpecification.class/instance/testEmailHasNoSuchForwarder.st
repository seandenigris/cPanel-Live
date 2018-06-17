as yet unclassified
testEmailHasNoSuchForwarder

	| result |
	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	result := cPanel hasForwarderFrom: 'unknown@', domain to: 'target@', domain.
	result should beFalse