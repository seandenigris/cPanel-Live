Class {
	#name : #CpEmailAddress,
	#superclass : #Object,
	#instVars : [
		'addressString'
	],
	#category : 'CPanel'
}

{ #category : #'instance creation' }
CpEmailAddress class >> fromString: aString [ 

	^ self new
		addressString: aString;
		yourself
]

{ #category : #accessing }
CpEmailAddress >> addressString [
	^ addressString
]

{ #category : #accessing }
CpEmailAddress >> addressString: anObject [
	addressString := anObject
]

{ #category : #'as yet unclassified' }
CpEmailAddress >> domain [
	^ addressString copyAfter: $@
]
