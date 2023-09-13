extends Node2D

@onready var characters = get_children()
@onready var start = [PI/3, PI/3]
@onready var offset = [30, 50]
@onready var switch = false

func _ready():
	for i in characters.size():
		characters[i].get_children()[1].disabled = true
		characters[i].get_children()[1].visible = true
		

func _process(delta):
	for i in characters.size():
		if i == 0:
			characters[i].position = Vector2(60*sin(start[0])+60 + offset[0], -40*cos(start[1])+40 + offset[1])
			characters[i].play("idle")
			characters[i].modulate.a = 1
		elif i == 1:
			characters[i].position = Vector2(60*sin(start[0]+(2*PI/3))+60 + offset[0], -40*cos(start[1]+(2*PI/3))+40 + offset[1])
			characters[i].play("breathing")
			characters[i].modulate.a = 0.4
		elif i == 2:
			characters[i].position = Vector2(60*sin(start[0]+(4*PI/3))+60 + offset[0], -40*cos(start[1]+(4*PI/3))+40 + offset[1])
			characters[i].play("breathing")
			characters[i].modulate.a = 0.4

	if switch :
		if start[0] < (3*PI/3):
			start[0] += 0.05
			start[1] += 0.05
		else:
			start = [PI/3, PI/3]
			characters.insert(0,characters.pop_back())
			switch = false
	print(characters[0].skills)

func _on_end_turn_pressed():
	switch = true
	
