extends Area2D
class_name ProjectileComponent

@export var velocity: int = 700

func _ready():
	top_level = true
	body_entered.connect(_on_body_entered)

func _process(delta):
	global_position += (Vector2(velocity * delta, 0))

func set_starting_position(pos: Vector2):
	global_position = pos

func _on_body_entered(body: Node2D):
	if not is_instance_of(body, Player):
		queue_free()
