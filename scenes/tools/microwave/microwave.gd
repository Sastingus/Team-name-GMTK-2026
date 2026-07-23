extends Area2D
class_name Microwave

var current_target : RigidBody2D
var current_temp := 0.0

const HEAT_PER_SECOND = 50

func _process(delta: float) -> void:
	if current_target != null:
		current_temp += HEAT_PER_SECOND * delta
		if current_target.get_node("Microwaveable_Component").target_heat <= current_temp:
			current_target.get_node("Microwaveable_Component").microwave()


func _on_body_entered(body: Node2D) -> void:
	if body.has_node("Microwaveable_Component"):
		current_target = body


func _on_body_exited(body: Node2D) -> void:
	if body == current_target:
		current_target = null
