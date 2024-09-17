extends RigidBody2D

var direction = Vector2(0,1)
var positions = []
var length = 3

func _physics_process(delta):
	position += direction
	var left_right = Input.get_action_strength("left") - Input.get_action_strength("right")
	var up_down = Input.get_action_strength("up") - Input.get_action_strength("down")
	if left_right != 0:
		if direction[1] != 0:
			direction[0] = left_right * -1
			direction[1] = 0
			
	if up_down != 0:
		if direction[0] != 0:
			direction[1] = up_down * -1
			direction[0] = 0

func _process(delta):
	if len(positions) > 300:
		positions.append(position)
		positions.remove_at(0)
	else:
		positions.append(position)
	
	
	
