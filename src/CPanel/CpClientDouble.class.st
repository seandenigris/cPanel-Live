Class {
	#name : #CpClientDouble,
	#superclass : #Object,
	#instVars : [
		'getExpectations',
		'contentReader'
	],
	#category : 'CPanel-Specification'
}

{ #category : #'as yet unclassified' }
CpClientDouble >> contentReader: aBlock [
	contentReader := aBlock
]

{ #category : #'as yet unclassified' }
CpClientDouble >> get: aZnUrl [ 

	| response |
	(self getExpectations includesKey: aZnUrl) should beTrue.
	response := self getExpectations at: aZnUrl.
	self getExpectations removeKey: aZnUrl.
	^ contentReader
		ifNil: [ response ]
		ifNotNil: [ contentReader value: response ]
	
]

{ #category : #'as yet unclassified' }
CpClientDouble >> getExpectations [
	^ getExpectations ifNil: [ getExpectations := Dictionary new ]
]

{ #category : #'as yet unclassified' }
CpClientDouble >> shouldGet: url [

	self shouldGet: url andReturn: ''
]

{ #category : #'as yet unclassified' }
CpClientDouble >> shouldGet: url andReturn: returnString [

	self getExpectations at: url put: returnString
]
