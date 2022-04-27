extends TextureRect

const MAX_IMAGE_LENGTH : int = 5000
const MIN_ZOOM_LEVEL : int = 1

var max_zoom_level : int = 1
var zoom_level : int = 1

onready var highlighter : TextureRect = $PixelHighlighter


func calculate_max_zoom_level():
	var texture_size = texture.get_size()
	var x_max_zoom_level = floor(MAX_IMAGE_LENGTH / texture_size.x)
	var y_max_zoom_level = floor(MAX_IMAGE_LENGTH / texture_size.y)
	
	max_zoom_level = min(x_max_zoom_level, y_max_zoom_level)
	max_zoom_level = max(max_zoom_level, 1.0)


func get_zoom_level() -> int:
	return zoom_level


func _zoom_in():
	zoom_level = zoom_level + 1
	zoom_level = int(min(zoom_level, max_zoom_level))
	
	_zoom()


func _zoom_out():
	zoom_level = zoom_level - 1
	zoom_level = int(max(zoom_level, MIN_ZOOM_LEVEL))
	
	_zoom()


func _zoom():
	rect_min_size = texture.get_size() * zoom_level
	highlighter.set_zoom_level(zoom_level)


func _on_ZoomIn_pressed():
	_zoom_in()


func _on_ZoomOut_pressed():
	_zoom_out()
