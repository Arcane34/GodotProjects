extends ProgressBar
class_name HealthComponent

@export var MAX_HEALTH := 200

# setting the progress bar to the health value given to the character
func _ready():
	self.max_value = MAX_HEALTH
	self.value = MAX_HEALTH

	
# damage function to decrease the health bar when needed
func damage(card : Ability):
	self.value -= card.attack_damage
	
	# removing self if health is below 0 aka dead
	if value <= 0:
		get_parent().get_node("SpriteComponent").state = "death"
		
