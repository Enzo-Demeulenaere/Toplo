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

{ #category : #example }
ToSliderProportionalLayout class >> exampleHorizontal [
	"The values of the slider are also written in the transcript"

	<script>
self beHorizontal openInSpace
]

{ #category : #testing }
ToSliderProportionalLayout class >> exampleHorizontalSegmented [

	<script>
	self new beSegmented openInSpace
]

{ #category : #testing }
ToSliderProportionalLayout class >> exampleHorizontalSegmentedWithValue [

	<script>
	|slider|
	slider := self new beSegmented.
	slider segmentedValues: { 0. 5. 15. 27. 38. 50 }.
	slider openInSpace
]

{ #category : #example }
ToSliderProportionalLayout class >> exampleVertical [
	"The values of the slider are also written in the transcript"

	<script>
	self beVertical openInSpace
]

{ #category : #testing }
ToSliderProportionalLayout class >> exampleVerticalSegmented [

	<script>
	self beVertical beSegmented openInSpace
]

{ #category : #testing }
ToSliderProportionalLayout class >> exampleVerticalSegmentedWithValue [

	<script>
	| slider |
	slider := self beVertical beSegmented.
	slider segmentedValues: { 0. 5. 15. 27. 38. 50 }.
	slider openInSpace
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

	self isHorizontal ifTrue: [ ^ self ].
	self whenLayoutedDoOnce: [ self extent: self extent transposed ].
	self swapRatios.
	self horizontal: true.
	self rebuild
]

{ #category : #building }
ToSliderProportionalLayout >> beSegmented [

	self stepValue
		ifNil: [ self error: 'Cannot segment a slider with a nil stepValue' ]
		ifNotNil: [ self segmented: true ].
]

{ #category : #building }
ToSliderProportionalLayout >> beSmooth [

	self segmented: false.
	self segmentedValues: nil
]

{ #category : #accessing }
ToSliderProportionalLayout >> beVertical [

	self isHorizontal ifFalse: [ ^ self ].
	self whenLayoutedDoOnce: [ self extent: self extent transposed ].
	self swapRatios.
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

	"method not used/called"
	maxLabel text: (aValue asRopedText attributes: {
				 (BlTextForegroundAttribute paint: Color white).
				 (BlFontSizeAttribute size: 12).
				 BlFontWeightAttribute bold }).
	maxValue := aValue
]

{ #category : #'as yet unclassified' }
ToSliderProportionalLayout >> changeMinValueLabelTo: aValue [

	"method not used/called"
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
			self ifHorizontal: [ c proportional vertical
				  top: self topRatio;
				  bottom: self bottomRatio.
			  c proportional horizontal
				  left: self leftRatio;
				  right: self leftRatio ] 
			ifVertical: [ c proportional vertical
				  top: self bottomRatio;
				  bottom: self bottomRatio.
			  c proportional horizontal
				  left: self leftRatio;
				  right: self rightRatio ].
			   ];
		  yourself
]

{ #category : #'api - bounds' }
ToSliderProportionalLayout >> defaultHandle [

	^ BlElement new
		  geometry: (BlRoundedRectangleGeometry cornerRadius: 2);
		  constraintsDo: [ :c |
			self ifHorizontal: [ c proportional vertical
				  top: self topRatio;
				  bottom: self bottomRatio.
			  c proportional horizontal
				  left: self handleRatio - 0.01;
				  right: self handleRatio + 0.01 ] 
			ifVertical: [ c proportional vertical
				  top: self handleRatio - 0.01;
				  bottom: self handleRatio +0.01.
			  c proportional horizontal
				  left: self leftRatio ;
				  right: self rightRatio ].
			   ];
		  yourself
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
							self ifHorizontal: [ c proportional vertical
				            top: 0.45;
				            bottom: 0.55.
			            c proportional horizontal
				            left: self leftRatio - 0.1;
				            right: self leftRatio - 0.05 ] ifVertical: [ c proportional horizontal
				            left: 0.45;
				            right: 0.55.
			            c proportional vertical
				            top: self bottomRatio + 0.05;
				            bottom: self bottomRatio + 0.05 ].
			             ].

	maxLabel := BlAttributedTextElement new
		            text: (self maxValue asRopedText attributes: {
						             (BlTextForegroundAttribute paint: Color white).
						             (BlFontSizeAttribute size: 15).
						             BlFontWeightAttribute bold });
		            constraintsDo: [ :c | 
						self ifHorizontal: [ c proportional vertical
				            top: 0.45;
				            bottom: 0.55.
			            c proportional horizontal
				            left: self rightRatio + 0.05;
				            right: self rightRatio + 0.1 ] ifVertical: [ c proportional horizontal
				            left: 0.45;
				            right: 0.55.
			            c proportional vertical
				            top: self topRatio - 0.05;
				            bottom: self topRatio - 0.05 ].
			             ].

	valueLabel := BlAttributedTextElement new
		              text: (self value asRopedText attributes: {
						               (BlTextForegroundAttribute paint: Color black).
						               (BlFontSizeAttribute size: 15).
						               BlFontWeightAttribute bold });
		              constraintsDo: [ :c |
			              c proportional vertical
				              top: 0.45;
				              bottom: 0.55.
			              c proportional horizontal
				              left: 0.45;
				              right: 0.55 ].

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
			self handleRatio: newRatio ]
		ifVertical: [ 
			| newRatio |
			newRatio := newPos y / self height.
			newRatio := newRatio beBetween: self topRatio and: self bottomRatio.
			self handleRatio: newRatio ].
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

{ #category : #building }
ToSliderProportionalLayout >> rebuild [

	self removeParts.
	self initializeParts.
	self reinstallSkin
]

{ #category : #'as yet unclassified' }
ToSliderProportionalLayout >> reinstallSkin [ 

	self ensuredSkinManager
		requestUninstallSkinIn: self;
		requestInstallSkinIn: self
]

{ #category : #removing }
ToSliderProportionalLayout >> removeParts [

	self removeChildren.

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

	self setValue: self maxValue
]

{ #category : #initialization }
ToSliderProportionalLayout >> setToMin [

	self setValue: self minValue
]

{ #category : #accessing }
ToSliderProportionalLayout >> setValue: aNumber [

	| newValue |
	newValue := aNumber beBetween: minValue and: maxValue.
	self moveHandleTo: (self valueToCoord: newValue)
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

{ #category : #'as yet unclassified' }
ToSliderProportionalLayout >> swapRatios [

	| hAux vAux |
	hAux := leftRatio.
	leftRatio := topRatio.
	topRatio := hAux.

	vAux := rightRatio.
	rightRatio := bottomRatio.
	bottomRatio := vAux.

	handleRatio := bottomRatio 
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

	self coloredBar constraintsDo: [ :c |
		self ifHorizontal: [ c proportional horizontal right: self handleRatio ] 
		ifVertical: [ c proportional vertical top: self handleRatio ].
		 ]
]

{ #category : #'as yet unclassified' }
ToSliderProportionalLayout >> updateHandle [

	handle constraintsDo: [ :c |
		self ifHorizontal: [ c proportional horizontal
			left: self handleRatio - 0.01;
			right: self handleRatio + 0.01 ] ifVertical: [ 
			c proportional vertical
			top: self handleRatio - 0.01;
			bottom: self handleRatio + 0.01 ]. 
		 ]
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

	| valueDiff coeff ratio ratioDist newValue |
	ratio := aPoint y / self height.
	ratio := ratio beBetween: self bottomRatio and: self topRatio.
	ratioDist := ratio - self topRatio.
	"careful : topRatio is the lowest here"
	ratioDist = 0
		ifTrue: [ newValue := maxValue ]
		ifFalse: [
			valueDiff := maxValue - minValue.
			coeff := self bottomRatio - self topRatio / ratioDist.
			newValue := maxValue - (valueDiff / coeff) ].
	value := self nearestValue: newValue.
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
	newRatio := self leftRatio * self width
	            + (ratio * ratioDist / valueDiff).
	^ newRatio asFloat @ 0
]

{ #category : #'api - transformations' }
ToSliderProportionalLayout >> valueToY: aNumber [

	| valueDiff ratio ratioDist newRatio |
	valueDiff := maxValue - minValue.
	ratio := aNumber - minValue.
	ratioDist := (self bottomRatio - self topRatio) * self height.
	newRatio := self bottomRatio * self height
	            - (ratio * ratioDist / valueDiff).
	^ 0 @ newRatio asFloat
]
