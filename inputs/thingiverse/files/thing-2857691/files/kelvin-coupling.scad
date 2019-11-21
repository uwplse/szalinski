// kelvin coupling or Maxwell kinematic system
// http://pergatory.mit.edu/kinematiccouplings/
// got inspired from the talk:
// Tool changing 3D Printers by Sanjay of E3D  
// https://www.youtube.com/watch?v=DRkF-D0fEbQ
// enjoy...
// made on OpenSCAD version 2018.02 
////////////////////////////////////////////////


//////////////
// Settings //
//////////////
// how much detail default 30 go for more if you want to wait
$fn=30; 
// what_size, its the outside of the connectors size
what_size=40;


//////////////////////////////////////////////
// Uncomment out what you want to see below //
//////////////////////////////////////////////

// Show all flat
// print();

// Show all together
 view(); 

// Top part with balls
// top(size);
 
// Bottom part with groves
// bottom(size);

// The latch
//latch(); 
// The on side latch to print
//rotate([90,0,0])latch();

//  Connectors
// connectors(size);
 
//  Plugs
// plugs(size);

///////////////////////////
// settings, 
//////////////////////////

// how thick to make the base of the bottom and top
base_thick=4;
// defaults for the coupling connectors
x=10;
y=20;
z=10;
// calculate the distance from the center of the coupling to [0,0,0]
size=what_size+y/2;
////////////////////////////
// latch settings
// x,y,z of the hole for the latch and latch
slot_x=20; 
slot_y=5; 
slot_z=4;
// hight of the cylinder in the latch
hight=20;

////////////////////
//  Modules below //
////////////////////
// tetrahedron coupling connector
module connect(x=10,y=20,z=10){
x2=x/2;
z2=z/2;

points = [[0,0,0],[x,0,0],[x,y,0],[0,y,0],[x,0,z],[x,y,z],[x2,0,z2],[x2,y,z2],[0,0,z],[0,y,z]];
faces = [[0,1,2,3],[1,4,5,2],[4,6,7,5],[6,8,9,7],[8,0,3,9],[3,2,5,7,9],[0,8,6,4,1]];
    polyhedron( points, faces);
}

// example changing the connection
module connect_example(x=10,y=20,z=10){
    translate([x/2,y/2,0])
    difference(){
    cylinder(h=z,d=y/2,center=false);
        translate([0,0,z])sphere(d =y/2,center=true);
    }
}

// the groves 
module connectors(size=60){
translate([-x/2,-size,0])connect(x,y,z);
rotate([0,0,120])translate([-x/2,-size,0])connect(x,y,z);
rotate([0,0,240])translate([-x/2,-size,0])connect(x,y,z);
}

// all together for viewing
module view(){
mirror([0,0,1])top(size);
translate([0,0,-13.5])bottom(size);
translate([0,0,-1.2])latch();
}
//arrangement for printing
module print(){
translate([size*1,-size/2,slot_y/2])rotate([90,0,0])latch();
translate([size*2,0,0])top(size);    
bottom(size);
}
module bottom(size){
    color("red")connectors(size);
    difference(){
    color("blue")base(size);
        cylinder(h=4,d=8,center=true);
        cutouts();
        cube([slot_x+1,slot_y+1,slot_z*2],center=true);
    }
}

// the cut out of bottom of latch
module latch_cut(){
    rotate([10,0,0])translate([0,-slot_y/2,1-slot_z])
      cube([(slot_x/1.9),slot_y*1.5,slot_z]);
}


module latch (){
    translate([0,0,slot_z-hight])cylinder(h=hight,d=slot_y,center=false);
    latch_bar();
    translate([0,0,-11.2])mirror([0,0,1])latch_bar();
    
}
// latch bar part 
module latch_bar(){
    //slot_x=20, slot_y=5, slot_z=4
    difference(){
    translate([-slot_x/2,-slot_y/2,0]) cube([slot_x,slot_y,slot_z],center=false);
    latch_cut();
    rotate([0,0,180])latch_cut();
    }
}  

// the base with half balls
module top(size){ 
    color("LightBlue")plugs(size);
    difference(){
            color("yellow")base(size);
        cube([slot_x+1,slot_y+1,slot_z*2],center=true);
       cutouts(size);
        
    }
}

// base plate defaults=60
module base(size=60){
    //translate([0,0,-2])cylinder(h=2,r=60,center=true);
    // strange cylinder which thinks its a polyhedron
    rotate([0,0,270])cylinder(2,size,size,$fn=3);
}

// the balls defaults size=60,rad=6
module plugs(size=60){
    // rad = how big are the spheres 
    rad=6;
    difference(){
        union(){
            translate([0,-size+x,0])
                sphere(r = rad,center=true);
            rotate([0,0,120])translate([0,-size+x,0])
                sphere(r = rad,center=true);
            rotate([0,0,240])translate([0,-size+x,0])
                sphere(r = rad,center=true);
        }
            translate([0,0,-rad/2])cylinder(h=rad,r=size,center=true);
    }
}  
module cutouts(){
    hole_x=size/3;
    hole_y=size/12;
    hole_z=base_thick;
     translate([0,size/4,0])cube([hole_x*2,hole_y*2,hole_z*2],center=true);
        translate([0,-size/4,0])cube([hole_x,hole_y*2,hole_z*2],center=true);
}