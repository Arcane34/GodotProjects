extends HBoxContainer

var cards = []
var focus = null

func _process(delta):
	for i in get_children():
		if not i.is_connected("pressed",on_pressed):
			i.connect("pressed", on_pressed.bind(i))
			print(i.text)

func on_pressed(button):
	for i in cards:
		if i.button == button:
			focus = i
			
	
