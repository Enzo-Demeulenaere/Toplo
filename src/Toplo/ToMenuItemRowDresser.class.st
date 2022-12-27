Class {
	#name : #ToMenuItemRowDresser,
	#superclass : #ToDresser,
	#instVars : [
		'interspace'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'interspace computing' }
ToMenuItemRowDresser >> exactInterspaceChangedIn: anElement [

	| w left lw |
	
	" get the left side element "
	left := anElement isLabelFirst
		        ifTrue: [ anElement label ]
		        ifFalse: [ anElement element ].

	lw := left ifNil: [ 0 ] ifNotNil: [ left width ].
	" now measure the gap according to leftColumnWidth "
	w := anElement leftColumnWidth - lw max: 0.

	interspace ifNotNil: [ " adapt the existing fill "
		interspace width = w ifTrue: [ ^ false ].
		interspace size: w @ 0.
		^ true ].

	" first pass, create the fill "
	interspace := BlElement new
		                  size: w @ 0;
		                  id: #'icon-column-fill'.
	^ true
]

{ #category : #'interspace computing' }
ToMenuItemRowDresser >> interspaceChangedIn: anElement [

	" first the label column only if it is justified "

	anElement isJustified ifTrue: [ 
		(self justifiedInterspaceChangedIn: anElement) ifTrue: [ ^ true ].
		^ false ].

	" then check the left column "
	^ self exactInterspaceChangedIn: anElement
]

{ #category : #'interspace computing' }
ToMenuItemRowDresser >> justifiedInterspaceChangedIn: anElement [

	interspace ifNil: [ 
		interspace := anElement privateMatchParentFill.
		^ true ].
	^ false
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> onInstalledIn: anElement [

	super onInstalledIn: anElement.
	anElement whenLayoutedDoOnce: [ self updateInterspaceIn: anElement ].
	anElement
		whenAnnouncement: ToLabeledPresentationChangedAnnouncement
		do: [ 
			interspace := nil.
			self updateInterspaceIn: anElement ].
	anElement rowLayingOut: (self rowLayingOutIn: anElement)
]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> onUninstalledIn: anElement [

	super onUninstalledIn: anElement.

]

{ #category : #'api - install/uninstall  hook' }
ToMenuItemRowDresser >> rowLayingOutIn: anElement [

	^ (anElement isLabelFirst
		   ifTrue: [ 
			   { 
				   anElement label.
				   interspace.
				   anElement element } ]
		   ifFalse: [ 
			   { 
				   anElement element.
				   interspace.
				   anElement label } ]) select: #notNil
]

{ #category : #'interspace computing' }
ToMenuItemRowDresser >> updateInterspaceIn: anElement [

	(self interspaceChangedIn: anElement) ifFalse: [ ^ self ].
	
	" update the row laying out in the element "
	anElement rowLayingOut: (self rowLayingOutIn: anElement).
	" launch a second pass to finalize the laying out "
	anElement whenLayoutedDoOnce: [ self updateInterspaceIn: anElement ]
]