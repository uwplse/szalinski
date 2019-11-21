
outer_diameter_grinder = 59.0; //outer diameter of the holder
inner_diameter_grinder = 44.0; //inner diameter of the holder (defines the rim)
thickness_grinder      =  3.2; //thickness of holder base slice

diameter_sausage  = 18.0;       //outer diameter of the pipe
height            = 100;          //total length of the filling pipe
wall              = 1.6;          //thickness of the wall of the pipe
//==== End of Parameters ====

begin_pipe=(inner_diameter_grinder-diameter_sausage)*0.7;
$fn=90;

difference() {
  union() {
    //Plate
    difference() {
        union() {
          cylinder(d=outer_diameter_grinder, h=thickness_grinder);
          //Uncomment and edit to your need if you need a NOSE for your grinder
          //Sample makes a 6mm wide node that stands 5mm out of base plate on both sides
          //translate([-outer_diameter_grinder/2-5,-6/2,0])
          //cube([2*5+outer_diameter_grinder, 6, thickness_grinder]);
        }
        cylinder(d1=inner_diameter_grinder,
                 d2=inner_diameter_grinder-2, h=thickness_grinder);
    }

    //Funnel
    difference() {
        cylinder(d1=inner_diameter_grinder+2*wall+2,  //Wall thicker here!
                 d2=diameter_sausage, 
                 h=begin_pipe+thickness_grinder);
        cylinder(d1=inner_diameter_grinder       ,
                 d2=diameter_sausage-2*wall, 
                 h=begin_pipe+thickness_grinder);
    }

    //Pipe
    translate([0,0,thickness_grinder+begin_pipe])
    difference() {
        cylinder(d=diameter_sausage,
                 h=height-begin_pipe-thickness_grinder);
        cylinder(d=diameter_sausage-2*wall, 
                 h=height);
    }

    //rounded end piece for pipe
    translate([0,0,height])
    difference() {
        minkowski() {
            cylinder(d=diameter_sausage-2*wall/4*3, h=0.2);
            sphere(r = wall/4*3, $fn=36);
        }    
        translate([0,0,-2])
        cylinder(d=diameter_sausage-2*wall, h=height);
    }
  }
  
  //Uncomment and edit to your need if you need a NOTCH for your grinder
  //The sample makes a round notch with 6mm diameter at the outer rim
  //translate([0,outer_diameter_grinder/2,0])
  //cylinder(d=6, h=thickness_grinder);
  
  
  //For Debugging: ("Cuts open" the model, uncomment if needed)
  //cube([200,200,200]);
}