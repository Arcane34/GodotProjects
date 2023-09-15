extends HBoxContainer



func _on_button_pressed():
	self.get_child(0).grab_focus()


func _on_button_2_pressed():
	self.get_child(1).grab_focus()


func _on_button_3_pressed():
	self.get_child(2).grab_focus()
