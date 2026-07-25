extends Node2D

@onready var timer_label: Label = $Ui/TimerLabel
@onready var explosion: AnimatedSprite2D = $Ui/LoseLabel/Explosion
@onready var lose_label: Label = $Ui/LoseLabel
@onready var win_label: Label = $Ui/WinLabel
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _process(delta: float) -> void:
	timer_label.text = str(round(Globals.game_timer*10)/10)
	music_player()

func _ready() -> void:
	SignalBus.lose.connect(lose)
	SignalBus.win.connect(win)

func win():
	win_label.visible = true

func lose():
	lose_label.visible = true
	explosion.play("default")


func _on_restart_button_pressed() -> void:
	Globals._ready()
	get_tree().change_scene_to_packed(preload("res://scenes/worlds/main_menu.tscn"))
	

func music_player():
	if Globals.game_timer >= 30:
		if not audio_stream_player.stream == load("res://assets/music/A-Song.mp3"):
			audio_stream_player.stream = preload("res://assets/music/A-Song.mp3")
			audio_stream_player.play()
	else:
		if not audio_stream_player.stream == load("res://assets/music/SONG3BS2WT.mp3"):
			audio_stream_player.stream = preload("res://assets/music/SONG3BS2WT.mp3")
			audio_stream_player.play()
			
