// Coin 1
Dia1=23.88;
Thick1=1.58;
// Coin 2
Dia2=26.48;
Thick2=1.92;
// Print Setting
MinWall=1.2; //Minimum wall thickness
RingDia=5; //Key Ring Diameter
$fn=50;

// Calculations
Separation=max(Dia1,Dia2);
Thick=min(Thick1,Thick2);
MThick=max(Thick1,Thick2);

difference(){
    union(){
        cylinder(d=Dia1,h=Thick1);
        translate([0,Separation,0])cylinder(d=Dia2,h=Thick2);
        translate([-(RingDia+MinWall*2)/2,0,0])cube([RingDia+MinWall*2,Separation,Thick]);
    }
    union(){
        translate([RingDia+MinWall,RingDia/2,-MThick/2])minkowski(){
            cube([Separation-RingDia,Separation-RingDia,MThick]);
            cylinder(d=RingDia,h=MThick);
        }
        translate([-Separation-MinWall,RingDia/2,-MThick/2])minkowski(){
            cube([Separation-RingDia,Separation-RingDia,MThick]);
            cylinder(d=RingDia,h=MThick);
        }
        //translate([0,RingDia,-Thick/2])cylinder(d=RingDia,h=Thick*2);
        //translate([0,Separation-RingDia,-Thick/2])cylinder(d=RingDia,h=Thick*2);
        //translate([-RingDia/2,RingDia,-Thick/2])cube([RingDia,Separation-RingDia*2,Thick*2]);
    }
}


// Remix of http://www.thingiverse.com/thing:233194/#files
