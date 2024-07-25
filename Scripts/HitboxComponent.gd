extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent

func _ready():
	area_shape_entered.connect(_on_area_entered)

func on_hit(attack: int):
	if health_component:
		health_component.take_damage(attack)

func _on_area_entered(_area_rid: RID, _area: Area2D, _area_shape_index: int, _local_shape_index: int):
	get_parent().position.x += 50
