slots = 12;
box = "Switch";
//box = "PS4";
//box = "XBox";

thick = 1.5;
height = 56.6;
length = 51.625;
y=100;

if (box=="Switch") Make_Holder(11.5);
else if (box=="PS4") Make_Holder(15.3);
else if (box=="XBox")Make_Holder(16);

module Game_Slot (width) {
    difference() {
        cube([length+thick,width+thick*2,height+thick]);
        translate ([thick,thick,thick]) cube ([length,width,height]);
        translate([0,0,height+thick])rotate ([0,45,0])cube([y+thick,width+thick*2,y]);
    }
}

module Make_Holder(width) {
    for(x = [0:1:slots-1]) {
        translate ([0,width*x+thick*x,0])Game_Slot(width);
    }
    }

//Designed by Cyberandrew03, https://www.thingiverse.com/Cyberandrew03/about