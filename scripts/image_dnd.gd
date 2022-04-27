extends PanelContainer

const IMAGE_EXTENSIONS = ["png"]


func _ready():
	var _signal_connection_error = get_tree().connect("files_dropped", self, "_on_files_dropped")


func _on_files_dropped(files : PoolStringArray, _screen : int):
	var image_files : PoolStringArray = _retrieve_image_files(files)
	_pick_image(image_files)


func _retrieve_image_files(files : PoolStringArray) -> PoolStringArray:
	var image_files = PoolStringArray()
	
	for file in files:
		var file_extension = file.get_extension()
		
		if file_extension in IMAGE_EXTENSIONS:
			image_files.append(file)
	
	return image_files


func _pick_image(image_files : PoolStringArray):
	if image_files.size() > 1:
		get_parent().pick_image(image_files)
	elif image_files.size() == 1:
		var image = Image.new()
		image.load(image_files[0])
		get_parent().analyze_image(image)
