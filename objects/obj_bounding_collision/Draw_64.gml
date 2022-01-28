/// @description TEXTS

draw_set_halign(fa_left)
if(collision_state == COLLISION_CHECK_STATE.CHOOSE_COLLISION){
	draw_text(20, 40, "Escolha um tipo de colisão para testar");
	draw_text(20, 60, "1: AABB x AABB");
	draw_text(20, 80, "2: AABB x Círculo");
	draw_text(20, 100, "3: Círculo x Círculo");
	draw_text(20, 120, "4: OBB x AABB");
	draw_text(20, 140, "5: OBB x OBB");
	draw_text(20, 160, "6: OBB x Círculo");
}
else {
	draw_text(20, 40, "Você pode mover uma primitiva!");
	draw_text(20, 60, "Use LMB para selecionar a primitiva");
	draw_text(20, 80, "Mova o mouse para a primitiva selecionada");
	draw_text(20, 100, "Se houver colisão -> Primitivas de VERMELHO");
	draw_text(20, 120, "Se NÃO houver colisão -> Primitivas de AMARELO");
	
	draw_text(20, global.window.height - 20, "ESPAÇO: Escolher novo tipo de teste de colisão");
}


draw_set_halign(fa_center)

draw_text(global.window.center_x, 20, "Colisão de envoltórios");
