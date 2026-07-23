extends Area2D
class_name StationSwitcher

@export var station : Globals.Stations
var hovering = false

func _ready() -> void:
	SignalBus.back.connect(click)

func click():
	if hovering:
		SignalBus.switch_station.emit(station)
		Globals.current_station = station

func _mouse_enter() -> void:
	hovering = true
func _mouse_exit() -> void:
	hovering = false
