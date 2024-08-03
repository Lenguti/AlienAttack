class_name ProjectileComponent
extends Area2D

@export var _velocity: int = 700
@export var _attack_component: AttackComponent

@onready var _screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var _pew_player: AudioStreamPlayer = $Pew

func _ready() -> void:
	top_level = true
	_pew_player.play()
	area_shape_entered.connect(_on_area_entered)
	_screen_notifier.screen_exited.connect(_on_screen_exited)


func _physics_process(delta) -> void:
	global_position += (Vector2(_velocity * delta, 0))


func set_starting_position(pos: Vector2) -> void:
	global_position = pos


func set_velocity(velocity: int) -> void:
	_velocity = velocity


func get_attack_component() -> AttackComponent:
	return _attack_component


func _on_area_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area is HitboxComponent:
		# Check if the missle came from the player and the thing we hit is an enemy.
		# Check if the missle came from an enemy and the thing we hit is a player.
		if get_parent() is Player and area.get_parent() is Enemy or get_parent() is Enemy and area.get_parent() is Player:
			area.on_hit(_attack_component.get_damage())
	queue_free()


func _on_screen_exited() -> void:
	queue_free()

