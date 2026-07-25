extends Node
class_name Ingredient_Component

@export var parent : RigidBody2D
@export var label : Label
@export var item_name := ""
@export var effects_list : Array[Globals.Effects]
@export var grab_component : GrabComponent
@export var finished := false

var effects_list_string := ""

func _ready() -> void:
	for effect in effects_list:
		effects_list_string += str(Globals.Effects.keys()[effect])+"
		"
	
	label.text = item_name + "
	"+effects_list_string

func _process(delta: float) -> void:
	label.visible = grab_component.hovering
	label.global_position = parent.global_position + Vector2(-26.0,-112.0)
