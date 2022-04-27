extends Control

var color_info = load("res://scenes/ColorInfo.tscn")

var colors : Array = []
var total_number_of_pixels : int = 0

onready var preview : TextureRect = $HBoxContainer/Preview/VBoxContainer/ScrollContainer/ImagePreview
onready var highlighter : TextureRect = $HBoxContainer/Preview/VBoxContainer/ScrollContainer/ImagePreview/PixelHighlighter
onready var confirmation : ConfirmationDialog = $ConfirmationDialog
onready var image_info : HBoxContainer = $HBoxContainer/Analysis/VBoxContainer/ImageInfo
onready var analysis : VBoxContainer = $HBoxContainer/Analysis/VBoxContainer/ScrollContainer/VBoxContainer
onready var copy_color : PopupMenu = $CopyColor


func analyze_image(image: Image):
	_preview_image(image)
	_initialize_pixel_highlighter(image)
	_analyze_image(image)
	_populate_analysis(image)


func _preview_image(image: Image):
	var image_texture = ImageTexture.new()
	image_texture.create_from_image(image, 0)
	preview.set_texture(image_texture)
	preview.calculate_max_zoom_level()


func _initialize_pixel_highlighter(image: Image):
	highlighter.initialize(image)


func _analyze_image(image: Image):
	total_number_of_pixels = image.get_width() * image.get_height()
	
	image.lock()
	var colors_dict : Dictionary = {}
	for x_value in image.get_width():
		for y_value in image.get_height():
			var pixel = image.get_pixel(x_value, y_value)
			var html = pixel.to_html()
			
			if colors_dict.has(html):
				colors_dict[html] = colors_dict[html] + 1
			else:
				colors_dict[html] = 1
	
	image.unlock()
	
	for color in colors_dict:
		colors.append([color, colors_dict[color]])
	
	colors.sort_custom(ColorsArraySorter, "sort_descending")


class ColorsArraySorter:
	static func sort_descending(a, b):
		if a[1] > b[1]:
			return true
		return false


func _populate_analysis(image: Image):
	image_info.set_data(image.get_size(), colors.size())
	
	for color in colors:
		var color_info_instance = color_info.instance()
		color_info_instance.set_data(color, total_number_of_pixels)
		
		analysis.add_child(color_info_instance)
		
		color_info_instance.connect("highlight_color", self, "_highlight_color")
		color_info_instance.connect("copy_color", self, "_copy_color")


func _highlight_color(color: Color):
	highlighter.highlight_color(color)


func _remove_highlight():
	highlighter.hide()


func _copy_color(color: Color):
	copy_color.set_color(color)
	copy_color.popup(Rect2(get_global_mouse_position(), Vector2(30, 20)))


func _on_NewImage_pressed():
	confirmation.popup_centered()


func _on_ConfirmationDialog_confirmed():
	get_parent().import_image()


func _on_RemoveHighlights_pressed():
	_remove_highlight()
