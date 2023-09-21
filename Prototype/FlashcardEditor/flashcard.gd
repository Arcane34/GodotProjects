extends Control


#delete flashcard object when delete button pressed
func _on_delete_pressed():
	queue_free()
