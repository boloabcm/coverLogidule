/*
   Project: Cover for Logidule
   File: cover.scad
   Version: 0.1
   Create by: Rom1 <rom1@canel.ch> - CANEL - https://www.canel.ch
   Date: 25/10/2018
   Licence: GNU GENERAL PUBLIC LICENSE v3
   Language: OpenSCAF
   Description
*/

include <config.scad>

module drilling(param)
{
	for(i_drill = [0:len(param)-1])
		translate([param[i_drill][1], param[i_drill][2], 0])
			cylinder(h = cover_thinkness, d = param[i_drill][0], $fn=60);
}

module holder(param)
{
	thinkness = 1.6;

	for( i_holder = [0:len(param)-1] )
	{
		h   = param[i_holder][3];
		dia = param[i_holder][0];

		translate([param[i_holder][1], param[i_holder][2], thinkness]) 
		difference()
		{
			cylinder(h = h, d = dia+2*thinkness, $fn=60);
			cylinder(h = h, d = dia, $fn=60);
		}
	}
}

module create_cover()
{
	cube([cover_side[0]*logidule_size[0], cover_side[1]*logidule_size[1], cover_thinkness]);
}

module create_opening_cover()
{
	/* Create two sides */
	for(b = [0:1])
	{
		/* For X */
		for(i = [0:logidule_size[0]*2])
			translate([cover_open_start+cover_open_inter*i, 
					   b*((logidule_size[1]*cover_side[0])-cover_open[0]),
					   0])
				cube([cover_open[1], cover_open[0], cover_thinkness]);
		/* For Y */
		for(i = [0:logidule_size[1]*2])
			translate([b*((logidule_size[0]*cover_side[0])-cover_open[0]),
					   cover_open_start+cover_open_inter*i,
					   0])
				cube([cover_open[0], cover_open[1], cover_thinkness]);
	}
}

module create_clips()
{
	module clip(sens)
	{
		module _clip()
		{
			cube([clip_holder_v[0], clip_holder_v[1], clip_holder_v[2]]);
			translate([clip_holder_v[0], 0, clip_holder_v[2]-clip_holder_v[0]])
				rotate([90, 0, 0])
					translate([0,0,-clip_holder_v[1]])
						linear_extrude(height = clip_holder_v[1])
							polygon([[0,0], [0.5,0], [0,clip_holder_v[0]]], [[0,1,2]]);
		}
		if(sens == 3)
			translate([0, 0, 0])
				_clip();
		if(sens == 2)
			rotate([0, 0, 90])
				translate([0, -clip_holder_v[1], 0])
					_clip();
		if(sens == 1)
			rotate([0, 0, 180])
				translate([-clip_holder_v[0], -clip_holder_v[1], 0])
					_clip();
		if(sens == 0)
			rotate([0, 0, 270])
				translate([-clip_holder_v[0], 0,0])
					_clip();
	}

	translate([clip_pos[1],
			   clip_pos[0],
			   0])
		clip(0);
	translate([cover_side[1]*logidule_size[0]-clip_holder_v[1]-clip_pos[1],
			   clip_pos[0],
			   0])
		clip(0);
	translate([clip_pos[0],
			   clip_pos[1],
			   0])
		clip(1);
	translate([clip_pos[0],
			   cover_side[0]*logidule_size[1]-clip_holder_v[1]-clip_pos[1],
			   0])
		clip(1);
	translate([clip_pos[1],
			   cover_side[0]*logidule_size[1]-clip_holder_v[0]-clip_pos[0],
			   0])
		clip(2);
	translate([cover_side[1]*logidule_size[0]-clip_holder_v[1]-clip_pos[1],
			   cover_side[0]*logidule_size[1]-clip_holder_v[0]-clip_pos[0],
			   0])
		clip(2);
	translate([cover_side[0]*logidule_size[0]-clip_holder_v[0]-clip_pos[0],
			   clip_pos[1],
			   0])
		clip(3);
	translate([cover_side[0]*logidule_size[0]-clip_holder_v[0]-clip_pos[0],
			   cover_side[0]*logidule_size[1]-clip_holder_v[1]-clip_pos[1],
			   0])
		clip(3);
}


/* Main code */
difference()
{
	create_cover(logidule_size);
	create_opening_cover(logidule_size);
	drilling(drilling_plane);
}
	holder(holder_plane);
	if(with_clip) create_clips();


//  vim: ft=openscad tw=100 noet ts=4 sw=4
