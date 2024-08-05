class_name Player
extends CharacterBody2D

signal rocket_did_fire(rocket_fired: int)
signal rocket_did_reload(rocket_reloaded: int)

@export var _target_velociy: int = 500
@export var _pixel_projectile_offset_x: int = 100

const PLAYER_HEIGHT_OFFSET: int = 45
const PLAYER_WIDTH_OFFSET: int = 65
const MAX_ROCKETS = 4

var _current_rocket_fired: int = MAX_ROCKETS

@onready var ProjectileScene: Resource = preload("res://Scenes/projectile.tscn")
@onready var _rocket_booster: GPUParticles2D = $RocketBoosterEffect
@onready var _timer: Timer = $Timer
@onready var _viewport_rect: Vector2 = get_viewport_rect().size

func _ready() -> void:
	_timer.timeout.connect(_timer_did_tick)


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("fire")):
		if _current_rocket_fired > 0:
			var projectile_component: ProjectileComponent = ProjectileScene.instantiate()
			projectile_component.set_starting_position(Vector2(global_position.x + _pixel_projectile_offset_x, global_position.y))
			add_child(projectile_component)
			emit_signal("rocket_did_fire", _current_rocket_fired)
			_current_rocket_fired -= 1


func _physics_process(_delta: float) -> void:
	_rocket_booster.emitting = true
	velocity = Vector2(0, 0)
	if (Input.is_action_pressed("move_right")):
		velocity.x = _target_velociy
	if (Input.is_action_pressed("move_left")):
		_rocket_booster.emitting = false
		velocity.x = -_target_velociy
	if (Input.is_action_pressed("move_up")):
		velocity.y = -_target_velociy
	if (Input.is_action_pressed("move_down")):
		velocity.y = _target_velociy
	move_and_slide()
	_check_bounds()


func _check_bounds() -> void:
	if global_position.x < 0:
		global_position.x = 0
	if global_position.y - PLAYER_HEIGHT_OFFSET < 0:
		global_position.y = PLAYER_HEIGHT_OFFSET
	if global_position.x + PLAYER_WIDTH_OFFSET > _viewport_rect.x:
		global_position.x = _viewport_rect.x - PLAYER_WIDTH_OFFSET
	if global_position.y + PLAYER_HEIGHT_OFFSET > _viewport_rect.y:
		global_position.y = _viewport_rect.y - PLAYER_HEIGHT_OFFSET


func _timer_did_tick() -> void:
	if _current_rocket_fired < MAX_ROCKETS:
		_current_rocket_fired += 1
		emit_signal("rocket_did_reload", _current_rocket_fired)

