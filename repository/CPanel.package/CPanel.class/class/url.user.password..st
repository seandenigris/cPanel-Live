instance creation
url: aUrl user: username password: password

	^ self new
		url: aUrl;
		loginAs: username withPassword: password;
		yourself