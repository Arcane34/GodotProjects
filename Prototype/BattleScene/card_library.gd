extends Control

@onready var hand = $Hand
@onready var card = Card.new()

func _ready():
	
	
	card.attack_damage = 5
	card.sprite_frames = load("res://addons/duelyst_animated_sprites/assets/spriteframes/icons/artifact_f1_ironbanner.tres")
	card._ready()
	hand.add_child(card.button)
	
	hand.add_child(Button.new())

func _process(delta):
	card._process(delta)
