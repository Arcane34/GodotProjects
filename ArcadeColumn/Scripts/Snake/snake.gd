extends Node2D


@onready var player = $Player
@onready var coins = $Apples
@onready var coinDeath = $Coin/CoinDeath
@onready var scoreLab = $ScoreLabel
var segment = load("res://Scenes/Snake/segment.tscn")
var done = false
@onready var segments = $Segments

#@onready var bubble = $SubViewportContainer/SubViewport/Bubble
#@onready var player = $SubViewportContainer/SubViewport/Player
#@onready var nonGravArea = $SubViewportContainer/SubViewport/Bubble/NonGravArea/NonGravArea
#@onready var camera = $Camera2D
#@onready var coins = $SubViewportContainer/SubViewport/Coin
#@onready var coinDeath = $SubViewportContainer/SubViewport/Coin/CoinDeath
#@onready var scoreLab = $SubViewportContainer/SubViewport/CanvasLayer/Label

var outside = true
var coinScene = load("res://Scenes/Snake/apple.tscn")
var coinsList = []
var score = 0
var curCoin = null
var coinVis = false

func _ready():
	createCoin()
	
	
func createCoin():
	coinVis = true
	if len(coinsList) < 2:
		print("not enough coins")
		var vec = Vector2(randf_range(0,160), randf_range(0,160))
		var instance = coinScene.instantiate()
		instance.get_node("Area2D").connect("body_entered",destroyCoin.bind(instance))
		instance.position = vec
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
			var vec = Vector2(randf_range(0,160), randf_range(0,160))
			while (prevCoin - (vec )).length() < 200:
				vec = Vector2(randf_range(0,160), randf_range(0,160))
			coinsList[curCoin].position = vec 
			coinsList[curCoin].get_node("Area2D").set_deferred("monitoring",true)
			coinsList[curCoin].visible = true
	
func destroyCoin(body,instance):
	coinVis = false
	if body == player:
		instance.get_node("Area2D").set_deferred("monitoring", false)
		#coinDeath.position = instance.position
		instance.visible = false
		#coinDeath.emitting = true
		score += 1
	scoreLab.text = "Score: " + str(score)
	
	
#func _draw():
	#draw_circle(Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2), 1000.0, bubbleCol)
	#draw_circle(Vector2(get_viewport_rect().size.x/2,get_viewport_rect().size.y/2), 800.0, bubbleCol)
	

func _process(_delta):
	
	if !coinVis:
		createCoin()
	
	if len(player.positions) > 20 * player.length:
		
		if not done:
			for i in player.length:
				var segmentInstance = segment.instantiate()
				segmentInstance.position = player.positions[-20*i]
				segments.add_child(segment.instantiate())
			done = true
		else:
			for i in segments.get_child_count():
				segments.get_child(i).position = player.positions[-20*(i+1)]
				print(i, player.positions[-5*i])
		

	
