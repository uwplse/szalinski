battery_length=102;
battery_height=24;
battery_width=37;
// high is not be tested it can be it will not fit in!
wall_height=2; // [3:low,2:medium,1.5:!high!]
thickness=2; // [1:3]
hole= 3; // [0:8]
sunk_screws=0; // [0:NO, 1:YES]
// set this to 0 for one hole.
hole_distance=50;
light=1; // [0:NO, 1:YES]
cable_tie_hole=1;// [0:NO, 1:YES]
band_hole=1; // [0:NO, 1:YES]
thick_edge=0; // [0:NO, 1:YES]
//This will only disable wall height and band hole!
hard_case=0; // [0:NO, 1:YES]

module Akku(){
cube([battery_length,battery_width,battery_height],center=true);
}


module Case(L,B,H)
{
difference(){
cube([L,B,H],center=true);
Akku();

if (hard_case==0)
{
if(battery_length > 100)
{
translate([25,0,thickness+battery_height/wall_height]){
cube([L,B+0.5,H],center=true);
}
} else {
translate([battery_length/4,0,thickness+battery_height/wall_height]){
cube([L,B+0.5,H],center=true);
}
}
}

if(light==1)
{
translate([-L/2,0,0])
{
cube([L,battery_width-thickness*4,battery_height-thickness*4],center=true);
}
}



if (hard_case==1)
{
translate([L/2,0,0])
{
cube([L,battery_width,battery_height],center=true);
}
}
translate([L/2,battery_width/2-thickness*1.5,0])
{
cube([L,thickness*3,battery_height-thickness*2],center=true);
}
translate([L/2,-battery_width/2+thickness*1.5,0])
{
cube([L,thickness*3,battery_height-thickness*2],center=true);
}



if(cable_tie_hole==1)
{
translate([battery_length/2-thickness*3,battery_width/2-1.5,-battery_height/2-0.1])
{
cube([5.5,3,thickness*2],center=true);
}
translate([battery_length/2-thickness*3,-battery_width/2+1.5,-battery_height/2-0.1])
{
cube([5.5,3,thickness*2],center=true);
}
translate([-battery_length/3,battery_width/2-1.5,-battery_height/2-0.1])
{
cube([5.5,3,thickness*2],center=true);
}
translate([-battery_length/3,-battery_width/2+1.5,-battery_height/2-0.1])
{
cube([5.5,3,thickness*2],center=true);
}

translate([battery_length/2-thickness*3,0,-battery_height/2])
{
cube([5.5,battery_width,thickness],center=true);
}
translate([-battery_length/3,0,-battery_height/2])
{
cube([5.5,battery_width,thickness],center=true);
}
}





if(thick_edge==1)
{
if(battery_length/5 > 20)
{
translate([battery_length,battery_width/2,0])
{
cube([battery_length+20,thickness*3,battery_height-thickness*2],center=true);
}
translate([battery_length,-battery_width/2,0])
{
cube([battery_length+20,thickness*3,battery_height-thickness*2],center=true);
}
} else{
translate([battery_length,battery_width/2,0])
{
cube([battery_length+battery_length/5,thickness*3,battery_height-thickness*2],center=true);
}
translate([battery_length,-battery_width/2,0])
{
cube([battery_length+battery_length/5,thickness*3,battery_height-thickness*2],center=true);
}
}
}




if (hard_case==0)
{
if(band_hole==1)
{
translate([battery_length/5,0,-battery_height/2+1.5])
{
if(battery_length > 60)
{
cube([20,battery_width+thickness*2+1,3],center=true);
} else {
cube([battery_length/3,battery_width+thickness*2+1,3],center=true);
}
}
}
}

if (hard_case==1)
{
translate([battery_length/2-thickness*3,0,0])
{
cube([3,20,battery_height+20],center=true);
}
}


if(light==1)
{
translate([battery_length/5,battery_width/4,-battery_height/2-0.1])
{
cube([battery_length/3,battery_width/3,thickness*2],center=true);
}
translate([-battery_length/6,-battery_width/4,-battery_height/2-0.1])
{
cube([battery_length/4,battery_width/3,thickness*2],center=true);
}
translate([battery_length/5,-battery_width/4,-battery_height/2-0.1])
{
cube([battery_length/3,battery_width/3,thickness*2],center=true);
}
translate([-battery_length/6,battery_width/4,-battery_height/2-0.1])
{
cube([battery_length/4,battery_width/3,thickness*2],center=true);
}
}


translate([hole_distance/2,0,-battery_height/2-thickness-0.1])
{
cylinder(d=hole,h=thickness+0.5,$fn=20);
}
if(sunk_screws==1)
{
translate([hole_distance/2,0,-battery_height/2-hole/2])
{
cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20);
}
}
translate([-hole_distance/2,0,-battery_height/2-thickness-0.1])
{
cylinder(d=hole,h=thickness+0.5,$fn=20);
}
if(sunk_screws==1)
{
translate([-hole_distance/2,0,-battery_height/2-hole/2])
{
cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20);
}
}
}
}


if(hole!=0)
{
difference(){
translate([hole_distance/2,0,-battery_height/2-thickness])
{
cylinder(d=hole+6,h=thickness,$fn=50);
}
translate([hole_distance/2,0,-battery_height/2-thickness-0.1])
{
cylinder(d=hole,h=thickness+0.5,$fn=20);
}
translate([battery_length/2-thickness*3,0,-battery_height/2])
{
cube([5.5,battery_width,thickness],center=true);
}
if(sunk_screws==1)
{
translate([hole_distance/2,0,-battery_height/2-hole/2])
{
cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20);
}
}
}


difference(){
translate([-hole_distance/2,0,-battery_height/2-thickness])
{
cylinder(d=hole+6,h=thickness,$fn=50);
}
translate([-hole_distance/2,0,-battery_height/2-thickness-0.1])
{
cylinder(d=hole,h=thickness+0.5,$fn=20);
}
translate([-battery_length/3,0,-battery_height/2])
{
cube([5.5,battery_width,thickness],center=true);
}
if(sunk_screws==1)
{
translate([-hole_distance/2,0,-battery_height/2-hole/2])
{
cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20);
}
}
}
}



Case(battery_length+thickness*2,battery_width+thickness*2,battery_height+thickness*2); 



