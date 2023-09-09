"
A ToStyleSheetTest is a test class for testing the behavior of ToStyleSheet
"
Class {
	#name : #ToStyleSheetTest,
	#superclass : #TestCase,
	#category : #'Toplo-Theme-Tests-StyleSheet'
}

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin0 [

	| ss button looks skin labelSkin attributes foregroundAttr |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors: { (ToClassSelector new elementClass: #button) }
			 looks: {
					 (ToLook forBackground 
						  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
						  whenInitialized: [ :e | Color transparent ];
						  yourself).
					 (ToLook forBorder
						  whenDisabled: [ :e | e toTheme colorBorderDisabled ];
						  whenInitialized: [ :e | e toTheme colorBorder ];
						  whenHovered: [ :e | e toTheme colorPrimaryHover ];
						  whenPressed: [ :e | e toTheme colorPrimaryPressed ] yourself) }).

	" danger button label rule "
	ss addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #'button-label')
					  parent:
					  (ToClassSelector new elementClasses: #( #button #danger ))
					  level: 2) }
			 looks: { (ToLabelTextLook new
					  disabledColor: [ :e | e toTheme colorTextDisabled ];
					  initialColor: [ :e | e toTheme colorError ];
					  hoverColor: [ :e | e toTheme colorErrorHover ];
					  pressedColor: [ :e | e toTheme colorError darker ];
					  yourself) }).


	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 2.
	skin := ToWidgetSkin new.
	skin addAllLooks: looks.
	button withSkin: nil.
	self assert: button privateSkin isNil.
	button withSkin: skin.
	button checkSkinInstallation.
	self assert: button border width equals: 1.
	self assert: button border paint isColorPaint.
	self
		assert: button border paint color
		equals: button toTheme colorBorder.

	button labelText: 'Default'.
	button label withSkin: nil.

	labelSkin := ToWidgetSkin new.
	looks := ss looksFor: button label.
	self assert: looks isEmpty.
	button label styleClass: #'button-label'.
	looks := ss looksFor: button label.
	" should be empty since the label rule expect the button to be of class #danger "
	self assert: looks isEmpty.
	button styleClasses: #( #button #danger ).
	looks := ss looksFor: button label.
	self assert: looks size equals: 1.

	labelSkin addAllLooks: looks.
	button label withSkin: labelSkin.
	button label checkSkinInstallation.
	attributes := button label text attributesAt: 1.
	self assert: attributes notEmpty.
	foregroundAttr := attributes
		                  detect: [ :eachAttribute |
		                  eachAttribute isKindOf: BlTextForegroundAttribute ]
		                  ifNone: [
			                  self fail:
				                  'should have a foreground attribute (toTheme colorError)' ].
	self
		assert: foregroundAttr paint
		equals: button label toTheme colorError
]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin1 [

	| ss button looks initC |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors: { (ToClassSelector new elementClass: #button) }
			 looks: { (ToLook forBackground
					  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
					  whenInitialized: [ :e | Color gray ];
					  yourself) }).

	ss addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #label)
					  parent:
					  (ToClassSelector new elementClass: #'triplet-inner-element')
					  level: 1) }
			 looks: { (ToLook forTextAttributes 
					  whenDisabled: [ :e | BlTextAttributesBuilder new foreground: e toTheme colorTextDisabled ];
					  whenInitialized: [ :e | BlTextAttributesBuilder new foreground: (initC := e toTheme colorText) ];
					  whenHovered: [ :e | BlTextAttributesBuilder new foreground: e toTheme colorPrimary ];
					  whenPressed: [ :e | BlTextAttributesBuilder new foreground: e toTheme colorPrimaryPressed ];
					  yourself) }).


	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLook.
	self
		assert: (looks first initialValue valueIn: nil)
		equals: Color gray.

	button labelText: 'Default'.
	looks := ss looksFor: button label.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLook.
	looks first initialValue valueIn: button.
	self
		assert: initC
		equals: button toTheme colorText.

]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin2 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors: { (ToClassSelector new elementClass: #button) }
			 looks: { (ToLook forBackground 
					  whenDisabled: [ :e | e toTheme colorBgContainerDisabled ];
					  whenInitialized: [ :e | Color gray ];
					  yourself) }).

	ss addRule: (ToStyleRule new
			 selectors: { ((ToClassSelector new elementClass: #label)
					  parent: (ToClassSelector new elementClass: #button)
					  level: 2) }
			 looks: { (ToLook forTextForegroundWithBuilder: BlTextAttributesBuilder new)
					  whenDisabled: [ :e | e toTheme colorTextDisabled ];
					  whenInitialized: [ :e | e toTheme colorText ];
					  whenHovered: [ :e | e toTheme colorPrimary ];
					  whenPressed: [ :e | e toTheme colorPrimaryPressed ];
					  yourself }).


	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLook.

	button labelText: 'Default'.
	looks := ss looksFor: button label.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLook
]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin3 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors: { (ToClassSelector new elementClass: #button) }
			 looks: { (ToLook forBackground
					  whenInitialized: Color gray;
					  yourself) }).
	ss addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses: #( #button #danger )) }
			 looks: { (ToLook forBackground
					  whenInitialized: Color red;
					  yourself) }).

	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLook.
	self
		assert: (looks first initialValue valueIn: nil)
		equals: Color gray.
	button addStyleClass: #danger.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLook.
	self
		assert: (looks first initialValue valueIn: nil)
		equals: Color red
]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin4 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors:
			 { (ToClassSelector new elementClasses: #( #button #danger )) }
			 looks: { (ToLook forBackground 
					  whenInitialized: [ :e | Color red ];
					  yourself) }).

	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 0.
	button addStyleClass: #danger.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLook.
	self assert: (looks first initialValue valueIn: nil) = Color red
]

{ #category : #'button skin building' }
ToStyleSheetTest >> testButtonSkin5 [

	| ss button looks |
	ss := ToStyleSheet new.

	" default button rule "
	ss addRule: (ToStyleRule new
			 selectors: { (ToClassSelector new elementClasses: #( #button )) }
			 looks: { (ToLook forBackground 
					  whenInitialized: [ :e | Color red ];
					  yourself) }).

	button := ToButton new.
	looks := ss looksFor: button.
	self assert: looks size equals: 1.
	self assert: looks first class equals: ToLook.
	self assert: (looks first initialValue valueIn: nil) = Color red.

	button addStyleClass: #danger.
	looks := ss looksFor: button.
	self assert: looks size equals: 0
]

{ #category : #basic }
ToStyleSheetTest >> testEmptyStyleSheet [

	| ss |
	ss := ToStyleSheet new.
	self assert: (ss rulesFor: (ToElement new)) isEmpty
]

{ #category : #'skin building' }
ToStyleSheetTest >> testSkinWithAnUniversalRule [

	| ss elem looks skin |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new
			 selectors: { ToUniversalSelector new }
			 looks: { ToLook forBorder whenInitialized: (BlBorderBuilder new paint: Color red;  width: 3; build) }).
	elem := ToElement new.
	looks := ss looksFor: elem.
	self assert: looks size equals: 1.
	skin := ToWidgetSkin new.
	skin addAllLooks: looks.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem border width equals: 3.
	self assert: elem border paint isColorPaint.
	self assert: elem border paint color equals: Color red
]

{ #category : #'skin building' }
ToStyleSheetTest >> testSkinWithChildRule [

	" with a direct child "
	| ss looks skin parent child |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new
			 selectors: { ((ToIdSelector new id: #child) parent:
					  (ToClassSelector new elementClass: #parent)) }
			 looks: { ToLook forBorder whenInitialized: (BlBorderBuilder new paint: Color red;  width: 3; build) }).
	parent := ToElement new styleClass: #parent.
	child := ToElement new id: #child.
	looks := ss looksFor: child.
	self assert: looks size equals: 0.

	parent addChild: child.
	looks := ss looksFor: child.
	self assert: looks size equals: 1.
	skin := ToWidgetSkin new.
	skin addAllLooks: looks.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #'skin building' }
ToStyleSheetTest >> testSkinWithChildRule2 [

	" the child is not a direct child "
	| ss looks skin parent child subParent |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new
			 selectors: { ((ToIdSelector new id: #child) parent:
					  (ToClassSelector new elementClass: #parent) level: 2) }
			 looks: { ToLook forBorder whenInitialized: (BlBorderBuilder new paint: Color red;  width: 3; build) }).
	parent := ToElement new styleClass: #parent.
	subParent := ToElement new.
	child := ToElement new id: #child.
	looks := ss looksFor: child.
	self assert: looks size equals: 0.

	parent addChild: subParent.
	subParent addChild: child.
	looks := ss looksFor: child.
	self assert: looks size equals: 1.
	skin := ToWidgetSkin new.
	skin addAllLooks: looks.
	child withSkin: skin.
	parent checkSkinInstallation.
	self assert: child border width equals: 3.
	self assert: child border paint isColorPaint.
	self assert: child border paint color equals: Color red
]

{ #category : #'skin building' }
ToStyleSheetTest >> testSkinWithIdRule [

	| ss elem looks skin |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new
			 selectors: { (ToIdSelector new id: #a) }
			 looks: { ( ToLook forBorder whenInitialized: (BlBorderBuilder new paint: Color red;  width: 3; build) ) }).
	elem := ToElement new.
	looks := ss looksFor: elem.
	self assert: looks size equals: 0.
	elem id: #a.
	looks := ss looksFor: elem.
	self assert: looks size equals: 1.
	skin := ToWidgetSkin new.
	skin addAllLooks: looks.
	elem withSkin: skin.
	elem checkSkinInstallation.
	self assert: elem border width equals: 3.
	self assert: elem border paint isColorPaint.
	self assert: elem border paint color equals: Color red
]

{ #category : #basic }
ToStyleSheetTest >> testStyleSheetWithAnUniversalRule [

	| ss |
	ss := ToStyleSheet new.
	ss addRule: (ToStyleRule new selectors: { (ToUniversalSelector new) } looks: { ToLook new }).
	self assert: (ss rulesFor: (ToElement new)) size equals: 1
]