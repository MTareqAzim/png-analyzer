extends Control

const HIGHLIGHT : Color = Color(0.5, 0.5, 0.9, 0.2)
const TRANSPARENT : Color = Color(0, 0, 0, 0)

signal highlighted(node)
signal highlight_color(color)
signal copy_color(color)

var color : Color

onready var background : ColorRect = $BG


func set_data(color_data: Array, total_pixels):
	var transparency : String = color_data[0].left(2)
	var hex_value : String = color_data[0].right(2)
	var usage_percent : float = color_data[1] / float(total_pixels) * 100.0
	
	var transparency_value = 100.0 - (("0x" + transparency).hex_to_int() / 255.0 * 100.0)
	
	color = Color(color_data[0])
	
	$VBC/Border/Color.color = color
	$VBC/Usage.text = String(usage_percent).pad_decimals(2)
	$VBC/Hex.text = "#" + hex_value.to_upper()
	
	if transparency_value < 0.01:
		$VBC/Transparency.text = "No Transparency"
	else:
		$VBC/Transparency.text = String(transparency_value).pad_decimals(0) + "% Transparent"
	
	$VBC/Red.text = String(color.r8)
	$VBC/Green.text = String(color.g8)
	$VBC/Blue.text = String(color.b8)


func highlight():
	background.color = HIGHLIGHT


func deselect():
	background.color = TRANSPARENT


func _on_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			emit_signal("highlight_color", color)
			emit_signal("highlighted", self)
		
		if event.button_index == BUTTON_RIGHT:
			emit_signal("copy_color", color)
