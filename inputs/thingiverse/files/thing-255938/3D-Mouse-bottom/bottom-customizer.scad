//fn = 100;

bottom_back_connector_position = 80;//[35:105]
bottom_left_connector_position = -46;//[-56:-26]
bottom_right_connector_position = 44;//[24:52]
bottom_length = 10.8;//[10.8,10.9,11,11.1,11.2,11.3,11.4,11.5]
bottom_width = 6.8;//[6.8,6.9,7,7.1,7.2]
bottom_height = 7;//[7,8,9]
bottom_hole_radius = 25;//[15:25]
bottom_hole_length = 1;//[0.7,0.8,0.9,1,1.1,1.2,1.3,1.4,1.5]
bottom_hole_width = 0.5;//[0.3,0.4,0.5,0.6,0.7,0.8]
screw_hole_size = 3;//[1,2,3,4]

module bottom()
{
//MAIN BOTTOM PART
linear_extrude(bottom_height)
difference()
{
scale([bottom_length+1.3,bottom_width+0.8,0])
circle(10);

//HOLE FOR SENSOR
scale([bottom_hole_length,bottom_hole_width,6])	
translate([10,0,0])
circle(bottom_hole_radius);

//FRONT SCREW HOLES
//LEFT
scale([1,1,15])
translate([-20,-59,0])
circle(screw_hole_size);
//RIGHT
scale([1,1,15])
translate([-20,59,0])
circle(screw_hole_size);

//BACK SCREW HOLES
//LEFT
scale(1,1,6)
translate([82,-36,0])
circle(screw_hole_size);
//RIGHT
scale(1,1,6)
translate([82,36,0])
circle(screw_hole_size);

//HOLE FOR LITTLE FINGER
scale([3,1,1])
translate([-12.5,bottom_width*18,0])
circle(7);
}

//BOTTOM SUPPORT

//BACK
//long
translate([bottom_back_connector_position,-20,7])
cube([4,40,10]);
//left
translate([bottom_back_connector_position-9,-20,15])
cube([10,10,2]);
//right
translate([bottom_back_connector_position-9,10,15])
cube([10,10,2]);

//LEFT
//long
translate([-55,bottom_left_connector_position,7])
cube([40,5,10]);
//right
translate([-25,bottom_left_connector_position+1 ,15])
cube([10,10,2]);
//left
translate([-55,bottom_left_connector_position+1,15])
cube([10,10,2]);

//RIGHT
//long
translate([-55,bottom_right_connector_position,7])
cube([40,5,10]);
//left
translate([-25,bottom_right_connector_position-5,15])
cube([10,10,2]);
//right
translate([-55,bottom_right_connector_position-5,15])
cube([10,10,2]);

}
//========================================//
scale(0.5)
{
rotate([0,0,180])
translate([0,0,-14])
bottom();
}