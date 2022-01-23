/// @description DRAW TEXT
draw_text(global.window.center_x, 20, "Envoltório " + global.bounding_type_text[bounding_type]);

draw_set_halign(fa_left);
if(bound_state == BOUNDING_STATE.DRAW_POINTS)
	draw_text(20, 40, "Gerando pontos aleatórios!");

else {
	draw_text(20, 40, "Pontos Gerados!");
	draw_text(20, 60, "LMB para adicionar um novo ponto");
	draw_text(20, 80, "Caso ponto seja VERDE, ele está dentro do envoltório");
	draw_text(20, 100, "Caso ponto seja VERMELHO, ele está fora do envoltório");
}


draw_text(20, global.window.height - 20, "ESPAÇO -> Gerar novos pontos");
draw_set_halign(fa_center);
