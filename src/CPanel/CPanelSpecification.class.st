Class {
	#name : #CPanelSpecification,
	#superclass : #TestCase,
	#instVars : [
		'url',
		'securityToken',
		'cPanel',
		'client',
		'domain',
		'urlListingForwarders'
	],
	#category : #'CPanel-Specification'
}

{ #category : #accessing }
CPanelSpecification >> emptyForwardersList [
	^ '{"messages":null,"errors":null,"status":1,"metadata":{"transformed":1},"data":[]}'.
]

{ #category : #'as yet unclassified' }
CPanelSpecification >> genericResponse [
	^ '{"messages":null,"errors":null,"status":1}'
]

{ #category : #'as yet unclassified' }
CPanelSpecification >> sampleForwardersList [
	^ '{"messages":null,"errors":null,"status":1,"metadata":{"transformed":1},"data":[{"html_dest":"fakeaddress1@mydomain.com","dest":"fakeaddress1@mydomain.com","html_forward":"target@mydomain.com","forward":"target@mydomain.com","uri_forward":"target%40mydomain.com","uri_dest":"fakeaddress1%40mydomain.com"},{"html_dest":"fakeaddress2@mydomain.com","dest":"fakeaddress2@mydomain.com","html_forward":"target@mydomain.com","forward":"target@mydomain.com","uri_forward":"target%40mydomain.com","uri_dest":"fakeaddress2%40mydomain.com"}]}'.
]

{ #category : #accessing }
CPanelSpecification >> setUp [

	url := 'https://my.domain.com/' asUrl.
	securityToken := 'securityToken'.
	domain := 'mydomain.com'.
	urlListingForwarders := url / securityToken / 'execute' / 'Email' / 'list_forwarders' ? ('domain' -> domain).
	client := CpClientDouble new.
	"Short circuit the usual creation method, which includes authentication, because it's hard to test"
	cPanel := CPanel new
		securityToken: securityToken;
		client: client;
		url: url;
		yourself
]

{ #category : #accessing }
CPanelSpecification >> testEmailAddForwarder [

	| sourceUser sourceDomain sourceEmail targetEmail expectedUrl |
	sourceUser := 'fakeaddress1'.
	sourceDomain := 'mydomain.com'.
	sourceEmail := sourceUser, '@', sourceDomain.
	targetEmail := 'target@mydomain.com'.
	expectedUrl := url / securityToken / 'execute' / 'Email' / 'add_forwarder' ? ('email' -> sourceUser) & ('domain' -> sourceDomain) & ('fwdopt' -> 'fwd') & ('fwdemail' -> targetEmail).
	client shouldGet: urlListingForwarders andReturn: self emptyForwardersList.
	client shouldGet: expectedUrl andReturn: self genericResponse.
	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	cPanel emailAddForwarderFrom: sourceEmail to: targetEmail
]

{ #category : #'as yet unclassified' }
CPanelSpecification >> testEmailAddForwarderAlreadyExists [

	| sourceUser sourceDomain sourceEmail targetEmail expectedUrl |
	sourceUser := 'fakeaddress1'.
	sourceDomain := 'mydomain.com'.
	sourceEmail := sourceUser, '@', sourceDomain.
	targetEmail := 'target@mydomain.com'.
	expectedUrl := url / securityToken / 'execute' / 'Email' / 'add_forwarder' ? ('email' -> sourceUser) & ('domain' -> sourceDomain) & ('fwdopt' -> 'fwd') & ('fwdemail' -> targetEmail).
	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	[ cPanel emailAddForwarderFrom: sourceEmail to: targetEmail ] should raise: CpError.
]

{ #category : #'as yet unclassified' }
CPanelSpecification >> testEmailHasForwarder [

	| result |
	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	result := cPanel hasForwarderFrom: 'fakeaddress1@', domain to: 'target@', domain.
	result should be: true.
]

{ #category : #'as yet unclassified' }
CPanelSpecification >> testEmailHasNoSuchForwarder [

	| result |
	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	result := cPanel hasForwarderFrom: 'unknown@', domain to: 'target@', domain.
	result should be: false
]

{ #category : #'as yet unclassified' }
CPanelSpecification >> testEmailListForwarders [

	client shouldGet: urlListingForwarders andReturn: self sampleForwardersList.
	cPanel emailListForwardersFor: domain
]
