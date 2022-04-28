extends Control

var gallery_image_preview = load("res://scenes/GalleryImagePreview.tscn")

onready var gallery = $Background/GalleryMargins/VBoxContainer/Gallery


func pick_image(files: PoolStringArray):
	_display_images(files)


func _display_images(files: PoolStringArray):
	for file in files:
		var texture_rect = gallery_image_preview.instance()
		var image_texture = ImageTexture.new()
		var image = Image.new()
		
		image.load(file)
		image_texture.create_from_image(image, 0)
		texture_rect.set_texture(image_texture)
		
		gallery.add_child(texture_rect)


func selected_image(image: Image):
	get_parent().analyze_image(image)
