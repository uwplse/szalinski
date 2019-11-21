include <configuration.scad>;



separation = 40;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin. (center to rod centerline)
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8.25;  // Hole for the hotend (J-Head diameter is 16mm) 
push_fit_height = 6.25;  // Length of brass threaded into printed plastic. may need to minimize to 3mm, (height-push_fit_height=hotend recess distance)
push_fit_radius = 6;    //increased to 6 for hex on ptfe tube quick connect(PC04-01)
eff_height = 8;
eff_recess = 1.5;  //decreased to 1.5 to enhance clamping
bracket_height = 6;
bracket_radius = 6.25; //increased to 6.25 for better fit
bracket_recess = 1.5;  //decreased to 1.5 to enhance clamping
cone_r1 = 2.5;
cone_r2 = 14;

//e3d heat sink
rim_radius = 8;
center_radius = 5;
rim_catch_radius = 6;
rim_height_top = 3.7;
rim_height_bottom = 3;
center_height = 6;
heatsink_total_height = 42.7;
heatsink_height = 26;
fin_height = 1;
fin_space = 2.5;
fin_radius = 11.15;
heatbreak_radius = 2.1;





/////////////////////////////////////////////////////////////////////////
//renders FOR PRINT FILE
//translate([0, 0, eff_height/2]) effector();
//translate([0, offset*2+10, bracket_height/2]) rotate([180, 0, 0]) bracket();




/////////////////////////////////////////////////////////////////////////
//render FOR FULL BUILD


translate([0, 0, heatsink_total_height+(eff_height/2)-(eff_height-push_fit_height)])
rotate([180, 0, 0])
effector();

translate([0, 0, (bracket_height/2)+heatsink_total_height-bracket_height-rim_height_top+bracket_recess])
rotate([180, 0, 0])
bracket();

Jhead();



///////////////////////////////////////////////////////////////////////
//effector module
module effector() {
    color( "cyan", 1)
  difference() {
    union() {
      //main cylinder
      cylinder(r=offset-3, h=eff_height, center=true, $fn=60);
      for (a = [60:120:359]) rotate([0, 0, a]) {
	rotate([0, 0, 30]) translate([offset-2, 0, 0])
	  cube([10, 13, eff_height], center=true);
	for (s = [-1, 1]) scale([s, 1, 1]) {
	  translate([0, offset, 0]) difference() {
	    intersection() {
	      cube([separation, 40, eff_height], center=true);
	      translate([0, -4, 0]) rotate([0, 90, 0])
		cylinder(r=10, h=separation, center=true);
	      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
		cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true, $fn=24);
	    }
	    rotate([0, 90, 0])
	      cylinder(r=m3_radius, h=separation+1, center=true, $fn=12);
	    rotate([90, 0, 90])
	      cylinder(r=m3_nut_radius, h=separation-24, center=true, $fn=6);
	  }
        }
      }
    }
    //push fit hole
    cylinder(r=push_fit_radius, h=eff_height*2, center=true);
    //hotend recess
    translate([0, 0, eff_height/2-eff_recess])
      cylinder(r=hotend_radius, h=eff_height, $fn=36);
    //mounting holes
    translate([0, 0, -6]) # import("m5_internal.stl");
    for (a = [0:60:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
	cylinder(r=m3_wide_radius, h=2*eff_height, center=true, $fn=12);
    }
  }
}



///////////////////////////////////////////////////////////////////////
//bracket module
module bracket()  {
    color( "aquamarine", 1)
    difference() {
      cylinder(r=offset-3, h=bracket_height, center=true);
        union()  {
            //bracket catch opoening
            rotate([0, 0, 90])
            translate([offset, 0, 0])
            cube([offset*2, bracket_radius*2, bracket_height*2], center=true);
            //hotend recess
            translate([0, 0, (-(bracket_height+bracket_height/2)+bracket_recess)])
            cylinder(r=hotend_radius, h=bracket_height*2, center=true);
            //bracket catch (12mm diameter on e3d jhead v6)
            cylinder(r=bracket_radius, h=bracket_height*2, center=true);
            //mounting holes
            translate([0, 0, -6]) # import("m5_internal.stl");
            for (a = [0:60:359]) rotate([0, 0, a]) {
            translate([0, mount_radius, 0])
                cylinder(r=m3_wide_radius, h=2*eff_height, center=true, $fn=12);   
            }
        }
        }
    }
    




///////////////////////////////////////////////////////////////////////
//e3d j head v6 heat sink module
module Jhead () {
    color( "orange", 1)   
    difference() {
        union() {    
        //center solid
        cylinder(r=center_radius, h=heatsink_total_height);
        //top mounting rim
        translate([0, 0, heatsink_total_height-rim_height_top])
        cylinder(r=rim_radius, h=rim_height_top);
        //mounting center
        translate([0, 0, heatsink_total_height-center_height-rim_height_top])
        cylinder(r=rim_catch_radius, h=center_height);
        //bottom mounting rim
        translate([0, 0, heatsink_total_height-rim_height_top-center_height-rim_height_bottom])
        cylinder(r=rim_radius, h=rim_height_bottom);
        //rim fin
        translate([0, 0, heatsink_total_height-rim_height_top-center_height-rim_height_bottom-fin_space])
        cylinder(r=rim_radius, h=fin_height);
        //heat sink fins
        for (i =[0:fin_space:heatsink_height])  {
            translate([0, 0, i])
            cylinder(r=fin_radius, h=fin_height);;
        }
        }
        translate([0, 0, heatsink_total_height-(rim_height_top+center_height+rim_height_bottom)])
        cylinder(r=3.175, h=rim_height_top+center_height+rim_height_bottom+1);
        translate([0, 0, -1])
        cylinder(r=heatbreak_radius, h=heatsink_total_height+1);
    }
}





  


/////////////////////////////////
//aro bracket file import below
*translate([0, 0, 0])
import("C:\\Program Files\\OpenSCAD\\libraries\\MCAD\\aro.stl", convexity=10);

