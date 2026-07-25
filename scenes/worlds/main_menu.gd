extends Node2D

@onready var recipe_station: Station = $RecipeStation


func _on_start_pressed() -> void:
	Globals.in_game = true
	get_tree().change_scene_to_packed(preload("res://scenes/worlds/world.tscn"))

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_recipes_pressed() -> void:
	recipe_station.visible = true

func back_to_menu():
	recipe_station.visible = false
