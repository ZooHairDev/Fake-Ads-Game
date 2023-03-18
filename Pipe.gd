extends Node2D

var pointA_drag = false
var pointB_drag = false
var point_end = false
var is_colliding_end = false
var target = null

signal pipe_done


#get surface 0 into mesh data tool
#func _ready():
#	var mdt = MeshDataTool.new() 
#	var nd = $MeshInstance2D
#	var m = nd.mesh
#	mdt.create_from_surface(m, 0)
#	print(mdt.get_vertex_count())
#	for vtx in range(mdt.get_vertex_count()):
#		var vert = mdt.get_vertex(vtx)
#		print("global vertex: "+str(nd.global_transform.xform(vert)))

func _physics_process(_delta):
	if pointB_drag:
		$PointB.position = get_local_mouse_position()
	else:
		if is_colliding_end:
			emit_signal("pipe_done")
			point_end = true
			$PointB.global_position = target.global_position
			$PointB.global_rotation_degrees = target.global_rotation_degrees

	$Polygon2D.polygon[0] = $PointA/A1.global_position
	$Polygon2D.polygon[3] = $PointA/A2.global_position
	$Polygon2D.polygon[1] = $PointB/B1.global_position
	$Polygon2D.polygon[2] = $PointB/B2.global_position
#	if pointA_drag:
#		$PointA.position = get_global_mouse_position()

func _on_PointA_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			pointA_drag = event.pressed


func _on_PointB_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and !point_end:
			pointB_drag = event.pressed


func _on_PointB_body_entered(body):
	if body.is_in_group("point end"):
		target = body
		is_colliding_end = true


func _on_PointB_body_exited(body):
	if body.is_in_group("point end"):
#		target = null
		is_colliding_end = false
