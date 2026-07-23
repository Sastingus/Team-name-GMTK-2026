extends Node
class_name CuttableComponent

@export var parent : RigidBody2D
@export var target_hits := 3
var current_hits := 0
@export var replacement_object : PackedScene

func hit():
	current_hits += 1
	if current_hits >= target_hits:
		if replacement_object.can_instantiate():
			var new_replacement_object = replacement_object.instantiate()
			parent.add_sibling(new_replacement_object)
			new_replacement_object.position = parent.position
			new_replacement_object.rotation = parent.rotation
			new_replacement_object.scale = parent.scale
			parent.queue_free()
