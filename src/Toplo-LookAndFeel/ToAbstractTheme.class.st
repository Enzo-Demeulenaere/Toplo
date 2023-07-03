Class {
	#name : #ToAbstractTheme,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#classInstVars : [
		'current'
	],
	#category : #'Toplo-LookAndFeel-Core'
}

{ #category : #cleanup }
ToAbstractTheme class >> cleanUp [
	<script>

	current := nil
]

{ #category : #cleanup }
ToAbstractTheme class >> cleanUp: anObject [

	self cleanUp
]

{ #category : #current }
ToAbstractTheme class >> current [

	current ifNil: [ current := ToTheme blue ].
	^ current
]

{ #category : #dresser }
ToAbstractTheme class >> dresserFor: aToElement [
	"return dresser which manage this theme"

	aToElement ifNil:[ ^ nil ].
	(aToElement isKindOf: ToElement) ifFalse:[ ^ nil ].

	aToElement class = ToRadioButton ifTrue: [ ^ ToLAFRadioButtonDresser new ].
	aToElement class = ToButton ifTrue: [ ^ ToLAFButtonDresser new ].
	aToElement class = ToLabel ifTrue: [ ^ ToLAFLabelDresser new ].
	aToElement class = ToImage ifTrue: [ ^ ToLAFImageDresser new ].

	^ aToElement defaultDresser
]

{ #category : #testing }
ToAbstractTheme class >> isAbstract [

	^ self = ToAbstractTheme
]

{ #category : #skins }
ToAbstractTheme class >> skinClassesFor: aToElementClass [
	"return skins which are designed for this theme"
	
	^ self subclassResponsibility
]

{ #category : #skins }
ToAbstractTheme class >> skinFor: aToElementClass type: aType [
	"return skin which are designed for this theme and a specified type"

	| skinClasses type skinClass |
	skinClasses := self skinClassesFor: aToElementClass.
	skinClasses ifEmpty: [ ^ nil ].
	
	type := aType ifNil:[ ToAbstractSkin defaultType ].
	skinClass := skinClasses detect: [ :e | e type = type ] ifNone: [ skinClasses first ].

	^ skinClass new
]

{ #category : #skins }
ToAbstractTheme class >> skins [
	"Return the list of all supported skins for this Theme"
	| set widgetClasses |
	set := Set new.
	
	widgetClasses := ToElement allSubclasses.
	widgetClasses do:[ :c | set addAll: (self skinClassesFor: c) ]. 
	
	^set asOrderedCollection
]

{ #category : #colors }
ToAbstractTheme >> backgroundColor [

	^ Color white
]

{ #category : #colors }
ToAbstractTheme >> darkTheme [

	^ nil
]

{ #category : #installation }
ToAbstractTheme >> installOnSpace: aSpace [

	aSpace ifNil:[ ^ self ].

	"Update root background color depending theme"
	self flag:'labordep : this code should not be here but in a dresser dedicated to root element (to be coherent with dresser pattern)'.
	aSpace root background: self backgroundColor.
	
	"Tag installation complete"
	aSpace root userData at: #isToThemeInstalled put: true
]

{ #category : #colors }
ToAbstractTheme >> isDark [

	^ false
]

{ #category : #colors }
ToAbstractTheme >> isLight [

	^ false
]

{ #category : #colors }
ToAbstractTheme >> isSupportLightAndDark [

	^ self isLight or: [ self isDark ]
]

{ #category : #colors }
ToAbstractTheme >> lightTheme [

	^ nil
]

{ #category : #accessing }
ToAbstractTheme >> name [

	^ name ifNil:[ name := 'No name Theme' ]
]

{ #category : #accessing }
ToAbstractTheme >> name: anObject [

	name := anObject
]

{ #category : #colors }
ToAbstractTheme >> printOn: aStream [

	aStream
		nextPutAll: (self name ifNil:[self class name]);
		nextPutAll: ' @ ';
		store: self identityHash
]

{ #category : #skins }
ToAbstractTheme >> skins [
	"Return all skins supported by the Theme"
	
	^self class skins
]