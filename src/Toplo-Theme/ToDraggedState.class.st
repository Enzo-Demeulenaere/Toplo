Class {
	#name : 'ToDraggedState',
	#superclass : 'ToElementState',
	#category : 'Toplo-Theme-State',
	#package : 'Toplo-Theme',
	#tag : 'State'
}

{ #category : 'accessing' }
ToDraggedState >> incompatibleStateClasses [

	^ {  }
]

{ #category : 'testing' }
ToDraggedState >> isPersistent [

	^ false
]

{ #category : 'accessing' }
ToDraggedState >> lookEventClass [

	^ ToDraggedLookEvent
]