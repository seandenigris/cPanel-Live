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
			baseline: 'BabyPhexample' with: [
				spec repository: 'github://seandenigris/Baby-Phexample:master/repository' ];
			baseline: 'Magritte3' with: [
				spec repository: 'github://seandenigris/Magritte3:master/repository' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence:master/repository' ].
		spec package: 'CPanel' with: [
				spec requires: #('NeoJSON' 'BabyPhexample' 'Magritte3' 'SimplePersistence'). ]. ].
