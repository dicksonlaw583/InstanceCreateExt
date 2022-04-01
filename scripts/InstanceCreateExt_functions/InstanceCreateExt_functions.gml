/**
This is a GameMaker Studio 2.3.8+ library for passing variables to new instances between the Pre-Create event
(Object Variables) and the Create event.

The included placeholder object __OBJ_INSTANCE_CREATE_EXT_EMBRYO__ must be present.

Last updated for: IDE 2.3.7.606 / Runtime 2.3.7.476

This library is based on an idea presented in YellowAfterlife's article for passing variables to the Create event:
https://yal.cc/gamemaker-create-event-arguments/
**/

///@func instance_create_layer_ext(x, y, layer, obj, vars)
///@arg {Real} x The x position to create the instance at
///@arg {Real} y The y position to create the instance at
///@arg {String|Id.Layer} layer The layer to create the instance on
///@arg {Resource.GMObject} obj The object to create an instance of
///@arg {Struct} vars Struct consisting of instance variables to inject
///@return {Id.Instance}
///@desc Create an instance of the given object on the specified layer. Return the ID of the created instance.
function instance_create_layer_ext(_x, _y, _layer, _obj, _vars) {
	var _inst = instance_create_layer(_x, _y, _layer, __OBJ_INSTANCE_CREATE_EXT_EMBRYO__);
	with (_inst) {
		__instance_create_ext_kernel__(_obj, _vars);
	}
	return _inst;
}

///@func instance_create_depth_ext(x, y, depth, obj, vars)
///@arg {Real} x The x position to create the instance at
///@arg {Real} y The y position to create the instance at
///@arg {Real} depth The depth to create the instance at
///@arg {Resource.GMObject} obj The object to create an instance of
///@arg {Struct} vars Struct consisting of instance variables to inject
///@return {Id.Instance}
///@desc Create an instance of the given object at the specified depth. Return the ID of the created instance.
function instance_create_depth_ext(_x, _y, _depth, _obj, _vars) {
	var _inst = instance_create_depth(_x, _y, _depth, __OBJ_INSTANCE_CREATE_EXT_EMBRYO__);
	with (_inst) {
		__instance_create_ext_kernel__(_obj, _vars);
	}
	return _inst;
}

///@func __instance_create_ext_kernel__(obj, vars)
///@arg {Resource.GMObject} obj The object to change into
///@arg {Struct} vars Struct consisting of instance variables to inject
///@desc (INTERNAL ONLY) Finish changing the embryo's object identity and variables.
function __instance_create_ext_kernel__(_obj, _vars) {
	instance_change(_obj, false);
	event_perform(14, 0); //14 is ev_pre_create
	if (is_struct(_vars)) {
		var _varkeys = variable_struct_get_names(_vars);
		for (var i = array_length(_varkeys)-1; i >= 0; --i) {
			var _varkey = _varkeys[i];
			var _varval = variable_struct_get(_vars, _varkey);
			variable_instance_set(id, _varkey,
				(is_method(_varval) && method_get_self(_varval) == _vars) ? method(id, _varval) : _varval
			);
		}
	}
	event_perform(ev_create, 0);
}
