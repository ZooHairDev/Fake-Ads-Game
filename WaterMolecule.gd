extends RigidBody2D

signal lava_touch(node1, node2)

#enum {DRAW_MODE_BLOB, DRAW_MODE_PRESSURE, DRAW_MODE_VISCOSITY}
#
#var display_mode = DRAW_MODE_BLOB
#var particle_mat = CanvasItemMaterial.new()


#func _physics_process(delta):
#	if is_in_group("stone"):
#		set_collision_layer_bit(0, false)
#		set_collision_layer_bit(4, true)
#		set_collision_mask_bit(0, false)
#		set_collision_mask_bit(4, true)
#		set_collision_layer(5)
#		set_collision_mask(5)
#		collision_mask = 5
#		gravity_scale = 3
#		yield(get_tree().create_timer(5), "timeout")
#		sleeping = true


func _on_WaterMolecule_body_entered(body):
	if body.is_in_group("lava"):
		if is_in_group("coin"):
			self.queue_free()
			get_node("/root/World").coins_destroyed += 1
			get_node("/root/World").coins_collected -= 1
		elif is_in_group("water"):
			emit_signal("lava_touch", self, body)
			body.remove_from_group("lava")
			body.add_to_group("stone")
			add_to_group("stone")
			remove_from_group("water")
