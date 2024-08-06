class_name EnemyKamakazi
extends Sprite2D

@onready var _hb_component: HitboxComponent = $HitboxComponent
@onready var _attck_component: AttackComponent = $AttackComponent

func _ready() -> void:
	_hb_component.area_entered.connect(_on_area_entered)
	

func _on_area_entered(body: Node2D) -> void:
	if body is HitboxComponent and body.get_parent() is Player:
		body.on_hit(_attck_component.get_damage())

