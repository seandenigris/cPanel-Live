connecting
openForm
	<script>

	self new openFormAnswering: [ :login | 
		login connect. 
		login cPanel inspect ]