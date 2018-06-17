private
client
	^ client ifNil: [
		client := ZnClient new
			url: url;
			yourself ]