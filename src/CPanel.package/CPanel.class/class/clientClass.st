accessing
clientClass
	^ clientClassForTesting ifNil: [ ^ ZnClient ]