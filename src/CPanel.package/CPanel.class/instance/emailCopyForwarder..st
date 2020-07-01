email
emailCopyForwarder: forwarder
	"Use case example: copying forwarders from one server to another during migration"

	self 
		emailAddForwarderFrom: (forwarder at: 'dest')
		to: (forwarder at: 'forward').