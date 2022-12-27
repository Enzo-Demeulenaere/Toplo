Class {
	#name : #ToGeneralButtonModel,
	#superclass : #ToViewModel,
	#category : #'Toplo-View Models'
}

{ #category : #'private - accessing - widget' }
ToGeneralButtonModel >> privateWidgetClass [

	^ ToGeneralButton
]

{ #category : #processing }
ToGeneralButtonModel >> setUpStatesWith: aCollectionOfStates [

	self widgetDo: [ :widget | widget setUpStatesWith: aCollectionOfStates ]
]

{ #category : #'api - action' }
ToGeneralButtonModel >> whenClickedDo: aBlock [
	"Inform that the button has been aclicked, and its action has been performed.
	 `aBlock` receive zero arguments."
	
	self widgetDo: [ :widget | widget whenClickedDo: aBlock ]
]