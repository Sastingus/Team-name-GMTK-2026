extends Node2D

@onready var timer_label: Label = $Ui/TimerLabel
@onready var explosion: AnimatedSprite2D = $Ui/LoseLabel/Explosion
@onready var lose_label: Label = $Ui/LoseLabel
@onready var win_label: Label = $Ui/WinLabel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _process(delta: float) -> void:
	timer_label.text = str(round(Globals.game_timer*10)/10)
	music_player()
	if round(Globals.game_timer*10)/10 == 30.38:
		fade_out()
	if round(Globals.game_timer*10)/10 == 30:
		fade_in()

func _ready() -> void:
	SignalBus.lose.connect(lose)
	SignalBus.win.connect(win)

func win():
	audio_stream_player.stream = preload("res://assets/music/WinSong.mp3")
	audio_stream_player.play()
	win_label.visible = true
	get_tree().paused = true

func lose():
	audio_stream_player.stream = preload("res://assets/music/LoseSong.mp3")
	audio_stream_player.play()
	lose_label.visible = true
	explosion.play("default")
	get_tree().paused = true


func _on_restart_button_pressed() -> void:
	Globals._ready()
	get_tree().paused = false
	get_tree().change_scene_to_packed(load("res://scenes/worlds/main_menu.tscn"))

func music_player():
	if Globals.game_timer >= 30:
		if not audio_stream_player.stream == load("res://assets/music/A-Song.mp3"):
			audio_stream_player.stream = preload("res://assets/music/A-Song.mp3")
			audio_stream_player.play()
	elif Globals.game_timer <= 30 and not Globals.game_timer <= 0 and not win_label.visible:
		if not audio_stream_player.stream == load("res://assets/music/SONG3BS2WT.mp3"):
			audio_stream_player.stream = preload("res://assets/music/SONG3BS2WT.mp3")
			audio_stream_player.play()


func fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(audio_stream_player,"volume_db",-30,0.25)

func fade_in():
	var tween = get_tree().create_tween()
	tween.tween_property(audio_stream_player,"volume_db",0,0.25)
