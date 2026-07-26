extends StaticBody2D
class_name Plate

var current_target := []
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var button: Button = $Button

func send_off():
	if current_target.size() > 0:
		for target in current_target:
			target.call_deferred("reparent",sprite)
		animation_player.play("send_off")
		if Globals.game_timer <= animation_player.current_animation_length + 0.25:
			for target in current_target:
				Globals.send_food(target.name)

func delete_target():
	for target in current_target:
		Globals.send_food(target.name)
		target.queue_free()
	current_target.clear()
	animation_player.play("send_back")


func _on_plating_area_body_entered(body: Node2D) -> void:
	if body.has_node("Ingredient_Component"):
		if body.get_node("Ingredient_Component").finished:
			current_target.append(body)
			if animation_player.current_animation == "":
				button.visible = true


func _on_plating_area_body_exited(body: Node2D) -> void:
	if body in current_target:
		current_target.erase(body)
		button.visible = false
