extends Control

@onready var player = $Player
@onready var enemies = $Enemies
@onready var hand = $Options/CardLibrary/Hand
@onready var player_turn = true #true = player's turn, else enemy turn
@onready var card_options = $Options
@onready var flashcard = $"Flashcard Test"


func _ready():
	# connecting hitbox buttons to allow card to be passed through to enemy and player objects
	for i in player.get_children():
		i.get_node("HitboxComponent").connect("pressed", hit.bind( i))
	
	# flipping the sprites of characters in the enemies section so they face backwards and binding a button here for the same reason
	for i in enemies.get_children():
		i.get_node("SpriteComponent").scale.x = -1
		i.get_node("HitboxComponent").connect("pressed", hit.bind( i))

func hit(character):
	# makes the flashcard object be visible and disables all background interactability (making it transparent a bit to make that clear)
	flashcard.visible = true
	for i in hand.get_children():
		i.disabled = true
	
	for j in 5:
		get_child(j).modulate.a = 0.5
	
	# the enemy or person the card is going to be used on
	flashcard.character = character
	
	
	
	

func _process(delta):
	
		
	
	# when a card is not selected enemies will be opaque
	for i in enemies.get_children():
		#enemies.get_child(i).position = Vector2(i*64, 0)
		#enemies.get_child(i).play("breathing")
		if hand.focus == null:
			i.modulate.a = 1
		# if an ability card is selected then enemies will be transparent unless hovered over
		else:
			if i.get_node("HitboxComponent").is_hovered():
				i.modulate.a = 1
			else:
				i.modulate.a = 0.7
		
		# enemy intentions being loaded on enemy turn and made visible on player turn
		if not player_turn:
			i.get_node("EnemyComponent").load_action()
			i.get_node("EnemyComponent").visible = false
		else:
			i.get_node("EnemyComponent").visible = true
				
	
	# if flashcard is visible it will end turn when the answer is hard, otherwise passes the card to the enemy dmg function
	if flashcard.visible:
		if flashcard.answer != "":
			if flashcard.answer == "hard":
				_on_end_turn_pressed()
			else:
				flashcard.character.get_node("SpriteComponent").state = "hit"
				flashcard.character.get_node("HitboxComponent").damage(hand.focus, flashcard.answer)
			
			#process for removing the card and disabling flashcard
			hand.remove_card()
			flashcard.answered()
			for i in hand.get_children():
				i.disabled = false
			for j in 5:
				get_child(j).modulate.a = 1



# change scene when you press the back button
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu/mainMenu.tscn")

func _on_end_turn_pressed():
	player_turn = not player_turn
	if not player_turn: #empty hand if going into enemy turn
		
		#put enemy actions logic here
		hand.empty_hand()
	else: #draw cards if going into player turn
		card_options.draw(5)   #replace 5 with draw amount later in development and feed it in as a bind to endturn press

