extends HBoxContainer

signal highlight_color(color)
signal copy_color(color)

var color : Color


func set_data(color_data: Array, total_pixels):
	var transparency : String = color_data[0].left(2)
	var hex_value : String = color_data[0].right(2)
	var usage_percent : float = color_data[1] / float(total_pixels) * 100.0
	
	var transparency_value = 100.0 - (("0x" + transparency).hex_to_int() / 255.0 * 100.0)
	
	color = Color(color_data[0])
	
	$Border/Color.color = color
	$Usage.text = String(usage_percent).pad_decimals(2)
	$Hex.text = "#" + hex_value.to_upper()
	
	if transparency_value < 0.01:
		$Transparency.text = "No Transparency"
	else:
		$Transparency.text = String(transparency_value).pad_decimals(0) + "% Transparent"
	
	$Red.text = String(color.r8)
	$Green.text = String(color.g8)
	$Blue.text = String(color.b8)


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			emit_signal("highlight_color", color)
		
		if event.button_index == BUTTON_RIGHT:
			emit_signal("copy_color", color)
