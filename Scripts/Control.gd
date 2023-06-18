extends Control

var s = 0
var m = 0
var time = "00:00"


func _ready():
	rect_size = get_viewport_rect().size
	$Timer.start()



func _process(delta):
	if s >= 60:
		s = 0
		m += 1
	
	time = "%02d:%02d" % [m, s]
	$Time.text = str(time)


func _on_Timer_timeout():
	s += 1
