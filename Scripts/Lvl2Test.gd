extends Node2D

var coins_destroyed = 0
var coins_collected = 0
var sent = false

signal winState(value)

func _ready():
	GameManager.current_lvl = 2
	$WaterLayer.custom_viewport = $WaterViewport/Viewport
	$LavaLayer.custom_viewport = $LavaViewport/Viewport
	$StoneLayer.custom_viewport = $StoneViewport/Viewport
#	$GasLayer.custom_viewport = $GasViewport/Viewport
	for node in $WaterLayer.get_children():
		node.connect("lava_touch", self, "Connected_signal")

func _process(delta):
	if coins_destroyed >= 20 and !sent:
		sent = true
		emit_signal("winState", false)
	if coins_collected >= 20:
		yield(get_tree().create_timer(2), "timeout")
		if coins_collected >= 20 and !sent:
			sent = true
			update_score_timer()
			emit_signal("winState", true)

func Connected_signal(water, lava):
	call_deferred("Reparent", water, lava)

func Reparent(water, lava):
	water.set_collision_layer_bit(0, false)
	water.set_collision_layer_bit(4, true)
	water.set_collision_mask_bit(0, false)
	water.set_collision_mask_bit(4, true)
	lava.set_collision_layer_bit(0, false)
	lava.set_collision_layer_bit(4, true)
	lava.set_collision_mask_bit(0, false)
	lava.set_collision_mask_bit(4, true)
	water.gravity_scale = 10
	lava.gravity_scale = 10
	$WaterLayer.remove_child(water)
	$StoneLayer.add_child(water)
	$LavaLayer.remove_child(lava)
	$StoneLayer.add_child(lava)


func update_score_timer():
	$Timer/Timer.stop()
	if int(GameManager.lvl_times[GameManager.current_lvl - 1]) != 0 and int(GameManager.lvl_times[GameManager.current_lvl - 1]) <= int($Timer/Time.text):
		pass
	else:
		GameManager.lvl_times[GameManager.current_lvl - 1] = $Timer/Time.text
