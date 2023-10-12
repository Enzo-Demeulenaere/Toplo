"
A ToDefaultStyleSheetTest is a test class for testing the behavior of ToDefaultStyleSheet
"
Class {
	#name : #ToBeeStyleSheetTest,
	#superclass : #TestCase,
	#instVars : [
		'styleSheet'
	],
	#category : #'Toplo-Theme-Bee-Tests'
}

{ #category : #running }
ToBeeStyleSheetTest >> setUp [ 

	super setUp.
	ToTheme cleanUp.
	styleSheet := ToBeeTheme new styleSheet.
	styleSheet inherits: false.
]

{ #category : #skin }
ToBeeStyleSheetTest >> testDefaultButtonSkin [

	| ss button writers skin labelSkin ssi |
	ss := ToBeeStyleSheet new.
	ssi := ToStyleSheetSkinBuilder new.
	button := ToButton new.
	writers := ssi writersFor: button.
	self assert: writers notEmpty.
	skin := ToStyleSheetSkin new.
	skin writers: writers.
	button withSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button checkSkinInstallation.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self assert: button border paint color equals: (button stampValue: #'color-border').
	
	button labelText: 'Default'.
	button label privateSkin: nil.
	
	labelSkin := ToStyleSheetSkin new.
	writers := ssi writersFor: button label.
	labelSkin writers: writers.
	button label withSkin: labelSkin.
	button checkSkinInstallation.
	
	
]

{ #category : #'labeled-icon' }
ToBeeStyleSheetTest >> testLabeledIconWithLabelAndIcon [

	| li |
	li := ToLabeledIcon new.
	li styleSheet: styleSheet.
	li label: (ToLabel text: 'A').
	li icon: (ToImage inner: (BlElement new
			 size: 60 @ 20;
			 background: (Color blue alpha: 0.2);
			 yourself)).
	self assert: (li icon constraints linear vertical alignment isKindOf: BlVerticalCenterAlignment) .	
	self assert: (li icon constraints linear horizontal alignment isKindOf: BlHorizontalCenterAlignment).
	self assert: (li filler constraints linear vertical alignment isKindOf: BlVerticalCenterAlignment) .	
	self assert: (li filler constraints linear horizontal alignment isKindOf: BlHorizontalCenterAlignment).
	self assert: (li label constraints linear vertical alignment isKindOf: BlVerticalCenterAlignment) .	
	self assert: (li label constraints linear horizontal alignment isKindOf: BlHorizontalCenterAlignment).

]

{ #category : #'look updaters' }
ToBeeStyleSheetTest >> testWriteablePropertyList [

	| index count elem |
	elem := ToElement new.
	elem styleSheet: styleSheet.
	index := IdentityDictionary new.
	styleSheet writablePropertyList do: [ :p |
		index at: p name ifAbsentPut: [ 0 ].
		count := (index at: p name) + 1.
		index at: p name put: count ].
	index keysAndValuesDo: [ :k :v | self assert: v identicalTo: 1 ].
	styleSheet writablePropertyList do: [ :p | self assert: (styleSheet writablePropertyNamed: p name) notNil ]
]