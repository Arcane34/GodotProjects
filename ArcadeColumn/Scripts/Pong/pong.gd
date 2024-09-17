extends Node2D

@onready var player = $Player
@onready var opponent = $Opponent
@onready var playScore = $Background/PlayerScore
@onready var oppoScore = $Background/OpponentScore

var score = 0
var opponent_score = 0
var reset = false
var scene = load("res://Scenes/Pong/ball.tscn")
var instance = scene.instantiate()
var speed = 150
var finished = false
var pointList

func _ready():
	print(get_viewport())
	pointList = []
	var sections = 8
	for i in sections*2:
		pointList.append(Vector2(160, i*(180/(sections*2-1) ) ) )
		
			 
	

func _physics_process(_delta):
	player.position.y = clamp((Input.get_action_strength("down") - Input.get_action_strength("up")) + player.position.y, 22, 158)
	if !(instance in get_children()):
		instance.position = Vector2(160,90)
		instance.linear_velocity = Vector2(randf_range(0.5,1)* (1-randi_range(0,1)*2),randf_range(-1,1)).normalized() * speed
		add_child(instance)
	else:
		if instance.position.y > opponent.position.y + 10:
			opponent.position.y = clamp(opponent.position.y + 1, 22, 158)
		elif instance.position.y < opponent.position.y - 10:
			opponent.position.y = clamp(opponent.position.y - 1, 22, 158)
		
			
	
	if instance.oob:
		instance.oob = false
		if instance.position.x < 30:
			opponent_score += 1
			oppoScore.text = str(opponent_score)
		elif instance.position.x > 200:
			score += 1
			playScore.text = str(score)
		
		if max(score,opponent_score) > 8:
			finished = true
			
		remove_child(instance)


func _draw():
	draw_multiline(pointList,Color(255,255,255,255), 1.0)

