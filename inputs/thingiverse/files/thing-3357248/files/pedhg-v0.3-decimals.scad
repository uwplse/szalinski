// configurable stuff

magnet_diameter = 5;    // [1:0.1:10]
magnet_thickness = 3;   // [1:0.1:10]
glass_thickness = 3;    // [1:0.1:10]

/* [Hidden] */

// number of facets
$fn = 50;

t2 = 5;     // extra edging around magnet to hold it in place

// extra space for magnet to stick out from recessed hole, to avoid the magnet from sinking in too deep and not making contact with its counterpart
// also my 3mm magnet seems to only be 2.5mm thick - need to account for this
t3 = 1;   


// aliases to simplify formulas

d1 = magnet_diameter + 0.2; // made it a bit bigger - too difficult to rely on stud friction - just use superglue/epoxy
t1 = magnet_thickness;
g1 = glass_thickness;
x2 = (d1+(2*t2));   // thickness of 1 magnet holder
x3 = 2*x2;          // two magnet holders

// this makes a "magnet holder" i.e. a cube with a cylindrical hole large enough to accomodate our magnet
module make_magnet_holder () {

    difference() {
    
        translate([-(d1+(2*t2))/2, -(d1+(2*t2))/2,0]) cube([d1+(2*t2), d1+(2*t2), t1+t2]);
        translate([0,0,-t3]) cylinder(h=t1, r1=d1/2, r2=d1/2);
    }
    

} // end module make_magnet_holder

// probably should have named this something else...but its basically the composite of two magnet_holder(s)
module make_door_handle () {
    
    translate([0,0,(d1+(2*t2))/2])
    rotate([90,0,0]) {
         make_magnet_holder();
    }
    translate([(d1+(2*t2))-0.01,0,(d1+(2*t2))/2])
    rotate([90,0,0]) {
         make_magnet_holder();
    }

} // end module make_door_handle

// use the power of mirror() in a for loop - so that we can copy the objects and position them correctly at the same time :)
for (i=[0,1]) mirror([i,0,0]) {

    // this is the magnet holder for our door handle
    translate([((d1+(2*t2))/2)+1.5,0,0]) make_door_handle();
    
    // magnet holder on the LACK table
    translate([((d1+(2*t2))/2)+1.5,4,0]) mirror([0,1,0]) make_door_handle();

    // these bits holds the glass in place
    translate([1.5,-(t1+t2),0]) mirror([0,1,0]) cube([x3,25,3]);
    translate([1.5,-(t1+t2+g1+4+0.5),0]) cube([x3,4,d1+(2*t2)]);
    
    // handle with a small cut out
    translate([1.5,-((2*(t1+t2)+g1)+16),0])
    difference() {
         cube([x3,4,30]);
         translate([(x3/2),8,28]) rotate([70,0,0]) cylinder(h=20,r1=d1*1.25,r2=d1*1.25);
        
    }
    
    // screw holes for attaching the magnet holders to the LACK table
    translate([1.5,t1+t2+4,0]) 
    difference() {
        cube([x3,10,5]);
        translate([x3/4,10/2,-0.1]) cylinder(h=6, r1=2, r2=2);
        translate([x3/4*3,10/2,-0.1]) cylinder(h=6, r1=2, r2=2);
    }
}




