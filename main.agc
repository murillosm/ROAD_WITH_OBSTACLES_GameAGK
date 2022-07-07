
// show all errors
SetErrorMode(2)

// set window properties
SetWindowTitle( "ops" )
SetWindowSize( 600, 744, 0 )
SetWindowAllowResize( 1 ) // allow the user to resize the window

// set display properties
SetVirtualResolution( 600, 744 ) // doesn't have to match the window
SetOrientationAllowed( 1, 1, 1, 1 ) // allow both portrait and landscape on mobile devices
SetSyncRate( 60, 0 ) // 30fps instead of 60 to save battery
SetScissor( 0,0,0,0 ) // use the maximum available screen space, no black borders
UseNewDefaultFonts( 1 ) // since version 2.0.22 we can use nicer default fonts
//SetVirtualResolution (480, 744)
/********************************************************************/
/********************************************************************/
/********************************************************************/
/********************************************************************/
//musicas e sons do game
LoadMusic ( 1, "Kalimba.mp3" )
PlayMusic ( 1, 100,1,0)

CarSound = LoadSound ("motor.wav" )

 
Sound = LoadSound ( "countdown.wav" )

ExplodeSound = LoadSound ( "explode3.wav" )
/********************************************************************/
/********************************************************************/
//carro principal vermelho sprite
LoadImage (2,"CarRed.png")
CreateSprite ( 2, 2 )
SetSpritePosition ( 2, 215, 600 )
SetSpriteSize(2,40,80)
SetSpriteDepth ( 2, 1 )
/********************************************************************/
/********************************************************************/
//pista sprite
LoadImage (1, "pista.jpg")
bg2 = createsprite (1)
SetSpriteSize(bg2, 600, 744)
bg2_2 = createsprite (1)
SetSpriteSize(bg2_2, 600, 744)
SetSpriteY (bg2_2, 19)
//SetSpriteDepth ( 1, 0)
/********************************************************************/
/********************************************************************/
//sprites obstaculos

LoadImage(3,"CarGreen.png")
global a=1

LoadImage(4,"CarOrange 2.png")
global b=1

LoadImage(5,"Caminhao.png")
global c=1

LoadImage(6,"CarPink.png")
global d=1

LoadImage(7,"CarWhite.png")
global e=1

LoadImage(8,"CarPink 2.png")
global d2=1

LoadImage(9,"BuMini.png")
global bu1 = 1
LoadImage(10,"BuMini.png")
global bu2 = 1
LoadImage(11,"BuMini.png")
global bu3 = 1

LoadImage(12,"Vida.png")
global ro = 1

/********************************************************************/
//explosao

CreateSprite(20,0)

		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 1.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 2.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 3.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 4.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 5.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 6.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 7.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 8.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 9.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 10.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 11.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 12.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 13.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 14.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 15.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 16.png" ) )
		AddSpriteAnimationFrame ( 20, LoadImage ( "explosao 17.png" ) )
		SetSpriteSize(20,193,185)

/********************************************************************/
//sprite menu e start

LoadImage(77,"menu.jpg")
LoadImage(78,"start.png")
CreateSprite(77,77)
CreateSprite(78,78)
SetSpriteVisible(77,0)	
SetSpriteVisible(78,0)
SetSpriteSize(77,600,744)
SetSpriteSize(78,322,201)

LoadImage(76,"gameover.jpg")

/********************************************************************/
global vida = 3

tempo = 0

menu = 0
/********************************************************************/
//Laço principal

do
	
	
	
	select menu
		
		case 0
			// tela menu
		SetSpriteVisible(77,1)	
		SetSpriteVisible(78,1)
		SetSpriteVisible(2,0)
		SetSpritePosition(78,130,300)
		if GetPointerPressed() = 1
			menu = 1
			SetSpriteVisible(77,0)
			SetSpriteVisible(78,0)
			PlaySound(CarSound,60,1,0)
		endif
			
			
		endcase
		
		case 1
	
			Km = Timer()
			SetSpriteVisible(2,1)
			//CREATE tempo 
			deletetext(leText1)
			S$=Left("",6-Len(Str(Km)))+Str(Km)
			leText1 = CreateText("Km:"+S$)
			SetTextPosition(leText1,450,10)
			SetTextDepth(leText1,0)
			SetTextSize(leText1,30)
			
			//CREATE vida 
			deletetext(leText2)
			S$=Left("",6-Len(Str(vida)))+Str(vida)
			leText2 = CreateText("vida:"+S$)
			SetTextPosition(leText2,300,10)
			SetTextDepth(leText2,0)
			SetTextSize(leText2,30)

			gosub asfalto
			gosub randomCar1  
			gosub Joystick
			gosub RotacaoDaPista
			gosub colision
			gosub reparo
			if vida = 0
				menu = 3
				Km = 0
			endif
			
		endcase
		
		
		case 3
			
			//DeleteAllSprites()
			DeleteAllText()
			if vida = 0
				StopMusic()
				StopSound(CarSound)
				gameover = CreateSprite(76)
				SetSpriteSize(gameover,600,744)
			endif
			if GetPointerPressed() = 1
				menu = 0
				DeleteSprite(gameover)
			endif
			//gameover
		endcase
		endselect
		
		
	Sync ( )
loop


/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
/*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*/
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/

//gackground
RotacaoDaPista:
	bg2y= GetSpriteY(bg2) + 6//*incvelocidade/15
	Setspriteposition (bg2,GetSpritex(bg2), bg2y)
	Setspriteposition (bg2_2, GetSpritex(bg2), bg2y-GetSpriteHeight(bg2))

	if bg2y > GetSpriteHeight(bg2)
		Setspriteposition (bg2, GetSpritex(bg2),bg2y-GetSpriteHeight(bg2_2))
	endif

	if GetSpritey(bg2_2) > GetSpriteheight(bg2_2)
		Setspriteposition (bg2_2, GetSpritex(bg2_2),bg2y-GetSpriteHeight(bg2_2))
	endif

return
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
/*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*/
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/


Joystick:
	x# = GetJoystickX ( )*6
		y# = GetJoystickY ( )*0


		Print ( x# )
		Print ( y# )


		SetSpritePosition ( 2, GetSpriteX ( 2 ) + x#, GetSpriteY ( 2 ) + y# )


		if ( GetSpriteX ( 2 ) < 42 )
			SetSpriteX ( 2, 42 )
		endif


		if ( GetSpriteX ( 2 ) > GetVirtualWidth()-GetSpriteWidth(2)- 40 )
			SetSpriteX ( 2, GetVirtualWidth()-GetSpriteWidth(2)-40 )
		endif
return

/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
/*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*/
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
//comandos dos carros
randomCar1:
	//carro verde
		if a = 1
			CreateSprite(3, 3)
			SetSpritePosition(3,Random2(470,500), -1000 )
			a = 2
		endif
		if a=2
			SetSpriteSize(3,40,80)
			SetSpritePosition(3, GetSpriteX(3), GetSpriteY(3)+3)
			SetSpriteShape(3,2)
		endif
		if getspritey(3) > GetVirtualHeight()
			SetSpritePosition(3,Random2(470,500),-100 )
			/*SetSpritePosition(3,Random2(230,430),-GetVirtualHeight()-160 )*/
		endif
	/**************************************************************************/
	/**************************************************************************/
	//carro laranja
			if b = 1
				CreateSprite(4, 4)
				SetSpritePosition(4,Random2(410,450), -160 )
				b = 2
			endif
			if b = 2
				SetSpriteSize(4,40,80)
				SetSpritePosition(4, GetSpriteX(4), GetSpriteY(4)+3)
				SetSpriteShape(4,3)
			endif
			if getspritey(4) > GetVirtualHeight()
				SetSpritePosition(4,Random2(410,450), -220 )
			endif
	/**************************************************************************/
	/**************************************************************************/		
	//carro rosa 2
		if d2 = 1
			CreateSprite(8, 8)
			SetSpritePosition(8,Random2(310,370), 30 )
			d2 = 2
		endif
		if d2=2
			SetSpriteSize(8,40,80)
			SetSpritePosition(8, GetSpriteX(8), GetSpriteY(8)+3)
			SetSpriteShape(8,2)
		endif
		if getspritey(8) > GetVirtualHeight()
			SetSpritePosition(8,Random2(310,370),-160 )
			/*SetSpritePosition(3,Random2(230,430),-GetVirtualHeight()-160 )*/
		endif		
	/**************************************************************************/
	/**************************************************************************/	
	//carro caminhao	
		if c = 1
				CreateSprite(5, 5)
				SetSpritePosition(5,Random(50,60), -200 )
				c = 2
			endif
			if c = 2
				SetSpriteSize(5,70,220)
				SetSpritePosition(5, GetSpriteX(5), GetSpriteY(5)+3)
				SetSpriteShape(5,2)
			endif
			if getspritey(5) > GetVirtualHeight()
				SetSpritePosition(5,Random(50,60), -200 )
			endif
	/**************************************************************************/
	/**************************************************************************/
	//carro rosa	
		if d = 1
				CreateSprite(6, 6)
				SetSpritePosition(6,Random(120,230), 10 )
				d = 2
			endif
			if d = 2
				SetSpriteSize(6,40,80)
				SetSpritePosition(6, GetSpriteX(6), GetSpriteY(6)+3)
				SetSpriteShape(6,2)
			endif
			if getspritey(6) > GetVirtualHeight()
				SetSpritePosition(6,Random(120,210), -170 )
			endif
	/**************************************************************************/
	/**************************************************************************/
	//carro branco	
		if e = 1
				CreateSprite(7, 7)
				SetSpritePosition(7,Random(250,270), -80 )
				e = 2
			endif
			if e = 2
				SetSpriteSize(7,40,80)
				SetSpritePosition(7, GetSpriteX(7), GetSpriteY(7)+3)
				SetSpriteShape(7,2)
			endif
			if getspritey(7) > GetVirtualHeight()
				SetSpritePosition(7,Random(250,270), -80 )
			endif
return

/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
/*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*/
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/

//buracos no asfalto
asfalto:
//buraco

	if bu1 = 1
		CreateSprite(9,9 )
		SetSpritePosition(9,Random2(70,150), -100 )
		bu1 = 2
	endif
	if bu1 =2
		SetSpriteSize(9,50,50)
		SetSpritePosition(9, GetSpriteX(9), GetSpriteY(9)+6)
		SetSpriteShape(9,2)
	endif
	if getspritey(9) > GetVirtualHeight()
		SetSpritePosition(9,Random2(70,150),-100)
	endif
	/**************************************************************************/
	if bu2 = 1
		CreateSprite(10 , 10 )
		SetSpritePosition(10,Random2(180,300), -150 )
		bu2 = 2
	endif
	if bu2 = 2
		SetSpriteSize(10,50,50)
		SetSpritePosition(10, GetSpriteX(10), GetSpriteY(10)+6)
		SetSpriteShape(10 , 2)
	endif
	if getspritey(10) > GetVirtualHeight()
		SetSpritePosition(10,Random2(180,300),-150)
	endif
	/**************************************************************************/
	if bu3 = 1
		CreateSprite(11 , 11 )
		SetSpritePosition(11,Random2(330,500), -1000 )
		bu3 = 2
	endif
	if bu3 = 2
		SetSpriteSize(11,50,50)
		SetSpritePosition(11, GetSpriteX(11), GetSpriteY(11)+6)
		SetSpriteShape(11 , 2)
	endif
	if getspritey(11) > GetVirtualHeight()
		SetSpritePosition(11,Random2(330,500),-1000)
	endif
return
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
/*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*/
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
reparo:
	if ro = 1
		CreateSprite(12 , 12 )
		SetSpritePosition(12,Random2(330,500), -10000 )
		ro = 2
	endif
	if ro = 2
		SetSpriteSize(12,50,50)
		SetSpritePosition(12, GetSpriteX(12), GetSpriteY(12)+6)
		SetSpriteShape(12 , 2)
	endif
	if getspritey(12) > GetVirtualHeight()
		SetSpritePosition(12,Random2(330,500),-10000)
	endif
//-------------------------------------------------------------------
	if GetSpriteCollision ( 2, 12 ) = 1
		
        PlaySound (Sound )
		vida=3
		SetSpriteVisible(12,0)
    endif
return
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
/*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*0*/
/*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/

colision:
	
	//SetSpritePosition ( 2, GetSpriteX ( 2 ) + 1, 200 )
	
    if GetSpriteCollision ( 2, 3 ) = 1
		
        PlaySound ( ExplodeSound )
		vida=vida-1
		
		SetSpriteVisible(20,1)
		PlaySprite ( 20, 30, 0, 1, 17)
		
		SetSpritePosition(20, getspritex(2),GetSpriteY(2))
		SetSpriteVisible(2,0)
		SetSpriteVisible(3,0)
		SetSpritePosition(3, random2(470,500), -100)
		SetSpriteVisible(3,1)
    endif
    if count = 100
		SetSpriteVisible(2,1)
		if  GetSpriteExists(20) = 1
		StopSprite(20)
		SetSpriteVisible(20, 0)
		endif
		count = 0
		endif
		count = count + 1
		
	/**************************************************************************/
	
	if GetSpriteCollision ( 2, 4 ) = 1
		PlaySound ( ExplodeSound )
		vida=vida-1
		
		SetSpriteVisible(20,1)
		PlaySprite ( 20, -30, 0, 1, 17)
		
		SetSpritePosition(20, getspritex(2),GetSpriteY(2))
		SetSpriteVisible(2,0)
		SetSpriteVisible(4,0)
		SetSpritePosition(4, random2(410,450), -100)
		SetSpriteVisible(4,1)

    endif
    if count = 100
		SetSpriteVisible(2,1)
		if  GetSpriteExists(20) = 1
		StopSprite(20)
		SetSpriteVisible(20, 0)
		endif
		count = 0
		endif
		count = count + 1
	/**************************************************************************/
	
	if GetSpriteCollision ( 2, 5 ) = 1
		PlaySound ( ExplodeSound )
		vida=vida-1
		
		SetSpriteVisible(20,1)
		PlaySprite ( 20, 30, 0, 1, 17)
		
		SetSpritePosition(20, getspritex(2),GetSpriteY(2))
		SetSpriteVisible(2,0)
		SetSpriteVisible(5,0)
		SetSpritePosition(5, random2(50,60), -1000)
		SetSpriteVisible(5,1)

    endif
    if count = 100
		SetSpriteVisible(2,1)
		if  GetSpriteExists(20) = 1
		StopSprite(20)
		SetSpriteVisible(20, 0)
		endif
		count = 0
		endif
		count = count + 1
		
	/**************************************************************************/
	
	if GetSpriteCollision ( 2, 6 ) = 1
		PlaySound ( ExplodeSound )
		vida=vida-1
		
		SetSpriteVisible(20,1)
		PlaySprite ( 20, 30, 0, 1, 17)
		
		SetSpritePosition(20, getspritex(2),GetSpriteY(2))
		SetSpriteVisible(2,0)
		SetSpriteVisible(6,0)
		SetSpritePosition(6, random2(120,210), -100)
		SetSpriteVisible(6,1)

    endif
    if count = 100
		SetSpriteVisible(2,1)
		if  GetSpriteExists(20) = 1
		StopSprite(20)
		SetSpriteVisible(20, 0)
		endif
		count = 0
		endif
		count = count + 1
		
	/**************************************************************************/
	
	if GetSpriteCollision ( 2, 7 ) = 1
		PlaySound ( ExplodeSound )
		vida=vida-1
		
		SetSpriteVisible(20,1)
		PlaySprite ( 20, 30, 0, 1, 17)
		
		SetSpritePosition(20, getspritex(2),GetSpriteY(2))
		SetSpriteVisible(2,0)
		SetSpriteVisible(7,0)
		SetSpritePosition(7, random2(250,270), -100)
		SetSpriteVisible(7,1)

    endif
    if count = 100
		SetSpriteVisible(2,1)
		if  GetSpriteExists(20) = 1
		StopSprite(20)
		SetSpriteVisible(20, 0)
		endif
		count = 0
		endif
		count = count + 1
	/**************************************************************************/
	
	if GetSpriteCollision ( 2, 8 ) = 1
		PlaySound ( ExplodeSound )
		vida=vida-1
		
		SetSpriteVisible(20,1)
		PlaySprite ( 20, 30, 0, 1, 17)
		
		SetSpritePosition(20, getspritex(2),GetSpriteY(2))
		SetSpriteVisible(2,0)
		SetSpriteVisible(8,0)
		SetSpritePosition(8, random2(230,430), -100)
		SetSpriteVisible(8,1)

    endif
    if count = 100
		SetSpriteVisible(2,1)
		if  GetSpriteExists(20) = 1
		StopSprite(20)
		SetSpriteVisible(20, 0)
		endif
		count = 0
		endif
		count = count + 1
		
	/**************************************************************************/
	
	if GetSpriteCollision ( 2, 9 ) = 1
		PlaySound ( ExplodeSound )
		vida=vida-1
		
		SetSpriteVisible(20,1)
		PlaySprite ( 20, 30, 0, 1, 17)
		
		SetSpritePosition(20, getspritex(2),GetSpriteY(2))
		SetSpriteVisible(2,0)
		SetSpriteVisible(9,0)
		SetSpritePosition(9, random2(70,150), -100)
		SetSpriteVisible(9,1)

    endif
    if count = 100
		SetSpriteVisible(2,1)
		if  GetSpriteExists(20) = 1
		StopSprite(20)
		SetSpriteVisible(20, 0)
		endif
		count = 0
		endif
		count = count + 1
	
	/**************************************************************************/
	
	if GetSpriteCollision ( 2, 10 ) = 1
		PlaySound ( ExplodeSound )
		vida=vida-1
		
		SetSpriteVisible(20,1)
		PlaySprite ( 20, 30, 0, 1, 17)
		
		SetSpritePosition(20, getspritex(2),GetSpriteY(2))
		SetSpriteVisible(2,0)
		SetSpriteVisible(10,0)
		SetSpritePosition(10, random2(180,300), -100)
		SetSpriteVisible(10,1)

    endif
    if count = 100
		SetSpriteVisible(2,1)
		if  GetSpriteExists(20) = 1
		StopSprite(20)
		SetSpriteVisible(20, 0)
		endif
		count = 0
		endif
		count = count + 1
	
	/**************************************************************************/
	
	if GetSpriteCollision ( 2, 11 ) = 1
		PlaySound ( ExplodeSound )
		vida=vida-1
		
		SetSpriteVisible(20,1)
		PlaySprite ( 20, 30, 0, 1, 17)
		
		SetSpritePosition(20, getspritex(2),GetSpriteY(2))
		SetSpriteVisible(2,0)
		SetSpriteVisible(11,0)
		SetSpritePosition(11, random2(330,500), -1000)
		SetSpriteVisible(11,1)

    endif
    if count = 100
		SetSpriteVisible(2,1)
		if  GetSpriteExists(20) = 1
		StopSprite(20)
		SetSpriteVisible(20, 0)
		endif
		count = 0
		endif
		count = count + 1
return


