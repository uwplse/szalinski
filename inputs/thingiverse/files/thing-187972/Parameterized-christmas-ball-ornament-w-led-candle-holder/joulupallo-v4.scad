// -------------------------------------------------------------------------
// NOTE: All dimensions are in millimeters

/* [ General ] */
// Which part would you like to print?
part = "sphere"; // [sphere:Sphere, led_candle_holder:Led candle holder, loop_pin:Loop pin]

// -------------------------------------------------------------------------
// Uncomment one of the following hole_type definitions
// Note that if you choose heart, you get better results if you
// print the ball upside down, see the "upside_down" parameter
// NOTE: For some reason when hole_type is "star2" or "star3", the
// sphere is not visible after loading the desigin (F4 in openscad),
// but it will appear after compiling the desing (F6 in openscad).

// Select the shape of the hole. The customizer (or Openscad with default settings) is not able to render star2 or star3 if Hole Count > 10 (or so), but the model still works if you compile it yourself in Openscad.
hole_type = "pentagram"; // [pentagram, heart, triangle, circle, ring_circle, star, star2, star3] 

// The size of the sphere.
sphere_diamater = 80;

// Number of holes on the sphere's equator
hole_count = 24; 

// the default hole sizes are derived from the size of the sphere.
// You can use hole_size_scale to increase or decrese the hole size

// Use to increase or decrease the size of the holes. For example, set to 1.1 to increase the size by 10%.
hole_size_scale = 1;

// --------------------------------------------------------------------------
// set led_candle_mount true if you want to include a mounting hole for 
// a led candle.
// NOTE: If enable led candle mount, print the separate led candle 
// holder first to make sure the candle will fit in the mounting hole
// (see led_candle_holder variable)

// Select Yes if you want to include a mounting hole for a led candle. If No, a suppor structure is added automatically.
led_candle_mount = 1; // [1:Yes, 0:No]

// The size of the led candle you have. Measure your candle and adjust the number accordingly
led_candle_diameter = 37.6;

// The height of the cylinder part or the base of the led candle. The led itself (the wick) is not included.
led_candle_height = 19; 

// -----------------------------------------------------------------------
// A fixed hanging loop on the north pole of the sphere
enable_loop = 1; // [1:Yes, 0:No]

do_loop = (!pin_loop_hole && enable_loop);

// -------------------------------------------------------------------
// Some shapes like the heart will print better if the model is turned upside  down. 
upside_down = 0; // [1:Yes, 0:No]

// ---------------------------------------------------------------------
// Prints a hole for a loop with a pin instead a fixed loop. Useful if you print the model upside down
pin_loop_hole = 0; // [1:Yes, 0:No]

/* [ Supports ] */

// --------------------------------------------------------------------------
// If you don't include the led candle mounting hole, a support poles are
// enable by default. They prevent the ball rolling over when printing
// Set enable_supports to false if you want disable the 
// supports when the led candle mounting hole is _not_ included
// The are 3 circles of suppors by default. You may not nessecarily always 
// need all of them. You may disable them by setting corresponding 
// enable_supports_circle_N variable to false
enable_supports = !led_candle_mount;

// Supports are included only if Led Candle Mount parameter is "No"
enable_supports_circle_1 = 0; // [1:Yes, 0:No]
enable_supports_circle_2 = 1; // [1:Yes, 0:No]
enable_supports_circle_3 = 1; // [1:Yes, 0:No]

// -------------------------------------------------------------------------
// Change to move the support poles closer of futher from the south pole. For example, 0.9 moves the poles 10% closer to the south pole.
supports_circle_scale_1 = 1;
supports_circle_scale_2 = 1;
supports_circle_scale_3 = 1;



/*  [Hidden] */

// -------------------------------------------------------------------------
// how much the led candle mount comes out from the sphere
led_candle_collar_height = 2; 

// Sphere's radius
outer_radius = sphere_diamater/2; 

// --------------------------------------------------------------------------
// set angle in degress if you wan't to rotate the holes around their
// center points

// Hole rotation
hole_rotation = 0; // [0:360]



// if loop is not enabled, make a hole on the top (the north pole) of the
// sphere. Set to false to disable
hole_on_top = !(do_loop || pin_loop_hole);




// -------------------------------------------------------------------
// ------------------------------------------------------------------
// You don't normally need to change the settings below this line, 
// but please feel free to modify the code as you wish

wall_thickness = 1.5;  // how thick the sphere's wall is. 1.5 is
                       // good default

sphere_rot = 0;
inner_radius = outer_radius - wall_thickness;

hole_circle_radius = hole_size_scale * outer_radius/15;
hole_circle_fn=12;

hole_ring_circle_radius = hole_size_scale * outer_radius/15;

hole_pentagram_size = hole_size_scale * outer_radius/6;

hole_star2_size = hole_size_scale * outer_radius/6.5;
hole_star2_fn= 12;

hole_star_size = hole_size_scale * outer_radius/8;
//hole_star_size = 6;


hole_heart_size = hole_size_scale * outer_radius/9.5;
hole_heart_fn=12;

hole_triangle_size = hole_size_scale * outer_radius/7.5;


loop_radius = outer_radius/15;
loop_thickness = 2;
loop_fn=12;

//hole_count = 12; // number of holes on the sphere's equator
//hole_on_bottom = false; // if true, draws a hole on sphere's south pole

// hole_on_bottom = upside_down;


//led_candle_radius = 19.1;
//led_candle_radius = 37.4/2.0; // AIRAM led-tuikku
led_candle_fn = 32;
led_candle_tolerance = 0.5;
led_candle_wall_thickness = 1.5;
module do_hole()
{
    rotate(hole_rotation, [1,0,0]) {
	translate(v=[inner_radius-2,0,0]) {

	    if (hole_type == "heart") hole_heart();
	    else if (hole_type == "triangle") hole_triangle();
	    else if (hole_type == "star") hole_star();
	    else if (hole_type == "star2") hole_star2(5,0);
	    else if (hole_type == "star3") hole_star2(6,360/12);
	    else if (hole_type == "circle") hole_circle();
	    else if (hole_type == "pentagram") hole_pentagram();
	    else if (hole_type == "ring_circle") hole_ring_circle();

	}
    }
}


// Equilateral triangle
module triangle_equilateral(size) {

  height = wall_thickness+2;
  translate(v = [-size/2,-size*sin(60)/2, 0]) {
    polyhedron
      (
       points = [   
		 [0,0,-height],
		 [size,0,-height],
		 
		 [size*cos(60),size*sin(60),-height],
		 [0,0,height],

		 [size,0,height],
		 [size*cos(60),size*sin(60),height],
		    ],                                 
       triangles=[
		  [0,1,2],
		  [3,5,4],
		  
		  [0,3,1],
		  [3,4,1],
		  
		  [1,5,2],
		  [4,5,1],
		  
		  [0,5,3],
		  [0,2,5]
		  ]                         
       );
  }
}



// isosceles triangle
module triangle_isosceles(size, alpha) {

  ratio = tan(alpha);
  ratio2 = tan(alpha/2);
  height = wall_thickness+2;
  size_per_2 = size/2;
  size_per_2_ratio = size_per_2 * ratio;
  size_per_2_ratio2 = size_per_2 * ratio2;

  translate(v = [-size/2,-size_per_2_ratio2, 0]) {
    polyhedron
      (
       points = [   
		 [0,0,-height],
		 [size,0,-height],
		 [size_per_2, size_per_2_ratio,-height],

		 [0,0,height],
		 [size,0,height],
		 [size_per_2, size_per_2_ratio,height],
		    ],                                 
       triangles=[
		  [0,1,2],
		  [3,5,4],
		  
		  [0,3,1],
		  [3,4,1],
		  
		  [1,5,2],
		  [4,5,1],
		  
		  [0,5,3],
		  [0,2,5]
		  ]                         
       );
  }
}


module loop()
{
  rad = loop_radius;
  difference() {
    translate(v=[0,0,rad+outer_radius]) {
      rotate(90, [0,1,0]) {
	difference() {
	  cylinder(r=rad+loop_thickness, h=loop_thickness, $fn=loop_fn, center=true);
	  cylinder(r=rad, h=loop_thickness+1, $fn=loop_fn, center=true);
	}
      }
    }
    sphere(inner_radius, center=true, $fn=64);
  }
}

module loop_pin()
{
  loop_hole_radius = 2;
  rad = loop_radius;
  pin_height = 3+2+wall_thickness+0.5;
  difference() {
  union() {
    // knop
    intersection() {
      cylinder(r1=loop_hole_radius-0.25, r2=loop_hole_radius+0.5, h=2, $fn=12, center=false);
      cube
	(
	 size=[2*(loop_hole_radius+0.5), 2*(loop_hole_radius-0.25), 5], 
	 center=true
	 );
    }
    
    // pin
    cylinder(r=loop_hole_radius-0.25, h=pin_height, $fn=12, center=false);
    
    // loop
    translate(v=[0,0,rad/2+pin_height+loop_thickness])
      rotate(90, [0,1,0]) {
      difference() {
	cylinder(r=rad+loop_thickness, h=loop_thickness, $fn=loop_fn, center=true);
	cylinder(r=rad, h=loop_thickness+1, $fn=loop_fn, center=true);
      }
    }
    
  }
  translate(v=[-(loop_hole_radius-1.5), -(loop_hole_radius+0.5+1), -1])
  cube(size=[2*(loop_hole_radius-1.5), 2*(loop_hole_radius+0.5+1), 2+2+wall_thickness+0.5]);
  }
  
}

module hole_ring_circle()
{
    height = 2*wall_thickness+4;
    num_circles = 12;
    alpha = 360/12;
    rad = 6;
    rad2 = 2*rad/num_circles;
    rotate(90,[0,1,0]) { 
	union() {
	    for (i = [0:num_circles-1]) {
		translate(v=[cos(i*alpha)*rad, sin(i*alpha)*rad, 0]) {
		    cylinder(r=rad2, h=height, center=true, $fn=12);
		}
	    }
	    cylinder(r=rad/2, h=height, center=true, $fn=12);
	}
    }
    
}

module hole_heart() {

  size = hole_heart_size;

  r1 = ((size/2)/cos(30))/2;
  shift_x = (2/3)*((r1 + r1*sin(30))/2 - size*sin(60)/2);

  height = (wall_thickness+2) * 2;

  rotate(90,[0,1,0])
  translate(v=[shift_x, 0, 0])
  union() {
    translate(v=[size*cos(30)/2,0,0]) rotate(270, [0,0,1]) triangle_equilateral(size);
    translate(v=[-r1*sin(30), -r1*cos(30), 0]) cylinder(r=r1,h=height,$fn=hole_heart_fn,center=true);
    translate(v=[-r1*sin(30), r1*cos(30), 0]) cylinder(r=r1,h=height,$fn=hole_heart_fn,center=true);
  }
}


module hole_pentagram()
{
    alpha=36;
    rotate(90,[0,0,1]) {
	rotate(90,[1,0,0]) {
	    rotate(180,[0,0,1]) {
		union() {
		    triangle_isosceles(hole_pentagram_size, alpha);	
		    rotate(72,[0,0,1]) triangle_isosceles(hole_pentagram_size, alpha);
		    rotate(144,[0,0,1]) triangle_isosceles(hole_pentagram_size, alpha);
		}
	    }
	}
    }
}


module hole_star()
{
    rotate(90,[0,0,1]) {
	rotate(90,[1,0,0]) {
	    union() {
		translate(v=[0,hole_star_size/6,0]) triangle_equilateral(hole_star_size);
		translate(v=[0,-hole_star_size/6,0]) rotate(180,[0,0,1]) triangle_equilateral(hole_star_size);
	    }
	    }
    }
}


module hole_star2(sides, rot)
{
    r = hole_star2_size / 2.0;
    alpha = 360/sides;
    o = 90 - alpha/2;
    b = tan(o)*r;
    c = sqrt(b*b + r*r);
    height = (wall_thickness+2) * 2;
    rotate(rot,[1,0,0]) {
	rotate(90,[0,1,0]) { 
	    rotate(270,[0,0,1]) {
		difference() {
		    cylinder(r=b, h=height, $fn=12, center=true);
		    for (i=[0 : sides-1]) {
			translate(v=[sin(i*alpha)*c,cos(i*alpha)*c,0]) {
			    cylinder(r=r*1.05, h=height*2, $fn=12, center=true);
			}
		    }
		}
	    }
	}
    }
}


module hole_triangle()
{
  rotate(90,[0,0,1]) {
    rotate(90,[1,0,0]) {
      triangle_equilateral(hole_triangle_size);
    }
  }
}


module hole_circle()
{
  height = 2*wall_thickness+4;
  rotate(90,[0,1,0]) { 
       cylinder(r=hole_circle_radius, h=height, center=true);
     }
}

module hole(i, nholes, declination) {
  rot = i * 360/nholes;
  rotate(declination, [cos(rot-90), sin(rot-90), 0]) {
    rotate(rot,[0,0,1]) {
      do_hole();
    }
  }
}


module draw_latitude(nholes, declanation)
{
  nholes = floor(nholes * cos(declanation));
  for (i=[0 : nholes-1]) {
    hole(i,nholes,declanation);
  }
}

module draw_holes(nholes) {

  j = floor(nholes/4);
  draw_latitude(nholes, 0);

  for (i=[1 : j]) {
    draw_latitude(nholes, i * 360/nholes);
    draw_latitude(nholes, -i * 360/nholes);
  }


  
}

module ball_frame() {
  difference() {
    sphere(outer_radius, center=true, $fn=64);
    sphere(inner_radius, center=true, $fn=64);
  }
}


module pole()
{
  union() {
    cylinder
      (r=0.75,h=outer_radius, center=false, $fn=12);
    cylinder
      (r=1.5,h=1, center=false, $fn=12);
  }
}


module supports()
{
    dist1 = (outer_radius / 7) * supports_circle_scale_1;
    dist2 = (outer_radius / 3) * supports_circle_scale_2;
    dist3 = (outer_radius / 1.7) * supports_circle_scale_3;
    difference() {
	union() {
	    if (enable_supports_circle_1) {
		for (i=[0: 7]) {
		    translate(v=[dist1*cos(i*360/8),dist1*sin(i*360/8),
				 -outer_radius])
			pole();
		}
	    }
	    if (enable_supports_circle_2) {
		for (i=[0: 7]) {
		    translate(v=[dist2*cos(i*360/8),dist2*sin(i*360/8),
				 -outer_radius])
			pole();
		}
	    }
	    if (enable_supports_circle_3) {
		for (i=[0: 7]) {
		    translate(v=[dist3*cos(i*360/8),dist3*sin(i*360/8),
				 -outer_radius])
			pole();
		}
	    }
	}
	sphere(outer_radius+0.2, center=true, $fn=64);
    }
}

module ring(height, outer, inner) 
{
    rotate(-90, [0,1,0]) {
	difference() {
	    cylinder(r=outer, h=height, center=true, $fn=12);
	    cylinder(r=inner, h=height+1, center=true, $fn=12);
	}
    }
}


module xmasball() {
    union() {
	difference() {
	    ball_frame();
	    draw_holes(hole_count);
	    if (pin_loop_hole) {
		rotate(-90, [0,1,0]) {
		    translate(v=[inner_radius-2,0,0]) {
			hole_circle();
		    }
		}
	    }
	}

	if (pin_loop_hole) {
	    rotate(-90, [0,1,0]) {
		translate(v=[outer_radius-1,0,0]) {
		    ring(2,5,2);
		}
	    }
	}
    }
}

module led_candle_mount_part1(inner_radius, outer_radius, part2_outer_radius)
{

    //inner_radius = led_candle_radius + led_candle_tolerance;
    //outer_radius = inner_radius + led_candle_wall_thickness;
    module groove() {
	cube(size=[2*(led_candle_wall_thickness+led_candle_tolerance/2), 2*led_candle_wall_thickness+led_candle_tolerance/2, led_candle_height+led_candle_wall_thickness], center=true);
    }

    difference() {
	cylinder(r=outer_radius, h=led_candle_height, $fn=led_candle_fn, center=true);	
	translate(v=[0,0,-led_candle_wall_thickness]) {
	    cylinder(r=inner_radius, h=led_candle_height+led_candle_wall_thickness, $fn=led_candle_fn, center=true);	
	}
	translate(v=[0,0,led_candle_wall_thickness*2]) {
	    cylinder(r=inner_radius-led_candle_wall_thickness*2, h=led_candle_height+led_candle_wall_thickness, $fn=led_candle_fn, center=true);	
	}
	translate(v=[outer_radius,0,0]) {
	    groove();
	}
	translate(v=[-outer_radius,0,0]) {
	    groove();
	}
	rotate(90,[0,0,1]) {		 		 
	    translate(v=[inner_radius-led_candle_wall_thickness*2,0,0]) {
		groove();	   
	    }
	}


    }
}

module led_candle_mount_part2(inner_radius, outer_radius, height, part1_inner_radius)
{
    //inner_radius = led_candle_radius + led_candle_wall_thickness + led_candle_tolerance*2;
    //outer_radius = inner_radius + led_candle_wall_thickness;
    cyl_height = height;
    rad_pole = led_candle_wall_thickness;
    dz_pole = cyl_height/2 - rad_pole;
    union() {
	translate(v=[0,0,cyl_height/2-led_candle_wall_thickness/2]) {
	    intersection() {
		cylinder(r=outer_radius, h=cyl_height, $fn=led_candle_fn, center=true);	
		difference() {
		    cube(size=[outer_radius*2,outer_radius*2,led_candle_wall_thickness], center=true);
		    cube(size=[outer_radius*2,outer_radius*1.5,led_candle_wall_thickness*2], center=true);
		}
	    }
	}
	difference() {
	    cylinder(r=outer_radius, h=cyl_height, $fn=led_candle_fn, center=true);	
	    translate(v=[0,0,-led_candle_wall_thickness]) {
		cylinder(r=inner_radius, h=led_candle_height+led_candle_wall_thickness*6, $fn=led_candle_fn, center=true);	
	    }
	}
	translate(v=[0,0,-dz_pole]) {
	    rotate(90, [0,1,0]) {
		difference() {
		    cylinder(r=rad_pole,h=outer_radius*2-led_candle_wall_thickness, $fn=led_candle_fn, center=true);
		    cylinder(r=rad_pole*2,h=part1_inner_radius*2, $fn=led_candle_fn, center=true);
		}
	    }
	}

    }
    
}



part1_inner_radius = led_candle_diameter/2 + led_candle_tolerance;
part1_outer_radius = part1_inner_radius + led_candle_wall_thickness;

part2_inner_radius = part1_outer_radius + led_candle_tolerance;
part2_outer_radius = part2_inner_radius + led_candle_wall_thickness;
part2_height = led_candle_height + led_candle_wall_thickness*3 + led_candle_tolerance;

part2_translate = sqrt
    (
     outer_radius*outer_radius - part1_outer_radius*part2_outer_radius
     );



if (part == "loop_pin") {
    loop_pin();
}
else if (part == "led_candle_holder")  {
    // render the separate led candle holder part
    translate(v=[0,0,led_candle_height/2]) {
	rotate(180, [0,1,0]) { 
	    led_candle_mount_part1(part1_inner_radius, part1_outer_radius, part2_outer_radius);
	}
    }
}
else {
    difference() {
	union() {
	    if (upside_down) rotate(180, [0,1,0]) xmasball();
	    else xmasball();
	    if (led_candle_mount) {
		translate(v=[0,0,-(outer_radius-led_candle_height/1.25)]) {
		    cylinder(r=part1_outer_radius,h=led_candle_height, 
			     center=true);
		}
	    }
	}

	if (hole_on_top) hole(0,1,90);
	if (led_candle_mount) {
	    translate(v=[0,0,-(outer_radius-led_candle_height/2)]) {
		cylinder(r=part2_outer_radius-led_candle_wall_thickness,
			 h=led_candle_height*2, center=true);
	    }
	}
    }
    if (do_loop) loop();

    if (led_candle_mount) {
	rotate(180,[0,1,0]) {
	    translate(v=[0,0, part2_translate - 
			 part2_height/2+led_candle_collar_height]) {
		rotate(180, [0,1,0]) {
		    led_candle_mount_part2
			(
			 part2_inner_radius,  part2_outer_radius, 
			 part2_height, part1_inner_radius
			 );
		}
	    }
	}
    }

    if (enable_supports) {
	supports();
    }
}


 
