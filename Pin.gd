extends KinematicBody2D



var offset : Vector2
var first_position = Vector2.ZERO


# Player dragging flag
var drag_enabled = false



export var maxDragDistance = 200;

var startingPosition;
var startDraggingOffset;
var isDragging;
var lastMouseWorldPosition;
var newMouseWorldPosition;




func _ready():
	first_position = position


func _physics_process(delta):
	var temp = get_local_mouse_position().x + offset.x
	var second_position = get_global_transform().affine_inverse() * get_parent().get_global_transform()
	if drag_enabled:
		translate(transform.basis_xform(Vector2(temp, 0)))
#		Vector between the starting position and the new position
		var length = position - first_position
#		the local right vector 
		var lengthDot = length.dot(transform.basis_xform(Vector2.RIGHT))

#		Clamp the position of the pin
		if lengthDot > 0:
			position = first_position
		else:
			if length.length() > maxDragDistance:
				position = first_position + length.normalized() * maxDragDistance




func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			drag_enabled = false


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			lastMouseWorldPosition = get_global_mouse_position()
			drag_enabled = event.pressed
			offset = position - get_global_mouse_position()


