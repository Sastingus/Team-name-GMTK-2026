extends RigidBody2D
class_name KnifeObject

@onready var hit_particles: GPUParticles2D = $HitParticles
@onready var hit_cooldown: Timer = $HitCooldown
@onready var grab_component: GrabComponent = $GrabComponent

var hit_ready := true

func _on_body_entered(body: Node) -> void:
	if hit_ready:
		if grab_component.grabbing:
			if body.has_node("CuttableComponent"):
				body.get_node("CuttableComponent").hit()
				hit_particles.position = self.get_colliding_bodies()[0].global_position
				hit_particles.emitting = true
				hit_ready = false
				hit_cooldown.start()


func _on_hit_cooldown_timeout() -> void:
	hit_ready = true
