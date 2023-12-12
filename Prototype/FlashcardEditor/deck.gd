extends Control


func _on_delete_pressed():
	queue_free()


func _on_open_pressed():
	print(get_parent().name)
