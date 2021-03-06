Class {
	#name : #FAMIXScopingEntity,
	#superclass : #FAMIXContainerEntity,
	#traits : 'FamixTWithGlobalVariables',
	#classTraits : 'FamixTWithGlobalVariables classTrait',
	#instVars : [
		'#childScopes => FMMany type: #FAMIXScopingEntity opposite: #parentScope',
		'#parentScope => FMOne type: #FAMIXScopingEntity opposite: #childScopes'
	],
	#category : #'Famix-Compatibility-Entities-Entities'
}

{ #category : #meta }
FAMIXScopingEntity class >> annotation [

	<FMClass: #ScopingEntity super: #FAMIXContainerEntity>
	<package: #FAMIX>
	<generated>
	^self
]

{ #category : #'Famix-Extensions-metrics' }
FAMIXScopingEntity >> abstractness [
	"Abstractness is the ratio between the number of abstract classes and the total number of classes in a package, in the range [0, 1]. 0 means the package is fully concrete, 1 it is fully abstract."
	
	self subclassResponsibility
]

{ #category : #accessing }
FAMIXScopingEntity >> addChildScope: aScopingEntity [ 
	childScopes add: aScopingEntity
]

{ #category : #'Famix-Extensions-metrics' }
FAMIXScopingEntity >> afferentCoupling [
	"Afferent coupling for a module is the number of modules that depend upon this module"
	
	^ self subclassResponsibility
]

{ #category : #accessing }
FAMIXScopingEntity >> allChildScopes [
	| result |
	result := OrderedCollection new.
	self allChildScopesDo: [ :each | result add: each].
	^ result 
]

{ #category : #accessing }
FAMIXScopingEntity >> allChildScopesDo: aBlock [
	self childScopes do: [:each |
		each withAllChildScopesDo: aBlock ]
]

{ #category : #accessing }
FAMIXScopingEntity >> allChildScopesGroup [
	<navigation: 'All child scopes'>
	^ FamixNamespaceGroup withAll: self allChildScopes withDescription: 'All child scopes from ', self printString
]

{ #category : #'Famix-Extensions' }
FAMIXScopingEntity >> allClasses [
	| result |
	result := OrderedCollection new.
	self withAllChildScopesDo: [ :each | result addAll: each classes ].
	^ result
]

{ #category : #'Famix-Extensions' }
FAMIXScopingEntity >> allClassesGroup [
	<navigation: 'All classes'>
	^ FamixTypeGroup withAll: self allClasses withDescription: 'All classes from ', self printString
]

{ #category : #'Famix-Extensions-metrics' }
FAMIXScopingEntity >> bunchCohesion [
	"Computing cohesion (Bunch formula)"

	^ self subclassResponsibility
]

{ #category : #'Famix-Extensions-metrics' }
FAMIXScopingEntity >> bunchCouplingWith: aScope [
	"Computing coupling (Bunch formula) with aScope"

	^ self subclassResponsibility
]

{ #category : #accessing }
FAMIXScopingEntity >> childScopes [
	"Relation named: #childScopes type: #FAMIXScopingEntity opposite: #parentScope"

	<generated>
	<FMComment: 'Child scopes embedded in this scope, if any.'>
	<derived>
	^ childScopes
]

{ #category : #accessing }
FAMIXScopingEntity >> childScopes: anObject [

	<generated>
	childScopes value: anObject
]

{ #category : #'Famix-Extensions' }
FAMIXScopingEntity >> childrenOfMyKind [
	"Polymorphic accessor to children of this scope in a hierarchical structure (package->subpackages, scope->subscopes)"

	^ self children allWithSubTypesOf: self class
]

{ #category : #'Famix-Extensions-metrics' }
FAMIXScopingEntity >> distance [
	"D = A + I - 1. A package should be balanced between abstractness and instability, i.e., somewhere between abstract and stable or concrete and unstable. This rule defines the main sequence by the equation A + I - 1 = 0. D is the distance to the main sequence."
	
	self subclassResponsibility
]

{ #category : #'Famix-Extensions-metrics' }
FAMIXScopingEntity >> efferentCoupling [
	"Efferent coupling for a module is the number of modules it depends upon"
	
	^ self subclassResponsibility
]

{ #category : #'Famix-Extensions-metrics' }
FAMIXScopingEntity >> instability [
	"I =	Ce(P)/(Ce(P)+Ca(P)), in the range [0, 1]. 0 means package is maximally stable (i.e., no dependency to other packages and can not change without big consequences), 1 means it is unstable."
	
	self subclassResponsibility
]

{ #category : #accessing }
FAMIXScopingEntity >> parentScope [
	"Relation named: #parentScope type: #FAMIXScopingEntity opposite: #childScopes"

	<generated>
	<FMComment: 'Parent scope embedding this scope, if any.'>
	<container>
	^ parentScope
]

{ #category : #accessing }
FAMIXScopingEntity >> parentScope: anObject [

	<generated>
	parentScope := anObject
]

{ #category : #navigation }
FAMIXScopingEntity >> parentScopeGroup [
	<generated>
	<navigation: 'ParentScope'>
	^ MooseSpecializedGroup with: self parentScope
]

{ #category : #'Famix-Extensions' }
FAMIXScopingEntity >> structuralChildren [ 
	^ (OrderedCollection withAll: self childScopes), self classes 
]

{ #category : #'Famix-Extensions' }
FAMIXScopingEntity >> withAllChildrenOfType: anSTClass [ 
	| all |
	all := OrderedCollection new.	
	self withAllChildScopesDo: [:each | each class = anSTClass ifTrue: [ all add: each ] ].
	^ (Smalltalk at: (anSTClass name, 'Group') asSymbol ifAbsent: [MooseGroup]) withAll: all
]
