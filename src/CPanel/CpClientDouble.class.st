Class {
	#name : #CpClientDouble,
	#superclass : #Object,
	#instVars : [
		'getExpectations',
		'contentReader'
	],
	#category : #'CPanel-Specification'
}

{ #category : #'as yet unclassified' }
CpClientDouble >> contentReader: aBlock [
	contentReader := aBlock
]

{ #category : #accessing }
CpClientDouble >> get: aZnUrl [ 

	| expectation |
	(self getExpectations first key = aZnUrl) should be: true.
	expectation := self getExpectations removeFirst.
	^ contentReader
		ifNil: [ expectation value ]
		ifNotNil: [ contentReader value: expectation value ]
	
]

{ #category : #accessing }
CpClientDouble >> getExpectations [
	^ getExpectations ifNil: [ getExpectations := OrderedCollection new ]
]

{ #category : #'as yet unclassified' }
CpClientDouble >> shouldGet: url [

	self shouldGet: url andReturn: ''
]

{ #category : #accessing }
CpClientDouble >> shouldGet: url andReturn: returnString [

	self getExpectations add: url -> returnString
]
