Class {
	#name : #ToFocusedState,
	#superclass : #ToElementState,
	#category : #'Toplo-Theme-State'
}

{ #category : #'look event sending' }
ToFocusedState >> applyOn: anElement [

	anElement dispatchLookEvent: ToFocusedLookEvent new
]