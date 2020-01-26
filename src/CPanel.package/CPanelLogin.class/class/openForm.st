connecting
openForm
	<script>

	self new openFormAnswering: [ :login | 
		login connect.
		CPanel servers add: login cPanel. 
		login cPanel inspect ]