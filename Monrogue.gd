extends Node2D

@export var countdown_time := 300
var remaining_time := countdown_time
	
func spawn_mob():
	const BAT = preload("res://Enemies/Bat/bat.tscn")
	var new_bat = BAT.instantiate()
	
	%MobSpawner.progress_ratio = randf()
	new_bat.global_position = %MobSpawner.global_position
	
	add_child(new_bat)
	
func _on_mob_spawn_timer_timeout():
	spawn_mob()

func _on_game_timer_timeout():
	remaining_time -= 1
	update_timer_label()
	
	if remaining_time <= 0:
		win_game()

func update_timer_label():
	var minutes = remaining_time / 60
	var seconds = remaining_time % 60
	%TimerLabel.text = "%02d:%02d" % [minutes, seconds]
	
func win_game():
	%GameTimer.stop()
	
	set_physics_process(false)

	%Tutorial.visible = false
	%Win.visible = true

func _on_player_health_depleted():
	%Tutorial.visible = false
	%GameTimer.stop()
	%MobTimer.stop()
	%Player.queue_free()
	set_physics_process(false)
	
	%Lose.visible = true
