extends TextureRect

const TRANSPARENT_OVERLAY := Color(0, 0, 0, 0.6)
const HIGHLIGHT := Color(1, 0, 0)

var base_image : Image
var zoom_level : int = 1


func initialize(image: Image):
	base_image = image
	hide()


func highlight_color(color: Color):
	var image : Image = base_image.duplicate()
	
	image.lock()
	for x_value in image.get_width():
		for y_value in image.get_height():
			if image.get_pixel(x_value, y_value) == color:
				image.set_pixel(x_value, y_value, HIGHLIGHT)
			else:
				image.set_pixel(x_value, y_value, TRANSPARENT_OVERLAY)
	image.unlock()
	
	var image_texture = ImageTexture.new()
	image_texture.create_from_image(image, 0)
	texture = image_texture
	set_zoom_level(get_parent().get_zoom_level())
	show()


func set_zoom_level(new_zoom_level):
	zoom_level = new_zoom_level
	_zoom()


func _zoom():
	if texture:
		rect_min_size = texture.get_size() * zoom_level
