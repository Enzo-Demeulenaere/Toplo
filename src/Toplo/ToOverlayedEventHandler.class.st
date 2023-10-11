Class {
	#name : #ToOverlayedEventHandler,
	#superclass : #ToAnchorEventHandler,
	#category : #'Toplo-Core-Window'
}

{ #category : #'element handlers' }
ToOverlayedEventHandler >> elementExtentChangedEvent: anEvent [

	windowHandler applySizeHookFromEvent: anEvent
]

{ #category : #'api - accessing' }
ToOverlayedEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { BlElementExtentChangedEvent }
]