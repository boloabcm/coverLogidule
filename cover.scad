thinkness = 2;

open_x = 2.75;
open_y = 5;

side_y = 39.8;
side_x = side_y*2;

drill = 2;
drill1_x = 12;
drill1_y = 15;
drill2_x = 12;
drill2_y = 25;

esp_x = 43.5;
esp_y = 20.5;
esp_pos_x = 25;
esp_pos_y = 10;

//function openH = cube([open_x, open_y, thinkness]);
//function openV = cube([open_y, open_x, thinkness]);
//function transV = side_y - open_x;

transV = side_y - open_x;
transH = side_x - open_x;

module openH()
{
	cube([open_x, open_y, thinkness]);
}

module openV()
{
	cube([open_y, open_x, thinkness]);
}

module clip(sens = "d")
{
	module _clip()
	{
		module gligli()
		{
			rotate([90,0,0]) translate([0,0,-3])
			linear_extrude(height=3) polygon([[0,0], [0.5,0], [0,1.3]], [[0,1,2]]);
		}
		cube([1.2, 3, 7.3]);
		//translate([1.2, 0, 6]) cube([0.5, 3, 1.3]);
		translate([1.2, 0, 6]) gligli();
	}

	if(sens == "r")
	{
		translate([0, 0, 0])
		{
			_clip();
		}
	}
	if(sens == "b")
	{
		rotate([0,0,90]) translate([0, -3, 0])
		{
			_clip();
		}
	}
	if(sens == "l")
	{
		rotate([0,0,180]) translate([-1.2, -3, 0])
		{
			_clip();
		}
	}
	if(sens == "f")
	{
		rotate([0,0,270]) translate([-1.2, 0,0])
		{
			_clip();
		}
	}
}

module socle()
{
	hight = 5;
	dia = 2.5;
	thinkness = 1.6;

	difference()
	{
		cylinder(h=hight, d=dia+2*thinkness, $fn=60);
		/*translate([thinkness, thinkness, 0])*/ cylinder(h=hight, d=dia, $fn=60);
	}
}

//*
difference()
{
	cube([side_x, side_y, thinkness]);
	translate([7,  0, 0]) openV();
	translate([27, 0, 0]) openV();
	translate([47, 0, 0]) openV();
	translate([67, 0, 0]) openV();
	translate([7,  transV, 0]) openV();
	translate([27, transV, 0]) openV();
	translate([47.5, transV, 0]) openV();
	translate([67.5, transV, 0]) openV();
	translate([0,  7, 0]) openH();
	translate([0, 27, 0]) openH();
	translate([transH,  7, 0]) openH();
	translate([transH, 27, 0]) openH();

	translate([drill1_x, drill1_y, 0]) cylinder(h=thinkness, d=drill, $fn=60);
	translate([drill2_x, drill2_y, 0]) cylinder(h=thinkness, d=drill, $fn=60);
}

	translate([8.5, 3.5, thinkness]) clip("f");
	translate([side_x-11.3, 3.5, thinkness]) clip("f");
	translate([8.5, side_y-3.5-1.2, thinkness]) clip("b");
	translate([side_x-11.3, side_y-3.5-1.2, thinkness]) clip("b");
	translate([side_x-3.5-1.2, side_y-11.5, thinkness]) clip("r");
	translate([side_x-3.5-1.2, 8.5, thinkness]) clip("r");
	translate([3.5, 8.5, thinkness]) clip("l");
	translate([3.5, side_y-11.5, thinkness]) clip("l");

	translate([esp_pos_x, esp_pos_y, thinkness]) socle();
	translate([esp_pos_x+esp_x, esp_pos_y, thinkness]) socle();
	translate([esp_pos_x, esp_pos_y+esp_y, thinkness]) socle();
	translate([esp_pos_x+esp_x, esp_pos_y+esp_y, thinkness]) socle();
//*/

//socle();
//clip("r");
