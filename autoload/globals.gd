extends Node

var mouse_down := false
var mouse_velocity := Vector2.ZERO

const THROW_STRENGTH = 1

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		mouse_down = true
		SignalBus.click.emit()
	if Input.is_action_just_released("click"):
		mouse_down = false
		SignalBus.release.emit()
	
	if event is InputEventMouseMotion:
		mouse_velocity = event.velocity
