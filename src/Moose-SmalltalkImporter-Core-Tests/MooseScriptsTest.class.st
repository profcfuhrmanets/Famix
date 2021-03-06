Class {
	#name : #MooseScriptsTest,
	#superclass : #TestCase,
	#category : #'Moose-SmalltalkImporter-Core-Tests'
}

{ #category : #accessing }
MooseScriptsTest class >> defaultTimeLimit [
	^ 1 minute
]

{ #category : #tests }
MooseScriptsTest >> testCreateLightModels [
	| models lanModel |
	#(#createLightModelForLAN #createLightModelForMorphic #createLightModelForNetwork)
		do: [ :k | 
			models := MooseModel root entities copy.
			MooseScripts perform: k.
			self assert: MooseModel root entities size equals: models size + 1.
			lanModel := (MooseModel root entities copyWithoutAll: models) first.
			lanModel remove.
			self assert: MooseModel root entities size equals: models size ]
]
