extends RigidBody2D


func _physics_process(delta):
	if is_in_group("stone"):
		gravity_scale = 50
#		yield(get_tree().create_timer(5), "timeout")
#		sleeping = true
