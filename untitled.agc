LoadImage(3,"CarGreen.png")

global a=1
randomCar:
	
	
	if a = 1
		CreateSprite(3, 3)
		SetSpritePosition(3,Random2(50,200), 30 )
		a = 2
	endif
	//car1=Random(1,5)
	if a=2
		SetSpriteSize(3,50,100)
		SetSpritePosition(3, GetSpriteX(3), GetSpriteY(3)+4)
		//if GetSpriteY(3)>800
		//	DeleteSprite(3)
		//endif
		SetSpriteShape(3,3)
	endif
return
