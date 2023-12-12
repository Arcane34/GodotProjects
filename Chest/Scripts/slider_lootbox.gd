extends Node2D

@onready var container = $HBoxContainer

func _ready():
	
	var scene = load("res://Scenes/loot.tscn")
	var instance = scene.instantiate()
	var totalLoot = instance.get_node("Sprite4Loot").vframes -1
	container.add_child(instance)
	for i in totalLoot:
		instance = scene.instantiate()
		instance.get_node("Sprite4Loot").frame += 1
		container.add_child(instance)
