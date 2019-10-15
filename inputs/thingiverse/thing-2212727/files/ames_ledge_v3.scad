box_width=100;
box_depth=50;
box_height=20;
thickness=3;

//resolution
$fn=150;

difference()
{
   
// the big cube
cube([box_width,box_depth, box_height]);
translate([-0.5,thickness,thickness])
cube([box_width+1,box_depth-2*thickness, box_height+1]);

translate([25,13,0])
thumbtack_hole();

translate([70,13,0])
thumbtack_hole();

translate([92,37,0])
thumbtack_hole();

translate([15,37,0])
thumbtack_hole();

}





module ledge()
{
translate([0,0,0])
difference()
{
cube([15,30,box_height]);
rotate([0,0,55])
cube([60,30,box_height]);
}
}


// 1st ledge
ledge();

// 2nd ledge
rotate([0,0,90])
translate([35,-40,0])
ledge();

// 3rd ledge
translate([45,0,0])
ledge();

// 4th ledge
rotate([0,0,90])
translate([35,-85,0])
ledge();

module thumbtack_hole()
{
translate([0,0,1])
cylinder(r=6.5,h=8);

translate([0,0,-4])
cylinder(r=1,h=15);
}
