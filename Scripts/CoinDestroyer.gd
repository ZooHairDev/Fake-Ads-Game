extends Area2D



func _on_Area2D_body_entered(body):
	if body.is_in_group("coin"):
		get_parent().coins_destroyed += 1
		get_parent().coins_collected -= 1

