extends Button

@export var health_component : HealthComponent

#send player damage value to health component
#NEED TO ADD DAMAGE SCALING DEPENDING ON CORRECTNESS
func damage(card : Ability, correctness: String):
	if card != null:
		if health_component:
			health_component.damage(card)


