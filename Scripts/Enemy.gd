class_name Enemy
extends Node2D

@export var _enemy_point_worth: int = 200
@export var _velocity: int = 200
@export var _pixel_projectile_offset_x: int = -110

static var enemy_deaths: int = 0
static var enemy_deaths_score: int = 0

@onready var ProjectileScene: Resource = preload("res://Scenes/projectile.tscn")
@onready var _on_screen_notie: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var _timer: Timer = $Timer
@onready var _hb_component: HitboxComponent = $HitboxComponent
@onready var _attck_component: AttackComponent = $AttackComponent
@onready var _health_component: HealthComponent = $HelthComponent

func _ready() -> void:
	_on_screen_notie.screen_exited.connect(_on_screen_exit)
	_hb_component.area_entered.connect(_on_area_entered)
	_health_component.on_death.connect(_on_death_triggered)
	_timer.timeout.connect(_on_timer_tick)


func _physics_process(delta) -> void:
	global_position.x -= _velocity * delta


func _on_timer_tick() -> void:
	var projectile_component: ProjectileComponent = ProjectileScene.instantiate()
	projectile_component.set_velocity(-700)
	projectile_component.get_attack_component().set_damage(10)
	projectile_component.set_starting_position(Vector2(global_position.x + _pixel_projectile_offset_x, global_position.y))
	var children: Array[Node] = projectile_component.get_children()
	for child in children:
		if child is Sprite2D:
			child.flip_h = true
	add_child(projectile_component)


# This ensures when the enemy collides with player, the player takes damage.
func _on_area_entered(body: Node2D) -> void:
	if body is HitboxComponent:
		body.on_hit(_attck_component.get_damage())


func _on_screen_exit() -> void:
	queue_free()


func _on_death_triggered() -> void:
	enemy_deaths += 1
	enemy_deaths_score = enemy_deaths * _enemy_point_worth
	
