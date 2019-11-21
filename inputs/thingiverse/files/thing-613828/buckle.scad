$fs=0.35; $fa=1;

//Adjustment for making holes go all the way
bump=.1;

//Width of the actual buckle [mm]
buckle_width=24;//mm
buckle_radius=buckle_width/2;
//Width of the slot, long way [mm]
slot_width  =15;//mm
//Height of the slot, short way [mm]
slot_height = 3;//mm
//Thickness of the buckle [mm]
thickness   = 2;//mm
//How close to a circle should the buckle be?
ovaltine=70; // [02:100]


difference(){
scale([1,ovaltine/100,1])
cylinder(r=buckle_radius,h=thickness);

translate([-slot_width/2,slot_height-slot_height/2,-bump])
cube([slot_width,slot_height,thickness+2*bump]);

translate([-slot_width/2,-slot_height-slot_height/2,-bump])
cube([slot_width,slot_height,thickness+2*bump]);

}