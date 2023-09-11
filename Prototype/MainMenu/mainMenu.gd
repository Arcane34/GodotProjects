extends Control


func _on_play_pressed():
	get_tree().change_scene_to_file("res://BattleScene/battle.tscn")


func _on_editor_pressed():
	get_tree().change_scene_to_file("res://FlashcardEditor/flashEditor.tscn")


func _on_quit_pressed():
	get_tree().quit()
