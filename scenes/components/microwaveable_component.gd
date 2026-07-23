extends Node
class_name Microwaveable_Component

@export var parent : RigidBody2D
@export var target_heat := 350
@export var replacement_object : PackedScene
@export var burnt_replacement_object : PackedScene

func microwave():
	Globals.replace(parent,replacement_object)

func burn():
	Globals.replace(parent,burnt_replacement_object)
