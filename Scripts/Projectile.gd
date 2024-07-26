extends Area2D
class_name ProjectileComponent

@export var velocity: int = 700
@export var attack_component: AttackComponent

func _ready():
	top_level = true
	area_shape_entered.connect(_on_area_entered)

func _physics_process(delta):
	global_position += (Vector2(velocity * delta, 0))

func set_starting_position(pos: Vector2):
	global_position = pos

func _on_area_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int):
	if area is HitboxComponent:
		if attack_component:
			area.on_hit(attack_component.damage)
		queue_free()
