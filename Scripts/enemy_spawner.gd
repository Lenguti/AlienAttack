extends Node2D

@onready var EnemyScene: Resource = preload("res://Scenes/enemy.tscn")
@onready var _timer: Timer = $Timer
@onready var _enemy_positions_container = $EnemySpawnPositions
@onready var _enemy_positions = _enemy_positions_container.get_children()

func _ready() -> void:
	print("CURRENT TICKER WAIT TIMER: %f" % _timer.wait_time)
	_timer.timeout.connect(_on_timer_tick)


## Need to figure this out as a single update and not a per frame update.
#func _process(_delta) -> void:
	#if Enemy.enemy_deaths != 0 and Enemy.enemy_deaths % 2 == 0:
		#print("SHOULD REDUCE WAIT TIMER: %f" % _timer.wait_time)
		#_timer.wait_time -= 2


func _on_timer_tick() -> void:
	var marker: Marker2D = _enemy_positions.pick_random()
	var enemy: Enemy = EnemyScene.instantiate()
	enemy.global_position = marker.position
	add_child(enemy)

