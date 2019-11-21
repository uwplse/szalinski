// Generic foot with #6 bolt and #6 square nut
// Al Williams (al.williams@awce.com or @awce_com)
// Hacked to fit with Customizer template

//	Uncomment the library/libraries of your choice to include them


//CUSTOMIZER VARIABLES

// Units for all custom variables
Units=1;  // [1:mm, 25.4:inches, 0.254:mils]
// Diameter of screw holes, 3.7mm = #6 clearance hole.  if your printer is a little "tight" you might open it up a bit
Bolt_Size=3.7; 
boltsize=Bolt_Size*Units;
// How deep do you want the bolt hole? Should be slightly shorter than the bolt so the nut can engage
Bolt_Depth=12.2;  
boltdepth=Bolt_Depth*Units;
// Size of the square nut (example #6 nut is 5/16 inch which is 7.9375 mm)
Nut_Size=7.9375;
nutsize=Nut_Size*Units;
// Foot height
Total_Height=40;
totalh=Total_Height*Units;


totalw=boltsize*4;    // diameter not radius!

// the .1 fudge factor here makes sure
// there is a clean cut between the bolt hole
// and the nut hole
nutdepth=(totalh-boltdepth)+0.1;


//CUSTOMIZER VARIABLES END


$fn=55+0; // # of arcs in a circle -- higher is better but runs longer

// Some measurements are in inches (original)
in2mm=25.4+0;




// mounting bolt hole
module bolthole()
{
// the .02 makes it stretch a little past the edge
// so the cut is clean
  translate([0,0,totalh-boltdepth])
    cylinder(h=boltdepth+.02,r=boltsize/2); 
    
}

module nuthole()
{
// The .02 makes it stretch a little past the edge
// so the cut is clean
translate([0,0,nutdepth/2])
   {
     cube(size=[nutsize,nutsize, nutdepth+.02],center=true); 
    }
}


// Here we go (translate and rotate so big end is up for printing)
translate([0,0,totalh])
rotate ([180,0,0]) difference () {
    cylinder(r=totalw/2,h=totalh,center=false);
    bolthole();
    nuthole();
}
