system startup
startUp: isStartup
	isStartup ifTrue: [ self servers do: #refreshLoginStatus ]