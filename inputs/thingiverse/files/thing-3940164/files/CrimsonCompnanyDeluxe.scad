/* [General] */
// Height of the print (box height minus manual)
height = 31; // [22.5:0.5:33]
// Thickness of card bottom
thickness = 2; // [0:0.1:2]

/* [Card Size] */
// Width of the card (short side)
card_width = 65; // [64:0.5:70]
// Height of the card (long side)
card_height = 90; // [89:0.5:100]

/* [Coin Size] */
// Small coin
small_coin_diameter = 19.5; // [19:0.5:21]
// Height of the coin holder
small_coin_height = 22; // [22:0.5:26]
// Large coin
large_coin_diameter = 23.5; // [23:0.5:25]
// Height of the coin holder
large_coin_height = 22; // [22:0.5:26]

difference()
{
    cube([155,110,height]);
    
    translate([2,2,thickness]) cube([card_width,card_height,height+1]);
    translate([17,2+card_height,-1])cube([card_width-34,110,height+3]);
    translate([17+(card_width-34)/2,2+card_height,-1])cylinder(d=card_width-34,h=height+3, $fn=72);
    
    translate([card_width+4,-1,22.5]) cube([155,112,height+1]);
    
    translate([155-54+12,110-32.5-(large_coin_height-24)/2,20.5]) rotate([-90,0,0]) cylinder(d=large_coin_diameter,h=large_coin_height, $fn=72);
    translate([155-54+12,110-32.5-(large_coin_height-24)/2,20.5]) sphere(d=14.5, $fn=72);
    translate([155-54+12,110-32.5+large_coin_height-(large_coin_height-24)/2,20.5]) sphere(d=14.5, $fn=72);
    translate([155-54+12-large_coin_diameter/2,110-32.5-(large_coin_height-24)/2,20.5]) cube([large_coin_diameter,large_coin_height, 32]);
    
    translate([155-81+12,110-32.5-(small_coin_height-24)/2,20.5]) rotate([-90,0,0]) cylinder(d=small_coin_diameter,h=small_coin_height, $fn=72);
    translate([155-81+12,110-32.5-(small_coin_height-24)/2,20.5]) sphere(d=14.5, $fn=72);
    translate([155-81+12,110-32.5+small_coin_height-(small_coin_height-24)/2,20.5]) sphere(d=14.5, $fn=72);
    translate([155-81+12-small_coin_diameter/2,110-32.5-(small_coin_height-24)/2,20.5]) cube([small_coin_diameter,small_coin_height, 32]);
    
    translate([155-27,2,-1]) cube([25,67,34]);
    translate([155-54,2,-1]) cube([25,67,34]);
    translate([155-81,2,-1]) cube([25,67,34]);
    
    translate([155-21,72,7]) cube([12,35,34]);
}