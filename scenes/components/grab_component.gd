extends Node2D
class_name GrabComponent

@export var grab_area : Area2D
@export var parent : RigidBody2D
@export var disable_grabbing := false
@export var station := Globals.Stations.KITCHEN

var hovering := false
var grabbing := false

func _ready() -> void:
	SignalBus.click.connect(grab)
	grab_area.mouse_entered.connect(hover)
	grab_area.mouse_exited.connect(stop_hovering)

func _process(_delta: float) -> void:
	if disable_grabbing:
		grabbing = false
	if station != Globals.Stations.KITCHEN:
		if Globals.current_station != station:
			grabbing = false
	
	if grabbing && Globals.mouse_down:
		parent.global_position = get_global_mouse_position()
	if not Globals.mouse_down && grabbing:
		parent.linear_velocity = Globals.mouse_velocity*Globals.THROW_STRENGTH
	if not Globals.mouse_down:
		grabbing = false


func grab():
	if hovering:
		grabbing = true

func hover():
	hovering = true

func stop_hovering():
	hovering = false
