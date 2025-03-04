Class {
	#name : #ToOverlayPlacement,
	#superclass : #ToTopLeftDownPlacement,
	#category : #'Toplo-Core-Window'
}

{ #category : #api }
ToOverlayPlacement >> arrangeWindow: aWindow onEvent: anEvent [

	| root element |
	root := aWindow anchorRoot.
	element := aWindow element.

	super arrangeWindow: aWindow onEvent: anEvent.
	aWindow size: element measuredWidth @ element measuredHeight
]
