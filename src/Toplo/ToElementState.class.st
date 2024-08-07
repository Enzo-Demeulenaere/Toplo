Class {
	#name : #ToElementState,
	#superclass : #Object,
	#category : #'Toplo-Core-States'
}

{ #category : #'look event sending' }
ToElementState >> applyOn: anElement [

	anElement dispatchEvent: self skinEvent.
	self onAppliedOn: anElement
]

{ #category : #testing }
ToElementState >> canBeEnqueuedFromElement: anElement inQueue: aStateQueue [

	^ aStateQueue hasInstallStateEnqueued
]

{ #category : #'look event sending' }
ToElementState >> onAppliedOn: anElement [

]

{ #category : #'look event sending' }
ToElementState >> requestEnqueueFromElement: anElement inQueue: aStateQueue [

	(self canBeEnqueuedFromElement: anElement inQueue: aStateQueue) ifTrue: [
		aStateQueue enqueueState: self for: anElement ]
]

{ #category : #accessing }
ToElementState >> skinEvent [

	^ self subclassResponsibility 
]
