Class {
	#name : #BaselineOfCPanel,
	#superclass : #BaselineOf,
	#category : 'BaselineOfCPanel'
}

{ #category : #baseline }
BaselineOfCPanel >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ].
		spec package: 'CPanel' with: [
				spec requires: #('Magritte' 'Mocketry' 'PharoEnhancements' 'SimplePersistence'). ]. ].
				
	spec for: #notGToolkit do: [
		spec baseline: 'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON' ].
		spec 
			package: 'CPanel' with: [ 
				spec requires: 'NeoJSON' ] ].
]

{ #category : #accessing }
BaselineOfCPanel >> customProjectAttributes [
	^ self isGTImage
			ifFalse: [ #(notGToolkit) ]
			ifTrue: [ #(GToolkit) ]
]

{ #category : #testing }
BaselineOfCPanel >> isGTImage [
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'GToolkit-' ]
]
