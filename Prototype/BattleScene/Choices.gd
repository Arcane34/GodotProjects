extends HBoxContainer

@onready var buttons = get_children()
@onready var playerGroup = $"../../Player"
var skillList = []


func _ready():
	skillList = playerGroup.get_child(0).skills
	

func _process(delta):
	
	for i in buttons.size():
		if i == 0:
			buttons[i].get_child(0).sprite_frames = load("res://addons/duelyst_animated_sprites/assets/spriteframes/icons/icon_f1_" + skillList[0] + ".tres")
		if buttons[i].is_hovered():
			buttons[i].get_children()[0].play("active")
		else:
			buttons[i].get_children()[0].play(buttons[i].get_children()[0].sprite_frames.get_animation_names()[1])



	
