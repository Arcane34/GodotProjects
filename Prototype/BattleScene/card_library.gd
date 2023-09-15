extends Control

@onready var hand = $Hand
@onready var card = Ability.new()

#func _ready():
#
#	card.attack_damage = 5.0
#	card.name = "Attack"
#	card.path = "res://addons/duelyst_animated_sprites/assets/spriteframes/icons/artifact_f2_crescentspear.tres"
#	card._ready()
#	hand.add_child(card.button)
#



func _process(_delta):
	var cards = hand.get_children()
	
	for i in cards.size():
			if cards[i].is_hovered():
				cards[i].get_children()[0].play("active")
			else:
				if cards[i].get_children()[0].sprite_frames.get_animation_names()[0] == "active":
					cards[i].get_children()[0].play(String(cards[i].get_children()[0].sprite_frames.get_animation_names()[1]))
				else:
					cards[i].get_children()[0].play(String(cards[i].get_children()[0].sprite_frames.get_animation_names()[0]))





func _on_back_pressed():
	get_tree().change_scene_to_file("res://MainMenu/mainMenu.tscn")
