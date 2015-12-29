convenience
forwardMailFrom: newEmail to: target

	| isSuccess |
	self emailAddForwarderFrom: newEmail to: target.
	isSuccess := self hasForwarderFrom: newEmail to: target.
	isSuccess
		ifTrue: [ 
			UIManager inform: 'Now forwarding mail from ' , newEmail.
			Clipboard clipboardText: newEmail ]