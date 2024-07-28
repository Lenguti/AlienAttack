extends CharacterBody2D
class_name Player

@onready var projectile_scn: Resource = preload("res://Scenes/projectile.tscn")
@onready var viewport_rect: Vector2 = get_viewport_rect().size

@export var target_velociy: int = 400
@export var pixel_projectile_offset_x: int = 100

const PLAYER_HEIGHT_OFFSET: int = 45
const PLAYER_WIDTH_OFFSET: int = 65

func _process(_delta: float):
	if (Input.is_action_just_pressed("fire")):
		var projectile_component: ProjectileComponent = projectile_scn.instantiate()
		projectile_component.set_starting_position(Vector2(global_position.x + pixel_projectile_offset_x, global_position.y))
		add_child(projectile_component)

func _physics_process(_delta: float):
	#print("Current global pos: (%d, %d)" % [global_position.x, global_position.y])
	velocity = Vector2(0, 0)
	if (Input.is_action_pressed("move_right")):
		velocity.x = target_velociy
	if (Input.is_action_pressed("move_left")):
		velocity.x = -target_velociy
	if (Input.is_action_pressed("move_up")):
		velocity.y = -target_velociy
	if (Input.is_action_pressed("move_down")):
		velocity.y = target_velociy
	move_and_slide()
	check_bounds()


func check_bounds():
	if global_position.x < 0:
		global_position.x = 0
	if global_position.y - PLAYER_HEIGHT_OFFSET < 0:
		global_position.y = PLAYER_HEIGHT_OFFSET
	if global_position.x + PLAYER_WIDTH_OFFSET > viewport_rect.x:
		global_position.x = viewport_rect.x - PLAYER_WIDTH_OFFSET
	if global_position.y + PLAYER_HEIGHT_OFFSET > viewport_rect.y:
		global_position.y = viewport_rect.y - PLAYER_HEIGHT_OFFSET
