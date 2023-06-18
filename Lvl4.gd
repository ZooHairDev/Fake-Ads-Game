extends Node2D

var coins_destroyed = 0
var coins_collected = 0
var sent = false

signal winState(value)


func _ready():
	GameManager.current_lvl = 4
	$WaterLayer.custom_viewport = $WaterViewport/Viewport
	$GasLayer.custom_viewport = $GasViewport/Viewport

func _process(delta):
	if coins_destroyed >= 20 and !sent:
		sent = true
		emit_signal("winState", false)
		$Timer/Timer.stop()
	if coins_collected >= 20:
		yield(get_tree().create_timer(3), "timeout")
		if coins_collected >= 20 and !sent:
			sent = true
			$Timer/Timer.stop()
			update_score_timer()
			emit_signal("winState", true)

func _on_Pipe_pipe_done():
	$BorderIn.set_collision_layer_bit(0, false)
	$BorderIn.set_collision_mask_bit(0, false)
	
	$PipeEnd.set_collision_layer_bit(0, false)
	$PipeEnd.set_collision_mask_bit(0, false)


func _on_Pipe2_pipe_done():
	$BorderIn2.set_collision_layer_bit(0, false)
	$BorderIn2.set_collision_mask_bit(0, false)
	
	$PipeEnd2.set_collision_layer_bit(0, false)
	$PipeEnd2.set_collision_mask_bit(0, false)


func update_score_timer():
	$Timer/Timer.stop()
	if int(GameManager.lvl_times[GameManager.current_lvl - 1]) != 0 and int(GameManager.lvl_times[GameManager.current_lvl - 1]) <= int($Timer/Time.text):
		pass
	else:
		GameManager.lvl_times[GameManager.current_lvl - 1] = $Timer/Time.text
