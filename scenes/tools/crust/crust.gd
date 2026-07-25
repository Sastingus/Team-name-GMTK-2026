extends RigidBody2D

@export var pumpkin_pie : PackedScene

func _on_body_entered(body: Node) -> void:
	if body.name == "PumpkinBits":
		body.queue_free()
		Globals.replace(self,pumpkin_pie)
