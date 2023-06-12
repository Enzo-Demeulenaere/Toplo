Class {
	#name : #ToExampleTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests'
}

{ #category : #accessing }
ToExampleTest class >> testSelectors [
	
	^ (self class selectors select: [ :each | (each beginsWith: 'example_B') and: [each numArgs isZero]])
]
