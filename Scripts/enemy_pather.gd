class_name EnemyPather
extends Path2D

var _enemy_kamakazi: EnemyKamakazi
var _did_trigger: bool = false

@onready var EnemyKamakaziScene: Resource = preload("res://Scenes/enemy_kamakazi.tscn")
@onready var _path_follower: PathFollow2D = $PathFollow2D

func _process(delta) -> void:
	if Enemy.enemy_deaths != 0 and Enemy.enemy_deaths % 3 == 0 and (_path_follower.progress_ratio == 0 and !_did_trigger):
		_enemy_kamakazi = EnemyKamakaziScene.instantiate()
		_path_follower.add_child(_enemy_kamakazi)
		_did_trigger = true
	
	if Enemy.enemy_deaths % 3 != 0:
		_did_trigger = false

	if _enemy_kamakazi:
		_path_follower.progress_ratio += 1 * delta

	if _path_follower.progress_ratio == 1:
		if _enemy_kamakazi:
			_enemy_kamakazi.queue_free()
			_path_follower.progress_ratio = 0
			_enemy_kamakazi = null

