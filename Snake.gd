extends Node2D

var posx = 0 ;
var posy = 0 ;

var pause = true ;

var direction = "L"

var Blocks_nbr = 0 ;

var Blocks = [Vector2()]

var New_Pos = Vector2()
var point ;

var j = 0 ;

var x = 0 ;

var time = 0.5 ;

func Score(x):
	get_node("Score").clear()
	get_node("Score").add_text(str("Score : ",x))\

func Border():
	#Test if the Play Pass the borders on the x axis
	if(posx > 230):
		posx = -10 ;
	elif(posx < 0):
		posx = 240 ;

	#Test if the Play Pass the borders on the y axis
	if(posy > 230):
		posy = -10 ;
	elif(posy < 0):
		posy = 240 ;
func Game_Over():
	var T = false ;
	for i  in range(Blocks.size()):
		if(i > 1 ):
			if(New_Pos == Blocks[i]):
				T = true ;
	return T ;

func Rand_Pos():
	return (randi() % 24) * 10 ;

func _ready():

	point = Vector2(Rand_Pos(),Rand_Pos())
	posx = 0 ;
	posy = 0 ;
	set_process_input(true) ;
	set_process(true) ;

func _process(delta):

	time -= delta*10
	if(time <= 0 ):
		Score(Blocks_nbr)
		time = 1 ;

		match direction :
			"R" : posx += 10 ;
			"D" : posy += 10 ;
			"L" : posx -= 10 ;
			"U" : posy -= 10 ;

		New_Pos.x = posx ; New_Pos.y = posy ;

		if(Game_Over()):
			get_tree().reload_current_scene()

		if(x < Blocks_nbr):
			x += 1 ;
			Blocks[x] = New_Pos ;
		else :
			x = 0 ;
			Blocks[x] = New_Pos ;
		update()
		Border()

func _input(event):
	if(Input.is_action_pressed("ESC")):
		if(pause == false):
			pause = true ;
		else :
			pause = false ;
		set_process(pause)

	if(Input.is_action_pressed("ui_right")and direction != "L"):
		direction = "R" ;
	if(Input.is_action_pressed("ui_down") and direction != "U"):
		direction = "D" ;
	if(Input.is_action_pressed("ui_up") and direction != "D"):
		direction = "U" ;
	if(Input.is_action_pressed("ui_left")and direction != "R"):
		direction = "L" ;

func _draw():


	#Grid Drawing H
	j = 0 ;
	for i in range(25) :
		j += 10
		draw_line(Vector2(0,j),Vector2(240,j),Color(255,255,255,5))
		draw_line(Vector2(j,0),Vector2(j,240),Color(255,255,255,5))

	#Test The Pos of Point
	if(point == Vector2(posx,posy)):
		Blocks.append(New_Pos)
		Blocks_nbr += 1 ;
		#draw_rect(Rect2(Vector2(Blocks[0]),Vector2(10,10)),Color(0,0,0))
		point = Vector2(Rand_Pos(),Rand_Pos())


	#Point Drawing
	draw_rect(Rect2(point,Vector2(10,10)),Color(0,0,0))
	
	#Snake Drawing 
	for i in range(Blocks.size()):
		draw_rect(Rect2(Blocks[i],Vector2(10,10)),Color(0,0,0),false)

	draw_rect(Rect2(Vector2(New_Pos),Vector2(10,10)),Color(0,0,0))

	draw_rect(Rect2(Vector2(0,240),Vector2(240,40)),Color("a2d089"))
