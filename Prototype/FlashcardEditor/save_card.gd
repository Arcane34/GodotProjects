extends Node2D

const SAVE_FILE = "user://save_file.dat"
var g_data = {}
@onready var Cfront = $CardFront
@onready var Cback = $CardBack

func _ready():
	load_data()

func save_data():
	var file = FileAccess.open(SAVE_FILE, FileAccess.WRITE)
	file.store_var(g_data)
	file.close()
	
func load_data():
	if not FileAccess.file_exists(SAVE_FILE):
		g_data = {
			"front": "",
			"back":""
		}
		save_data()
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	var g_data = file.get_var()
	Cfront.text = g_data.front
	Cback.text = g_data.back
	file.close()
	print(g_data)
	print("lol")



func _on_button_pressed():
	g_data.front = Cfront.text
	g_data.back = Cback.text
	save_data()
