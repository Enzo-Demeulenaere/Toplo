Class {
	#name : #ToDresserMouseEventListener,
	#superclass : #ToMouseEventListener,
	#instVars : [
		'dresser'
	],
	#category : #'Toplo-Core'
}

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> clickEvent: anEvent [

	super clickEvent: anEvent.
	self dresser clickEvent: anEvent in: privateTarget
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> doubleClickEvent: anEvent [

	super doubleClickEvent: anEvent.
	self dresser doubleClickEvent: anEvent in: privateTarget  
]

{ #category : #accessing }
ToDresserMouseEventListener >> dresser [

	^ dresser
]

{ #category : #accessing }
ToDresserMouseEventListener >> dresser: aDresser [

	dresser := aDresser
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> leftClickEvent: anEvent [

	super leftClickEvent: anEvent.
	self dresser leftClickEvent: anEvent in: privateTarget 
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> leftMouseDownEvent: anEvent [

	super leftMouseDownEvent: anEvent.
	self dresser leftMouseDownEvent: anEvent in: privateTarget
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> leftMouseUpEvent: anEvent [

	super leftMouseUpEvent: anEvent.
	self dresser leftMouseUpEvent: anEvent in: privateTarget
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> middleClickEvent: anEvent [

	super middleClickEvent: anEvent.
	self dresser middleClickEvent: anEvent in: privateTarget 
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> middleMouseDownEvent: anEvent [

	super middleMouseDownEvent: anEvent.
	self dresser middleMouseDownEvent: anEvent in: privateTarget
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> middleMouseUpEvent: anEvent [

	super middleMouseUpEvent: anEvent.
	self dresser middleMouseUpEvent: anEvent in: privateTarget
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> mouseDownOutsideEvent: anEvent [

	super mouseDownOutsideEvent: anEvent.
	self dresser mouseDownOutside: privateTarget event: anEvent

]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> mouseEnterEvent: anEvent [

	super mouseEnterEvent: anEvent.
	self dresser mouseEnterEvent: anEvent in: privateTarget
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> mouseLeaveEvent: anEvent [

	super mouseLeaveEvent: anEvent.
	self dresser mouseLeaveEvent: anEvent in: privateTarget
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> mousePickOutsideEvent: anEvent [

	super mousePickOutsideEvent: anEvent.
	self dresser mousePickOutsideEvent: anEvent in: privateTarget

]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> mouseUpEvent: anEvent [

	super mouseUpEvent: anEvent.
	self dresser mouseUpEvent: anEvent in: privateTarget
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> mouseUpOutsideEvent: anEvent [

	super mouseUpOutsideEvent: anEvent.
	self dresser mouseUpOutside: privateTarget event: anEvent

]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> rightMouseDownEvent: anEvent [

	super rightMouseDownEvent: anEvent.
	self dresser rightMouseDownEvent: anEvent in: privateTarget
]

{ #category : #'mouse handlers' }
ToDresserMouseEventListener >> rightMouseUpEvent: anEvent [

	super rightMouseUpEvent: anEvent.
	self dresser rightMouseUpEvent: anEvent in: privateTarget
]