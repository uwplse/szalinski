// This is a stand for:
//    Moon https://www.thingiverse.com/thing:2955930,
//    Earth Globe https://www.thingiverse.com/thing:2565357, 
//    Jupiter https://www.thingiverse.com/thing:2747956, 
//    or any other sphere.
// This stand is designed to put a led light in the bottom.
// I use the Ozark Trail 3-LED Headlamp from Walmart which sells for 1 USD in the store.
// https://www.walmart.com/ip/Ozark-Trail-10-Pack-LED-Headlamp-for-Camping-and-Outdoor-Use/49332881
// All measurements are in millimeters.
// The total height of the stand is calculated based on the measurements you provide
// so that the sphere does not touch the lamp.

/* [Parameters] */
// (mm) this is the diameter of the sphere which will rest on top of the stand
sphere_diameter = 72;  

// (mm) if using a lamp, make sure you lamp fits in here  
stand_inner_diameter = 54; 
// (mm) you can set this to zero if you don't need room for a lamp
height_of_lamp = 17; 
// (mm)
gap_between_lamp_and_sphere = 1;

// (mm) you may adjust the wall thickness to make the stand more or less translucent
wall_thickness = 3;
// (mm) you can set this to zero to remove the bottom
bottom_thickness = 4;
// (degrees) decrease this number to create a flared base
flare_angle = 90; // [20:90]
// for flared bases, do you want the inner wall to also be flared?
flare_inner_wall = 0; // [0:no,1:yes]

// number of facets to create the cylinder, use a smaller number for quick preview, larger number before creating the STL
FN = 50; // [8:100]

/* [Hidden] */
$fn=FN;
innerRadius = stand_inner_diameter/2; 
outerRadius = innerRadius + wall_thickness;
outerDiameter = outerRadius*2;
sphereRadius = sphere_diameter/2;
a = acos((sphereRadius*sphereRadius*2-(outerDiameter*outerDiameter))/(2*sphereRadius*sphereRadius));
// this is the height of the portion of the sphere that drops into the outer cylinder
heightOfSphereInCylinder = (sphere_diameter/2) * (1 - cos(a/2));
distanceToBottomOfSphere = bottom_thickness + height_of_lamp + gap_between_lamp_and_sphere;
echo(distanceToBottomOfSphere=distanceToBottomOfSphere);
totalHeight = distanceToBottomOfSphere + heightOfSphereInCylinder;
echo(totalHeight=totalHeight);

addedBaseRadius = (flare_angle < 90) ? totalHeight/tan(flare_angle) : 0;
echo(addedBaseRadius=addedBaseRadius);

difference() {
    cylinder(totalHeight,r1=outerRadius+addedBaseRadius,r2=outerRadius);
    cylinder(totalHeight,r1=innerRadius+(flare_inner_wall==1?addedBaseRadius:0),r2=innerRadius);
    //cylinder(totalHeight,r=outerRadius,true);
    //cylinder(totalHeight,r=innerRadius,true);
    translate([0,0,distanceToBottomOfSphere+sphereRadius]){
        sphere(d=sphere_diameter);
    }
}
if (bottom_thickness > 0){
    rtop = ((flare_angle < 90) ? (bottom_thickness/tan(flare_angle)) : 0);
    echo(rtop=rtop);
    cylinder(bottom_thickness,r1=outerRadius+addedBaseRadius,r2=outerRadius+addedBaseRadius-rtop);
}


