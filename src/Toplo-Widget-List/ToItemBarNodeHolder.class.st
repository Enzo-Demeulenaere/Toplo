Class {
	#name : #ToItemBarNodeHolder,
	#superclass : #ToNodeHolder,
	#category : #'Toplo-Widget-List-ItemBar'
}

{ #category : #accessing }
ToItemBarNodeHolder >> dataItem: aDataItem [

	| infiniteConstraints |
	super dataItem: aDataItem.
	infiniteConstraints := aDataItem constraints infinite.
	infiniteConstraints holder: self
]

{ #category : #accessing }
ToItemBarNodeHolder >> initializeNode [

	self dataItem itemConstraintsDo: [ :ic |
		ic constraintItem: self dataItem.
		self disabled: self dataItem isDisabled.
		self node flagAsDisabled: self dataItem isDisabled.
		self isHidden ifTrue: [ self node height: 0 ] ]

]
