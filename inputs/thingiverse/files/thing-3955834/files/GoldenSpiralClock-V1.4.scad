
/* Golden Spiral Clock by Thomas Heiser
 *
 * 2019-10-28
 * 
 * Thingiverse: thomasheiser https://www.thingiverse.com/thomasheiser/about
 * 
 * V1.4
 *
 * Licensing: This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported (CC BY-NC-SA 3.0)
 * Further information is available here - https://creativecommons.org/licenses/by-nc-sa/3.0/
*/



/* [General] */

// Part [dial,hour,minute,all]
part= "dial"; //[dial,dial2,hour,minute,minute_spiral,all]

// Diameter hour pointer hole [mm]
diameter_hour_pointer_hole = 5.5;

// thickness hour pointer [mm]
thickness_hour_pointer = 2;

// width hour pointer [mm]
width_hour_pointer = 2;

// Diameter hour pointer ring [mm]
diameter_hour_pointer_ring = 18;


// Diameter minute pointer hole [mm]
diameter_minute_pointer_hole = 3.7;

// Diameter minute pointer ring [mm]
diameter_minute_pointer_ring = 7;

// thickness minute pointer ring [mm]
thickness_minute_pointer_ring = 3;

// thickness minute pointer [mm]
thickness_minute_pointer = 2;

// width minute pointer (spiral only) [mm]
width_minute_pointer = 2;

// Dial height [mm]
dial_height = 190;

// Dial width [mm]
dial_width = 70;

// Dial hole [mm]
dial_hole = 7.7;

// Dial thickness [mm]
dial_thickness=2;

text_font= "Stencilia\\-A:style=Regular";


/* [hidden] */

from = 5; // from n-th fibonacci number
to = 10;  // to n-th fibonacci number
spirals = 1;
spiral_scale=1.4;



// Minute_Pointer
if(part=="all" || part=="minute")
{
    rotate_minute= part=="minute"? 180:0;

    color("white")
    rotate([0,rotate_minute,0])
    translate([0,0,thickness_hour_pointer])
    union()
    {
        difference()
        {
            cylinder(thickness_minute_pointer_ring,diameter_minute_pointer_ring/2,diameter_minute_pointer_ring/2,$fn=50,false);
            
            cylinder(thickness_minute_pointer_ring,diameter_minute_pointer_hole/2,diameter_minute_pointer_hole/2,$fn=50,false);
        }
        translate([diameter_minute_pointer_ring/2-1,-thickness_minute_pointer/2,thickness_minute_pointer_ring-thickness_minute_pointer])cube([50,thickness_minute_pointer,thickness_minute_pointer],false);
    }
}

// Hour_Pointer
if(part=="all" || part=="hour" || part=="minuute_spiral")
{
color("black")
hour_spiral();
}


// Minute_Pointer_Spiral
if(part=="all" || part=="minute_spiral")
{
color("red")
translate([0,0,thickness_hour_pointer])minute_spiral();
}


// Dial
if(part=="all" || part=="dial")
{
color("gray")
    difference() {
        translate([-dial_height/2,-dial_width/2,-dial_thickness])cube([dial_height,dial_width,dial_thickness],false);
        {
            translate([0,0,-dial_thickness])cylinder(dial_thickness,dial_hole/2,dial_hole/2,$fn=50,false);
            dial_hours_bottom(12);
            dial_hours_bottom(11);
            dial_hours_bottom(10);
            dial_hours_bottom(9);
            dial_hours_bottom(8);
            dial_hours_bottom(7);
            dial_hours_top(6);
            dial_hours_top(5);
            dial_hours_top(4);
            dial_hours_top(3);
            dial_hours_top(2);
            dial_hours_top(1);
            
            dial_number(12,-85.5,0);
            dial_number(11,-72,0);
            dial_number(10,-61,0);
            dial_number(9,-54,0);
            dial_number(8,-47.5,0);
            dial_number(7,-41,0);
            dial_number(6,85.5,0);
            dial_number(5,72,0);
            dial_number(4,61,0);
            dial_number(3,54,0);
            dial_number(2,47.5,0);
            dial_number(1,41,0);
            
        }    
    }
}

// Dial2
if(part=="all" || part=="dial2")
{
color("gray")
    difference() {
        translate([-dial_height/2,-dial_width/2,-dial_thickness])cube([dial_height,dial_width,dial_thickness],false);
        {
            translate([0,0,-dial_thickness])cylinder(dial_thickness,dial_hole/2,dial_hole/2,$fn=50,false);
            
            dial_hours_minutes_bottom(12);
            
            dial_hours_minutes_bottom(11);
            dial_hours_minutes_bottom(10);
            dial_hours_minutes_bottom(9);
            dial_hours_minutes_bottom(8);
            dial_hours_minutes_bottom(7);
            dial_hours_minutes_top(6);
            dial_hours_minutes_top(5);
            dial_hours_minutes_top(4);
            dial_hours_minutes_top(3);
            dial_hours_minutes_top(2);
            dial_hours_minutes_top(1);

            dial_number(1,38,-8);
            dial_number(2,44.5,-8);
            dial_number(3,51,-8);
            dial_number(4,58,-8);
            dial_number(5,69,-8);
            dial_number(6,83,-8);
            dial_number(7,-42.5,-8);
            dial_number(8,-49.5,-8);
            dial_number(9,-56,-8);
            dial_number(10,-63.5,-8);
            dial_number(11,-75,-8);
            dial_number(12,-87.5,-8);
              
            dial_number(5,42.5,8);   
            dial_number(10,49.5,8);
            dial_number(15,56,8);
            dial_number(20,63.5,8);
            dial_number(25,75,8);
            dial_number(30,87.5,8);
            dial_number(35,-38,8);   
            dial_number(40,-44.5,8); 
            dial_number(50,-58,8);
            dial_number(45,-51,8);
            dial_number(55,-69,8); 
            dial_number(0,-83,8); 
            
        }    
    }
}

module dial_number(hours,pos,posy)
{
translate([pos,posy,-5])linear_extrude(10)rotate(-90)text(str(hours),halign="center",valign="center",size=5, font=text_font);
}

module dial_hours_bottom(hours)
{
    translate([0,0,-dial_thickness])intersection()
    {
        rotate(hours*-30)hour_spiral();
        difference()
        {
            translate([-60,0,0])cube([70,20,20],true);
            translate([-60,0,0])cube([70,8,8],true);
        }
    }
}

module dial_hours_top(hours)
{
    translate([0,0,-dial_thickness])intersection()
    {
        rotate(hours*-30)hour_spiral();
        difference()
        {
            translate([60,0,0])cube([70,20,20],true);
            translate([60,0,0])cube([70,8,8],true);
        }
    }
}

module dial_hours_minutes_bottom(hours)
{
    translate([0,0,-dial_thickness])intersection()
    {
        rotate(hours*-30)hour_spiral();
        difference()
        {
            translate([-60,0,0])cube([70,35,35],true);
            translate([-60,0,0])union()
            {
                translate([0,8,0])cube([70,9,8],true);
                translate([0,-8,0])cube([70,8,8],true);
            }
        }
    }
}

module dial_hours_minutes_top(hours)
{
    translate([0,0,-dial_thickness])intersection()
    {
        rotate(hours*-30)hour_spiral();
        difference()
        {
            translate([60,0,0])cube([70,35,35],true);
            translate([60,0,0])union()
            {
                translate([0,8,0])cube([70,9,8],true);
                translate([0,-8,0])cube([70,8,8],true);
            }
        }
    }
}

module hour_spiral()
{
    union()
    {
        scale([spiral_scale,spiral_scale,1])rotate(0)linear_extrude(thickness_hour_pointer)golden_spiral(from, to, true, width_hour_pointer/spiral_scale);
        difference() {
            cylinder(thickness_minute_pointer,diameter_hour_pointer_ring/2,diameter_hour_pointer_ring/2,$fn=50,false);
            cylinder(thickness_hour_pointer,diameter_hour_pointer_hole/2,diameter_hour_pointer_hole/2,$fn=50,false);
        }
    }
}


module minute_spiral()
{
    difference()
    {
        union()
        {
            scale([spiral_scale,spiral_scale,1])rotate(0)linear_extrude(thickness_minute_pointer)golden_spiral(from, to, true, width_minute_pointer/spiral_scale);
            cylinder(thickness_minute_pointer,diameter_hour_pointer_ring/2,diameter_hour_pointer_ring/2,$fn=50,false);
        }
        cylinder(thickness_minute_pointer,diameter_minute_pointer_hole/2,diameter_minute_pointer_hole/2,$fn=50,false);
    }
}


// remix from: https://www.thingiverse.com/thing:1759124


function PI() = 3.14159;

function fibonacci(nth) = 
    nth == 0 || nth == 1 ? nth : (
	    fibonacci(nth - 1) + fibonacci(nth - 2)
	);
	
// Given a `radius` and `angle`, draw an arc from zero degree to `angle` degree. The `angle` ranges from 0 to 90.
// Parameters: 
//     radius - the arc radius 
//     angle - the arc angle 
//     width - the arc width 
module a_quarter_arc(radius, angle, width = 1) {
    outer = radius + width;
    intersection() {
        difference() {
            offset(r = width) circle(radius, $fn=48); 
            circle(radius, $fn=48);
        }
        polygon([[0, 0], [outer, 0], [outer, outer * sin(angle)], [outer * cos(angle), outer * sin(angle)]]);
    }
}

module golden_spiral(from, to, count_clockwise = false, width = 1) {
    if(from <= to) {
		f1 = fibonacci(from);
		f2 = fibonacci(from + 1);
		
		offset = f1 - f2;

		a_quarter_arc(f1, 90, width);

		translate([count_clockwise ? 0 : offset, count_clockwise ? offset : 0, 0]) rotate(count_clockwise ? 90 : -90) 
			golden_spiral(from + 1, to, count_clockwise, width);

	}
}

