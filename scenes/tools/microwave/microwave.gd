extends Area2D
class_name Microwave

var current_target : RigidBody2D
var current_temp := 0.0
var microwave_started := false
var microwave_opened := false

const HEAT_PER_SECOND = 50
const DOOR_MOVE_DISTANCE = 200
@onready var temp_heat_label: Label = $temp_HeatLabel
@onready var door_button: Button = $DoorButton
@onready var microwave_floor: CollisionShape2D = $StaticBody2D/MicrowaveFloor


func _process(delta: float) -> void:
	if current_target != null:
		if not microwave_opened:
			if microwave_started:
				current_temp += HEAT_PER_SECOND * delta
				if current_target.get_node("Microwaveable_Component").target_heat <= current_temp:
					current_target.get_node("Microwaveable_Component").microwave()
					microwave_started = false
					current_temp = 0.0
	else:
		microwave_started = false
	temp_heat_label.text = "current temp = "+str(round(current_temp))


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("Microwaveable_Component"):
		if microwave_opened:
			current_target = body


func _on_body_exited(body: Node2D) -> void:
	if body == current_target:
		current_target = null


func _on_start_button_pressed() -> void:
	microwave_started = true


func _on_door_button_toggled(toggled_on: bool) -> void:
	microwave_opened = toggled_on
	if microwave_opened:
		door_button.position -= Vector2(DOOR_MOVE_DISTANCE,0)
		microwave_floor.disabled = false
		door_button.visibility_layer = -1
	else:
		door_button.position += Vector2(DOOR_MOVE_DISTANCE,0)
		if current_target == null:
			microwave_floor.disabled = true
			door_button.visibility_layer = 1
		else:
			microwave_floor.disabled = false
			door_button.visibility_layer = -1
