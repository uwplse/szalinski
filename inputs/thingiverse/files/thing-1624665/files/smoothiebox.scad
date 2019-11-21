//Smoothieboard box
// Author: M. Dietz
// http://3dprintapps.de

/* [General] */

// Which part do you want to generate?
part = "Both"; // [Box,Lid,Both]

/* [Box] */

// Do you want V-slot mounting slots?
slots = 1; // [1:Yes, 0:No]

/* [Lid] */

// Do you want a fan mount?
fan_Mount = 1; // [1:Yes, 0:No]

// Distance between mounting holes
fanHoleDistance = 32;

// Diameter of the holes for your bolts
boltHoleDiameter = 3.2;

/* [Hidden] */

$fn=30;
sx=129.5;
sy=105;
sh=23;

buf=4.5; 
th=2.5;
bot=2.5;

w=sx+buf;
t=sy+buf;
h=sh+buf+bot;

off=th+buf/2;

//loch1
l1=28+off;
l2=127+off;
l1y=3.5+off;
l3y=98.5+off;
l3=121+off;
l2y=103+off;


if(part == "Box")
{
  box();
}
else if(part == "Lid")
{
  lid();
}
else
{
  translate([0,t+10,0]) lid();
  box();
}

module lid(){
    difference()
    {
      union()
      {
        roundBox(w+th+th,t+th+th,th-0.5,5);
        translate([th+0.1,th+0.1,th-0.5])  roundBox(w-0.2,t-0.2,th,5);
      }
      translate([th+3,th+3,th])  roundBox(w-6,t-6,th,5);
      if(!fan_Mount)
      {
        for ( i = [ 1:8 ])
        {
          translate([15*i,20,0]) roundBox(4,25,6,2);
          translate([15*i,t-20-25,0]) roundBox(4,25,6,2);
        }
      }
      if(fan_Mount) #translate([20+4,30+4,0]) fanMount(fanHoleDistance,boltHoleDiameter,5);
    }
}

module box(){
difference(){
    roundBox(w+th+th,t+th+th,h+th,5);
    translate([th,th,th])  roundBox(w,t,h,5);
    translate([l1,l1y,0]) cylinder(r=1.5,h=th);
    translate([l1,l2y,0]) cylinder(r=1.5,h=th);
    translate([l2,l1y,0]) cylinder(r=1.5,h=th);
  translate([l3,l3y,0]) cylinder(r=1.5,h=th);
      //   translate([w/2+off,t/2+off,0]) cylinder(r=20,h=th);
    //sd
   translate([sx,42+off,th+bot]) cube([14.5,14.5,5]);
    translate([sx,59+off,th+bot]) cube([16,16,16]);
    translate([sx,77+off,th+bot]) cube([13,13,13]);
    
    translate([16+off,sy,th+bot]) cube([11,13,11]);
    translate([30+off,sy,th+bot]) cube([57,13,11]);
  
    #translate([-1,t/2,h/2]) rotate([0,90,0]) cylinder(r=9,h=10);
    #translate([-1,t/2 -35,h/2]) rotate([0,90,0]) cylinder(r=9,h=10);
  
    #translate([w-(w-30-off-57)/2,t+off+5,h/2]) rotate([90,0,0]) cylinder(r=6,h=10);
      
    if(slots)
    {
      #translate([15+10+off,5,h-10+2.6]) rotate([90,0,0]) cylinder(r=2.6,h=10);
        
      #translate([w-15-10-off,5,h-10+2.6]) rotate([90,0,0]) cylinder(r=2.6,h=10);
      
      #translate([w/2-10/2,5,h-10+2.6]) rotate([90,0,0]) cylinder(r=2.6,h=10);
    }
     for ( i = [ 1:8 ]){
    translate([15*i,20,0]) roundBox(4,25,6,2);
    translate([15*i,t-20-25,0]) roundBox(4,25,6,2);
    }
}

 // translate([off,off,off])  cube([sx,sy,1]);
}
module roundBox(x,y,z,r){

hull(){
    translate([r,r,0]) cylinder(r=r,h=z);
    translate([r,y-r,0]) cylinder(r=r,h=z);
    translate([x-r,y-r,0]) cylinder(r=r,h=z);
    translate([x-r,r,0]) cylinder(r=r,h=z);
}
}

module fanMount(holeDistance, holeDiameter, holeDepth)
{
  fanHoleDiameter = holeDistance*1.2;
  echo(fanHoleDiameter);
 // Mounting holes
 cylinder(d=holeDiameter, h=holeDepth);
 translate([holeDistance, 0,0]) cylinder(d=holeDiameter, h=holeDepth);
 translate([holeDistance, holeDistance,0]) cylinder(d=holeDiameter, h=holeDepth);
 translate([0, holeDistance,0]) cylinder(d=holeDiameter, h=holeDepth);
 // Fan grill
 difference()
 {
   translate([holeDistance/2, holeDistance/2, 0])
      cylinder(d=fanHoleDiameter, h=holeDepth);
   // Y bar
   translate([holeDistance/2 - holeDiameter/2,-1*(fanHoleDiameter-holeDistance)/2,0]) 
      cube([holeDiameter,fanHoleDiameter,holeDepth]);
   // X bar
   translate([-1*(fanHoleDiameter-holeDistance)/2,holeDistance/2 - holeDiameter/2,0]) 
      cube([fanHoleDiameter,holeDiameter,holeDepth]);
 } 
}