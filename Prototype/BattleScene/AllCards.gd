extends GridContainer

func _ready():
	var scene = load("res://BattleScene/card.tscn")
	
	var dir = DirAccess.open("res://addons/duelyst_animated_sprites/assets/spriteframes/icons/")
	dir.list_dir_begin()
	var file_name = dir.get_next()
	var counter = 0
	
	while file_name != "":
		var instance = scene.instantiate()
		var resource = load("res://addons/duelyst_animated_sprites/assets/spriteframes/icons/" + file_name) 
		instance.get_node("AnimatedSprite2D").sprite_frames = resource
		


			
		var fileSplit = file_name.split("_")
		var abName = fileSplit[fileSplit.size()-1].split(".")[0]
		
		
		instance.get_node("Label").text = abName
		self.add_child(instance)
		
		file_name = dir.get_next()
		
		
		counter += 1
	print(counter)
		
func _process(_delta):
	var cards = self.get_children()
	
	for i in cards.size():
			if cards[i].is_hovered():
				cards[i].get_children()[0].play("active")
			else:
				if cards[i].get_children()[0].sprite_frames.get_animation_names()[0] == "active":
					cards[i].get_children()[0].play(String(cards[i].get_children()[0].sprite_frames.get_animation_names()[1]))
				else:
					cards[i].get_children()[0].play(String(cards[i].get_children()[0].sprite_frames.get_animation_names()[0]))
