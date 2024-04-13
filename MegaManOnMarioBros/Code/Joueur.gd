extends KinematicBody2D

#### CONSTANTE GENERALE #####
const GRAVITY = 1000 
const accel = 5 

##### VARIABLE GLOBALE #####
var vel = Vector2()
var maxSpeed = 100 
var nombreDeSaut = 0 

	
#func _ready(): 
#	pass
#
#func _process(delta):
#	pass
	
func _physics_process(delta):
	movement_loop()
	vel.y += GRAVITY * delta	
	vel = move_and_slide(vel, Vector2(0, -1))
	pass

func movement_loop():
	##### VARIABLES ######
	var MGdroite = Input.is_action_pressed("ui_right")
	var MGgauche = Input.is_action_pressed("ui_left") # action_pressed > tant que la touche est enfoncée
	var MGsaut = Input.is_action_just_pressed("ui_up") # action_just_pressed > meme si maintenue il n'y a qu'une imput
	var MGtir = Input.is_action_pressed("ui_down")
	var MGdirx = int(MGdroite) - int(MGgauche) 
	
	##### SAUT #####
	if is_on_floor() : 
		nombreDeSaut = 0
		
	if MGsaut == true and nombreDeSaut < 2 : 
		vel.y = -300
		nombreDeSaut += 1

	##### VELOCITE ET DEPLACEMENT ######
	if MGdirx == -1 : # GAUCHE
		vel.x = max(vel.x - accel, -maxSpeed)
		$Sprite.flip_h = true
	elif MGdirx == 1 : #DROITE
		vel.x = min(vel.x + accel, maxSpeed)
		$Sprite.flip_h = false
	elif MGdirx ==0 : #ARRET AVEC INERTIE
		vel.x = lerp(vel.x, 0, 0.15)
	else : 
		print("Dirx bug")
	
	print(MGdirx)
	animation(MGdirx, MGtir)
	
	
func animation(MGdirx, MGtir):
	if MGdirx != 0:
		$AnimationPlayer.play("MGCourse")
	if MGdirx == 0 && MGtir == false :
		$AnimationPlayer.play("MGArret")
	if MGdirx == 0 && MGtir == true :
		$AnimationPlayer.play("MGTir")
	if vel.y > 0 : 
		$AnimationPlayer.play("MGSaut")
	if vel.y < 0 : 
		$AnimationPlayer.play("MGSaut")
