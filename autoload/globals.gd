extends Node

var mouse_down := false
var mouse_velocity := Vector2.ZERO

const THROW_STRENGTH = 0.5

var sent_food := []
const RECIPE_COUNT = 7

var current_recipe := 1

var in_game := false
var game_timer := 0.0
const GAME_TIME = 120

var current_station : Stations = Stations.KITCHEN

enum Stations{
	KITCHEN,
	SHELF,
	RECIPE,
	COUNTER,
	KNIFE,
	MICROWAVE,
	PLATING
}

enum Effects{
	CHOPPED,
	RAW,
	COOKED,
	BURNT,
	SEASONED,
}

func _ready() -> void:
	game_timer = GAME_TIME

func _process(delta: float) -> void:
	mouse_velocity = Input.get_last_mouse_velocity()
	if in_game:
		game_timer -= delta
		if game_timer <= 0.0:
			lose()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		mouse_down = true
		SignalBus.click.emit()
		
	if Input.is_action_just_released("click"):
		mouse_down = false
		SignalBus.release.emit()
	
	if Input.is_action_just_pressed("back"):
		if current_station != Stations.KITCHEN:
			SignalBus.switch_station.emit(Stations.KITCHEN)
			current_station = Stations.KITCHEN
		SignalBus.back.emit()
	

func replace(parent,replacement_object):
	if replacement_object != null:
			var new_replacement_object = replacement_object.instantiate()
			parent.add_sibling.call_deferred(new_replacement_object)
			new_replacement_object.position = parent.position
			new_replacement_object.rotation = parent.rotation
			new_replacement_object.scale = parent.scale
			parent.queue_free()

func send_food(food):
	if not sent_food.has(food):
		sent_food.append(food)
		if sent_food.size() >= RECIPE_COUNT:
			win()

func win():
	in_game = false
	SignalBus.win.emit()

func lose():
	in_game = false
	SignalBus.lose.emit()
	sent_food = []
	current_station = Stations.KITCHEN
		
	
