Trait {
	#name : #TToDressable,
	#category : #'Toplo-Core'
}

{ #category : #'t - accessing dresser' }
TToDressable >> addDresser: aDresser [

	self dresser addDresser: aDresser in: self
]

{ #category : #'t - initialization dresser' }
TToDressable >> defaultDresser [

	^ ToNullDresser new
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresser [
	^ self userData at: #dresser ifAbsent: nil
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresser: aDresser [

	self dresserDo: [ :d | d launchUninstallationIn: self ].
	self userData at: #dresser put: aDresser.
	self userData at: #dresserActions ifPresent: [ :l | 
		l do: [ :a | a cull: aDresser cull: self ].
		self userData removeKey: #dressersActions ].
	self dresserDo: [ :d | d launchInstallationIn: self ]
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresserDo: aBlock [

	self dresser ifNotNil: [ :d | aBlock cull: d ]
]

{ #category : #'t - initialization dresser' }
TToDressable >> dresserDoOrDefer: aBlock [

	self dresser ifNotNil: [ :d | 
		aBlock cull: d cull: self.
		^ self ].
	self storeDresserAction: aBlock
]

{ #category : #'t - accessing dresser' }
TToDressable >> dresserSatisfying: aBlock [

	^ self dresser dresserSatisfying: aBlock
]

{ #category : #'t - initialization dresser' }
TToDressable >> initializeDresser [

	self dresser: self defaultDresser
]

{ #category : #'t - accessing dresser' }
TToDressable >> removeDresser: aDresser [

	self dresser = aDresser ifFalse: [ 
		self dresser removeDresser: aDresser in: self.
		^ self ].
	self dresser: aDresser next.
	aDresser next: ToNullDresser new.
	aDresser launchUninstallationIn: self
]

{ #category : #'t - initialization dresser' }
TToDressable >> storeDresserAction: aBlock [

	| l |
	l := self userData at: #dresserActions ifAbsentPut: [ OrderedCollection new ].
	l add: aBlock
]