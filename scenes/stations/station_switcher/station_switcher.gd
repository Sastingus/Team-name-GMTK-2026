extends Area2D
class_name StationSwitcher

@export var station : Globals.Stations

func _ready() -> void:
	SignalBus.click.connect(click)

func click():
	SignalBus.switch_station.emit(station)
