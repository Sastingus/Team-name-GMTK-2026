extends Node

var mouse_down := false
var mouse_velocity := Vector2.ZERO

const THROW_STRENGTH = 1

var held_ingredient : RigidBody2D

var current_station : Stations = Stations.KITCHEN

enum Stations{
	KITCHEN,
	COUNTER,
	KNIFE,
	MICROWAVE,
	PLATING
}

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		mouse_down = true
		SignalBus.click.emit()
	if Input.is_action_just_released("click"):
		mouse_down = false
		SignalBus.release.emit()
	
	if event is InputEventMouseMotion:
		mouse_velocity = event.velocity

func replace(parent,replacement_object):
	if replacement_object != null:
			var new_replacement_object = replacement_object.instantiate()
			parent.add_sibling(new_replacement_object)
			new_replacement_object.position = parent.position
			new_replacement_object.rotation = parent.rotation
			new_replacement_object.scale = parent.scale
			parent.queue_free()
