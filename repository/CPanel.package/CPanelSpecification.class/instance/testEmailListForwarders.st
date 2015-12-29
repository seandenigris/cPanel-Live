as yet unclassified
testEmailListForwarders

	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	cPanel emailListForwardersFor: domain