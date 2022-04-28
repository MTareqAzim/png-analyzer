extends Control

var image_dnd = load("res://scenes/ImageDnD.tscn")
var image_picker = load("res://scenes/ImagePicker.tscn")
var image_analysis = load("res://scenes/ImageAnalysis.tscn")

var drag = load("res://art/scroll_move.png")

var current_scene : Node = null


func _ready():
	var scene = image_dnd.instance()
	add_child(scene)
	current_scene = scene
	
	Input.set_custom_mouse_cursor(drag, Input.CURSOR_DRAG)


func import_image(error):
	var scene = _update_scene(image_dnd)
	
	scene.show_error(error)


func pick_image(files):
	var scene = _update_scene(image_picker)
	
	scene.pick_image(files)


func analyze_image(image):
	var scene = _update_scene(image_analysis)
	
	scene.analyze_image(image)


func _update_scene(scene_to_instance) -> Node:
	var scene = scene_to_instance.instance()
	
	add_child(scene)
	current_scene.queue_free()
	current_scene = scene
	
	return scene
