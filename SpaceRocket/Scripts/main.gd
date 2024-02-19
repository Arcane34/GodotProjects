extends Node2D

var bubbleCol = Color(0.0,0.0,1.0,0.2)
@onready var bubble = $Bubble
@onready var player = $Player
@onready var nonGravArea = $Bubble/NonGravArea/NonGravArea
@onready var camera = $Camera2D
@onready var coins = $Coin
@onready var coinDeath = $Coin/CoinDeath
@onready var scoreLab = $CanvasLayer/Label

var outside = true
var coinSpawnRad = 400.0
var coinScene = load("res://Scenes/coin.tscn")
var coinsList = []
var score = 0
var curCoin = null
var coinVis = false

func _ready():
	bubble.position = Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2)
	camera.offset = bubble.position
	createCoin()
	
	
func createCoin():
	coinVis = true
	if len(coinsList) < 2:
		print("not enough coins")
		var vec = (Vector2.ONE * randf_range(0, coinSpawnRad)).rotated(randf_range(0, PI))
		var instance = coinScene.instantiate()
		instance.get_node("Area2D").connect("body_entered",destroyCoin.bind(instance))
		instance.position = vec + bubble.position
		coinsList.append(instance)
		coins.add_child(instance)
		curCoin = len(coinsList) - 1
	else:
		if curCoin != null:
			var prevCoin = coinsList[curCoin].position
			if curCoin == 0:
				curCoin = 1
			else:
				curCoin = 0
			var vec = (Vector2.ONE * randf_range(0, coinSpawnRad)).rotated(randf_range(0, PI))
			while (prevCoin - (vec + bubble.position)).length() < 200:
				vec = (Vector2.ONE * randf_range(0, coinSpawnRad)).rotated(randf_range(0, PI))
			coinsList[curCoin].position = vec + bubble.position
			coinsList[curCoin].get_node("Area2D").set_deferred("monitoring",true)
			coinsList[curCoin].visible = true
	
func destroyCoin(body,instance):
	coinVis = false
	if body == player:
		instance.get_node("Area2D").set_deferred("monitoring", false)
		coinDeath.position = instance.position
		instance.visible = false
		coinDeath.emitting = true
		score += 1
	scoreLab.text = "Score: " + str(score)
	
	
#func _draw():
	#draw_circle(Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2), 1000.0, bubbleCol)
	#draw_circle(Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2), 800.0, bubbleCol)
	

func _process(_delta):
	
	if !coinVis:
		createCoin()
	
	if outside:
		player.gravity_scale = floor((bubble.position - player.position).length() / 300.0)
	else:
		player.gravity_scale = 0
		
	
		


func _on_area_2d_body_exited(body):
	if body == player:
		player.gravity_scale = 1.0
		outside = true


func _on_non_grav_area_body_entered(body):
	if body == player:
		player.gravity_scale = 0.0
		outside = false

