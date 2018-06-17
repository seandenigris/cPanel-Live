baseline
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec 
			project: 'NeoJSON' with: [
				spec
					className: #ConfigurationOfNeoJSON;
					versionString: #'stable';
					repository: 'http://mc.stfx.eu/Neo' ];
			project: 'BabyPhexample' with: [
				spec
					className: #ConfigurationOfBabyPhexample;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo40/main/' ];
			project: 'Magritte3' with: [
				spec
					className: #ConfigurationOfMagritte3;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Magritte/Magritte3/main/' ].
		spec package: 'CPanel' with: [
				spec requires: #('NeoJSON' 'BabyPhexample' 'Magritte3' ). ]. ].
