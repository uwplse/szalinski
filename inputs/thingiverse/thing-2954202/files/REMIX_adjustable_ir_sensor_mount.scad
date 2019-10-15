//Reprap differential IR sensor adjustable mount for E3D Chimera hotend (mounts to fan)
// CCBYNC Copyright Mark Benson 2016

// Openscad recreation and remix of thingiverse.com/thing:950478

// This remix is slightly sturdier and includes adjustable mounting holes.

//Fan mount holes 24mm centres
//IR Board mount holes 18mm centres

//Height (distance apart) 6mm min
//Aming for ~4mm adjustment (if poss)

//Mounting holes are
//3.5mm & 2.5mm holes

// REMIX by Stephen Wood (2018)
// Added Variables so that the mount can be used with different sized fans
// Added Variables so the horzontal offset between the fan and the probe can be adjusted
// Because these are small holes, they use "polyholes"
// http://hydraraptor.blogspot.com/2011/02/polyholes.html

// 2018-06-11 - Original implemtation of polyholes worked at 3.5mm but was worse at 2.5mm
// Adjustments being made.
// https://gilesbathgate.com/2016/02/07/polyholes-revisited/

Lg_hole = 3.5;          // Large mounting holes
Sm_hole = 2.5;          // Small mounting holes

Corner = 6.0;             // The Radiused lower corners of the bracket
Offset = 6.5;           // This is how thick the bracket will be
Bracket_height = 18.5;   // This is how tall the overall bracket will be
Fan_size = 40.0;          // The size of the fan (originally 30mm)
Fan_flange = 2.5;       // Thickness of the fan flange
IR_size = 18.0;           // The separation between the mounting holes for the IR Probe

Duct_width = Fan_size - 2.0*Corner;
Hole_wall = 2.0;          // The minmum wall around a hole

Slot_length = Bracket_height-Corner; 
                          // How long to make the adjustable slots                   
nozzle_dia=0.4;             // PolyHoles will get smaller as this decreases
layer_height=0.2;           // PolyHoles will get bigger as this decreases  

function pi() = 3.141592;
function width(d,h) = h-(pi()*((h*h)-(d*d)))/(4*h);
function arc(r,t) = 0.5*(t+sqrt((t*t)+4*(r*r)));
function polyhole(r,n,t) = arc(r,t)/cos(180/n);

function sides(d,t) = ceil(180 / acos((d-t)/d));

module hole(d,h)
{
  n=sides(d,0.1);
  t=width(nozzle_dia,layer_height);
  pr=polyhole(d/2,n,t);
  echo(d,n,pr*2);
  translate([0,0,-1])cylinder(r=pr,h=h+2,$fn=n);    
}

difference()
{
    //Main body
    hull()
    {
        translate([Corner/2,Offset/2,0])
        cylinder(d=Corner, h=Offset, $fn=25);
    
        translate([(Corner/2)+(Fan_size-Corner),Offset/2,0])
        cylinder(d=Corner, h=Offset, $fn=25);
     
        translate([0,Bracket_height,0])
        cube([Fan_size,Corner,Offset]);   
    }
    
    //Cut big section from main body
    translate([0,Corner,Fan_flange])
    cube([Fan_size,Offset+IR_size,Offset-Fan_flange]);
    
    //Left IR mounting hole
    translate([(Fan_size/2)-(IR_size/2),Offset/2,0])
    hole(Sm_hole,Offset);
    
    //Right IR mounting hole
    translate([(Fan_size/2)+(IR_size/2),Offset/2,0])
    rotate([0,0,180])
    hole(Sm_hole,Offset);
    
    //Left fan mount slot
    translate([0,0,0])
    hull()
    {
        translate([Corner/2,Bracket_height+Corner-(Lg_hole/2)-Hole_wall,0])
        hole(Lg_hole,Offset);
        
        translate([Corner/2,Bracket_height+Corner-Slot_length-Lg_hole,0])
        rotate([0,0,180])
        hole(Lg_hole,Offset);
    }
    
    //Right fan mount slot
    translate([Fan_size-Corner,0,0])
    hull()
    {
        translate([Corner/2,Bracket_height+Corner-(Lg_hole/2)-Hole_wall,0])
        hole(Lg_hole,Offset);
        
        translate([Corner/2,Bracket_height+Corner-Slot_length-Lg_hole,0])
        rotate([0,0,180])
        hole(Lg_hole,Offset);
    }
    
    //Cutout between mounting slots for fan
    translate([(Duct_width/2)-Corner+Hole_wall/2,(Duct_width/2)-Corner+Hole_wall/2,0])
    hull()
    {
        translate([0,0,0])
        cylinder(d=Corner, h=Offset, $fn=100);
    
        translate([Duct_width-Corner,0,0])
        cylinder(d=Corner, h=Offset, $fn=100);
        
        translate([0,Duct_width-Corner,0])
        cylinder(d=Corner, h=Offset, $fn=100);
    
        translate([Duct_width-Corner,Duct_width-Corner,0])
        cylinder(d=Corner, h=Offset, $fn=100);    
    }
    
    //Cutout between IR mount holes
    translate([(Fan_size/2)-(IR_size/2)+Hole_wall,0,Offset-2.5])
    cube([IR_size-2*Hole_wall,Corner,Offset]); 

}