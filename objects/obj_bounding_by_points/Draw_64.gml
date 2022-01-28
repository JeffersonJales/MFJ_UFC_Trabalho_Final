/// @description DRAW TEXT
draw_text(global.window.center_x, 20, "Envoltórios + Teste ponto");

draw_set_halign(fa_left);
switch(bound_state){
	case BOUNDING_STATE.SELECET_FORM:
		draw_text(20, 40, "Escolha uma forma para ser gerada!");
		draw_text(20, 60, "1 : AABB");
		draw_text(20, 80, "2 : OBB");
		draw_text(20, 100, "3 : Circulo");
	break;
	
	case BOUNDING_STATE.DRAW_POINTS: 
		draw_text(20, 40, "Gerando pontos aleatórios!");
	break;
	
	case BOUNDING_STATE.CHECK_COLLISION:
		draw_text(20, 40, "Pontos Gerados!");
		draw_text(20, 60, "LMB para adicionar um novo ponto");
		draw_text(20, 80, "Caso ponto seja VERDE, ele está dentro do envoltório");
		draw_text(20, 100, "Caso ponto seja VERMELHO, ele está fora do envoltório");
	break;
}


draw_text(20, global.window.height - 20, "ESPAÇO -> Recomeçar");
draw_text(20, global.window.height - 40, "ESC -> Voltar para menu");

draw_set_halign(fa_center);
