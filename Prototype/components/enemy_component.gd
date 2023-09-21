extends Node2D

@export var actions = ["A:16","A:8","D:20"]
@onready var intention = $Intention
@onready var value = $Value

# loads the intention of enemies and displays it as a change in colour of the icon currently
func load_action():
	if actions.size() > 0:
		print(actions)
		actions.append(actions.pop_front())
		
		var current_action = actions[0].split(":")
		if current_action[0] == "A":
			intention.modulate.g = 0
			intention.modulate.b = 0
		else:
			intention.modulate.g = 255
			intention.modulate.b = 255
		value.text = current_action[1]
		
	
