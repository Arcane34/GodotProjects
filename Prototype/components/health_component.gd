extends ProgressBar
class_name HealthComponent

@export var MAX_HEALTH := 400


func _ready():
	self.max_value = MAX_HEALTH
	self.value = MAX_HEALTH

	
	
func damage(card : Ability):
	self.value -= card.attack_damage
	
	
	if value <= 0:
		get_parent().queue_free()
