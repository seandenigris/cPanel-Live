as yet unclassified
get: aZnUrl 

	| response |
	(self getExpectations includesKey: aZnUrl) should beTrue.
	response := self getExpectations at: aZnUrl.
	self getExpectations removeKey: aZnUrl.
	^ contentReader
		ifNil: [ response ]
		ifNotNil: [ contentReader value: response ]
	