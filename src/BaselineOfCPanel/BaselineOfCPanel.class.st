Class {
	#name : #BaselineOfCPanel,
	#superclass : #BaselineOf,
	#category : #BaselineOfCPanel
}

{ #category : #baseline }
BaselineOfCPanel >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: #'Magritte' with: [
				spec repository: 'github://seandenigris/Magritte' ];
			baseline: #'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: #'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: #'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ];
			baseline: #'Superuser' with: [
				spec repository: 'github://seandenigris/Superuser' ].
		spec package: #'CPanel' with: [
				spec requires: #(Magritte Mocketry PharoEnhancements SimplePersistence Superuser). ]. ].
				
	spec for: #notGToolkit do: [
		spec baseline: #'NeoJSON' with: [
				spec repository: 'github://svenvc/NeoJSON' ].
		spec 
			package: #'CPanel' with: [ 
				spec requires: #'NeoJSON' ] ].
]

{ #category : #accessing }
BaselineOfCPanel >> customProjectAttributes [
	^ self isGTImage
			ifTrue: [ #(GToolkit) ]
			ifFalse: [ #(notGToolkit) ]
]

{ #category : #testing }
BaselineOfCPanel >> isGTImage [
	
	^ RPackageOrganizer default packageNames anySatisfy: [ :pn | pn beginsWith: 'Lepiter-' ].
	"Implementation note: used to check for GToolkit prefix, but P7 has a GToolkit-Examples package. Lepiter, OTOH, could only be loaded in a GT image"
]
