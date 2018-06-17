actions
connect
	| result |
	result := CPanel url: self url user: self username password: self password.
	result inspect