extends StaticBody2D

@export var speed: float = 300.0
@export var up_input: String = ""
@export var down_input: String = ""

func _ready() -> void:
	#var material := PhysicsMaterial.new()
	#material.bounce = 1.0
	#material.absorbent = false
	#$CollisionShape2D.material = material
	pass

func _physics_process(delta):
	var direction: float = 0.0
	if Input.is_action_pressed(up_input):
		direction -= 1.0
	if Input.is_action_pressed(down_input):
		direction += 1.0

	position.y += direction * speed * delta

	position.y = clamp(position.y, 54, get_viewport_rect().size.y-54)
