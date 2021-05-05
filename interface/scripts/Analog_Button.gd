extends TouchScreenButton

var pos = position
var boundary = get_shape().radius
var threshold = 10
var ongoing_drag = -1
var radius = Vector2(92,92)

func get_pos():
	return radius + position
	
func _input(event):
	
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var event_dist_from_centre = (event.position - get_parent().global_position).length()
		if event_dist_from_centre <= boundary or ongoing_drag == event.get_index():	
			set_global_position(event.position - radius)
			if get_pos().length() > boundary:
				set_position(get_pos().normalized() * boundary - radius)
			ongoing_drag = event.get_index()
	
	if event is InputEventScreenTouch and !event.is_pressed() and event.get_index() == ongoing_drag:
		ongoing_drag = -1
		position = pos

func get_value():
	if get_pos().length() > threshold: 
		return (get_pos().normalized() * get_pos().length() / boundary)
	else:
		return Vector2(0, 0)
