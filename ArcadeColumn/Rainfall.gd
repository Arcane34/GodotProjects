extends Node2D
var scene = load("res://rain.tscn")

func _process(delta):
	var instance = scene.instantiate()
	instance.position = Vector2(randf_range(-100,300),0)
	add_child(instance)
