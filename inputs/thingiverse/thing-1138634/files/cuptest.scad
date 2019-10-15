//Test rig to see if wires can be laid down during a print in the hole, printed over and then heated to seal the hole
//The layer height must be equivalent to the hole diameter
cupout=10;
wallt=2;
holer=0.5;
cuph=20;
$fn=60;

difference(){
    cylinder(r=cupout, h=cuph);
    translate([0,0,wallt])cylinder(r=cupout-wallt, h=cuph);
    translate([0,cupout, cuph/2])rotate([90,0,0])cylinder(r=holer, h=2*cupout); //hole for wire
}
