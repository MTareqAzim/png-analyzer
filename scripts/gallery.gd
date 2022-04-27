extends GridContainer

export var image_picker_path : NodePath
onready var image_picker = get_node(image_picker_path)


func selected_image(image: Image):
	image_picker.selected_image(image)
