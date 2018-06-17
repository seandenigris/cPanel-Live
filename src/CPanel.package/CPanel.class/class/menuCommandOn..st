world menu
menuCommandOn: aBuilder  
	<worldMenu>
	(aBuilder item: #'CPanel') with: [
		(aBuilder item: #'Browse Servers')
			action: [ self servers inspect ];
			icon: (Smalltalk ui icons iconNamed: #smallRemoteOpenIcon).
		(aBuilder item: #'Connect...')
		action: [ CPanelLogin openForm ];
		icon: (Smalltalk ui icons iconNamed: #smallRemoteOpenIcon). ]. 