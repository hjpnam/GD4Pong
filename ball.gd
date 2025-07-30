extends RigidBody2D

@export var launch_strength: float = 500.0


func launch(launch_directon: Vector2) -> void:
	var min_angle_deg = -15
	var max_angle_deg = 15
	var angle_deg = randf_range(min_angle_deg, max_angle_deg)
	var angle_rad = deg_to_rad(angle_deg)
	
	var impulse = launch_directon.rotated(angle_rad) * launch_strength

	apply_central_impulse(impulse)


func set_collision_disabled(value: bool) -> void:
	$CollisionShape2D.set_disabled(value)
