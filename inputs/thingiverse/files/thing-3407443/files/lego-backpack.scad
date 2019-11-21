 use <lego_brick_builder.scad>;

/* [Hidden] */

FLU = 1.6; // Fundamental Lego Unit = 1.6 mm
BRICK_WIDTH = 5*FLU; // basic brick width

/* [Block Dimensions] */
// when attached to your model, how wide is the adapter in studs.
lego_width =      2;
// when attached to your model, how tall is the adapter in studs.
lego_length =     2;
// when attached to your model, how thick is the adapter in studs.
lego_height = 1;

/* [Adapter Settings] */
// does this connect via one pin or two.
isTwoPins = "Two"; //  [One, Two]
// how tall are the pins that extend into the body?
pinHeight =      3.9;

PinOffset = (isTwoPins == "Two") ? 1 : 0;






translate([0,-BRICK_WIDTH*lego_width/2,0])  brick(lego_length,lego_width,lego_height);
brickSolid(lego_length,lego_width, lego_height);
pins();







module brickSolid(lego_length,lego_width, lego_height){
    translate([0,BRICK_WIDTH*lego_width/-2,0])  cube(size=[
    lego_length*BRICK_WIDTH,
    lego_width*BRICK_WIDTH,
    lego_height*FLU*2-.1]);
}

module pins(zOffset=1, dOffset=0){
    offsetValue = 4.65;
    translate([BRICK_WIDTH*lego_length/2,0,-pinHeight*zOffset/2])  for (ix = [-1,1]){
        translate([0,offsetValue*ix*PinOffset,0]) cylinder(d=2.9+dOffset, h=pinHeight, center=true, $fn=50);
    }   
}