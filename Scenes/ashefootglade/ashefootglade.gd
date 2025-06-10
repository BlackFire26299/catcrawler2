extends Node2D


func _on_boss_area_body_entered(body):
	if body is Player:
		$"Background Music".stop()
		$"Boss Music".play()
	
		$Player.respawn_point = $bossArena/bossArenaRespawn
