Class {
	#name : #ToSliderProportionalLayout,
	#superclass : #ToElement,
	#instVars : [
		'handle',
		'bar',
		'coloredBar',
		'isHorizontal',
		'minValue',
		'maxValue',
		'stepValue',
		'segmented',
		'segmentedValues',
		'callBack',
		'value',
		'minLabel',
		'maxLabel',
		'label',
		'valueLabel',
		'name',
		'leftRatio',
		'rightRatio',
		'topRatio',
		'bottomRatio',
		'handleRatio'
	],
	#category : #'Toplo-Widget-Slider-core'
}

{ #category : #accessing }
ToSliderProportionalLayout class >> beHorizontal [

	^ self new beHorizontal 
]

{ #category : #accessing }
ToSliderProportionalLayout class >> beVertical [ 
	
	^ self new beVertical 
]

{ #category : #accessing }
ToSliderProportionalLayout class >> label: aString [ 

	|slider|
	slider := self new name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : #'instance creation' }
ToSliderProportionalLayout class >> new [

	^ self readOnly initializeEvents
]

{ #category : #'instance creation' }
ToSliderProportionalLayout class >> readOnly [

	^ self basicNew initialize
]

{ #category : #'instance creation' }
ToSliderProportionalLayout class >> readOnlyLabel: aString [

	| slider |
	slider := self readOnly name: aString.
	slider initializeLabel.
	^ slider
]

{ #category : #example }
ToSliderProportionalLayout class >> simpleExampleHorizontal [
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
ToSliderProportionalLayout class >> simpleExampleVertical [
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
ToSliderProportionalLayout >> bar [
	^ bar
]

{ #category : #accessing }
ToSliderProportionalLayout >> bar: aBlElement [ 
	bar := aBlElement
]

{ #category : #'api - values' }
ToSliderProportionalLayout >> basicSetValue: aNumber [

	value := aNumber.
	self valueLabel text: value asRopedText.
	self callBack ifNotNil: [ :e | e value: value ]
]

{ #category : #accessing }
ToSliderProportionalLayout >> beHorizontal [

	self horizontal: true.
	self rebuild
]

{ #category : #building }
ToSliderProportionalLayout >> beSegmented [

	self stepValue
		ifNil: [ self error: 'Cannot segment a slider with a nil stepValue' ]
		ifNotNil: [ self segmented: true].
	self rebuild
]

{ #category : #building }
ToSliderProportionalLayout >> beSmooth [

	self segmented: false.
	self segmentedValues: nil.
	self rebuild
]

{ #category : #accessing }
ToSliderProportionalLayout >> beVertical [

	self horizontal: false.
	self rebuild
]

{ #category : #accessing }
ToSliderProportionalLayout >> bottomRatio [

	^ bottomRatio
]

{ #category : #accessing }
ToSliderProportionalLayout >> bottomRatio: anObject [

	bottomRatio := anObject
]

{ #category : #building }
ToSliderProportionalLayout >> buildHorizontal [

	self removeParts.
	self initializeParts
]

{ #category : #building }
ToSliderProportionalLayout >> buildVertical [

	self removeParts.
	self initializeParts
]

{ #category : #accessing }
ToSliderProportionalLayout >> callBack [ 

	^ callBack 
]

{ #category : #accessing }
ToSliderProportionalLayout >> callBack: aBlock [

	callBack := aBlock 
]

{ #category : #'as yet unclassified' }
ToSliderProportionalLayout >> changeMaxValueLabelTo: aValue [

	maxLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	maxValue := aValue
]

{ #category : #'as yet unclassified' }
ToSliderProportionalLayout >> changeMinValueLabelTo: aValue [

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
ToSliderProportionalLayout >> coloredBar [ 

	^ coloredBar 
]

{ #category : #accessing }
ToSliderProportionalLayout >> coloredBar: aBlElement [

	coloredBar := aBlElement 
]

{ #category : #'api - slider' }
ToSliderProportionalLayout >> decrementValue: aValue [

	| tmp |
	tmp := value - aValue.
	self setValue: tmp
]

{ #category : #'api - bounds' }
ToSliderProportionalLayout >> defaultBar [

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		  constraintsDo: [ :c |
			  c proportional horizontal
				  left: self leftRatio;
				  right: self rightRatio.
			  c proportional vertical
				  top: self topRatio;
				  bottom: self bottomRatio ];
		  yourself
]

{ #category : #accessing }
ToSliderProportionalLayout >> defaultColoredBar [

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 5);
		  constraintsDo: [ :c |
			  c proportional vertical
				  top: self topRatio;
				  bottom: self bottomRatio.
			  c proportional horizontal
				  left: self leftRatio;
				  right: self leftRatio ];
			yourself
]

{ #category : #'api - bounds' }
ToSliderProportionalLayout >> defaultHandle [

	^ BlElement new
		       geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		       constraintsDo: [ :c |
			       c proportional vertical
				       top: self topRatio;
				       bottom: self bottomRatio.
			       c proportional horizontal
				       left: self handleRatio - 0.01;
				       right: self handleRatio + 0.01 ];
			       yourself.

]

{ #category : #'api - bounds' }
ToSliderProportionalLayout >> defaultSize [
	
	^ 250 @ 50
]

{ #category : #accessing }
ToSliderProportionalLayout >> handle [
	^ handle
]

{ #category : #accessing }
ToSliderProportionalLayout >> handle: aBlElement [ 
	handle := aBlElement
]

{ #category : #accessing }
ToSliderProportionalLayout >> handleRatio [ 

	^ handleRatio 
]

{ #category : #accessing }
ToSliderProportionalLayout >> handleRatio: aNumber [

	handleRatio := aNumber.
	self updateHandle.
	self updateColoredBar
]

{ #category : #accessing }
ToSliderProportionalLayout >> horizontal: aBoolean [

	isHorizontal := aBoolean 
]

{ #category : #building }
ToSliderProportionalLayout >> ifHorizontal: horizontalBlock ifVertical: verticalBlock [

	^ self isHorizontal
		ifTrue: horizontalBlock
		ifFalse: verticalBlock
]

{ #category : #'api - slider' }
ToSliderProportionalLayout >> incrementValue: aValue [

	| tmp |
	tmp := value + aValue.
	self setValue: tmp
]

{ #category : #initialization }
ToSliderProportionalLayout >> initialize [

	super initialize.
	isHorizontal := true.
	segmented := false.
	self size: self defaultSize.
	self initializeRatios.
	self layout: BlProportionalLayout new.
	self initializeValues.
	self initializeParts
]

{ #category : #initialization }
ToSliderProportionalLayout >> initializeEvents [ 

	self addEventHandlerOn: BlMouseDownEvent do: [ :event | self moveHandleTo: event position].
	self addEventHandlerOn: BlDragStartEvent do: [ :event | event consumed: true].
	self addEventHandlerOn: BlDragEvent do: [ :event | self moveHandleTo: event position]
]

{ #category : #initialization }
ToSliderProportionalLayout >> initializeLabel [

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
ToSliderProportionalLayout >> initializeParts [

	bar := self defaultBar.
	self addChild: bar.

	coloredBar := self defaultColoredBar.
	self addChild: coloredBar.

	handle := self defaultHandle.
	self addChild: handle.

	self initializeValueLabels
]

{ #category : #initialization }
ToSliderProportionalLayout >> initializeRatios [

	leftRatio := 1 / 8.
	rightRatio := 7 / 8.
	topRatio := 2 / 8.
	bottomRatio := 6 / 8.
	handleRatio := leftRatio 
]

{ #category : #initialization }
ToSliderProportionalLayout >> initializeValueLabels [

	minLabel := BlAttributedTextElement new
		            text: (self minValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color white).
						             (BlFontSizeAttribute size: 15).
						             BlFontWeightAttribute bold });
		            constraintsDo: [ :c |
			            "c padding: (BlInsets horizontal: 10).
			            c frame horizontal alignLeft.
			            c frame vertical alignCenter"
							c proportional vertical top: 0.45; bottom: 0.55.
							c proportional horizontal left: self leftRatio - 0.1 ; right: self leftRatio -0.05 ].

	maxLabel := BlAttributedTextElement new
		            text: (self maxValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color white).
						             (BlFontSizeAttribute size: 15).
						             BlFontWeightAttribute bold });
		            constraintsDo: [ :c |
			            "c ignoreByLayout.
			            c padding: (BlInsets horizontal: 10).
			            c frame horizontal alignRight.
			            c frame vertical alignCenter"
			c proportional vertical top: 0.45; bottom: 0.55.
							c proportional horizontal left: self rightRatio + 0.05 ; right: self rightRatio +0.1 ].

	valueLabel := BlAttributedTextElement new
		              text: (self value asRopedText attributes: {
						               (BlTextForegroundAttribute paint: Color black).
						               (BlFontSizeAttribute size: 15).
						               BlFontWeightAttribute bold });
		              constraintsDo: [ :c |
			              "c ignoreByLayout.
			              c frame horizontal alignCenter.
			              c frame vertical alignCenter "
			c proportional vertical top: 0.45; bottom: 0.55.
			c proportional horizontal left: 0.45; right: 0.55.].

	self addChild: minLabel.
	self addChild: valueLabel.
	self addChild: maxLabel
]

{ #category : #initialization }
ToSliderProportionalLayout >> initializeValues [

	minValue := 0.
	maxValue := 50.
	value := minValue.
	stepValue := 10
]

{ #category : #accessing }
ToSliderProportionalLayout >> isHorizontal [ 

	^ isHorizontal 
]

{ #category : #testing }
ToSliderProportionalLayout >> isSegmented [ 

	^ segmented 
]

{ #category : #accessing }
ToSliderProportionalLayout >> label [

	^ label
]

{ #category : #accessing }
ToSliderProportionalLayout >> leftRatio [

	^ leftRatio
]

{ #category : #accessing }
ToSliderProportionalLayout >> leftRatio: anObject [

	leftRatio := anObject
]

{ #category : #accessing }
ToSliderProportionalLayout >> maxLabel [

	^ maxLabel
]

{ #category : #accessing }
ToSliderProportionalLayout >> maxValue [

	^ maxValue
]

{ #category : #accessing }
ToSliderProportionalLayout >> maxValue: aNumber [

	maxValue := aNumber
]

{ #category : #accessing }
ToSliderProportionalLayout >> minLabel [ 

	^ minLabel 
]

{ #category : #accessing }
ToSliderProportionalLayout >> minValue [ 

	^ minValue 
]

{ #category : #accessing }
ToSliderProportionalLayout >> minValue: aNumber [

	minValue := aNumber 
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> moveHandleTo: aPosition [

	| newPos |
	newPos := aPosition.
	"deal with segmentation"
	self isSegmented ifTrue: [
		| tmpValue |
		tmpValue := self valueAtCoord: aPosition.
		newPos := self valueToCoord: tmpValue ].
	self
		ifHorizontal: [
			| newRatio |
			newRatio := newPos x / self width.
			newRatio := newRatio beBetween: self leftRatio and: self rightRatio.
			self handleRatio: newRatio
			"| newPosX |
			newPosX := newPos x.
			newPos x < bar position x ifTrue: [ newPosX := bar position x ].
			newPos x > (bar position x + bar width) ifTrue: [
				newPosX := bar position x + bar width ].
			newPos := newPosX - bar position x @ handle position y.
			handle position: newPos " ]
		ifVertical: [ "| newPosY |
			newPosY := newPos y.
			newPos y < bar position y ifTrue: [ newPosY := bar position y ].
			newPos y > (bar position y + barLength) ifTrue: [
				newPosY := bar position y + barLength ].
			newPos := handle position x @ newPosY.
			handle position: newPos"
			 ].
	"self updateColoredBarTo: newPos."
	self basicSetValue: (self valueAtCoord: newPos)
]

{ #category : #accessing }
ToSliderProportionalLayout >> name [ 

	^ name
]

{ #category : #accessing }
ToSliderProportionalLayout >> name: aString [ 

	name := aString 
]

{ #category : #'api - values' }
ToSliderProportionalLayout >> nearestValue: aValue [

	| val minResult tmp tmp2 values |
	self isSegmented ifFalse: [ ^ aValue rounded ].
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
ToSliderProportionalLayout >> newRawSkin [ 

	^ ToSliderDefaultSkin new
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> positionDefaultBar: aBar [

	self
		ifHorizontal: [
			aBar position:
				self defaultMarginLength @ self defaultMarginThickness ]
		ifVertical: [
			aBar position:
				self defaultMarginThickness @ self defaultMarginLength ]
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> positionDefaultHandle [

	self whenLayoutedDoOnce: [
		self
			ifHorizontal: [ handle position: 0@0 ]
			ifVertical: [ handle position: bar position + (0 @ bar height) ] ]
]

{ #category : #building }
ToSliderProportionalLayout >> rebuild [

	self extent: self extent transposed.
	self
		ifHorizontal: [ self buildHorizontal ]
		ifVertical: [ self buildVertical ].
	"self moveHandleTo: self handle position."
	self ensuredSkinManager
		requestUninstallSkinIn: self;
		requestInstallSkinIn: self
]

{ #category : #removing }
ToSliderProportionalLayout >> removeParts [

	self removeChildren. 
	bar := nil.
	handle := nil
]

{ #category : #accessing }
ToSliderProportionalLayout >> rightRatio [

	^ rightRatio
]

{ #category : #accessing }
ToSliderProportionalLayout >> rightRatio: anObject [

	rightRatio := anObject
]

{ #category : #accessing }
ToSliderProportionalLayout >> segmented: aBoolean [ 

	segmented := aBoolean
]

{ #category : #accessing }
ToSliderProportionalLayout >> segmentedValues [

	segmentedValues ifNil: [	segmentedValues := (self minValue to: self maxValue by:
	                    self stepValue) asOrderedCollection].
	^ segmentedValues
]

{ #category : #accessing }
ToSliderProportionalLayout >> segmentedValues: aCollection [ 

	segmentedValues := aCollection 
]

{ #category : #initialization }
ToSliderProportionalLayout >> setToMax [

	"this method is created with a button that would set to max in the widget"
	self setValue: self maxValue.
]

{ #category : #initialization }
ToSliderProportionalLayout >> setToMin [ 

	"this method is created with a button that would set to max in the widget"
	self setValue: self minValue.
]

{ #category : #accessing }
ToSliderProportionalLayout >> setValue: aNumber [

	| newValue |
	newValue := aNumber.
	aNumber < self minValue ifTrue: [ newValue := minValue ].
	aNumber > self maxValue ifTrue: [ newValue := maxValue ].

	self moveHandleTo: (self valueToCoord: newValue)
]

{ #category : #'api - bounds' }
ToSliderProportionalLayout >> size: aValue [
	"just to keep the widgset size"

	super size: aValue.
	
	" for now do not support resize
	
	self isBuildSlider ifTrue: [ self rebuildSlider ]
	"
]

{ #category : #accessing }
ToSliderProportionalLayout >> stepValue [

	^ stepValue 
]

{ #category : #accessing }
ToSliderProportionalLayout >> stepValue: aNumber [

	stepValue := aNumber.
	segmentedValues := nil
]

{ #category : #accessing }
ToSliderProportionalLayout >> topRatio [

	^ topRatio
]

{ #category : #accessing }
ToSliderProportionalLayout >> topRatio: anObject [

	topRatio := anObject
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> updateColoredBar [

	self coloredBar constraintsDo: [ :c | c proportional horizontal right: self handleRatio ]
]

{ #category : #'as yet unclassified' }
ToSliderProportionalLayout >> updateHandle [ 

	handle constraintsDo: [ :c | c proportional horizontal left: self handleRatio -0.01; right: self handleRatio +0.01 ]
]

{ #category : #accessing }
ToSliderProportionalLayout >> value [ 

	^ value 
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> valueAtCoord: aPoint [

	^ self
		  ifHorizontal: [ self valueAtX: aPoint ]
		  ifVertical: [ self valueAtY: aPoint ]
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> valueAtX: aPoint [

	| valueDiff coeff ratio ratioDist newValue |
	ratio := aPoint x / self width.
	ratio := ratio beBetween: self leftRatio and: self rightRatio.
	ratioDist := ratio - self leftRatio.
	ratioDist = 0
		ifTrue: [ newValue := minValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := self rightRatio - self leftRatio / ratioDist.
			newValue := minValue + (valueDiff / coeff) ].
	value := self nearestValue: newValue.
	^ value
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> valueAtY: aPoint [

	"| dist valueDiff coeff |
	dist := bar position y + barLength - aPoint y.
	dist = 0
		ifTrue: [ value := minValue ]
		ifFalse: [
			
			coeff := barLength / dist.
			value := minValue + (valueDiff / coeff) ]."
	value := self nearestValue: value.
	^ value
]

{ #category : #accessing }
ToSliderProportionalLayout >> valueLabel [

	^ valueLabel
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> valueToCoord: aNumber [

	^ self
		  ifHorizontal: [ self valueToX: aNumber ]
		  ifVertical: [ self valueToY: aNumber ]
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> valueToX: aNumber [

	| valueDiff ratio ratioDist newRatio |
	valueDiff := maxValue - minValue.
	ratio := aNumber - minValue.
	ratioDist := (self rightRatio - self leftRatio) * self width.
	newRatio := self leftRatio* self width + (ratio * ratioDist / valueDiff).
	^ newRatio asFloat @ 0
	"| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + (coeff * barLength).
	self forceLocalLayout.
	""This is needed so handle position != 0""
	^ dist @ handle position y"
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> valueToY: aNumber [

	"| dist valueDiff coeff |
	valueDiff := aNumber - minValue.
	coeff := (valueDiff / (maxValue - minValue)) asFloat.
	dist := marginLength + barLength - (coeff * barLength).
	self forceLocalLayout.
	""This is needed so handle position != 0""
	^ handle position x @ dist"
]
