extends HBoxContainer

var cards = []

# the card that was selected last
var focus = null

# create a connection for all the children cards that haven't been connected to the function 
func _process(delta):
	for i in get_children():
		if not i.is_connected("pressed",on_pressed):
			i.connect("pressed", on_pressed.bind(i))
			print(i.text)

# function that gets a button to change the focus to itself from the cards list when pressed
func on_pressed(button):
	for i in cards:
		if i.button == button:
			focus = i
			print(focus.name)

# remove the card that was in focus before and reset the focus
func remove_card():
	var index = cards.find(focus)
	if index != -1:
		print(index)
		cards.remove_at(index)
		get_child(index).queue_free()
	focus = null
	
# remove all cards from the hand (used when turn ends usually)
func empty_hand():
	var temp_num = cards.size()
	cards = []
	for i in temp_num:
		get_child(i).queue_free()
