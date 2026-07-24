extends RigidBody2D
class_name PepperShaker

@onready var grab_component: GrabComponent = $GrabComponent
@onready var particles: GPUParticles2D = $PepperArea/GPUParticles2D
@onready var pepper_collision: CollisionShape2D = $PepperArea/CollisionShape2D

func _process(delta: float) -> void:
	particles.emitting = grab_component.grabbing
	pepper_collision.disabled = not grab_component.grabbing


func _on_pepper_area_body_entered(body: Node2D) -> void:
	if body.has_node("SeasonableComponent"):
		body.get_node("SeasonableComponent").seasoned()
