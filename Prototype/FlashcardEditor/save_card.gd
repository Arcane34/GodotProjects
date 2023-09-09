extends Node2D

const SAVE_FILE = "user://save_file.dat"
var g_data = []
@onready var cards = $ScrollContainer/CardContainer



func _ready():
	load_data()

func save_data():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(g_data)
	file.close()
	
func load_data():
	if not FileAccess.file_exists(SAVE_FILE):
		g_data = [[],[]]
		save_data()
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
	print(g_data)
	print("lol")



func _on_button_pressed():
	g_data = [[],[]]
	var cardObjects = cards.get_children()
	for i in len(cardObjects):
		g_data[0].append(cardObjects[i].get_node("HBoxContainer/Front").text)
		g_data[1].append(cardObjects[i].get_node("HBoxContainer/Back").text)
	
	save_data()


func _on_add_pressed():
	var scene = load("res://FlashcardEditor/flashcard.tscn")
	var instance = scene.instantiate()
	cards.add_child(instance)
	
