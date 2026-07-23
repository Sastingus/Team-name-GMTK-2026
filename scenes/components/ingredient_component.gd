extends Node
class_name Ingredient_Component

@export var parent : RigidBody2D
@export var grab_component : GrabComponent

func _ready() -> void:
	SignalBus.switch_station.connect(switch_station)

func switch_station(_station : Globals.Stations):
	if grab_component.grabbing:
		Globals.held_ingredient = parent
