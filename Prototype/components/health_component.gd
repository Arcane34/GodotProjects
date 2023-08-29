extends ProgressBar
class_name HealthComponent

@export var MAX_HEALTH := 400
var health : float

func _ready():
	health = MAX_HEALTH
	
	
func damage(attack):
	health -= attack.attack_damage
	
	if health <= 0:
		get_parent().queue_free()
