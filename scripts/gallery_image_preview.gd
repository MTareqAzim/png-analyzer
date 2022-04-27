extends TextureRect

onready var highlight = $Highlight


func _on_focus_entered():
	highlight.show()


func _on_focus_exited():
	highlight.hide()


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.doubleclick:
			var image = texture.get_data()
			get_parent().selected_image(image)
