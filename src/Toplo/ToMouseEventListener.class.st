Class {
	#name : #ToMouseEventListener,
	#superclass : #BlEventListener,
	#instVars : [
		'privateTarget'
	],
	#category : #'Toplo-Core'
}

{ #category : #'mouse handlers' }
ToMouseEventListener >> clickAvortedEvent: anEvent [

	super clickAvortedEvent: anEvent.
	(anEvent upTarget ~= privateTarget and: [ (privateTarget findMouseEventTargetAt: anEvent upTarget position) isNil ])
		ifTrue: [ ^ self ].
	anEvent processor fireClickEventFrom: anEvent
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> clickEvent: anEvent [

	super clickEvent: anEvent.
	anEvent
		  ifPrimary: [ self leftClickEvent: anEvent ]
		  secondary: [ self rightClickEvent: anEvent ]
		  middle: [ self middleClickEvent: anEvent ]
		  other: [ self leftClickEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> doubleClickEvent: anEvent [

	super doubleClickEvent: anEvent
]

{ #category : #'api - accessing' }
ToMouseEventListener >> eventsToHandle [

	^ {
		  BlUIEvent.
		  BlMousePickOutsideEvent }
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> leftClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> leftMouseDownEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToMouseEventListener >> leftMouseUpEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> middleClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> middleMouseDownEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToMouseEventListener >> middleMouseUpEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseDownEvent: anEvent [

	super mouseDownEvent: anEvent.
	anEvent
		  ifPrimary: [ self leftMouseDownEvent: anEvent ]
		  secondary: [ self rightMouseDownEvent: anEvent ]
		  middle: [ self middleMouseDownEvent: anEvent ]
		  other: [ self leftMouseDownEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseDownOutsideEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseLeaveEvent: anEvent [

	super mouseLeaveEvent: anEvent
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mousePickOutsideEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseUpEvent: anEvent [

	super mouseUpEvent: anEvent.
	anEvent
		  ifPrimary: [ self leftMouseUpEvent: anEvent ]
		  secondary: [ self rightMouseUpEvent: anEvent ]
		  middle: [ self middleMouseUpEvent: anEvent ]
		  other: [ self leftMouseUpEvent: anEvent ]
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> mouseUpOutsideEvent: anEvent [
]

{ #category : #'mouse handlers' }
ToMouseEventListener >> rightClickEvent: anEvent [

]

{ #category : #'mouse handlers' }
ToMouseEventListener >> rightMouseDownEvent: anEvent [


]

{ #category : #'mouse handlers' }
ToMouseEventListener >> rightMouseUpEvent: anEvent [

]

{ #category : #accessing }
ToMouseEventListener >> target: anElement [
	" the element which has myself as an event handler, must be not nil"
	privateTarget := anElement
]