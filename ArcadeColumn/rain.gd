extends AnimatedSprite2D
@onready var lifetime = $Timer
var direction = Vector2(0.5,1)

func _ready():
	lifetime.wait_time = randf_range(0.2,1)
	lifetime.start()
	

func _process(delta):
	if lifetime.is_stopped():
		play("land")
		rotation = 0
	else:
		position += direction * 5
		look_at(position+direction)
		rotate(PI/2)
		
	

func _on_animation_finished():
	queue_free()
