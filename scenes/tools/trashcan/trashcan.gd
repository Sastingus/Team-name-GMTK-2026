extends Area2D

var current_target : RigidBody2D

func _ready() -> void:
	SignalBus.release.connect(delete)

func delete():
	if not current_target == null:
		current_target.queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.has_node("Ingredient_Component"):
		current_target = body


func _on_body_exited(body: Node2D) -> void:
	if body == current_target:
		current_target = null
