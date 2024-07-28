class_name Enemy
extends Node2D

@export var velocity: int = 200
@export var pixel_projectile_offset_x: int = -110

@onready var ProjectileScene: Resource = preload("res://Scenes/projectile.tscn")
@onready var on_screen_notie: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var timer: Timer = $Timer
@onready var hb_component: HitboxComponent = $HitboxComponent
@onready var attck_component: AttackComponent = $AttackComponent

func _ready():
	on_screen_notie.screen_exited.connect(_on_screen_exit)
	hb_component.area_entered.connect(_on_area_entered)
	timer.timeout.connect(_on_timer_tick)


func _physics_process(delta):
	global_position.x -= velocity * delta


func _on_timer_tick():
	print("Enemy shoot timer ticked!")
	var projectile_component: ProjectileComponent = ProjectileScene.instantiate()
	print("New projectile scene instance")
	print(projectile_component)
	projectile_component.velocity = -700
	projectile_component.attack_component.damage = 10
	projectile_component.set_starting_position(Vector2(global_position.x + pixel_projectile_offset_x, global_position.y))
	var children: Array[Node] = projectile_component.get_children()
	for child in children:
		if child is Sprite2D:
			child.flip_h = true
	add_child(projectile_component)


func _on_area_entered(body: Node2D):
	print("Enemy hit!")
	if body is HitboxComponent:
		body.on_hit(attck_component.damage)


func _on_screen_exit():
	queue_free()
