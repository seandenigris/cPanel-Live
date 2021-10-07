Extension { #name : #String }

{ #category : #'*CPanel' }
String >> cpAsEmailAddress [
	^ CpEmailAddress fromString: self
]
