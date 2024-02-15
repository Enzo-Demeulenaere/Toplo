Class {
	#name : #ToNoneSelectionModelSelecterTest,
	#superclass : #ToParameterizedHostTest,
	#instVars : [
		'holder',
		'selectionChanged',
		'selecter'
	],
	#category : #'Toplo-Widget-List-Tests-Selection-Selecter'
}

{ #category : #running }
ToNoneSelectionModelSelecterTest >> setUp [

	super setUp.
	selectionChanged := false.
	holder := ToSelectionModelHolderForTest new.
	space root addChild: holder.
	holder data addAll: (1 to: 1000).
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selectionChanged := true ]).
	selecter := holder noneSelectionSelecter
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDeselectAll [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDeselectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	selecter deselectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty 
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDeselectIndex [

	selecter selectIndex: 2.
	selecter deselectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testDispatchSelectionChanged [

	| selChangedEvent |
	holder addEventHandler: (BlEventHandler
			 on: ToListSelectionChangedEvent
			 do: [ :event | selChangedEvent := event ]).

	selecter selectAllIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: selChangedEvent isNil.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.

	selChangedEvent := nil.
	" no change "
	selecter selectAllIndexes: { 2. 6. 9 }.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self waitTestingSpaces.
	self assert: selChangedEvent isNil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAll [

	selecter selectAll.
	self waitTestingSpaces.
	self deny: holder selectionModel isNotEmpty.
	self
		deny: holder selectionModel isWholeSelectionModel
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAll2 [

	selecter selectAll.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0.
	self assert: holder selectionModel isEmptySelectionModel
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAllIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToIndex: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: holder scrollIndex equals: nil

]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToNext [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToNext.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: holder scrollIndex equals: nil

]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToNextDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToNextDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	selecter selectAndScrollToNextDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: holder scrollIndex equals: nil

]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToPrevious [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToPrevious.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: holder scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectAndScrollToPreviousDeselected [

	selecter deselectAll.
	selecter selectIndex: 2.
	self waitTestingSpaces.
	selecter selectAndScrollToPreviousDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	selecter selectAndScrollToPreviousDeselected.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	self assert: holder scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndex2 [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndexTo [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectIndexTo2 [

	selecter selectIndex: 2 to: 10.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectNextOnLastIndex [

	selecter selectIndex: holder dataSource itemCount.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0.
	selecter selectAndScrollToNext.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes isEmpty.
	self
		assert: selecter currentIndex
		equals: 0.
	self assert: holder scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectOnlyIndex [

	selecter deselectAll.
	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndex: 10.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectOnlyIndexes [

	selecter selectAllIndexes: {2. 6. 9}.
	selecter selectOnlyIndexes: {10. 6. 20}.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectPreviousOnFirstIndex [

	selecter selectIndex: 1.
	self waitTestingSpaces.
	self assert: selecter currentIndex equals: 0.
	selecter selectAndScrollToPrevious.
	self waitTestingSpaces.
	self
		assert: holder selectionModel selectedIndexes isEmpty.
	self
		assert: selecter currentIndex
		equals: 0.
	self assert: holder scrollIndex equals: nil
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectThenDeselectAll [

	selecter selectIndex: 2.
	selecter deselectAll.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectToIndex [

	selecter selectIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	selecter selectToIndex: 12.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0.
	selecter selectToIndex: 2.
	self waitTestingSpaces.
	self assert: holder selectionModel selectedIndexes isEmpty.
	self assert: selecter currentIndex equals: 0

]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectionChanged [

	selecter selectAllIndexes: {2}.
	self waitTestingSpaces.
	self deny: selectionChanged. 

]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll [

	selectionChanged := false.
	selecter selectAllIndexes: {2}.
	self waitTestingSpaces.
	selecter deselectAll.
	self waitTestingSpaces.
	self deny: selectionChanged
]

{ #category : #tests }
ToNoneSelectionModelSelecterTest >> testSelectionChangedOnDeselectAll2 [

	selectionChanged := false.
	selecter selectAllIndexes: {2 }.
	self waitTestingSpaces.
	selecter deselectAll.
	selecter deselectAll.
	self waitTestingSpaces.
	self deny: selectionChanged
]