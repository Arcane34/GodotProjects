extends CanvasLayer

const SAVE_FILE = "user://save_file.dat"
var g_data = []
var order = []
var card_front = ""
var card_back = ""
var answer = ""
var character
@onready var card = $Card

func _ready():
	var file = FileAccess.open(SAVE_FILE, FileAccess.READ)
	g_data = file.get_var()
	file.close()
	for i in g_data[0].size():
		order.append(i)
	order.shuffle()
	choose()
	card.text = card_front

func choose():
	var cardNum = order[0]
	card_front = g_data[0][cardNum]
	card_back = g_data[1][cardNum]
	answer = ""

	
	
# func answer will pop the current card and insert it later in the array
	


func _on_flip_pressed():
	if card.text == card_front:
		card.text = card_back
	else:
		card.text = card_front


func _on_hard_pressed():
	answer = "hard"


func _on_ok_pressed():
	answer = "ok"


func _on_good_pressed():
	answer = "good"


func _on_easy_pressed():
	answer = "easy"
	
func answered():
	if answer == "easy":
		order.insert(order.size()-1, order.pop_front())
		
	if answer == "good":
		order.insert(min(10,order.size()-1), order.pop_front())
		
	if answer == "ok":
		order.insert(min(4,order.size()-1), order.pop_front())
		
	if answer == "hard":
		order.insert(min(2,order.size()-1), order.pop_front())
	
	answer = ""
	self.visible = false
