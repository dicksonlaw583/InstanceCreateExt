///@func icx_test_instance_create_depth_ext()
function icx_test_instance_create_depth_ext() {
	var inst;
	
	#region instance_create_depth_ext, no overrides
	inst = instance_create_depth_ext(32, 64, 16, obj_icx_test, {});
	assert_equal(
		[inst.x, inst.y, inst.depth, inst.object_index, inst.sprite_index, inst.hspeed, inst.vspeed],
		[32, 64, 16, obj_icx_test, spr_icx_test1, 0, 0],
		"FAILED: instance_create_depth_ext, no overrides"
	);
	#endregion
	
	#region instance_create_depth_ext, with overrides
	inst = instance_create_depth_ext(96, 128, 17, obj_icx_test, {
		sprite_index: spr_icx_test2,
		vspeed: 7,
	});
	assert_equal(
		[inst.x, inst.y, inst.depth, inst.object_index, inst.sprite_index, inst.hspeed, inst.vspeed],
		[96, 128, 17, obj_icx_test, spr_icx_test2, 0, 7],
		"FAILED: instance_create_depth_ext, with overrides"
	);
	#endregion
	
	#region instance_create_depth_ext, with custom method
	inst = instance_create_depth_ext(160, 192, 18, obj_icx_test, {
		selfIdentify: function() {
			return object_get_name(object_index);
		},
	});
	assert_equal(
		[inst.x, inst.y, inst.depth, inst.object_index, inst.selfIdentify(), inst.sprite_index, inst.hspeed, inst.vspeed],
		[160, 192, 18, obj_icx_test, "obj_icx_test", spr_icx_test1, 0, 0],
		"FAILED: instance_create_depth_ext, with custom method"
	);
	#endregion
	
	#region instance_create_depth_ext, with foreign method
	inst = instance_create_depth_ext(224, 256, 19, obj_icx_test, {
		foreignMethod: method({ name: "World" }, function() {
			return "Hello " + name;
		}),
	});
	assert_equal(
		[inst.x, inst.y, inst.depth, inst.object_index, inst.foreignMethod(), inst.sprite_index, inst.hspeed, inst.vspeed],
		[224, 256, 19, obj_icx_test, "Hello World", spr_icx_test1, 0, 0],
		"FAILED: instance_create_depth_ext, with foreign method"
	);
	#endregion
	
	// Cleanup
	instance_destroy(obj_icx_test);
}
