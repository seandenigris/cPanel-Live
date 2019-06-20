convenience
forwardMailFrom: newEmail to: target

	"Example: 
		self forwardMailFrom: 'alias@clipperadams.com' to: 'target@clipperadams.com'.
	"
	
	| isSuccess |
	self emailAddForwarderFrom: newEmail to: target.
	isSuccess := self hasForwarderFrom: newEmail to: target.
	isSuccess ifFalse: [ ^ self ].
	UIManager inform: 'Now forwarding mail from ' , newEmail.
	Clipboard clipboardText: newEmail