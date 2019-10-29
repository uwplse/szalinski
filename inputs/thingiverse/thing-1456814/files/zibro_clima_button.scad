connector_height = 10;
connector_width = 10;
connector_thickness = 6;
cross_1_thickness = 3;
cross_2_thickness = 2.5;

union(){
intersection(){
difference()
{
    sphere(r=20, center = true, $fn=50);
    translate([-20,-20,-40]) cube([40,40,40]); //bottom
   
}
 rotate([45,0,0])
        translate([-3,-3,-3]) cube([5,30,30]); //border
}
translate([0,0,-connector_height/2])
    difference(){
        cube([connector_thickness,connector_width,connector_height], center = true); // bottom cube
        cube([cross_1_thickness,connector_width-2,connector_height], center=true); // partial cut
        translate([0,0,-1]) // complete cut
            rotate([0,0,90]) cube([cross_2_thickness,connector_width-2,connector_height-1], center =true);
        }
}