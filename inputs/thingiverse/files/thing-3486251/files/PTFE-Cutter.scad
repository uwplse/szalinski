$fn=64;
// Length of PTFE Tube
l=34;

// Knife blade Width
kerf=0.5; // [0.5, 0.75, 1, 1.5, 2]

// chamfering on the edges in mm
chamfer=2; 

c2=chamfer;

//ptfe tube outer diameter
tube_base=4; // [4,6.35]

// ptfe tube clearance
clearance=0.1;

tlen=l*2;

tube = (tube_base+clearance)/2;

// block width
d=20;
w=l+tube+kerf;

// block height
h=12;


// move the assembly to the zero axis for easy measuring in openscad... not strictly needed, but nice.
translate([chamfer,chamfer,chamfer*-1.5]) {
// make the rounded edges on it
    difference() {
    { minkowski() { 
        cube([w,d,h]); // base cube
        sphere(chamfer); // rounded corners
        }
    }
    // add the knife slot
    translate([l-c2,0-chamfer,h/2-tube+chamfer])
        cube([kerf,d+chamfer*2+1,h+chamfer]);

    // add the tube 
    translate([-w/10,d/2,h/2+chamfer]) rotate([0,90,0]) cylinder(tlen,tube,tube);

    // cut the bottom off so the bottom has squared off edges
    translate([-chamfer*1.5,-chamfer*1.5,-chamfer*1.5]) 
        cube([w+chamfer*3,d+chamfer*3,chamfer*3]);
    // add the text label
    translate([1,d/2-2,h+c2-.6]) linear_extrude(1) text(str(l,"mm PTFE"),4);

    } 
}