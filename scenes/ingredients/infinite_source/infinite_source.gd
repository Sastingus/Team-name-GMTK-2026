extends Area2D
class_name InfiniteSource

@export var spawned_item : PackedScene

var hovering := false

func _mouse_enter() -> void:
	hovering = true

func _mouse_exit() -> void:
	hovering = false

func _ready() -> void:
	SignalBus.click.connect(click)

func click():
	if hovering:
		var new_item = spawned_item.instantiate()
		call_deferred("add_sibling",new_item)
		if new_item.has_node("GrabComponent"):
			new_item.get_node("GrabComponent").grabbing = true
		else:
			new_item.global_position = get_global_mouse_position()
