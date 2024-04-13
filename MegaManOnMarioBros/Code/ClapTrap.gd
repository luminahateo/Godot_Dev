extends KinematicBody2D

##### CONSTANTE GLOBALE #####
const GRAVITY = 1000 
const accel = 2 

##### VARIABLE GLOBALE #####
var vel = Vector2()
var maxSpeed = 100 
var dirx = 0

func _ready(): 
	randomize()
	pass

func _on_Timer_timeout():
	##### VARIABLE #####
	var moveTrapClap = int(rand_range(0, 10)) #Random entre 0 et 10
	if moveTrapClap < 4 :
		dirx = -1
	elif moveTrapClap > 6 :
		dirx = 1
	elif moveTrapClap == 5 :
		dirx = 0
	elif moveTrapClap == 6 :
		dirx = 2
	else :
		dirx = 3
#	debug(moveTrapClap)
	pass
	
func _process(delta):
	pass
	
func _physics_process(delta):
	movement_loop()
	animation_loop()
	vel.y += GRAVITY * delta
	vel = move_and_slide(vel, Vector2(0, -1)) 
	pass

func movement_loop():
	if dirx == -1 : #GAUCHE
		vel.x = max(vel.x - accel, -maxSpeed)
		$Sprite.flip_h = false
	elif dirx == 1 : #DROITE
		vel.x = min(vel.x + accel, maxSpeed)
		$Sprite.flip_h = true
	elif dirx == 2 : #SAUT
		vel.y = -100
	else : #ARRET AVEC INERTIE
		vel.x = lerp(vel.x, 0, 0.15)
	pass

func animation_loop():
	if dirx ==1 || dirx == -1 : 
		$AnimationPlayer.play("Roule")
	elif dirx == 0 :
		$AnimationPlayer.play("Arret")
	else :
		$AnimationPlayer.play("Tir")
	if vel.y > 0 : 
		$AnimationPlayer.play("Saut")
	if vel.y < 0 : 
		$AnimationPlayer.play("Saut")
	pass
	
#func debug(moveTrapClap) :
#	print("Random Trap :", moveTrapClap)