extends Button

@export var health_component : HealthComponent


func damage(card : Ability, correctness: String):
	if card != null:
		if health_component:
			health_component.damage(card)


