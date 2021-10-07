Class {
	#name : #CPanelLogin,
	#superclass : #Object,
	#instVars : [
		'url',
		'username',
		'password',
		'cPanel'
	],
	#category : 'CPanel'
}

{ #category : #connecting }
CPanelLogin class >> for: cPanel [

	^ self new
			cPanel: cPanel;
			yourself
]

{ #category : #connecting }
CPanelLogin class >> openForm [
	<script>

	self new openFormAnswering: [ :login | 
		login connect.
		CPanel servers add: login cPanel. 
		login cPanel inspect ]
]

{ #category : #actions }
CPanelLogin >> cPanel [
	
	^ cPanel ifNil: [ 
			cPanel := CPanel new
				url: self url;
				yourself ].
]

{ #category : #accessing }
CPanelLogin >> cPanel: anObject [
	cPanel := anObject
]

{ #category : #actions }
CPanelLogin >> connect [
	self cPanel loginAs: self username withPassword: self password 
]

{ #category : #magritte }
CPanelLogin >> descriptionPassword [
	<magritteDescription>

	^ MAPasswordDescription new
			accessor: #password;
			priority: 300;
			yourself
]

{ #category : #magritte }
CPanelLogin >> descriptionUrl [
	<magritteDescription>

	^ MAUrlDescription new
			accessor: #(cPanel url);
			priority: 100;
			yourself
]

{ #category : #magritte }
CPanelLogin >> descriptionUsername [
	<magritteDescription>

	^ MAStringDescription new
			accessor: #username;
			priority: 200;
			yourself
]

{ #category : #actions }
CPanelLogin >> openForm [

	self openFormAnswering: [ :login | login connect ]
]

{ #category : #actions }
CPanelLogin >> openFormAnswering: aBlock [

	self asMagritteMorph
		addButtons;
		addWindow;
		onAnswer: aBlock;
		openInWorld
]

{ #category : #accessing }
CPanelLogin >> password [
	^ password
]

{ #category : #accessing }
CPanelLogin >> password: anObject [
	password := anObject
]

{ #category : #accessing }
CPanelLogin >> url [
	^ url
]

{ #category : #accessing }
CPanelLogin >> url: anObject [
	url := anObject
]

{ #category : #accessing }
CPanelLogin >> username [
	^ username
]

{ #category : #accessing }
CPanelLogin >> username: anObject [
	username := anObject
]
