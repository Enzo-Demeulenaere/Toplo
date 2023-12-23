Class {
	#name : 'ToListNodeSelectionEvent',
	#superclass : 'ToListNodeEvent',
	#instVars : [
		'listElement',
		'selected'
	],
	#category : 'Toplo-Widget-List-Node',
	#package : 'Toplo-Widget-List',
	#tag : 'Node'
}

{ #category : 'accessing' }
ToListNodeSelectionEvent >> listElement [

	^ listElement
]

{ #category : 'accessing' }
ToListNodeSelectionEvent >> listElement: aListElement [

	listElement := aListElement
]

{ #category : 'accessing' }
ToListNodeSelectionEvent >> selected [

	^ selected
]

{ #category : 'accessing' }
ToListNodeSelectionEvent >> selected: aBoolean [

	selected := aBoolean
]

{ #category : 'sending' }
ToListNodeSelectionEvent >> sendTo: anObject [

	anObject listNodeSelectionEvent: self
]