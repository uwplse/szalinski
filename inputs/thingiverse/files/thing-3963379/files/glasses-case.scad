/*
Glasses case and ronded box with lid

Author  : Dave Borghuis
Email   : contact@twenspace.nl
Website : https://twenspace.nl
Licence : (c) by TwenSpace / Dave Borghuis

If you want to use this model for e.g. commercial user please contact me.

*/

height = 30;
lengt = 155;
width = 55;
//Height of lid
heightlid = 20;

/* [Advanced parameters] */
rim = 10;

//Thickness of walls
wall = 3;
//Extra tolerance (so lid can easly open/closed)
tolerance = 0.3; //for lid extra

/* [Hidden] */
//internal parameters
//resolution of circles
$fn=80;

//Make the objects
makecase();
translate ([0,width+20,0]) makelid();

module makecase() {
    //middle part
    difference() {        
        translate([0,0,height/2]) cube([lengt-width,width,height],center=true);
        //rim1
        translate([0,width-wall/2,height/2+height-rim]) cube([lengt,width,height],center=true);
        //rim2
        translate([0,-width+wall/2,height/2+height-rim]) cube([lengt,width,height],center=true);
        //inner
        translate([0,0,height/2+wall]) cube([lengt-width,width-2*wall,height],center=true);
    }

    //left and right side
    difference() {
        union () {
            translate([lengt/2-width/2,0,height/2]) side();
            translate([-(lengt/2-width/2),0,height/2]) side();
            
        };
        translate([0,0,height/2]) cube([lengt-width,width,height],center=true);  
    };
};

module makelid() {
    //middle part
    difference() {        
        //outer
        translate([0,0,heightlid/2]) cube([lengt-width,width,heightlid],center=true);
        //remover inner 
        translate([0,0,heightlid/2+wall]) cube([lengt-width,width-2*wall,heightlid],center=true);       
        //remove rim
        translate([0,0,heightlid/2+rim/2]) cube([lengt-width,width-wall+tolerance,rim],center=true);
    };    
    
    //left and right side
    difference() {
        union () {
            translate([lengt/2-width/2,0,heightlid/2]) side_lid();
            translate([-(lengt/2-width/2),0,heightlid/2]) side_lid();        
        };
        translate([0,0,height/2]) cube([lengt-width,width,height],center=true);  
    };

};

module side() {
    difference() {
        //main cylinder
        difference() {
            cylinder(h=height,r=width/2,center=true);
            translate ([0,0,wall]) cylinder(h=height,r=width/2-wall,center=true);
        };
        //remove rim
        translate ([0,0,height/2-rim/2])
        difference() {
            cylinder(h=rim,r=width/2*1.5,center=true);
            //minus (inner)
            cylinder(h=rim,r=(width/2-wall/2),center=true);
        };
    };
};

module side_lid() {
    difference() {
        //main cylinder
        difference() {
            cylinder(h=heightlid,r=width/2,center=true);
            translate ([0,0,wall]) cylinder(h=heightlid,r=width/2-wall,center=true);
            translate ([0,0,heightlid/2-rim/2]) cylinder(h=rim,r=(width-wall+tolerance)/2,center=true);
        };
    };
};