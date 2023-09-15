extends Control

@onready var player = $Player
@onready var enemies = $Enemies

func _process(delta):
	for i in enemies.get_children().size():
		#enemies.get_child(i).position = Vector2(i*64, 0)
		#enemies.get_child(i).play("breathing")
		enemies.get_child(i).scale.x = -1

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu/mainMenu.tscn")
