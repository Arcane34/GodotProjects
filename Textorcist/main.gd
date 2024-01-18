extends Node2D

@onready var label = $RichTextLabel
@onready var mistake = $Label
var written = ""
var notWritten = "Lets type like our life depends on it"
var mistakes = 0

func _ready():
	label.text = "[color=blue]" + written + "[/color]" + notWritten
	mistake.text = "Mistakes = " + str(mistakes)

		
func _input(event):
	if event is InputEventKey and event.pressed:
		while notWritten[0] == " ":
			written += notWritten[0]
			notWritten = notWritten.substr(1,len(notWritten))
			
		print(event.as_text_keycode())
		if event.as_text_keycode() == notWritten[0].capitalize():
			written += notWritten[0]
			notWritten = notWritten.substr(1,len(notWritten))
			
		else:
			mistakes += 1
			mistake.text = "Mistakes = " + str(mistakes)
			
	
	label.text = "[color=blue]" + written + "[/color]" + notWritten
		
