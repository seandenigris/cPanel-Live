instance creation
url: aUrlOrString user: username password: password

	^ self new
		url: aUrlOrString asUrl;
		loginAs: username withPassword: password;
		yourself