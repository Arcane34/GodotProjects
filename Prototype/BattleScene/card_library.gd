extends Control

const ABILITIES_SAVE_FILE = "res://abilities/abilties.dat"
@onready var hand = $Hand
@onready var all_cards = $ScrollContainer/AllCards
@onready var data = {}

func _ready():
	load_cards()
	
	#hand.add_child(create_card(0))
	
#	var scene = load("res://BattleScene/card.tscn")
#
#	var dir = DirAccess.open("res://addons/duelyst_animated_sprites/assets/spriteframes/icons/")
#	dir.list_dir_begin()
#	var file_name = dir.get_next()
#	var counter = 0
#
#	while file_name != "":
#		var instance = scene.instantiate()
#		var resource = load("res://addons/duelyst_animated_sprites/assets/spriteframes/icons/" + file_name) 
#		instance.get_node("AnimatedSprite2D").sprite_frames = resource
#
#		var fileSplit = file_name.split("_")
#		var abName = fileSplit[fileSplit.size()-1].split(".")[0]
#
#
#		instance.get_node("Label").text = abName
#		all_cards.add_child(instance)
#
#		file_name = dir.get_next()
#		counter += 1
#	print(counter)
#

func _process(_delta):
	var h_cards = hand.get_children()
	
	
	for i in h_cards.size():
			if h_cards[i].is_hovered():
				h_cards[i].get_children()[0].play("active")
			else:
				if h_cards[i].get_children()[0].sprite_frames.get_animation_names()[0] == "active":
					h_cards[i].get_children()[0].play(String(h_cards[i].get_children()[0].sprite_frames.get_animation_names()[1]))
				else:
					h_cards[i].get_children()[0].play(String(h_cards[i].get_children()[0].sprite_frames.get_animation_names()[0]))

	var cards = all_cards.get_children()
	
	for i in cards.size():
			if cards[i].is_hovered():
				cards[i].get_children()[0].play("active")
			else:
				if cards[i].get_children()[0].sprite_frames.get_animation_names()[0] == "active":
					cards[i].get_children()[0].play(String(cards[i].get_children()[0].sprite_frames.get_animation_names()[1]))
				else:
					cards[i].get_children()[0].play(String(cards[i].get_children()[0].sprite_frames.get_animation_names()[0]))





func save_cards():
	var temp_cards = []
	
	
	var card = Ability.new()
	card.name = "Attack"
	card.attack_damage = 5.0
	card.path = "res://addons/duelyst_animated_sprites/assets/spriteframes/icons/artifact_f2_crescentspear.tres"
	card._ready()
	temp_cards.append(card)
	
	card = Ability.new()
	card.name = "Leech"
	card.status = "Drain"
	card.status_number = 10.0
	card.path = "res://addons/duelyst_animated_sprites/assets/spriteframes/icons/artifact_f2_bloodleechmask.tres"
	card._ready()
	temp_cards.append(card)
	
	
	data = {
		"names": [],
		"attack_damages": [],
		"status'": [],
		"status_numbers": [],
		"paths": []
	}
	
	for i in temp_cards:
		data["names"].append(i.name)
		data["attack_damages"].append(i.attack_damage)
		data["status'"].append(i.status)
		data["status_numbers"].append(i.status_number)
		data["paths"].append(i.path)
		
		
	var file = FileAccess.open(ABILITIES_SAVE_FILE, FileAccess.WRITE)
	file.store_var(data)
	file.close()
	print(data)

	


func load_cards():
	if not FileAccess.file_exists(ABILITIES_SAVE_FILE):
		print("running save ")
		save_cards()
	var file = FileAccess.open(ABILITIES_SAVE_FILE, FileAccess.READ)
	data = file.get_var()
	file.close()
	
	
	for n in data["names"].size():
		var card_node = create_card(n)
		all_cards.add_child(card_node.button)
		
	
	print(data)
	print("well")

func create_card(index: int) -> Ability:
	var card = Ability.new()
	card.name = data["names"][index]
	card.attack_damage = data["attack_damages"][index]
	card.status = data["status'"][index]
	card.status_number = data["status_numbers"][index]
	card.path = data["paths"][index]
	card._ready()
	return card


func _on_back_pressed():
	get_tree().change_scene_to_file("res://MainMenu/mainMenu.tscn")


func _on_save_pressed():
	save_cards()
	print(all_cards.get_child_count())
	for i in all_cards.get_child_count():
		all_cards.get_child(i).queue_free()
	load_cards()
