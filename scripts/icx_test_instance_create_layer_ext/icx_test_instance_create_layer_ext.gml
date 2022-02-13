///@func icx_test_instance_create_layer_ext()
function icx_test_instance_create_layer_ext() {
	var inst;
	
	#region instance_create_layer_ext, no overrides
	inst = instance_create_layer_ext(32, 64, "Instances", obj_icx_test, {});
	assert_equal(
		[inst.x, inst.y, inst.layer, inst.object_index, inst.sprite_index, inst.hspeed, inst.vspeed],
		[32, 64, layer_get_id("Instances"), obj_icx_test, spr_icx_test1, 0, 0],
		"FAILED: instance_create_layer_ext, no overrides"
	);
	#endregion
	
	#region instance_create_layer_ext, with overrides
	inst = instance_create_layer_ext(96, 128, "Instances", obj_icx_test, {
		sprite_index: spr_icx_test2,
		hspeed: 5,
	});
	assert_equal(
		[inst.x, inst.y, inst.layer, inst.object_index, inst.sprite_index, inst.hspeed, inst.vspeed],
		[96, 128, layer_get_id("Instances"), obj_icx_test, spr_icx_test2, 5, 0],
		"FAILED: instance_create_layer_ext, with overrides"
	);
	#endregion
	
	#region instance_create_layer_ext, with custom method
	inst = instance_create_layer_ext(160, 192, "Instances", obj_icx_test, {
		selfIdentify: function() {
			return object_get_name(object_index);
		},
	});
	assert_equal(
		[inst.x, inst.y, inst.layer, inst.object_index, inst.selfIdentify(), inst.sprite_index, inst.hspeed, inst.vspeed],
		[160, 192, layer_get_id("Instances"), obj_icx_test, "obj_icx_test", spr_icx_test1, 0, 0],
		"FAILED: instance_create_layer_ext, with custom method"
	);
	#endregion
	
	#region instance_create_layer_ext, with foreign method
	inst = instance_create_layer_ext(224, 256, "Instances", obj_icx_test, {
		foreignMethod: method({ name: "World" }, function() {
			return "Hello " + name;
		}),
	});
	assert_equal(
		[inst.x, inst.y, inst.layer, inst.object_index, inst.foreignMethod(), inst.sprite_index, inst.hspeed, inst.vspeed],
		[224, 256, layer_get_id("Instances"), obj_icx_test, "Hello World", spr_icx_test1, 0, 0],
		"FAILED: instance_create_layer_ext, with foreign method"
	);
	#endregion
	
	// Cleanup
	instance_destroy(obj_icx_test);
}
