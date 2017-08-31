email
emailCopyForwarder: forwarder

	self 
		emailAddForwarderFrom: (forwarder at: 'dest')
		to: (forwarder at: 'forward').