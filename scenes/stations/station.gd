extends Node2D
class_name Station

@export var station_id : Globals.Stations

@onready var camera: Camera2D = $Camera2D


func _ready() -> void:
	SignalBus.switch_station.connect(switch_station)

func switch_station(station : Globals.Stations):
	if station == station_id:
		camera.enabled = true
	else:
		camera.enabled = false
