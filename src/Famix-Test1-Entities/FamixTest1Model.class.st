"
This is a the comment of the model class
"
Class {
	#name : #FamixTest1Model,
	#superclass : #MooseModel,
	#instVars : [
		'#modelHasProperties => FMProperty'
	],
	#category : #'Famix-Test1-Entities-Model'
}

{ #category : #accessing }
FamixTest1Model class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Traits')
]

{ #category : #meta }
FamixTest1Model class >> annotation [
	<FMClass: #FamixTest1Model super: #MooseModel>
	<package: #'Famix-Test1-Entities'>
	<generated>
]

{ #category : #accessing }
FamixTest1Model >> modelHasProperties [

	<FMProperty: #modelHasProperties type: #Object>
	<generated>
	^ modelHasProperties
]

{ #category : #accessing }
FamixTest1Model >> modelHasProperties: anObject [
	<generated>
	modelHasProperties := anObject
]
