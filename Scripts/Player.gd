extends Node2D


var health = 100
var oxygen = 100
var lava_hit = false
var water_hit = false
var isDrowning = false
var isDying = false
var target = null
var face = null
var sent = false
var drown = false

var waterMol = 0
var lavaMol = 0
var gasMol = 0

func _ready():
	$Sprite.playing = true
	
func _physics_process(delta):

	if waterMol > 0:
		health -= 0.1
	if lavaMol > 0:
		health -= 0.5
	if gasMol > 0:
		health -= 0.1
		
		
	if get_parent().is_in_group("oxygen lvl"):
		$ProgressBar.value = oxygen
		$ProgressBar.modulate = Color.blue
		
		if face and $Face.overlaps_body(face):
			if face.is_in_group("oxygen"):
				oxygen += 0.3
		else:
			oxygen -= 0.15
	else:
		lavaMol = 0
		
		$ProgressBar.value = health
		$ProgressBar.modulate = Color.red
		for body in $Body.get_overlapping_bodies():
			if body.is_in_group("water"):
				waterMol = 0
				for col in $Face.get_overlapping_bodies():
					if col.is_in_group("water"):
						waterMol += 1
			if body.is_in_group("lava"):
				lavaMol += 1
		gasMol = 0
		for col in $Face.get_overlapping_bodies():
			if col.is_in_group("gas"):
				gasMol += 1
#		if $Body.overlaps_body(target):
#			if target.is_in_group("water"):
#				if $Face.overlaps_body(face):
#					if face.is_in_group("water"):
#						health -= 0.1
#			if target.is_in_group("lava"):
#				health -= 0.5
#		if $Face.overlaps_body(face):
#			if face.is_in_group("gas"):
#				health -= 0.5
	if health < 0 and !sent:
		sent = true
		get_parent().emit_signal("winState", false)
#		GameManager.game_state = GameManager.LOSE 
#	if drown or lava_hit:
#		health -= 0.5

func _on_Body_body_entered(body):
	target = body


func _on_Face_body_entered(body):
	face = body


func _on_Body_body_exited(body):
	if body.is_in_group("lava"):
		lava_hit = false
	if body.is_in_group("water"):
		water_hit = false
#
#
func _on_Face_body_exited(body):
	if body.is_in_group("water"):
		drown = false


func _on_B_body_entered(body):
	pass # Replace with function body.


func _on_ProgressBar_value_changed(value):
	$AnimationPlayer.play("hit")
