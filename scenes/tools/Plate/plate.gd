extends StaticBody2D
class_name Plate

var current_target : RigidBody2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Polygon2D = $Polygon2D
@onready var button: Button = $Button

func send_off():
	if current_target != null:
		current_target.reparent(sprite)
		animation_player.play("send_off")

func delete_target():
	current_target.queue_free()
	animation_player.play("send_back")


func _on_plating_area_body_entered(body: Node2D) -> void:
	if body.has_node("Ingredient_Component"):
		if body.get_node("Ingredient_Component").finished:
			current_target = body
			button.visible = true


func _on_plating_area_body_exited(body: Node2D) -> void:
	if body == current_target:
		current_target == null
		button.visible = false
