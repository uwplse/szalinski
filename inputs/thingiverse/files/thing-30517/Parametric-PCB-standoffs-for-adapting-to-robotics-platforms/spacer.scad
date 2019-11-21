$fn = 40;

inches_to_mm = 25.4;

hole_1_diameter = 0.185*inches_to_mm;
hole_2_diameter = 0.140*inches_to_mm;
dx_h1h2_center = 1/8*inches_to_mm;
dy_h1h2_center = 5/8*inches_to_mm;
spacer_width = 0.3*inches_to_mm;
spacer_thickness = 0.1*inches_to_mm;
standoff_thickness = 0.375*inches_to_mm;

translate([1,1,0]) bracket_1();
translate([-1,1,0]) bracket_2();
translate([1,-1,0]) bracket_3();
translate([-1,-1,0]) bracket_4();
               

module bracket_1()
{
  difference()
  {
    union()
    {
      // A
      linear_extrude(height=spacer_thickness) square([spacer_width,dy_h1h2_center+spacer_width]);
      // B
      linear_extrude(height=spacer_thickness) translate([0,dy_h1h2_center]) square([dx_h1h2_center+spacer_width,spacer_width]);
      // C
      linear_extrude(height=standoff_thickness) translate([dx_h1h2_center,dy_h1h2_center]) square([spacer_width,spacer_width]);
    }



    translate([0,0,-1]) linear_extrude(height=spacer_thickness+2) translate([spacer_width/2,spacer_width/2]) circle(r=hole_1_diameter/2);
    translate([0,0,-1]) linear_extrude(height=standoff_thickness+2) translate([dx_h1h2_center+spacer_width/2,dy_h1h2_center+spacer_width/2]) circle(r=hole_2_diameter/2);
  }
}

module bracket_2()
{
  multmatrix(m = [ [-1, 0, 0, 0],
		  [0, 1, 0, 0],
		  [0, 0, 1, 0],
		  [0, 0, 0, 1]
		]) bracket_1();
}

module bracket_3()
{
  multmatrix(m = [ [1, 0, 0, 0],
		  [0, -1, 0, 0],
		  [0, 0, 1, 0],
		  [0, 0, 0, 1]
		]) bracket_1();
}

module bracket_4()
{
  multmatrix(m = [ [-1, 0, 0, 0],
		  [0, -1, 0, 0],
		  [0, 0, 1, 0],
		  [0, 0, 0, 1]
		]) bracket_1();
}