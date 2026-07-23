extends Node2D

@export var station_id : Globals.Stations

@onready var camera: Camera2D = $Camera2D
@onready var inventory: Node2D = %Inventory


func _ready() -> void:
	SignalBus.switch_station.connect(switch_station)

func switch_station(station : Globals.Stations):
	if station == station_id:
		camera.enabled = true
		inventory.add_child(Globals.held_ingredient)
	else:
		camera.enabled = false
		if inventory.get_children().has(Globals.held_ingredient):
			inventory.get_children()[Globals.held_ingredient].queue_free()
