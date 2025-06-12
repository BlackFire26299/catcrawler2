extends Node2D


func _on_boss_area_body_entered(body): #Triggers when the player enters the boss arena
	if body is Player:
		$"Background Music".stop() #stops the regular background music
		$"Boss Music".play() #Plays the boss music
	
		$Player.respawn_point = $bossArena/bossArenaRespawn # Changes the respawnpoint to the one for the boss room


func _on_player_player_died_boss() -> void: # Triggers when player dies while fighting the boss
	$Enemies/Boss/RiderBoss.health += 40  # Increases the bosses health by 40 (half max health)
	$Player.ui.update_boss_bar($Enemies/Boss/RiderBoss.health) # Updates Ui to align
	$Enemies/Boss/RiderBoss.enraged = false # sets enraged to false
	
	if $Enemies/Boss/RiderBoss.health > 80: # Caps the health at 80
		$Enemies/Boss/RiderBoss.health = 80
		


func _on_rider_boss_boss_died() -> void:
	# Play some victory celebratory animations 
	$"Victory Eplosion".emitting = true
	$"Victory Eplosion2".emitting = true
	$"Victory Eplosion3".emitting = true
