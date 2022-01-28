/// @description STATE MACHINE

switch(collision_state){
	case COLLISION_CHECK_STATE.CHOOSE_COLLISION:
		input_choose();
	break;
	
	case COLLISION_CHECK_STATE.HANDLE_COLLISION:
		mouse_image();
		collision_test();
	break;

	case COLLISION_CHECK_STATE.DRAGING_PRIMITIVE:
		drag_primitive();
		collision_test();
	break;
}

input_reset();
inputs();
