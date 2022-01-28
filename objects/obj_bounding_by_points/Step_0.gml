/// @description RESTART
input_reset();

switch(bound_state){
	case BOUNDING_STATE.SELECET_FORM: select_form_input(); break;
	case BOUNDING_STATE.DRAW_POINTS: 
	case BOUNDING_STATE.CHECK_COLLISION: 
		inputs();
	break;
}


