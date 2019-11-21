/*
Customizable centrifugal fan wheel "tasmanian devil"

This model is just used as quick hack as part of my bigger project.

The big thing is that instead of trying to make turbopump wheel, where it is important to control gap tolerances in between chassis and rotating part... Just make whole thing spinning and connect stationary tube to inner bearing ring and rotating part 

Hardware
Bearings 6803 2RS Rubber Shielded Deep Groove Ball Bearing Metric 17x26x5mm
A2212 6T 2200KV Motor Outrunner Brushless For RC Aircraft Quadcopter Helicopte

Inlet tube (non-rotating) is attach (with glue?) to bearings inner ring.
I will provide later chassis for this (with static blades) on separate desing

Beware flying plastic pieces. Rapid unplanned disassembly, can occur at high speeds



*/

$fn=100;

dOuter=55;
hOutlet=4;
floorwall=2;
dBearingExt=26.3;

dBearing=17;
hBearing=5;

topwall=2.7;

bearingRise=18;
dAxisHole=5.4;

bearingwall=2.3;

wingCount=13;
sickleRad=14;
sickleOffset=1;

ringDownShift=2; //TODO might need adjust this

//Sickle found... but hammer is missing :D
module sickle(radius,offset){
    difference(){
        translate([radius,0,0])
        cylinder(r=radius,h=1);
        translate([radius,offset,0])
        cylinder(r=radius,h=3,center=true);
    }
}

module wing(dInner,dOuter,sickleRad,sickleOff){
    intersection(){
        difference(){
            sickle(sickleRad,sickleOff);
            //Inner cylinder
            cylinder(r=dInner/2,h=3,center=true);
        }
        //Outer cylinder cuts
        cylinder(r=dOuter/2,h=3,center=true);
    }
}


module wings(n,height,dInner,dOuter,sickleRad,sickleOff){
    translate([0,0,height]) //Mirror here
    rotate([0,180,0])
    scale([1,1,height])  //Mirror here
    for(i=[0:n]){
        rotate([0,0,i*360/n])
        wing(dInner,dOuter,sickleRad,sickleOff);
    }
}



module wingvolume(){
    cylinder(r=dOuter/2,h=hOutlet+floorwall);
    translate([0,0,hOutlet+floorwall-0.1])
    cylinder(r1=dOuter/2,r2=dBearingExt/2,h=bearingRise-hOutlet-floorwall);
}



module wingpart(){
    intersection(){
        wings(wingCount,bearingRise,dBearingExt,dOuter,sickleRad,sickleOffset);
        wingvolume();
    }
    difference(){
        cylinder(r=dOuter/2,h=floorwall);
		cylinder(r=dAxisHole/2,h=floorwall*4,center=true);
    }
}


module cylRing(r1,r2,h){
    difference(){
    cylinder(r=r2,h=h,center=true);
    cylinder(r=r1,h=h*3,center=true);
    }
}

module cappart(){
    translate([0,0,-0.4])
    difference(){
        translate([0,0,topwall])
        wingvolume();
        scale([1.01,1.01,1])
        wingvolume();
        cylinder(r=(dBearingExt+dBearing)/4,h=50);
    }
    //translate([0,0,bearingRise+hBearing/2-0.6+topwall-2])

	translate([0,0,bearingRise+hBearing/2+topwall-ringDownShift])
    cylRing(dBearingExt/2,dBearingExt/2+bearingwall,hBearing+ringDownShift);
}



wingpart();
cappart();

