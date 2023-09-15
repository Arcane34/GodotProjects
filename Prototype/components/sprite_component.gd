extends AnimatedSprite2D

@onready var state = "idle"

func _process(delta):
	play(state)
