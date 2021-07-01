baseline
baseline: spec
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ].
		spec package: 'CPanel' with: [
				spec requires: #('BabyPhexample' 'Magritte' 'Mocketry' 'NeoJSON' 'PharoEnhancements' 'SimplePersistence'). ]. ].
