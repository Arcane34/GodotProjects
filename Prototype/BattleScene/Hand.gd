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
			print(focus.name)

func remove_card():
	var index = cards.find(focus)
	if index != -1:
		print(index)
		cards.remove_at(index)
		get_child(index).queue_free()
	focus = null
	
func empty_hand():
	var temp_num = cards.size()
	cards = []
	for i in temp_num:
		get_child(i).queue_free()
