extends Node2D

var _did_trigger_speed_up: bool = false

@onready var EnemyScene: Resource = preload("res://Scenes/enemy.tscn")
@onready var _timer: Timer = $Timer
@onready var _enemy_positions_container = $EnemySpawnPositions
@onready var _enemy_positions = _enemy_positions_container.get_children()

func _ready() -> void:
	_timer.timeout.connect(_on_timer_tick)


func _process(_delta) -> void:
	if Enemy.enemy_deaths != 0 and Enemy.enemy_deaths % 2 == 0 and not _did_trigger_speed_up: 
		_timer.wait_time -= 1.0
		if _timer.wait_time < 1.0:
			_timer.wait_time = 1.0
		_did_trigger_speed_up = true
	elif Enemy.enemy_deaths % 2 != 0:
		_did_trigger_speed_up = false


func _on_timer_tick() -> void:
	var marker: Marker2D = _enemy_positions.pick_random()
	var enemy: Enemy = EnemyScene.instantiate()
	enemy.global_position = marker.position
	add_child(enemy)

