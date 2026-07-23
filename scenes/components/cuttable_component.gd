extends Node
class_name CuttableComponent

@export var parent : RigidBody2D
@export var target_hits := 3
var current_hits := 0
@export var replacement_object : PackedScene

func hit():
	current_hits += 1
	if current_hits >= target_hits:
		Globals.replace(parent,replacement_object)
