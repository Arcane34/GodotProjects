extends Node2D

#@onready var characters = get_children()
#@onready var start = [4*PI/3, 4*PI/3]
#@onready var offset = [250, 30]
#@onready var choose = false
#@onready var rotate = 0
#
#func _ready():
#	for i in characters.size():
#		characters[i].scale.x = -1
#
#func _process(delta):
#
#	for i in characters.size():
#		characters[i].play("idle")
#		characters[i].modulate.a = 1
#		if i == 0:
#			characters[i].position = Vector2(60*sin(start[0])+60 + offset[0], -40*cos(start[1])+40 + offset[1])
#		elif i == 1:
#			characters[i].position = Vector2(60*sin(start[0]+(2*PI/3))+60 + offset[0], -40*cos(start[1]+(2*PI/3))+40 + offset[1])
#			if choose:
#				characters[i].modulate.a = 0.4
#		elif i == 2:
#			characters[i].position = Vector2(60*sin(start[0]+(4*PI/3))+60 + offset[0], -40*cos(start[1]+(4*PI/3))+40 + offset[1])
#			if choose:
#				characters[i].modulate.a = 0.4
#
#
#	var x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	if choose:
#		if x > 0:
#			rotate = 1
#		elif x < 0:
#			rotate = -1
#
#		if rotate > 0:
#			if start[0] < (6*PI/3):
#				start[0] += 0.05
#				start[1] += 0.05
#			else:
#				rotate = 0
#				start = [4*PI/3, 4*PI/3]
#				characters.insert(0,characters.pop_back())
#		if rotate < 0:
#			if start[0] > (2*PI/3):
#				start[0] -= 0.05
#				start[1] -= 0.05
#			else:
#				rotate = 0
#				start = [4*PI/3, 4*PI/3]
#				characters.append(characters.pop_front())
#
#


func _on_attack_pressed():
	var choose = true
