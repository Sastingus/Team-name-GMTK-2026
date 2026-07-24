extends Node2D
class_name GrabComponent

@export var grab_area : Area2D
@export var parent : RigidBody2D
@export var disable_grabbing := false
@export var station := Globals.Stations.KITCHEN

var timer := 0.0
var old_position := Vector2.ZERO 
var tracked_velocity := Vector2.ZERO

var hovering := false
var grabbing := false

func _ready() -> void:
	SignalBus.click.connect(grab)
	grab_area.mouse_entered.connect(hover)
	grab_area.mouse_exited.connect(stop_hovering)

func _process(delta: float) -> void:
	timer += delta
	if timer >= 0.01:
		tracked_velocity = (global_position-old_position)/timer
		
		timer = 0.0
		old_position = global_position
	
	if disable_grabbing:
		grabbing = false
	
	if station != Globals.Stations.KITCHEN:
		if Globals.current_station != station:
			grabbing = false
	
	if grabbing && Globals.mouse_down:
		parent.freeze = true
		parent.global_position = get_global_mouse_position()
	if not Globals.mouse_down && grabbing:
		parent.freeze = false
		parent.linear_velocity = tracked_velocity
	if not Globals.mouse_down:
		grabbing = false


func grab():
	if hovering:
		grabbing = true

func hover():
	hovering = true

func stop_hovering():
	hovering = false
