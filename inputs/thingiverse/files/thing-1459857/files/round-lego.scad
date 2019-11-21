/* [Brick settings] */
//Brick diameter
lego_diam = 8.0;
//Height of entire brick
lego_height = 13;

/* [Pin Settings] */
//Height of pin
pin_height = 1.7;
//Diameter of pin
pin_diam = 4.8;
//Diameter addition for pin Hole (bottom)
pin_diff = 1.0;

/* [Hidden] */
//This tells OpenScad to make the circle really round
$fn = 100;
pin_rad = pin_diam / 2;
lego_rad = lego_diam / 2;
hole_rad = pin_rad-pin_diff/2;
hole_rad2 = pin_rad;

difference()
{
union()
{
    cylinder(pin_height, pin_rad+pin_diff, pin_rad+pin_diff);
    translate([0,0,pin_height])
        cylinder(lego_height-pin_height*2, lego_rad, lego_rad);
    translate([0,0,lego_height-pin_height])
        cylinder(pin_height, pin_rad, pin_rad);
}
translate([0,0,-1])
//Two pins, lego height + 2 to make sure the hole exceeds the model
    cylinder(pin_height*2+lego_height+2, hole_rad, hole_rad);
translate([0,0,-1])
    cylinder(lego_height-pin_height*2, hole_rad2, hole_rad2);
}