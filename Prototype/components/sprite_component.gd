extends AnimatedSprite2D

#this will store the current animation for all characters
@onready var state = "idle"

# this will just play the current state
func _process(delta):
	play(state)



	





func _on_animation_looped():
	if state == "death":
		get_parent().queue_free()
	elif state != "idle":
		state = "idle"
	
	
