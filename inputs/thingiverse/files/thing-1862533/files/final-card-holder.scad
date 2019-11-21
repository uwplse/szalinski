//card height (Y axis)
card_height = 87.2;
//card width (X axis)
card_width = 55;
//card thickness (Z axis)
card_thickness = 1.5;
//frame out thickness
frame_out_thickness = 1.5;
//frame in thickness
frame_in_thickness = 1.5;
//holder thickness (tip: totalThickness = 2*holder_thickness + card_thickness)
holder_thickness = 1.2;
//corner size
corner_size = 6;

//key ring radius (outside)
key_ring_radius = 9.5;
//key ring thickness (Z axis)
key_ring_thickness = card_thickness+holder_thickness;
//key ring circle thickness
key_ring_circle_thickness = 2;
//key ring separation (respect to the card holder) >= key ring radius
key_ring_separation = key_ring_radius*4/3;

//round corner
round_radius = 3;

//symmetrical design
symmetrical = 0; // [1,0]

//opened key_ring
openedkey_ring = 1; // [1,0]

$fn=50;

module roundCreator()
{
    round_length = 2*holder_thickness + card_thickness + 0.01;
    difference(){
       translate([-0.05,-0.05,0]) cube([round_radius+0.1,round_radius+0.1,round_length], center = false);
       translate([round_radius, round_radius, 0]) cylinder(round_length, round_radius, round_radius, false);
    }
}

module cardkey_ring()
{
    difference()
        {
            diag=pow(pow(corner_size+frame_out_thickness,2)*2,0.5);            
            cube([corner_size+frame_out_thickness,corner_size+frame_out_thickness,holder_thickness], center = false);
            translate([0, corner_size+frame_out_thickness, 0])  rotate([0,0,-45])
            cube([diag,diag,holder_thickness], center = false);
        }
}

module fullCardkey_ring()
{
        translate([0, 0, holder_thickness+card_thickness]) cardkey_ring();
        translate([card_width+frame_out_thickness*2, 0, holder_thickness+card_thickness]) rotate([0,0,90]) cardkey_ring();
        translate([0, card_height+frame_out_thickness*2, holder_thickness+card_thickness]) rotate([0,0,-90]) cardkey_ring();
        translate([card_width+frame_out_thickness*2, card_height+frame_out_thickness*2, holder_thickness+card_thickness]) rotate([0,0,180]) cardkey_ring();
}

module bruteHolder()
{
        difference()
        {
            cube([card_width+2*frame_out_thickness,card_height+2*frame_out_thickness,card_thickness+holder_thickness*2], center = false);
            translate([frame_out_thickness, frame_out_thickness, holder_thickness])
            cube([card_width,card_height,card_thickness+holder_thickness], center = false);
            //translate([frame_in_thickness+frame_out_thickness, frame_in_thickness+frame_out_thickness, 0])
            if(!symmetrical){
                translate([frame_in_thickness+frame_out_thickness, frame_in_thickness+frame_out_thickness, 0])
                cube([card_width-2*frame_in_thickness,card_height-2*frame_in_thickness,holder_thickness], center = false);
            } else {
                translate([frame_out_thickness, frame_out_thickness, 0])
                cube([card_width,card_height,holder_thickness], center = false);
            }
        }
        fullCardkey_ring();
        if(symmetrical){
            translate([0, 0, -card_thickness-holder_thickness]) fullCardkey_ring();
        }
}
    
module prekey_ring()
{
    translate([(card_width+2*frame_out_thickness)/2-(key_ring_radius),-key_ring_separation, 0])
    cube([key_ring_radius*2,key_ring_separation,key_ring_thickness], center = false);
    translate([(card_width+2*frame_out_thickness)/2,-key_ring_separation, 0])  
    cylinder(key_ring_thickness, key_ring_radius, key_ring_radius, false);
}

difference()
{
    bruteHolder();
    roundCreator();
    translate([(card_width+frame_out_thickness*2), 0, 0])
    rotate([0,0,90])
    roundCreator();

    translate([(card_width+frame_out_thickness*2), (card_height+frame_out_thickness*2), 0])
    rotate([0,0,180])
    roundCreator();
    translate([0, (card_height+frame_out_thickness*2), 0])
    rotate([0,0,270])
    roundCreator();
}

precission_margin=0.5;
difference()
{
    prekey_ring();
    translate([(card_width+2*frame_out_thickness)/2,-key_ring_separation, 0]) 
    cylinder(key_ring_thickness, key_ring_radius-key_ring_circle_thickness, key_ring_radius-key_ring_circle_thickness, false);
    if(openedkey_ring){
        translate([(card_width+2*frame_out_thickness)/2+(key_ring_radius-key_ring_circle_thickness)-(precission_margin/2),-(key_ring_separation+key_ring_circle_thickness/2), 0]) 
        cube([key_ring_circle_thickness+precission_margin,0.5,key_ring_thickness], center = false);
    }
}








