Class {
	#name : #CPanelDB,
	#superclass : #SpFileDatabase,
	#category : 'CPanel-Persistence'
}

{ #category : #accessing }
CPanelDB class >> backupDirectoryParent [
	^ FileLocator dynabookData
]

{ #category : #accessing }
CPanelDB class >> schema [

	^ { CPanel }.
]
