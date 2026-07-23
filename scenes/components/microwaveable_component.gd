extends Node
class_name Microwaveable_Component

@export var parent : RigidBody2D
@export var target_heat := 350
@export var replacement_object : PackedScene

func microwave():
	Globals.replace(parent,replacement_object)
