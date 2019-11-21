// Ava's Gear Toy 1 by Les Hall
// modified from Gear Toy 1 on Sat July 4 2015



// parameters
part = 4;  // 1=base, 2=gear1, 3=gear2, 4=thing, 5=assembly
nozzle = 0.4;  // diameter of nozzle opening
circPitch = 10;  // length of teeth
teeth1 = 20;  // number of teeth on first gear
teeth2 = 10;  // number of teeth on second gear
spacing = 3;  // spacing between parts in print
baseThickness = 5;  // thickness of base
shaftDiameter = 15;  // diameter of shaft
gearThickness = 12;  // thickness of gears
play = 1;  // excess room for rotation of gears
$fn = 50;  // number of facets



// include the gear library that does all the hard work for us
include <MCAD/involute_gears.scad>



// decare the functions that will be used later
function pitch(mm) = mm * 180 / PI;
function radius(cp, teeth) = cp * teeth / PI / 2 + nozzle;



// calculations
radius1 = radius(circPitch, teeth1) + nozzle/2 + play/2;
radius2 = radius(circPitch, teeth2) + nozzle/2 + play/2;



// decide which part to make and make it
if (part == 1)
	base();
else if (part == 2)
	gear1();
else if (part == 3)
	gear2();
else if (part == 4)
    thing();
else if (part == 5)
    assembly();



// draw the assembly
module assembly()
{
    base();
    
    translate([0, -radius1, baseThickness])
    gear1();
    
    translate([0, radius2, baseThickness])
    gear2();
}



// draw the base and both gears, ready for printing 
module thing()
{
    rotate(-atan2(radius2-radius1, 2.25*max(radius2, radius1) + 
        circPitch + spacing) )
    {
        translate([-(circPitch + max(radius2, radius1)), 0, 0])
        base();
        
        translate([max(radius1, radius2), 0, 0])
        {
            translate([0, 
                radius2-max(radius1, radius2)/2+circPitch/2, 0])
            rotate(180/teeth1)
            gear1();
            
            translate([0, 
                -(radius1+max(radius1, radius2)/2+circPitch/2), 0])
            rotate(180/teeth2)
            gear2();
        }
    }
}



// draw the base by itself
module base()
{
    // hull makes a shape that conforms to 
    // all the shapes of its children
    hull()
    {
        // child 1 is gear 1 plus a border
        translate([0, -radius1, 0])
        cylinder(r=circPitch*3/4 + radius1, 
            h=baseThickness);
        
        // child 2 is gear 2 plus a border
        translate([0, radius2, 0])
        cylinder(r=circPitch*3/4 + radius2, 
            h=baseThickness);
    }
    
    translate([0, -radius1, baseThickness])
        cylinder(r=(shaftDiameter-nozzle)/2, 
            h=gearThickness*4/3);
    
    translate([0, radius2, baseThickness])
        cylinder(r=(shaftDiameter-nozzle)/2, 
            h=gearThickness*4/3);
}



// draw gear1 by itself
module gear1()
{
    // call the gear function from the involute gears library
    // that was instantiated way up near the top of the file
    gear (
        number_of_teeth = teeth1, 
        circular_pitch=pitch(circPitch), 
        bore_diameter = shaftDiameter+nozzle+play, 
        hub_diameter = shaftDiameter*4/3+nozzle+play, 
        rim_width = shaftDiameter/6, 
        gear_thickness = gearThickness*2/3, 
        rim_thickness = gearThickness, 
        hub_thickness = gearThickness, 
        circles=8);
}



// draw gear2 by itself
module gear2()
{
    // call the gear function from the involute gears library
    // that was instantiated way up near the top of the file
	gear (
        number_of_teeth = teeth2, 
        circular_pitch=pitch(circPitch), 
        bore_diameter = shaftDiameter+nozzle+play, 
        hub_diameter = shaftDiameter*4/3+nozzle+play, 
        rim_width = shaftDiameter/6, 
        gear_thickness = gearThickness*2/3, 
        rim_thickness = gearThickness, 
        hub_thickness = gearThickness, 
        circles=0);
}


