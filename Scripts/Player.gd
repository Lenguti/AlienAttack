extends CharacterBody2D
class_name Player

@export var target_velociy: int = 500
@export var pixel_projectile_offset_x: int = 100

var input_velocity_x: int
var input_velocity_y: int
var projectile_component_resource: Resource

func _ready():
	projectile_component_resource = preload("res://Scenes/projectile.tscn")

func _process(_delta: float):
	if (Input.is_action_just_pressed("fire")):
		var projectile_component: ProjectileComponent = projectile_component_resource.instantiate()
		projectile_component.set_starting_position(Vector2(global_position.x + pixel_projectile_offset_x, global_position.y))
		add_child(projectile_component)

func _physics_process(_delta: float):
	if (Input.is_action_pressed("move_right")):
		input_velocity_x = target_velociy
	if (Input.is_action_pressed("move_left")):
		input_velocity_x = -target_velociy
	if (Input.is_action_pressed("move_up")):
		input_velocity_y = -target_velociy
	if (Input.is_action_pressed("move_down")):
		input_velocity_y = target_velociy
	velocity = Vector2(input_velocity_x, input_velocity_y)
	move_and_slide()
	input_velocity_x = 0
	input_velocity_y = 0
