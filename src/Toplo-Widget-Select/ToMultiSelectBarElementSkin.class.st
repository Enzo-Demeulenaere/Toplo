Class {
	#name : #ToMultiSelectBarElementSkin,
	#superclass : #ToBasicListElementSkin,
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #'event handling' }
ToMultiSelectBarElementSkin >> focusedLookEvent: anEvent [

	super focusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToMultiSelectBarElementSkin >> installLookEvent: anEvent [

	super installLookEvent: anEvent.
	anEvent elementDo: [ :e | 
		e border: BlBorder empty.
		e padding: BlInsets empty.
		e margin: BlInsets empty.
		e shortcuts: (self shortcutsToInstallIn: e).
		e installShortcuts ]
]

{ #category : #'accessing - shortcuts' }
ToMultiSelectBarElementSkin >> shortcutsToInstallIn: aListElement [

	^ Array streamContents: [ :stream |
		
		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowDown build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement selecter nextSelectableIndexToScrollTo.
					   aListElement selecter scrollToDataSourcePosition: idx.
					   aListElement selecter selectOnlyIndex: idx ]).

		  stream nextPut: (BlShortcutWithAction new
				   combination: BlKeyCombination builder arrowUp build;
				   action: [ :aShortcutEvent :aShortcut |
					   | idx |
					   idx := aListElement selecter previousSelectableIndexToScrollTo.
					   aListElement selecter scrollToDataSourcePosition: idx.
					   aListElement selecter selectOnlyIndex: idx ]).

		  aListElement isMultipleSelection ifTrue: [
			
			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination primaryA;
					   action: [ :aShortcutEvent :aShortcut |
						   aListElement selecter selectAll ]).
					
			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowDown build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := aListElement selecter nextDeselectedIndex.
						   aListElement selecter selectIndex: idx.
						   aListElement selecter scrollToDataSourcePosition: idx ]).

			  stream nextPut: (BlShortcutWithAction new
					   combination: BlKeyCombination builder shift arrowUp build;
					   action: [ :aShortcutEvent :aShortcut |
						   | idx |
						   idx := aListElement selecter previousDeselectedIndex.
						   aListElement selecter selectIndex: idx.
						   aListElement selecter scrollToDataSourcePosition: idx ]) ] ]
]

{ #category : #'event handling' }
ToMultiSelectBarElementSkin >> unfocusedLookEvent: anEvent [

	super unfocusedLookEvent: anEvent.
	anEvent elementDo: [ :e |
		e border: BlBorder empty ]
]

{ #category : #'event handling' }
ToMultiSelectBarElementSkin >> uninstallLookEvent: anEvent [

	super uninstallLookEvent: anEvent.
	anEvent elementDo: [ :e | e uninstallShortcuts ]
]