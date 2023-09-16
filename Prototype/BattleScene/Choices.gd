extends CanvasLayer

@onready var buttons = get_children()
@onready var playerGroup = $"../Player"
@onready var card_lib = $CardLibrary
var skillList = []


func _ready():
	card_lib.get_child(1).position.y = -300
	card_lib.get_child(2).position.y = -25
	card_lib.get_child(3).position.y = -25
	
	skillList = playerGroup.get_child(0).skills
	for i in skillList:
		var ability = card_lib.create_card(i)
		card_lib.hand.cards.append(ability)
		card_lib.hand.add_child(ability.button)
	




	
