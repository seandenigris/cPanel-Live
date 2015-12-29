world menu
menuCommandOn: aBuilder  
	<worldMenu>
	(aBuilder item: #'CPanel Connect...')
		action: [ self openForm ];
		icon: (Smalltalk ui icons iconNamed: #smallRemoteOpenIcon). 