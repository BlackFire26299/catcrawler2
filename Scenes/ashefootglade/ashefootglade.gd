extends Node2D


func _on_boss_area_body_entered(body):
	if body is Player:
		$"Background Music".stop()
		$"Boss Music".play()
	
		$Player.respawn_point = $bossArena/bossArenaRespawn


func _on_player_player_died_boss() -> void:
	$Enemies/Boss/RiderBoss.health += 40 
	$Player.ui.update_boss_bar($Enemies/Boss/RiderBoss.health)
	$Enemies/Boss/RiderBoss.enraged = false
	
	if $Enemies/Boss/RiderBoss.health > 80:
		$Enemies/Boss/RiderBoss.health = 80
		


func _on_rider_boss_boss_died() -> void:
	pass
