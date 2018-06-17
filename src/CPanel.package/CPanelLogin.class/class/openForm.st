connecting
openForm
	<script>

	self new asMagritteMorph
		addButtons;
		addWindow;
		onAnswer: [ :login | login connect ];
		openInWorld