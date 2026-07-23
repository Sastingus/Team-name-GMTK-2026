extends Node2D
class_name Station

@export var station_id : Globals.Stations

@onready var camera: Camera2D = $Camera2D


func _ready() -> void:
	SignalBus.switch_station.connect(switch_station)

func switch_station(station : Globals.Stations):
	if station == station_id:
		camera.enabled = true
		if Globals.held_ingredient != null:
			add_child(Globals.held_ingredient)
	else:
		camera.enabled = false
		if get_children().has(Globals.held_ingredient):
			get_children()[Globals.held_ingredient].queue_free()
