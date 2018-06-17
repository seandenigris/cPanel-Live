printing
printOn: aStream

	nickname ifNotNil: [ aStream nextPutAll: self nickname ].
	url ifNotNil: [ 
		aStream
			space;
			nextPut: $(;
			print: self url;
			nextPut: $) ].