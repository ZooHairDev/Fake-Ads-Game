extends Node2D

var sent = false

signal winState(value)


func _ready():
	GameManager.current_lvl = 7
	$WaterLayer.custom_viewport = $WaterViewport/Viewport
	$OxygenLayer.custom_viewport = $OxygenViewport/Viewport

func _process(delta):
	if $Player.oxygen > 100 and !sent:
		sent = true
		update_score_timer()
		emit_signal("winState", true)
	if $Player.oxygen < 0 and !sent:
		sent = true
		emit_signal("winState", false)



func _on_Pipe_pipe_done():
	$BorderIn.set_collision_layer_bit(0, false)
	$BorderIn.set_collision_mask_bit(0, false)
	
	$PipeEnd.set_collision_layer_bit(0, false)
	$PipeEnd.set_collision_mask_bit(0, false)


func update_score_timer():
	$Timer/Timer.stop()
	if int(GameManager.lvl_times[GameManager.current_lvl - 1]) != 0 and int(GameManager.lvl_times[GameManager.current_lvl - 1]) <= int($Timer/Time.text):
		pass
	else:
		GameManager.lvl_times[GameManager.current_lvl - 1] = $Timer/Time.text
