extends HBoxContainer

@onready var buttons = get_children()


func _process(delta):
	for i in buttons.size():
		if buttons[i].is_hovered():
			buttons[i].get_children()[0].play("active")
		else:
			buttons[i].get_children()[0].play("default")



	
