extends Node2D

@onready var enemy_scene: Resource = preload("res://Scenes/enemy.tscn")
@onready var timer: Timer = $Timer
@onready var enemy_positions_container = $EnemySpawnPositions
@onready var enemy_positions = enemy_positions_container.get_children()

func _ready():
	timer.timeout.connect(_on_timer_tick)

func _on_timer_tick():
	print("Timer did tick!")
	var marker: Marker2D = enemy_positions.pick_random()
	var enemy: Enemy = enemy_scene.instantiate()
	enemy.global_position = marker.position
	add_child(enemy)
