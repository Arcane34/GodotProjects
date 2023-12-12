extends Node2D

const SAVE_FILE = "user://save_file.dat"
var g_data = []
@onready var cards = $Flashcards/CardContainer
@onready var title = $Title

#load flashcards
func _ready():
	load_data()

#store the g_data variable into a file 
func save_data():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(g_data)
	file.close()
	
# if the load of data is empty re-make the file with 2 empty lists, one for card fronts and one for card backs
func load_data():
	if not FileAccess.file_exists(SAVE_FILE):
		g_data = [[],[]]
		save_data()
		
	# load all flashcards and add them as children so they can be seen and interacted with
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	g_data = file.get_var()
	if not g_data.is_empty():
		var scene = load("res://FlashcardEditor/flashcard.tscn")
		
		for i in len(g_data[0]):
			var instance = scene.instantiate()
			instance.get_node("HBoxContainer/Front").text = g_data[0][i]
			instance.get_node("HBoxContainer/Back").text = g_data[1][i]
			cards.add_child(instance)
	
	file.close()
	

	

# add a new default flashcard scene to the list
func _on_add_pressed():
	var scene = load("res://FlashcardEditor/flashcard.tscn")
	var instance = scene.instantiate()
	cards.add_child(instance)
	

# save the current flashcards into the save file, overwriting all changes
func _on_save_pressed():
	g_data = [[],[]]
	var cardObjects = cards.get_children()
	for i in len(cardObjects):
		g_data[0].append(cardObjects[i].get_node("HBoxContainer/Front").text)
		g_data[1].append(cardObjects[i].get_node("HBoxContainer/Back").text)
	
	save_data()

# go to main menu
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://MainMenu/mainMenu.tscn")


func _on_back_pressed():
	if title.text == "Decks":
		get_tree().change_scene_to_file("res://MainMenu/mainMenu.tscn")
	else:
		title.text = "Decks"
