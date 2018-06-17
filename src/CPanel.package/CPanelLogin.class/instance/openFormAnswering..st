actions
openFormAnswering: aBlock

	self asMagritteMorph
		addButtons;
		addWindow;
		onAnswer: aBlock;
		openInWorld