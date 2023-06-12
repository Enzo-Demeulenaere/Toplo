Class {
	#name : #ToExampleTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests'
}

{ #category : #accessing }
ToExampleTest class >> testSelectors [
	
	^ (self class selectors select: [ :each | (each beginsWith: 'example_') and: [each numArgs isZero]])
]
