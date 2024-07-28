class_name ProjectileComponent
extends Area2D

@export var velocity: int = 700
@export var attack_component: AttackComponent

@onready var screen_notifier: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

func _ready():
	top_level = true
	area_shape_entered.connect(_on_area_entered)
	screen_notifier.screen_exited.connect(_on_screen_exited)


func _physics_process(delta):
	global_position += (Vector2(velocity * delta, 0))


func set_starting_position(pos: Vector2):
	global_position = pos


func _on_area_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int):
	print("HITTING SOMETHING!")
	#print(area)
	print(area is HitboxComponent)
	if area is HitboxComponent:
		area.on_hit(attack_component.damage)
	queue_free()


func _on_screen_exited():
	queue_free()
