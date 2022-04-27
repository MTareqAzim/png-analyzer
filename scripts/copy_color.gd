extends PopupMenu

const COPY_HEX_VALUE : int = 0

var color : Color


func _ready():
	add_item("Copy Hex Value", COPY_HEX_VALUE)


func set_color(new_color):
	color = new_color


func _on_id_pressed(id):
	if id == COPY_HEX_VALUE:
		OS.clipboard = color.to_html(false)
