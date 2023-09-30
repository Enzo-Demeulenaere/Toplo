Class {
	#name : #ToPaneNodeExampleEventHandler,
	#superclass : #ToNodeEventHandler,
	#instVars : [
		'nodeButton',
		'changeBackground'
	],
	#category : #'Toplo-Examples'
}

{ #category : #accessing }
ToPaneNodeExampleEventHandler >> changeBackground [

	^ changeBackground ifNil: [ changeBackground := true ]
]

{ #category : #accessing }
ToPaneNodeExampleEventHandler >> changeBackground: aBoolean [

	changeBackground := aBoolean
]

{ #category : #'events handling' }
ToPaneNodeExampleEventHandler >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	self changeBackground ifTrue: [
		anEvent currentTarget background: (Color lightGray alpha: 0.2) ].
	nodeButton := ToButton new labelText: 'Do something'; yourself.
	nodeButton stampWith: #primary.
	nodeButton updateSkin.
	nodeButton whenClickedDo: [ self inform: 'CLICK' ].
	nodeButton constraintsDo: [ :c |
		c ignoreByLayout.
		c ignored horizontal alignRight ].
	anEvent currentTarget addChild: nodeButton.
	nodeButton position: 0 @ -10
]

{ #category : #'events handling' }
ToPaneNodeExampleEventHandler >> mouseLeaveEvent: anEvent [

	super mouseLeaveEvent: anEvent.
	self changeBackground ifTrue: [ anEvent currentTarget background: (Color transparent) ].
	nodeButton ifNotNil: [
		nodeButton removeFromParent.
		nodeButton := nil ]
]