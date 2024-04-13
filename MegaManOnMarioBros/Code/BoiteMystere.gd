extends KinematicBody2D

#func _ready():
#	pass # Replace with function body.

func _physics_process(delta):
	movement_loop()
	
func movement_loop():
	$AnimationPlayer.play("Arret")
	