extends Area2D
class_name Microwave

var current_target : RigidBody2D
var current_temp := 0.0
var microwave_started := false
var microwave_opened := false

const HEAT_PER_SECOND = 50
const DOOR_MOVE_DISTANCE = 200
const BURNT_HEAT = 50
@onready var heat_label: Label = $ColorRect/HeatLabel
@onready var door_button: Button = $DoorButton
@onready var microwave_walls: StaticBody2D = $Walls


func _process(delta: float) -> void:
	current_temp = clamp(current_temp,0,650)
	
	if get_microwaveable():
		current_temp += HEAT_PER_SECOND * delta
	heat_label.text = str(round(current_temp))+"°"
	if microwave_started:
		door_button.disabled = true
	else:
		door_button.disabled = false

func get_microwaveable() -> bool:
	if current_target != null:
		if microwave_opened:
			if microwave_started:
				return true
	return false

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("Microwaveable_Component"):
		if not microwave_opened:
			current_target = body


func _on_body_exited(body: Node2D) -> void:
	if body == current_target:
		current_target = null

func _on_start_button_pressed() -> void:
	if microwave_opened:
		microwave_started = true
func _on_stop_button_pressed() -> void:
	if get_microwaveable():
		if current_target.get_node("Microwaveable_Component").target_heat+BURNT_HEAT <= current_temp:
			current_target.get_node("Microwaveable_Component").burn()
		elif current_target.get_node("Microwaveable_Component").target_heat <= current_temp:
			current_target.get_node("Microwaveable_Component").microwave()
	microwave_started = false
	current_temp = 0

func _on_door_button_toggled(toggled_on: bool) -> void:
	microwave_opened = not toggled_on
	if not microwave_started:
		if microwave_opened:
			door_button.modulate = Color(1.0, 1.0, 1.0, 0.7)
			door_button.position += Vector2(door_button.size.x,0)
			if current_target == null:
				enable_walls(true)
				door_button.z_index = -1
			else:
				enable_walls(false)
				door_button.z_index = 1
		else:
			door_button.modulate = Color(0.0, 0.0, 0.0, 1)
			door_button.position -= Vector2(door_button.size.x,0)
			enable_walls(false)
			door_button.z_index = -1
			recalculate_target()
			

func recalculate_target():
	for body in get_overlapping_bodies():
		if body.has_node("Microwaveable_Component"):
			body_entered.emit(body)

func enable_walls(yes):
	for wall in microwave_walls.get_children():
		wall.disabled = yes
