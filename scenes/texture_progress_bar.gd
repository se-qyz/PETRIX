extends TextureProgressBar


func _set_health_bar(health, maxHealth):
	max_value = maxHealth
	value = health
	
	
func _change_health(newValue):
	value += newValue
