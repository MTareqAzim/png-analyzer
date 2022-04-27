extends ScrollContainer

export(int) var vertical_increment = 10
export(int) var horizontal_increment = 10

var rect_pos : Vector2
var rect_bottom_right_pos : Vector2

var left_click_held : bool = false


func _ready():
	rect_pos = rect_global_position
	rect_bottom_right_pos = rect_pos + rect_size


func _input(event):
	if event is InputEventMouse:
		var mouse_pos = event.global_position
		var within_horizontal = mouse_pos.x >= rect_pos.x and mouse_pos.x <= rect_bottom_right_pos.x
		var within_vertical = mouse_pos.y >= rect_pos.y and mouse_pos.y <= rect_bottom_right_pos.y
		
		if within_horizontal and within_vertical:
			if event is InputEventMouseButton:
				if event.control:
					if event.button_index == BUTTON_WHEEL_DOWN:
						_scroll_horizontal(horizontal_increment)
					if event.button_index == BUTTON_WHEEL_UP:
						_scroll_horizontal(-horizontal_increment)
				else:
					if event.button_index == BUTTON_WHEEL_DOWN:
						_scroll_vertical(vertical_increment)
					if event.button_index == BUTTON_WHEEL_UP:
						_scroll_vertical(-vertical_increment)
			
			if event is InputEventMouseButton:
				if event.is_pressed() and event.button_index == BUTTON_LEFT:
					left_click_held = true
	
	if event is InputEventMouseMotion:
		if left_click_held:
			var relative_distance = event.relative
			_scroll_horizontal(round(-relative_distance.x))
			_scroll_vertical(round(-relative_distance.y))
	
	if event is InputEventMouseButton:
		if left_click_held:
			if !event.is_pressed() and event.button_index == BUTTON_LEFT:
				left_click_held = false


func _scroll_vertical(increment):
	scroll_vertical = scroll_vertical + increment


func _scroll_horizontal(increment):
	scroll_horizontal = scroll_horizontal + increment
