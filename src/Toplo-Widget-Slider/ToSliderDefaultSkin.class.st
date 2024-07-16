Class {
	#name : #ToSliderDefaultSkin,
	#superclass : #ToRawSkin,
	#category : #'Toplo-Widget-Slider-core'
}

{ #category : #'event handling' }
ToSliderDefaultSkin >> draggedSkinEvent: anEvent [

	super draggedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e valueLabel text:
			(e value asRopedText attributes: self valueAttributes) ]
]

{ #category : #'event handling' }
ToSliderDefaultSkin >> installSkinEvent: anEvent [ 

	super installSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e background: Color veryVeryLightGray.
		e bar background: Color veryLightGray.
		e coloredBar background: (Color darkGray alpha: 0.6).
		e handle background: Color darkGray.
		e minLabel text: (e minValue asRopedText attributes: self minMaxAttributes).
		e maxLabel text: (e maxValue asRopedText attributes: self minMaxAttributes).
		e valueLabel text: (e value asRopedText attributes: self valueAttributes) ]
]

{ #category : #accessing }
ToSliderDefaultSkin >> minMaxAttributes [

	^ {
		  (BlTextForegroundAttribute paint: Color black).
		  (BlFontSizeAttribute size: 15).
		  BlFontWeightAttribute bold }
]

{ #category : #'event handling' }
ToSliderDefaultSkin >> pressedSkinEvent: anEvent [

	super pressedSkinEvent: anEvent.
	anEvent elementDo: [ :e |
		e valueLabel text:
			(e value asRopedText attributes: self valueAttributes) ]
]

{ #category : #accessing }
ToSliderDefaultSkin >> valueAttributes [

	^ {
		  (BlTextForegroundAttribute paint: Color white).
		  (BlFontSizeAttribute size: 15).
		  BlFontWeightAttribute bold }
]
