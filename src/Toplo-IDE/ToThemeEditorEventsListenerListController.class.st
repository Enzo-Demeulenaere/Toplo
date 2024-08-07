Class {
	#name : #ToThemeEditorEventsListenerListController,
	#superclass : #Object,
	#traits : 'TToThemeEditorControllerWithButtons + TToThemeEditorRulesTreeObserver + TToThemeEditorObservable + TToThemeEditorEventListenerEditorObserver',
	#classTraits : 'TToThemeEditorControllerWithButtons classTrait + TToThemeEditorRulesTreeObserver classTrait + TToThemeEditorObservable classTrait + TToThemeEditorEventListenerEditorObserver classTrait',
	#instVars : [
		'styleRule',
		'isTriggerSelectedRuleChanged',
		'theme'
	],
	#category : #'Toplo-IDE-theme-editor-presenter-eventListeners'
}

{ #category : #adding }
ToThemeEditorEventsListenerListController >> addEventListener [

	| newEventListener |
	self styleRule ifNil: [ ^ self ].
	newEventListener := self defaultEventListner.
	self styleRule addSkinEventListener: newEventListener.
	self updatePresenterOn: newEventListener
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventsListenerListController >> allEventListeners [

	self styleRule ifNil: [ ^ {  } ].
	^ self styleRule skinEventListeners
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventsListenerListController >> defaultEventListner [
	self theme ifNil: [ ^ ToSkinEventAction new action: [ :e | ]; yourself ].
	^ ToPropertyWriter new
		                    value: [ :e |  ];
		                    eventClass: ToSkinEvent;
		                    property: self defaultProperty;
		                    yourself.
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> defaultProperty [

	^ self theme styleSheet writablePropertyIndex index atRandom value.
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> doNotTriggerSelectedRuleChanged [

	isTriggerSelectedRuleChanged := false
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> doNotTriggerSelectedRuleChangedWhile: aBlock [

	self doNotTriggerSelectedRuleChanged.
	aBlock value.
	self doTriggerSelectedRuleChanged
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> doTriggerSelectedRuleChanged [

	isTriggerSelectedRuleChanged := true
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventsListenerListController >> duplicateEventListener: anEventListener [
	|newEventListener | 
self styleRule ifNil: [ ^ self ].
	newEventListener := ToPropertyWriter new
		value: anEventListener value copy;
		eventClass: anEventListener eventClass;
		property: anEventListener property;
		supplement: anEventListener isSupplement;
		yourself.
	self styleRule addSkinEventListener: newEventListener.
	self updatePresenterOn: newEventListener
]

{ #category : #initialization }
ToThemeEditorEventsListenerListController >> initialize [ 

	isTriggerSelectedRuleChanged := true
]

{ #category : #testing }
ToThemeEditorEventsListenerListController >> isButtonAddEnabled [

	^ self styleRule isNotNil
]

{ #category : #testing }
ToThemeEditorEventsListenerListController >> isButtonRemoveEnabled [

	self styleRule ifNil: [ ^ false ].
	^ self presenter eventListenersList selectedItem isNotNil
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> isTriggerSelectedRuleChanged [

	^ isTriggerSelectedRuleChanged
]

{ #category : #adding }
ToThemeEditorEventsListenerListController >> removeEventListener: anEventListener [

	self styleRule ifNil: [ ^ self ].
	self styleRule removeSkinEventListener: anEventListener.
	self styleRule: self styleRule
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventsListenerListController >> replaceEventListener: anOldEventListener with: aNewEventListener [

	self styleRule removeSkinEventListener: anOldEventListener.
	self styleRule addSkinEventListener: aNewEventListener.
	self updatePresenterOn: aNewEventListener
]

{ #category : #initialization }
ToThemeEditorEventsListenerListController >> selectedEventListenerChanged: anEventListener [

		self isTriggerSelectedRuleChanged ifFalse: [ ^ self ].
		self observers do: [ :each |
			each selectedEventListenerChanged: anEventListener ]
]

{ #category : #initialization }
ToThemeEditorEventsListenerListController >> selectedRuleChanged: aToStyleRule [

	self styleRule: aToStyleRule
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventsListenerListController >> styleRule [

	^ styleRule
]

{ #category : #'as yet unclassified' }
ToThemeEditorEventsListenerListController >> styleRule: aToStyleRule [

	styleRule := aToStyleRule.
	self presenter eventListenersList items: self allEventListeners.
	self presenter updatePresenter.
	self allEventListeners ifEmpty: [ ^ self ].
	self presenter eventListenersList selectItem:
		self allEventListeners first.
		self presenter updatePresenterOnlyButtons
]

{ #category : #accessing }
ToThemeEditorEventsListenerListController >> theme [
	^ theme 
]

{ #category : #accessing }
ToThemeEditorEventsListenerListController >> theme: anObject [


	theme:= anObject
]

{ #category : #initialization }
ToThemeEditorEventsListenerListController >> updatePresenterOn: aToSkinEventAction [

	self doNotTriggerSelectedRuleChangedWhile: [
		self presenter updatePresenter ].
	self presenter eventListenersList selectItem: aToSkinEventAction
]
