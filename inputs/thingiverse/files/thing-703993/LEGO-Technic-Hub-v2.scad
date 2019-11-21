/*      
        LEGO Technic Hub
        Steve Medwin
        March 2015
*/
$fn=50*1.0;  
// preview[view:north east, tilt:top]

// constants
width = 7.3*1.0;        // beam width
height = 7.8*1.0;       // beam height
hole = 5.0/2;           // hole diameter
counter = 6.1/2;        // countersink diameter
depth = 0.85*1.0;       // countersink depth
pitch = 8.0*1.0;        // distance between holes
perAngleSmall = 20*1.0; // set smoothness of beam: cylinders between holes
slotWidth = 2.1*1.0;    // width of cross slot
slotLength = 5.1*1.0;   // length of cross slot
bevel = 0.4*1.0;        // bevel on bottom of cross

// user parameters
// number of holes =
Holes = 18;      // [8,9,12,18,24,27,36]
// include center for axle?
Hub = "yes";    // [yes,no]

// calculations
Degrees = 360/Holes;    // set degrees between holes to make a complete circle
numHoles = Holes;   
angleSmall = Degrees;
Diameter = ceil(Holes/3) * pitch;     // round up so distance is multiple of pitch
radius = Diameter/2;
hubDia = (11.55/2)*(Holes/9);       // distance allows beams to span lightening holes
holeRadius = (radius - width/2 - hubDia/2)/2;

// create beam
difference()
{
    // make circle from cylinder
        cylinder(h=height, r=radius+pitch+width/2, $fn = 100);
    // subtract center
       if (Hub=="yes") { translate([0,0,height - depth]) cylinder(h=height, r=radius-width/2, $fn = 100);   } 
            else { cylinder(h=height, r=radius-width/2, $fn = 100); }
    // add main holes, countersink holes and add chamfer on bottom to avoid supports
        for (i=[0:numHoles-1]) {
            rotate(a=[0,0,-i*angleSmall])
            {
                translate([0,radius,-2])
                cylinder(h=height+4, r=hole);
                
                translate([0,radius,0])
                cylinder(h=depth, r=counter);      
                
                translate([0,radius,height-depth])
                cylinder(h=depth, r=counter);
                
                translate([0,radius,depth])
                cylinder(h=(counter - hole), r1=counter, r2=hole);      
            }    
        }
    // add second row of holes
        for (i=[0:numHoles-1]) {
            rotate(a=[0,0,-i*angleSmall])
            {
                translate([0,radius+pitch,-2])
                cylinder(h=height+4, r=hole);
                
                translate([0,radius+pitch,0])
                cylinder(h=depth, r=counter);      
                
                translate([0,radius+pitch,height-depth])
                cylinder(h=depth, r=counter);
                
                translate([0,radius+pitch,depth])
                cylinder(h=(counter - hole), r1=counter, r2=hole);       
            }    
        }                       
    // subtract cross for shaft
        cube(size = [slotWidth+bevel, slotLength+bevel, depth], center = true);
        cube(size = [slotLength+bevel, slotWidth+bevel, depth], center = true);
        cube(size = [slotWidth, slotLength, height*2], center = true);
        cube(size = [slotLength, slotWidth, height*2], center = true);       
   // subtract lightening holes unless only 9 holes then too small
        if (Holes > 9) { 
            for (i=[0:3]) {
                rotate(a=[0,0,i*90])
                translate([holeRadius + hubDia/2,0,0]) 
                cylinder(h=height, r=holeRadius, $fn = 100); 
            }
        }
  }


  