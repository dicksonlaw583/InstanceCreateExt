///@func icx_test_all()
function icx_test_all() {
	global.__test_fails__ = 0;
	var timeA, timeB;
	timeA = current_time;
	
	/* v Tests here v */
	icx_test_instance_create_layer_ext();
	icx_test_instance_create_depth_ext();
	assert_fail(instance_exists(obj_icx_test), "Extended instance creation cleanup incomplete!");
	/* ^ Tests here ^ */
	
	timeB = current_time;
	show_debug_message("Extended instance creation tests done in " + string(timeB-timeA) + "ms.");
	return global.__test_fails__ == 0;
}
