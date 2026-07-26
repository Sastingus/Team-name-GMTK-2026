extends Area2D
class_name Microwave

var current_target := []
var current_temp := 0.0
var microwave_started := false
var microwave_opened := true

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
	if current_target.size() >= 1:
		if microwave_opened:
			if microwave_started:
				return true
	return false

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("Microwaveable_Component"):
		if not microwave_opened:
			if not body in current_target:
				current_target.append(body)
				body.set_collision_mask_value(5,true)

func _on_body_exited(body: Node2D) -> void:
	if body in current_target:
		body.z_index = 0
		body.collision_layer = 0
		current_target.erase(body)
		body.set_collision_mask_value(5,false)

func _on_start_button_pressed() -> void:
	if microwave_opened:
		microwave_started = true

func _on_stop_button_pressed() -> void:
	if get_microwaveable():
		for target in current_target:
			if target.get_node("Microwaveable_Component").target_heat+BURNT_HEAT <= current_temp:
				target.get_node("Microwaveable_Component").burn()
			elif target.get_node("Microwaveable_Component").target_heat <= current_temp:
				target.get_node("Microwaveable_Component").microwave()
	microwave_started = false
	current_temp = 0

func _on_door_button_toggled(toggled_on: bool) -> void:
	microwave_opened = not toggled_on
	if not microwave_started:
		if microwave_opened:
			door_button.modulate = Color(1.0, 1.0, 1.0, 0.7)
			door_button.position += Vector2(door_button.size.x,0)
			if current_target.size() == 0:
				disable_walls(true)
				door_button.z_index = -1
			else:
				disable_walls(false)
				microwave_reorder(-2)
				door_button.z_index = -1
		else:
			door_button.modulate = Color(0.0, 0.0, 0.0, 1)
			door_button.position -= Vector2(door_button.size.x,0)
			disable_walls(false)
			microwave_reorder(0)
			door_button.z_index = -1
			recalculate_target()
			

func recalculate_target():
	for body in get_overlapping_bodies():
		if body.has_node("Microwaveable_Component"):
			body_entered.emit(body)

func disable_walls(yes):
	for wall in microwave_walls.get_children():
		wall.disabled = yes

func microwave_reorder(idx:int):
	for target in current_target:
		target.z_index = idx
