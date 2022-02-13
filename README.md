# Extended Instance Creation

```
instance_create_depth(0, 0, 2022, obj_library, {
	product: "GameMaker Studio 2.3",
	announce: function() {
		show_message("Create customized instances with ease on " + product + "!");
	},
});
```

## Overview

This library is an extended implementation of [YellowAfterlife's book line for passing variables to the Create event](https://yal.cc/gamemaker-create-event-arguments/). Simply add `_ext` after `instance_create_layer` or `instance_create_depth`, plus a struct of variable values and/or method definitions.

## Requirements

- GameMaker Studio 2.3.7+

## Installation

Get the current asset package from [the releases page](https://github.com/dicksonlaw583/InstanceCreateExt/releases). Simply extract everything to your project, including the placeholder object and all accompanying scripts.

## Quick Examples

### Create an instance on a layer with custom variables

```
instance_create_layer_ext(x, y, "Instances", obj_bullet, {
    sprite_index: spr_grapeshot,
	hspeed: 5
});
```

### Create an instance at a depth with custom variables and methods

```
var inst = instance_create_depth_ext(32, 64, 100, obj_thing, {
	sprite_index: spr_customized_thing,
	selfIdentifyPopup: function() {
		show_message("I am an instance of " + object_get_name(object_index));
	},
});
inst.selfIdentifyPopup(); //Shows "I am an instance of obj_thing"
```

