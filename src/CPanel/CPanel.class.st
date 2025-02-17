"
#### Example Usage
self emailListForwardersFor: 'mydomain.com'.
self hasForwarderFrom: 'source@mydomain.com' to: 'destination@mydomain.com'.
self emailAddForwarderFrom: 'source@mydomain.com' to: 'destination@mydomain.com'.
"
Class {
	#name : #CPanel,
	#superclass : #Object,
	#instVars : [
		'nickname',
		'url',
		'securityToken',
		'client'
	],
	#classVars : [
		'Servers'
	],
	#classInstVars : [
		'clientClassForTesting'
	],
	#category : #CPanel
}

{ #category : #accessing }
CPanel class >> clientClass [
	^ clientClassForTesting ifNil: [ ^ ZnClient ]
]

{ #category : #'fuel support' }
CPanel class >> fuelIgnoredInstanceVariableNames [
	^ #(client)
]

{ #category : #initialization }
CPanel class >> initialize [
	
	SessionManager default 
		registerUserClassNamed: self name
		atPriority: SessionManager default defaultPriority + 1
]

{ #category : #'world menu' }
CPanel class >> menuCommandOn: aBuilder [  
	<worldMenu>
	(aBuilder item: #'CPanel') with: [
		(aBuilder item: #'Browse Servers')
			action: [ self servers inspect ];
			icon: (Smalltalk ui icons iconNamed: #smallRemoteOpenIcon).
		(aBuilder item: #'Connect...')
		action: [ CPanelLogin openForm ];
		icon: (Smalltalk ui icons iconNamed: #smallRemoteOpenIcon). ]. 
]

{ #category : #persistence }
CPanel class >> restoreFrom: anObject [

	Servers := anObject.
]

{ #category : #accessing }
CPanel class >> servers [
	^ Servers ifNil: [ Servers := OrderedCollection new ]
]

{ #category : #persistence }
CPanel class >> spData [
	^ Servers
]

{ #category : #'system startup' }
CPanel class >> startUp: isStartup [
	isStartup ifTrue: [ self servers do: #refreshLoginStatus ]
]

{ #category : #'instance creation' }
CPanel class >> url: aUrlOrString user: username password: password [

	^ self new
		url: aUrlOrString asUrl;
		loginAs: username withPassword: password;
		yourself
]

{ #category : #private }
CPanel >> baseApiUrl [
	^ self url / self securityToken / 'execute'
]

{ #category : #private }
CPanel >> client [
	^ client ifNil: [
		client := ZnClient new
			url: url;
			yourself ]
]

{ #category : #private }
CPanel >> client: aClient [
	client := aClient
]

{ #category : #contactus }
CPanel >> contactusIsEnabled [
	"From https://documentation.cpanel.net/display/DD/UAPI+Functions+-+Contactus%3A%3Ais_enabled
	
	URL:
	https://hostname.example.com:2083/cpsess##########/execute/Contactus/is_enabled"
	^ self client
		contentReader: [ :e | 
			| json |
			json := NeoJSONReader fromString: e contents.
			json at: 'data' ];
		get: self baseApiUrl / 'Contactus' / 'is_enabled'
]

{ #category : #magritte }
CPanel >> descriptionNickname [
	<magritteDescription>

	^ MAStringDescription new
			accessor: #nickname;
			priority: 200;
			yourself
]

{ #category : #magritte }
CPanel >> descriptionUrl [
	<magritteDescription>

	^ MAUrlDescription new
			accessor: #url;
			label: 'Url';
			priority: 100;
			yourself
]

{ #category : #email }
CPanel >> emailAddForwarderFrom: source to: target [
	"From https://documentation.cpanel.net/display/SDK/UAPI+Functions+-+Email%3A%3Aadd_forwarder"
	| sourceUser sourceDomain addForwarderUrl doesExist |
	doesExist := self hasForwarderFrom: source to: target.
	doesExist ifTrue: [ CpError signal: 'Forwarder already exists from ', source, ' to ', target ].
	sourceUser := source copyUpTo: $@.
	sourceDomain := source copyAfter: $@.
	addForwarderUrl := self baseApiUrl / 'Email' / 'add_forwarder' ? ('email' -> sourceUser) & ('domain' -> sourceDomain) & ('fwdopt' -> 'fwd') & ('fwdemail' -> target).
	self client
		contentReader: nil;
		get: addForwarderUrl.
	doesExist := self hasForwarderFrom: source to: target.
	doesExist ifFalse: [ CpError signal: 'Failed to create forwarder from ', source, ' to ', target ].
]

{ #category : #email }
CPanel >> emailCopyForwarder: forwarder [
	"Use case example: copying forwarders from one server to another during migration"

	self 
		emailAddForwarderFrom: (forwarder at: 'dest')
		to: (forwarder at: 'forward').
]

{ #category : #email }
CPanel >> emailListForwardersFor: domain [
	" 
	Example:
		self emailListForwardersFor: 'clipperadams.com'.
	
	API Reference: https://documentation.cpanel.net/display/SDK/UAPI+Functions+-+Email%3A%3Alist_forwarders"
	^ self client
		contentReader: [ :e | 
			| json |
			json := NeoJSONReader fromString: e contents.
			json at: 'data' ];
		get: self baseApiUrl / 'Email' / 'list_forwarders' ? ('domain' -> domain)
]

{ #category : #convenience }
CPanel >> forwardMailFrom: newEmail to: target [

	"Example: 
		self forwardMailFrom: 'alias@clipperadams.com' to: 'target@clipperadams.com'.
	"
	
	| isSuccess |
	self emailAddForwarderFrom: newEmail to: target.
	isSuccess := self hasForwarderFrom: newEmail to: target.
	isSuccess ifFalse: [ ^ self ].
	UIManager inform: 'Now forwarding mail from ' , newEmail.
	Clipboard clipboardText: newEmail
]

{ #category : #testing }
CPanel >> hasForwarderFrom: sourceEmail to: targetEmail [

	| domain forwarders |
	domain := sourceEmail asSuEmailAddress domain.
	forwarders := self emailListForwardersFor: domain.
	^ forwarders anySatisfy: [ :e |
		(e at: 'dest') = sourceEmail and: [ (e at: 'forward') = targetEmail ] ]
]

{ #category : #testing }
CPanel >> isLoggedIn [

	securityToken ifNil: [ ^ false ].

	"Implementation note: There doesn't seem to be an easy way to test for this via the API. As a workaround, when a function is called with an invalid security token, it returns HTML instead of the usual valid JSON response. We picked #contactusIsEnabled because it seemed to be a very simple call."
	^ [ self contactusIsEnabled. true ] 
			on: NeoJSONParseError
			do: [ false ].
]

{ #category : #accessing }
CPanel >> logIn [
	self client: nil. "Otherwise we get a 401 error due to the expited security token"
	(CPanelLogin for: self) openForm.
]

{ #category : #private }
CPanel >> loginAs: username withPassword: password [ 

	| json rawSecurityToken |
	json := self client
		path: '/login/';
		queryAt: 'login_only' put: '1';
		formAt: 'user' put: username;
		formAt: 'pass' put: password;
		contentReader: [ :e | NeoJSONReader fromString: e contents ];
		post.
	rawSecurityToken := json at: 'security_token'.
	securityToken := rawSecurityToken allButFirst: '/' size.
]

{ #category : #accessing }
CPanel >> nickname [
	^ nickname
]

{ #category : #accessing }
CPanel >> nickname: anObject [
	nickname := anObject
]

{ #category : #printing }
CPanel >> printOn: aStream [

	nickname ifNotNil: [ aStream nextPutAll: self nickname ].
	url ifNotNil: [ 
		aStream
			space;
			nextPut: $(;
			print: self url;
			nextPut: $) ].
]

{ #category : #private }
CPanel >> refreshLoginStatus [
	self isLoggedIn ifFalse: [ self securityToken: nil ]
]

{ #category : #accessing }
CPanel >> securityToken [
	^ securityToken ifNil: [ 
		self logIn. 
		securityToken ]
]

{ #category : #private }
CPanel >> securityToken: anObject [
	securityToken := anObject
]

{ #category : #private }
CPanel >> url [
	^ url
]

{ #category : #private }
CPanel >> url: anObject [
	url := anObject
]

{ #category : #email }
CPanel >> userLevelFiltering [
	"https://secureus84.sgcpanel.com:2083/{token}/frontend/Crystal/mail/filters/managefilters.html"
	
	self shouldBeImplemented.
	
	"Results of creating group email address (method per https://secure.web-hosting.net.my/clients/knowledgebase/209/how-to-create-an-email-group-in-cpanel.html):"
	
	"~/etc/domain.org/username/filter:"
	
	'if not first_delivery and error_message then finish endif

#E-Board
if
 $header_to: is "group@domain.org"
then
 deliver "user1@domain.org"
 deliver "user2@domain.org"
endif"'.

"~/etc/domain.org/username/filter.yaml (used by cPanel per https://forums.cpanel.net/threads/filter-vs-filter-yaml.292921/)"

'--- 
filter: 
  - 
    actions: 
      - 
        action: deliver
        dest: user1@domain.org
      - 
        action: deliver
        dest: user2@domain.org
    filtername: E-Board
    rules: 
      - 
        match: is
        opt: or
        part: "$header_to:"
        val: group@domain.org
    unescaped: 1
version: ''2.2'''.
]
