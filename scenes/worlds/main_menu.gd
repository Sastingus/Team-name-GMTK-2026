extends Node2D

@onready var recipe_station: Station = $RecipeStation
@onready var hard_mode_button: Button = $Control/HardModeButton


func _on_start_pressed() -> void:
	Globals.in_game = true
	get_tree().change_scene_to_packed(preload("res://scenes/worlds/world.tscn"))

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_recipes_pressed() -> void:
	recipe_station.visible = true

func back_to_menu():
	recipe_station.visible = false


func _on_hard_mode_button_toggled(toggled_on: bool) -> void:
	match toggled_on: 
		true: 
			hard_mode_button.text = "Hard Mode"
			Globals.GAME_TIME = 100
			Globals.game_timer = Globals.GAME_TIME
		false: 
			hard_mode_button.text = "Easy Mode"
			Globals.GAME_TIME = 300
			Globals.game_timer = Globals.GAME_TIME
