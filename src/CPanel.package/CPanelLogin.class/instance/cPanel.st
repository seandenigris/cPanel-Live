actions
cPanel
	
	^ cPanel ifNil: [ 
			cPanel := CPanel new
				url: self url;
				yourself ].