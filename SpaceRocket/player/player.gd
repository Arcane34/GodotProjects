extends RigidBody2D


@export var move_speed : float = 30
@export var starting_direction : Vector2 = Vector2(0,1)





func _physics_process(_delta):
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	
	if input_direction[1] == -1:
		self.get_node("propulsion").emitting = true
	else:
		self.get_node("propulsion").emitting = false
	

		
	if input_direction[0] == -1:
		self.rotation -= 0.05
	elif input_direction[0] == 1:
		self.rotation += 0.05


	var velocity = Vector2(0,0)
	if input_direction[1] < 0:
		velocity = input_direction[1] * move_speed
	
	var angle = self.rotation - PI/2
	self.apply_impulse(Vector2(cos(angle), sin(angle)) * velocity * -1)
	
	
	# directional arrows move type
	#self.apply_impulse(input_direction * move_speed)
	
	
	
