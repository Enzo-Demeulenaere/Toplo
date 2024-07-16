Class {
	#name : #ToSlider,
	#superclass : #ToElement,
	#instVars : [
		'widgetSize',
		'handle',
		'bar',
		'coloredBar',
		'isHorizontal',
		'minValue',
		'maxValue',
		'stepValue',
		'barThickness',
		'barLength',
		'marginThickness',
		'marginLength',
		'segmented',
		'segmentedValues',
		'callBack',
		'overlayer',
		'value',
		'minLabel',
		'maxLabel',
		'label',
		'valueLabel',
		'name'
	],
	#category : #'Toplo-Widget-Slider-core'
}

{ #category : #accessing }
ToSlider class >> beHorizontal [

	^ self new beHorizontal 
]

{ #category : #accessing }
ToSlider class >> beVertical [ 
	
	^ self new beVertical 
]

{ #category : #accessing }
ToSlider class >> label: aString [ 

	|slider|
	slider := self new name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : #'instance creation' }
ToSlider class >> new [

	^ self readOnly initializeEvents
]

{ #category : #'instance creation' }
ToSlider class >> readOnly [

	^ self basicNew initialize
]

{ #category : #'instance creation' }
ToSlider class >> readOnlyLabel: aString [

	| slider |
	slider := self readOnly name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : #example }
ToSlider class >> simpleExampleHorizontal [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beHorizontal.
	textElt := BlTextElement new position: slider defaultSize.

	textElt text: slider value asRopedText.

	slider callBack: [ :value | textElt text: value asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : #example }
ToSlider class >> simpleExampleVertical [
	"The values of the slider are also written in the transcript"

	<script>
	| slider textElt container |
	slider := self beVertical.
	textElt := BlTextElement new position: slider defaultSize.

	textElt text: slider value asRopedText.

	slider callBack: [ :value | textElt text: value asRopedText ].

	container := BlElement new clipChildren: false.

	container addChild: slider.
	container addChild: textElt.

	container openInSpace
]

{ #category : #accessing }
ToSlider >> bar [
	^ bar
]

{ #category : #accessing }
ToSlider >> bar: aBlElement [ 
	bar := aBlElement
]

{ #category : #accessing }
ToSlider >> barLength [

	^ barLength
]

{ #category : #accessing }
ToSlider >> barLength: aNumber [

	barLength := aNumber.
	self rebuild
]

{ #category : #accessing }
ToSlider >> barThickness [ 

	^ barThickness 
]

{ #category : #accessing }
ToSlider >> barThickness: aNumber [

	barThickness := aNumber.
	self rebuild
]

{ #category : #'api - values' }
ToSlider >> basicSetValue: aNumber [

	value := aNumber.
	self callBack ifNotNil: [ :e | e value: value ]
]

{ #category : #accessing }
ToSlider >> beHorizontal [

	self horizontal: true.
	self rebuild
]

{ #category : #building }
ToSlider >> beSegmented [

	self stepValue
		ifNil: [ self error: 'Cannot segment a slider with a nil stepValue' ]
		ifNotNil: [ self segmented: true].
	self rebuild
]

{ #category : #building }
ToSlider >> beSmooth [

	self segmented: false.
	self segmentedValues: nil.
	self rebuild
]

{ #category : #accessing }
ToSlider >> beVertical [

	self horizontal: false.
	self buildVertical
]

{ #category : #building }
ToSlider >> buildHorizontal [

	widgetSize y > widgetSize x ifTrue: [
		self widgetSize: widgetSize y @ widgetSize x ].
	self removeParts.
	self initializeParts
]

{ #category : #building }
ToSlider >> buildVertical [

	widgetSize y > widgetSize x ifFalse: [
		self widgetSize: widgetSize y @ widgetSize x ].

	self removeParts.
	self initializeParts
]

{ #category : #accessing }
ToSlider >> callBack [ 

	^ callBack 
]

{ #category : #accessing }
ToSlider >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : #'as yet unclassified' }
ToSlider >> changeMaxValueLabelTo: aValue [

	maxLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	maxValue := aValue
]

{ #category : #'as yet unclassified' }
ToSlider >> changeMinValueLabelTo: aValue [

	minLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	valueLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color black).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).

	minValue := aValue.
	value := aValue
]

{ #category : #accessing }
ToSlider >> coloredBar [ 

	^ coloredBar 
]

{ #category : #accessing }
ToSlider >> coloredBar: aBlElement [

	coloredBar := aBlElement 
]

{ #category : #'api - slider' }
ToSlider >> decrementValue: aValue [

	| tmp |
	tmp := value - aValue.
	self setValue: tmp
]

{ #category : #'api - bounds' }
ToSlider >> defaultBar [

	| size |
	size := self
		        ifHorizontal: [
		        self defaultBarLength @ self defaultBarThickness ]
		        ifVertical: [
		        self defaultBarThickness @ self defaultBarLength ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  size: size;
		  constraintsDo: [ :c | c ignoreByLayout ];
		  yourself
]

{ #category : #'api - bounds' }
ToSlider >> defaultBarLength [

	^ 200
]

{ #category : #'api - bounds' }
ToSlider >> defaultBarThickness [

	^ 30
]

{ #category : #accessing }
ToSlider >> defaultColoredBar [

	| size |
	size := self
		        ifHorizontal: [ 0 @ self defaultBarThickness ]
		        ifVertical: [ self defaultBarThickness @ 0.1 ].

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 10);
		  constraintsDo: [ :c | c ignoreByLayout ];
		  size: size;
		  yourself
]

{ #category : #'api - bounds' }
ToSlider >> defaultHandle [

	| size elt |
	size := self
		        ifHorizontal: [ 5 @ barThickness ]
		        ifVertical: [ barThickness @ 5 ].

	elt := BlElement new
		       geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		       constraintsDo: [ :c | c ignoreByLayout ];
		       size: size;
		       transformDo: [ :t | "so the position is now the center"
			       t translateBy: size negated / 2 ];
		       yourself.

	^ elt
]

{ #category : #'api - bounds' }
ToSlider >> defaultMarginLength [

	^ 30
]

{ #category : #'api - bounds' }
ToSlider >> defaultMarginThickness [

	^ 20
]

{ #category : #'api - bounds' }
ToSlider >> defaultSize [
	"self bar size maybe"

	^ self
		  ifHorizontal: [
			  self defaultBarLength + (2 * self defaultMarginLength)
			  @ (self defaultBarThickness + (2 * self defaultMarginThickness)) ]
		  ifVertical: [
			  self defaultBarThickness + (2 * self defaultMarginThickness)
			  @ (self defaultBarLength + (2 * self defaultMarginLength)) ]
]

{ #category : #accessing }
ToSlider >> direction [
	"Returns true if horizontal else false"
	^ self ifHorizontal: [ true ]
			 ifVertical: [ false ].
]

{ #category : #accessing }
ToSlider >> handle [
	^ handle
]

{ #category : #accessing }
ToSlider >> handle: aBlElement [ 
	handle := aBlElement
]

{ #category : #accessing }
ToSlider >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : #building }
ToSlider >> ifHorizontal: horizontalBlock ifVertical: verticalBlock [

	^ self isHorizontal
		ifTrue: horizontalBlock
		ifFalse: verticalBlock
]

{ #category : #'api - slider' }
ToSlider >> incrementValue: aValue [

	| tmp |
	tmp := value + aValue.
	self setValue: tmp
]

{ #category : #initialization }
ToSlider >> initialize [

	super initialize.
	isHorizontal := true.
	segmented := false.
	self initializeSizes.
	self widgetSize: self defaultSize.
	self layout: BlFrameLayout new.
	self initializeValues.
	self initializeParts.
]

{ #category : #initialization }
ToSlider >> initializeEvents [ 

	self addEventHandlerOn: BlMouseDownEvent do: [ :event | self moveHandleTo: event position].
	self addEventHandlerOn: BlDragStartEvent do: [ :event | event consumed: true].
	self addEventHandlerOn: BlDragEvent do: [ :event | self moveHandleTo: event position]
]

{ #category : #initialization }
ToSlider >> initializeLabel [

	label := BlTextElement new.
	label text: (self name asRopedText attributes:
			 { (BlTextForegroundAttribute paint: Color white) }).
	label text fontSize: 15.
	label text bold.
	label constraintsDo: [ :c |
		c padding: (BlInsets all: 5).
		c frame horizontal alignLeft.
		c frame vertical alignTop ].
	
	self addChild: label
]

{ #category : #initialization }
ToSlider >> initializeParts [

	self bar: self defaultBar.
	self positionDefaultBar: self bar.
	self addChild: self bar.


	self coloredBar: self defaultColoredBar.
	self positionDefaultBar: self coloredBar.
	self addChild: self coloredBar.


	self handle: self defaultHandle.
	self positionDefaultHandle.
	self addChild: self handle.

	self initializeValueLabels.
]

{ #category : #initialization }
ToSlider >> initializeSizes [ 

	barLength := self defaultBarLength.
	barThickness := self defaultBarThickness.
	marginLength := self defaultMarginLength.
	marginThickness := self defaultMarginThickness.
]

{ #category : #initialization }
ToSlider >> initializeValueLabels [

	minLabel := BlTextElement new
		            text: (self minValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color white).
						             (BlFontSizeAttribute size: 15).
						             BlFontWeightAttribute bold });
		            constraintsDo: [ :c |
			            c padding: (BlInsets horizontal: 10).
			            c frame horizontal alignLeft.
			            c frame vertical alignCenter ].

	maxLabel := BlTextElement new
		            text: (self maxValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color white).
						             (BlFontSizeAttribute size: 15).
						             BlFontWeightAttribute bold });
		            constraintsDo: [ :c |
			            c padding: (BlInsets horizontal: 10).
			            c frame horizontal alignRight.
			            c frame vertical alignCenter ].

	valueLabel := BlTextElement new
		              text: (self value asRopedText attributes: {
						               (BlTextForegroundAttribute paint: Color black).
						               (BlFontSizeAttribute size: 15).
						               BlFontWeightAttribute bold });
		              constraintsDo: [ :c |
			              c frame horizontal alignCenter.
			              c frame vertical alignCenter ].

	self addChild: minLabel.
	self addChild: valueLabel.
	self addChild: maxLabel.
]

{ #category : #initialization }
ToSlider >> initializeValues [

	self minValue: 0.
	self maxValue: 50.
	value := self minValue 
]

{ #category : #accessing }
ToSlider >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : #testing }
ToSlider >> isSegmented [ 

	^ segmented 
]

{ #category : #accessing }
ToSlider >> label [

	^ label
]

{ #category : #accessing }
ToSlider >> marginLength [

	^ marginLength
]

{ #category : #accessing }
ToSlider >> marginLength: aNumber [

	marginLength := aNumber.
	self rebuild
]

{ #category : #accessing }
ToSlider >> marginThickness [ 

	^ marginThickness 
]

{ #category : #accessing }
ToSlider >> marginThickness: aNumber [

	marginThickness := aNumber.
	self rebuild
]

{ #category : #accessing }
ToSlider >> maxLabel [

	^ maxLabel
]

{ #category : #accessing }
ToSlider >> maxValue [

	^ maxValue
]

{ #category : #accessing }
ToSlider >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : #accessing }
ToSlider >> minLabel [ 

	^ minLabel 
]

{ #category : #accessing }
ToSlider >> minValue [ 

	^ minValue 
]

{ #category : #accessing }
ToSlider >> minValue: aNumber [

	minValue := aNumber 
]

{ #category : #'api - transformations' }
ToSlider >> moveHandleTo: aPosition [

	| newPos |
	newPos := aPosition.
	"deal with segmentation"
	self isSegmented ifTrue: [
		| value |
		value := self valueAtCoord: aPosition.
		newPos := self valueToCoord: value ].
	self
		ifHorizontal: [
			| newPosX |
			newPosX := newPos x.
			newPos x < bar position x ifTrue: [ newPosX := bar position x ].
			newPos x > (bar position x + barLength) ifTrue: [
				newPosX := bar position x + barLength ].
			newPos := newPosX @ handle position y.
			handle position: newPos ]
		ifVertical: [
			| newPosY |
			newPosY := newPos y.
			newPos y < bar position y ifTrue: [ newPosY := bar position y ].
			newPos y > (bar position y + barLength) ifTrue: [
				newPosY := bar position y + barLength ].
			newPos := handle position x @ newPosY.
			handle position: newPos ].
	self updateColoredBarTo: newPos.
	self basicSetValue: (self valueAtCoord: newPos)
]

{ #category : #accessing }
ToSlider >> name [ 

	^ name
]

{ #category : #accessing }
ToSlider >> name: aString [ 

	name := aString 
]

{ #category : #'api - values' }
ToSlider >> nearestValue: aValue [

	| val minResult tmp tmp2 values |
	self isSegmented ifFalse: [ ^ aValue rounded].
	values := self segmentedValues.
	val := values first.
	minResult := (aValue - val) abs.
	2 to: values size do: [ :e |
		tmp := values at: e.
		tmp2 := (aValue - tmp) abs.
		tmp2 < minResult ifTrue: [
			minResult := tmp2.
			val := tmp ] ].
	^ val rounded
]

{ #category : #'instance creation' }
ToSlider >> newRawSkin [ 

	^ ToSliderDefaultSkin new
]

{ #category : #'api - transformations' }
ToSlider >> positionDefaultBar: aBar [

	self
		ifHorizontal: [
			aBar position:
				self defaultMarginLength @ self defaultMarginThickness ]
		ifVertical: [
			aBar position:
				self defaultMarginThickness @ self defaultMarginLength ]
]

{ #category : #'api - transformations' }
ToSlider >> positionDefaultHandle [

	self
		ifHorizontal: [
		handle position: self defaultMarginLength @ (widgetSize y / 2) ]
		ifVertical: [
			handle position:
				widgetSize x / 2 @ (self defaultMarginLength + barLength) ]
]

{ #category : #building }
ToSlider >> rebuild [

	self
		ifHorizontal: [ self buildHorizontal ]
		ifVertical: [ self buildVertical ]
]

{ #category : #removing }
ToSlider >> removeParts [

	self removeChildren. 
	bar := nil.
	handle := nil
]

{ #category : #accessing }
ToSlider >> segmented: aBoolean [ 

	segmented := aBoolean
]

{ #category : #accessing }
ToSlider >> segmentedValues [

	segmentedValues ifNil: [	segmentedValues := (self minValue to: self maxValue by:
	                    self stepValue) asOrderedCollection].
	^ segmentedValues
]

{ #category : #accessing }
ToSlider >> segmentedValues: aCollection [ 

	segmentedValues := aCollection 
]

{ #category : #initialization }
ToSlider >> setToMax [

	"this method is created with a button that would set to max in the widget"
	self setValue: self maxValue.
]

{ #category : #initialization }
ToSlider >> setToMin [ 

	"this method is created with a button that would set to max in the widget"
	self setValue: self minValue.
]

{ #category : #accessing }
ToSlider >> setValue: aNumber [

	| newValue |
	newValue := aNumber.
	aNumber < self minValue ifTrue: [ newValue := minValue ].
	aNumber > self maxValue ifTrue: [ newValue := maxValue ].

	self moveHandleTo: (self valueToCoord: newValue)
]

{ #category : #'api - bounds' }
ToSlider >> size: aValue [
	"just to keep the widgset size"

	super size: aValue.
	
	" for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]

{ #category : #accessing }
ToSlider >> stepValue [

	^ stepValue 
]

{ #category : #accessing }
ToSlider >> stepValue: aNumber [

	stepValue := aNumber 
	
]

{ #category : #'api - transformations' }
ToSlider >> updateColoredBarTo: aPosition [

	self
		ifHorizontal: [
			coloredBar position: bar position.
			coloredBar size: (aPosition - coloredBar position) x @ barThickness ]
		ifVertical: [
			coloredBar position: aPosition x - (barThickness / 2) @ aPosition y.
			coloredBar size:
				barThickness @ (bar position y + barLength - aPosition y) ]
]

{ #category : #accessing }
ToSlider >> value [ 

	^ value 
]

{ #category : #'api - transformations' }
ToSlider >> valueAtCoord: aPoint [

	^ self
		  ifHorizontal: [ self valueAtX: aPoint ]
		  ifVertical: [ self valueAtY: aPoint ]
]

{ #category : #'api - transformations' }
ToSlider >> valueAtX: aPoint [

	| dist valueDiff coeff |
	dist := (aPoint - bar position) x.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	value := self nearestValue: value.

	^ value
]

{ #category : #'api - transformations' }
ToSlider >> valueAtY: aPoint [

	| dist valueDiff coeff |
	dist := bar position y + barLength - aPoint y.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ].
	value := self nearestValue: value.
	^ value
]

{ #category : #accessing }
ToSlider >> valueLabel [

	^ valueLabel
]

{ #category : #'api - transformations' }
ToSlider >> valueToCoord: aNumber [

	^ self
		  ifHorizontal: [ self valueToX: aNumber ]
		  ifVertical: [ self valueToY: aNumber ]
]

{ #category : #'api - transformations' }
ToSlider >> valueToX: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ dist @ handle position y
]

{ #category : #'api - transformations' }
ToSlider >> valueToY: aNumber [

	| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + barLength - (coeff * barLength).
	self forceLocalLayout.
	"This is needed so handle position != 0"
	^ handle position x @ dist
]

{ #category : #accessing }
ToSlider >> widgetSize [ 

	^ widgetSize 
]

{ #category : #accessing }
ToSlider >> widgetSize: aNumber [

	widgetSize := aNumber.
	self size: aNumber 
]
