extends Node2D

@onready var rewards = ["FGF See Progress", "Add to FGF", "Rain World \n 2 Cycles", "Celeste 30 Lives",
 "20 Pushups", "Run", "Work on\nPortfolio", "Work on\nVillage Sidebar", "Work on\nPocket Tasks",
"Work on\nShaders", "Sketch", "Pixelart", "Cross Stitch", "Anki", "Duolingo", "Read\nORV", "Read\nGTO",
"Watch\nSteins Gate", "Meetup with people", "Listen to music and chill", "Nap", "Read Solo Levelling",
"Read Eleceed", "Get Pizza this week"]
@onready var out = $Output

func _ready():
	rewards.shuffle()
	out.text = "You got:\n" + rewards[0]


func _on_spin_pressed():
	rewards.shuffle()
	out.text = "You got:\n" + rewards[0]
