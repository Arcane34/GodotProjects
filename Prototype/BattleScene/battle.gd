extends Control

@onready var player = $Player
@onready var enemies = $Enemies
@onready var hand = $Options/CardLibrary/Hand
@onready var player_turn = true #true = player's turn, else enemy turn
@onready var card_options = $Options

func _ready():
	for i in player.get_children():
		i.get_node("HitboxComponent").connect("pressed", hit.bind( i))
	
	for i in enemies.get_children():
		i.get_node("SpriteComponent").scale.x = -1
		i.get_node("HitboxComponent").connect("pressed", hit.bind( i))

func hit(character):
	character.get_node("HitboxComponent").damage(hand.focus)
	hand.remove_card()
	
	

func _process(delta):
		
	for i in enemies.get_children():
		#enemies.get_child(i).position = Vector2(i*64, 0)
		#enemies.get_child(i).play("breathing")
		
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
	player_turn = not player_turn
	if not player_turn: #empty hand if going into enemy turn
		hand.empty_hand()
	else: #draw cards if going into player turn
		card_options.draw(5)   #replace 5 with draw amount later in development and feed it in as a bind to endturn press

