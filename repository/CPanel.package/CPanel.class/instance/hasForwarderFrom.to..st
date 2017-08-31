testing
hasForwarderFrom: sourceEmail to: targetEmail

	| domain forwarders |
	domain := sourceEmail cpAsEmailAddress domain.
	forwarders := self emailListForwardersFor: domain.
	^ forwarders anySatisfy: [ :e |
		(e at: 'dest') = sourceEmail and: [ (e at: 'forward') = targetEmail ] ]