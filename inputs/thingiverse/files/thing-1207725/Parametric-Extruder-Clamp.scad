// Based on extruder mount that came with my HKBay Kossel 2020
//include <configuration.scad>;
// appended


// Z-Height of Clamping surface
ClampHeight=15;

// Radius or cylindrical element to clamp to the open beam
GearBoxRadius=18.15;

// Thickness of Clamp - keep this above 2.5 for best results
ClampThickness=2.5;

// OpenBeam Profile, 2020, 1515, etc.
ExtrudedBeamWidth=20;

// Height of M3 Hardware used to attach to beam
M3HeadHeight=3.1;

// $fn - Segments per cylinder
MainCylinderFn=64;

// Stuff you don't set
ClampRadius=GearBoxRadius+ClampThickness;

//ExtrudedBeamChannelWidth=5.85;
//ExtrudedBeamChannelDepth=1.5;

module extruderClamp() {
    difference() {
    union() {
        //hull() {
        //main cylinder
        color( "blue", 1) cylinder(h=ClampHeight, r=ClampRadius, $fn=MainCylinderFn);
        //mount to extrusion - modified to keep bottom flat for print
        hull() {
        translate([-ClampRadius-ClampThickness,-(ExtrudedBeamWidth/2),0])
            cube([(2*ClampThickness),ExtrudedBeamWidth,ClampHeight]);
        translate([-ClampRadius-(2*ClampThickness),-(ExtrudedBeamWidth/2),0])
            cube([ClampThickness,ExtrudedBeamWidth,1.5*ClampHeight]);
     //clamp mount hole reinforcement top
     translate([-ClampRadius-ClampThickness,0,1.5*ClampHeight-m3_nut_radius])
     rotate([0,90,0])
     cylinder(h=(2*ClampThickness), r=m3_nut_radius, $fn=MainCylinderFn);
    

     };//hull
     /*
     // Channel filler
     // ExtrudedBeamChannelWidth ExtrudedBeamChannelDepth   
     translate([-ClampRadius-(2*ClampThickness)-ExtrudedBeamChannelDepth,-ExtrudedBeamChannelWidth/2,0])
            cube([ExtrudedBeamChannelDepth,ExtrudedBeamChannelWidth,1.5*ClampHeight]);   
     */
        // Side bump outs for the main Clamping screws
        hull() {
        translate([-ClampThickness,ClampRadius,0])
            cube([(2*ClampThickness),(2*ClampThickness),ClampHeight]); 
        translate([0,ClampRadius-(ClampThickness/2),0])
            cylinder(h=ClampHeight, r=(2.25*ClampThickness), $fn=MainCylinderFn);
        };//hull
        hull(){
        translate([-ClampThickness,-ClampRadius-(2*ClampThickness),0])
            cube([(2*ClampThickness),(2*ClampThickness),ClampHeight]);
        translate([0,-ClampRadius+(ClampThickness/2),0])
            cylinder(h=ClampHeight, r=(2.25*ClampThickness), $fn=MainCylinderFn);
       };//hull

        
        
     }//union clamp body
                 
     // Top - M3 Screw hole Head Height recess for flush fitting
     translate([-(.98*GearBoxRadius+M3HeadHeight),0,1.35*ClampHeight-m3_nut_radius])
     rotate([0,90,0])
     # cylinder(h=M3HeadHeight, r=m3_nut_radius, $fn=MainCylinderFn);
    
    // Top - M3 Screw hole
    translate([-ClampRadius-(3*ClampThickness),0,1.35*ClampHeight-m3_nut_radius])
     rotate([0,90,0])
     # cylinder(h=6*ClampThickness, r=1.7, $fn=12);
     
     // Bottom - M3 Screw hole Head Height recess for flush fitting
     translate([-(.98*GearBoxRadius+M3HeadHeight),0,.55*ClampHeight-m3_nut_radius])
     rotate([0,90,0])
     # cylinder(h=M3HeadHeight, r=m3_nut_radius, $fn=MainCylinderFn);
    
    // Bottom - M3 Screw hole
    translate([-ClampRadius-(3*ClampThickness),0,.55*ClampHeight-m3_nut_radius])
     rotate([0,90,0])
     # cylinder(h=6*ClampThickness, r=1.7, $fn=12);
    
//main cylinder - cut out
   cylinder(h=ClampHeight, r=GearBoxRadius, $fn=MainCylinderFn);
 //main cylinder - Bisecting Cut   
    translate([-0.5,-1.5*ClampRadius,0])
    # cube([1,3*ClampRadius,ClampHeight]);
    
    //clamp hex cap screw recess left, ref. extrusion mount at back
    translate([1.5*ClampThickness,-ClampRadius-ClampThickness/2,ClampHeight/2]) 
    rotate([0,90,0])
      cylinder(h=4*ClampThickness, r=m3_nut_radius, $fn=MainCylinderFn);
    //clamp nut left, ref. extrusion mount at back
    translate([-1.5*ClampThickness,-ClampRadius-ClampThickness/2,ClampHeight/2])   
    rotate([180,90,0])
      cylinder(h=4*ClampThickness, r=m3_nut_radius, $fn=6);
    
    // M3 Screw hole - left
    translate([-3*ClampThickness*ClampThickness,-ClampRadius-ClampThickness/2,ClampHeight/2]) 
    rotate([0,90,0])
    # cylinder(h=6*ClampThickness*ClampThickness, r=1.7, $fn=12);
    
    //clamp hex cap screw recess right, ref. extrusion mount at back
    translate([1.5*ClampThickness,ClampRadius+ClampThickness/2,ClampHeight/2])   
    rotate([0,90,0])
      cylinder(h=4*ClampThickness, r=m3_nut_radius, $fn=MainCylinderFn);
    //clamp nut right, ref. extrusion mount at back
    translate([-1.5*ClampThickness,ClampRadius+ClampThickness/2,ClampHeight/2])   
    rotate([180,90,0])
      cylinder(h=4*ClampThickness, r=m3_nut_radius, $fn=6);
    
    // M3 Screw hole - right
    translate([-3*ClampThickness*ClampThickness,ClampRadius+ClampThickness/2,ClampHeight/2])   
    rotate([0,90,0])
      # cylinder(h=6*ClampThickness*ClampThickness, r=1.7, $fn=12);
    }
    
}

extruderClamp();


//Begin <configuration.scad>
// Increase this if your slicer or printer make holes too tight.
extra_radius = 0.1;

// OD = outside diameter, corner to corner.
m3_nut_od = 6.1;
m3_nut_radius = m3_nut_od/2 + 0.2 + extra_radius;
m3_washer_radius = 3.5 + extra_radius;

// Major diameter of metric 3mm thread.
m3_major = 2.85;
m3_radius = m3_major/2 + extra_radius;
m3_wide_radius = m3_major/2 + extra_radius + 0.2;

// NEMA17 stepper motors.
motor_shaft_diameter = 5;
motor_shaft_radius = motor_shaft_diameter/2 + extra_radius;

// Frame brackets. M3x8mm screws work best with 3.6 mm brackets.
thickness = 3.6;

// OpenBeam or Misumi. Currently only 15x15 mm, but there is a plan
// to make models more parametric and allow 20x20 mm in the future.
extrusion = 20;

// Placement for the NEMA17 stepper motors.
motor_offset = 44;
motor_length = 47;
