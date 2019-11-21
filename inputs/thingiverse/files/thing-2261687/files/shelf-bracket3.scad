//This is how far the bracket will extend into the shelf
hookthick = 20;
length = 62*1;

width = 33*1;

heightlow = 10*1;

heighthight = 16*1;
//This is how thick the wood is that the bracet will grab on to in mm
hookshelf = 13;
difference(){
    
    union(){
        color("red")   translate([0,hookthick,0] )     cube([length, hookshelf, heightlow]);
    
        color("blue")   cube([length, hookthick, heighthight]);
    }
       color ("red") translate([length/2, 0, heightlow/2]) rotate([270,0,0]) cylinder(hookthick*.75,5,5);
    translate([length/2, 0, heightlow/2]) rotate([270,0,0]) cylinder(hookthick + heighthight,2.5,2.5);

} 
translate([length, 0,0]) rotate([0,180,0]) cube([length, hookshelf + hookthick , 1]);
//text("woo") center = true;

//difference()  {cube(12, center=true); sphere(8);}