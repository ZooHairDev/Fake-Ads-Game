extends CanvasLayer


func _ready():
	$ColorRect.hide()

func change_scene(scene_path):
	get_tree().paused = true
	$ColorRect.show()
	$AnimationPlayer.play("trans_in")
	yield($AnimationPlayer, "animation_finished")
	if scene_path: get_tree().change_scene(scene_path)
	$AnimationPlayer.play("trans_out")
	yield($AnimationPlayer, "animation_finished")
	$ColorRect.hide()
	get_tree().paused = false
	
