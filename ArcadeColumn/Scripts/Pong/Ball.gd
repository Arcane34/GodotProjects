extends RigidBody2D

var oob = false


func _on_body_entered(body):
	if body.name == "OutOfBounds":
		oob = true
	elif body.name == "Player" or body.name == "Opponent":
		apply_central_force(Vector2(0, (position.y - body.position.y) * 100 ))
	apply_central_force(linear_velocity)
