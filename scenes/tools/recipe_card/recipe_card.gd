extends Node2D
class_name RecipeCard

@export var recipe_name := ""
@export_multiline() var recipe_description := "°"
@export var id := 1

@onready var name_label: Label = $NameLabel
@onready var description_label: Label = $DescriptionLabel
@onready var id_label: Label = $IdLabel


func _ready() -> void:
	name_label.text = recipe_name
	description_label.text = recipe_description
	id_label.text = str(id)+"."

func _process(delta: float) -> void:
	visible = Globals.current_recipe == id

func next_recipe():
	Globals.current_recipe += 1
	if Globals.current_recipe > Globals.RECIPE_COUNT:
		Globals.current_recipe = 1

func back_recipe():
	Globals.current_recipe -= 1
	if Globals.current_recipe < 1:
		Globals.current_recipe = Globals.RECIPE_COUNT
