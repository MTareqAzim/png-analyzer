extends HBoxContainer


func set_data(size: Vector2, num_of_colors: int):
	$Dimensions.text = "Dimensions: " + String(size.x) + " x " + String(size.y)
	$Colors.text = "Number of Colors: " + String(num_of_colors)
