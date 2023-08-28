extends RigidBody2D


@export var move_speed : float = 30
@export var starting_direction : Vector2 = Vector2(0,1)




# parameters/Idle/blend_position
func _ready():
	self.get_node("propulsion2").process_material.direction.y = -1
	

func _physics_process(_delta):
	
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	
	if input_direction[1] == -1:
		self.get_node("propulsion").emitting = true
	else:
		self.get_node("propulsion").emitting = false
	
	if input_direction[1] == 1:
		self.get_node("propulsion2").emitting = true
	else:
		self.get_node("propulsion2").emitting = false
		
	if input_direction[0] == -1:
		self.get_node("leftThrust").process_material.direction.y = 1
		self.get_node("rightThrust").process_material.direction.y = -1
		self.get_node("leftThrust").emitting = true
		self.get_node("rightThrust").emitting = true
		self.rotation -= 0.02
	elif input_direction[0] == 1:
		self.get_node("leftThrust").process_material.direction.y = -1
		self.get_node("rightThrust").process_material.direction.y = 1
		self.get_node("leftThrust").emitting = true
		self.get_node("rightThrust").emitting = true
		self.rotation += 0.02
	else:
		self.get_node("leftThrust").emitting = false
		self.get_node("rightThrust").emitting = false

		
		
	var velocity = input_direction[1] * move_speed
	
	var angle = self.rotation - PI/2
	self.apply_central_impulse(Vector2(cos(angle), sin(angle)) * velocity * -1)
	
	
