extends CanvasLayer

enum {WIN, LOSE}

var lvl_save = "user://save.save"
var lvls = [false, false, false, false, false, false, false, false, false]
var nbr_of_lvls = 10

var lvl_times = ["00:00", "00:00", "00:00", "00:00", "00:00", "00:00", "00:00", "00:00", "00:00", "00:00"]

var game_state = null
var coins_destroyed = 0
var coins_collected = 0
var current_lvl = 1
var play_ads_count = 0

func _ready():
	$AdMob.load_interstitial()
	var i = 0
	$BGMusic.play()
	load_lvls()
	while i < nbr_of_lvls - 1:
		get_node("LvlContainer/Lvl" + str(i+2) + "Btn").disabled = !lvls[i]
		i += 1
	populate_times()
	$AdMob.connect("interstitial_loaded", self, "_on_MobileAds_interstitial_loaded")
	$AdMob.connect("interstitial_closed", self, "_on_MobileAds_interstitial_closed")




func _on_ExitBtn_pressed():
	save_lvls()
	get_tree().quit()
	$ClickSound.play()


func _on_PlayBtn_pressed():
	$MadeBy.hide()
	$Title.hide()
	$ClickSound.play()
	$LvlContainer.show()
	$HomeBtn.show()
	$PlayBtn.hide()
	$ExitBtn.hide()
	$TutoBtn.hide()


func _on_RestartBtn_pressed():
	Play_Ads()
	$ClickSound.play()
	get_tree().reload_current_scene()
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _unlock_Lvl(value):
	$HomeBtn.hide()
	$RestartBtn.hide()
	if value:
		$WinSound.play()
		Check_lvl_to_unlock(nbr_of_lvls)
		$Win.show()
#		if current_lvl > 3:
#			$Win.visible = true
#		current_lvl += 1
	else:
		$LoseSound.play()
		$Lose.visible = true


func Play_Ads():
	#Play Ad after every 2 retries
	if play_ads_count > 0:
		$AdMob.show_interstitial()
		play_ads_count = 0
	else:
		play_ads_count += 1


func Check_lvl_to_unlock(var nbr_of_lvls):
	var i = 1
	while i < nbr_of_lvls:
		if current_lvl == i:
			$Win.visible = true
			get_node("LvlContainer/Lvl" + str(i+1) + "Btn").disabled = false
			lvls[i-1] = true
		i += 1


func _on_Button_lose_restart_pressed():
	$RestartBtn.show()
	$HomeBtn.show()
	$ClickSound.play()
	$Lose.visible = false
	Play_Ads()
	get_tree().reload_current_scene()
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Button_win_continue_pressed():
	$ClickSound.play()
	$RestartBtn.show()
	$HomeBtn.show()
	$Win.visible = false
	save_lvls()
	get_node("LvlContainer/Lvl" + str(current_lvl) + "Btn/Time").text = lvl_times[current_lvl - 1]
	if current_lvl >= nbr_of_lvls:
		get_tree().change_scene("res://World.tscn")
		show_home_screen()
	else:
		get_tree().change_scene("res://Lvl/Lvl" + str(current_lvl + 1) + ".tscn")
		yield(get_tree().create_timer(1), "timeout")
		get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Button_pressed():
	$AdMob.show_interstitial()
#	$AdMob.load_banner()



func _on_HomeBtn_pressed():
	$ClickSound.play()
	get_tree().change_scene("res://World.tscn")
	get_node("LvlContainer/Lvl" + str(current_lvl) + "Btn/Time").text = lvl_times[current_lvl-1]
	show_home_screen()
	save_lvls()


func show_home_screen():
		$PlayBtn.show()
		$ExitBtn.show()
		$Title.show()
		$RestartBtn.hide()
		$LvlContainer.hide()
		$HomeBtn.hide()
		$MadeBy.show()
		$TutoBtn.show()


func load_lvls():
	var f = File.new()
	if f.file_exists(lvl_save):
		f.open(lvl_save, File.READ)
		lvls = f.get_var()
		lvl_times = f.get_var()
		f.close()
	else:
		lvls = [false, false, false, false, false, false, false, false, false]
		lvl_times = ["00:00", "00:00", "00:00", "00:00", "00:00", "00:00", "00:00", "00:00", "00:00", "00:00"]


func save_lvls():
	var f = File.new()
	f.open(lvl_save, File.WRITE)
	f.store_var(lvls)
	f.store_var(lvl_times)
	f.close()


func check_score():
	get_node("LvlContainer/Lvl" + str(current_lvl) + "Btn/Time").text = lvl_times[current_lvl-1]
	

func populate_times():
	var i = 0
	while i < nbr_of_lvls:
		get_node("LvlContainer/Lvl" + str(i+1) + "Btn/Time").text = lvl_times[i]
		i += 1


func _on_Lvl1Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl1.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Lvl2Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl2.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Lvl3Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl3.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Lvl4Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl4.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Lvl5Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl5.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Lvl6Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl6.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Lvl7Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl7.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Lvl8Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl8.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Lvl9Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl9.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_Lvl10Btn_pressed():
	$ClickSound.play()
	$HomeBtn.show()
	$RestartBtn.show()
	$LvlContainer.hide()
	get_tree().change_scene("res://Lvl/Lvl10.tscn")
	yield(get_tree().create_timer(1), "timeout")
	get_node("/root/World").connect("winState", self, "_unlock_Lvl")


func _on_TutoBtn_pressed():
	$MadeBy.hide()
	$Title.hide()
	$ClickSound.play()
	$HomeBtn.show()
	$PlayBtn.hide()
	$TutoBtn.hide()
	$ExitBtn.hide()
	get_tree().change_scene("res://Lvl/Tuto.tscn")


func _on_MadeBy_pressed():
	OS.shell_open("https://www.youtube.com/c/ZooHair")


func _on_AdMob_interstitial_closed():
	$AdMob.load_interstitial()


func _on_AdMob_interstitial_failed_to_load(error_code):
	$TestAdmob/Label.text = str(error_code)
	$AdMob.load_interstitial()
