extends Control

@onready var player = $Player
@onready var enemies = $Enemies
@onready var hand = $Options/CardLibrary/Hand


func _ready():
	for i in player.get_children():
		i.get_node("HitboxComponent").connect("pressed", hit.bind( i))
	
	for i in enemies.get_children():
		i.get_node("HitboxComponent").connect("pressed", hit.bind( i))

func hit(character):
	print(hand.focus.name)
	character.get_node("HitboxComponent").damage(hand.focus)
	

func _process(delta):
	var visible = true
		
		
	for i in enemies.get_children():
		#enemies.get_child(i).position = Vector2(i*64, 0)
		#enemies.get_child(i).play("breathing")
		i.scale.x = -1
		if hand.focus == null:
			i.modulate.a = 1
		else:
			if i.get_node("HitboxComponent").is_hovered():
				i.modulate.a = 1
			else:
				i.modulate.a = 0.7
		


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu/mainMenu.tscn")


func _on_end_turn_pressed():
	pass # Replace with function body.
