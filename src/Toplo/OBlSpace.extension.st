Extension { #name : #OBlSpace }

{ #category : #'*Toplo-LookAndFeel' }
OBlSpace >> isSupportToTheme [
	"Development method : to check if the Space support ToTheme management"

	^ self root toTheme isNil
]

{ #category : #'*Toplo-LookAndFeel' }
OBlSpace >> isThemeInstalled [
	"This method is temporary here to detect when a Theme is installed, this is dirty and a Space need to have a dresser pattern"
	
	self flag:'laborded : this is necessary to have this state for the first instanciation, this is temporary'.
	^ self root userData at: #isToThemeInstalled ifAbsentPut:[ false ]
]

{ #category : #'*Toplo-LookAndFeel' }
OBlSpace >> switchThemeDarkOrLight [
	"Switch to the opposite theme : dark or light (if available)"
	| newTheme |

	(self toTheme isNil or:[self toTheme isSupportLightAndDark not]) ifTrue:[ ^ self ].

	newTheme := self toTheme isLight
			 ifTrue: [ self toTheme darkTheme ]
			 ifFalse: [ self toTheme lightTheme ].
			
	newTheme ifNil:[ ^ self ].
	self toTheme: newTheme
]

{ #category : #'*Toplo-LookAndFeel' }
OBlSpace >> toTheme [

	| theme |
	theme := self root toTheme.

	"Check theme installation : this is dirty and temporary"
	(theme notNil and:[self isThemeInstalled not]) ifTrue:[ theme installOnSpace: self ].
	
	^ theme
]

{ #category : #'*Toplo-LookAndFeel' }
OBlSpace >> toTheme: aTheme [

	aTheme ifNotNil: [ aTheme installOnSpace: self ].
	self root toTheme: aTheme
]