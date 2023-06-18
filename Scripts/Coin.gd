extends RigidBody2D



func _on_Coin_body_entered(body):
	if body.is_in_group("lava"):
		self.queue_free()
