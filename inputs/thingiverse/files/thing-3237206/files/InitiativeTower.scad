//Pegs are perfect
//Weight is MORE than neough but doesnt hinder function
//Coins could do with a little more clearance
//Height is sufficient
//Print failed towards the tower top. Insufficient anchorage.
//Consider larger base for plate adhesion reasons.
//As always, printer could deliver better quality.


/* [Output] */
// - Maximum Z of your printer
Headspace = 200;

// - Things to render
Type = "FitConfig"; // [Tower:Tower,OnePeg:One Peg,PegSet:Peg Series,FitConf:Fit Configuration (Don't print)!]


/* [Tower Shape] */
// - Tower thickness (mm)
TowerY = 7; 

// - Baseplate thickness (mm) (zero for no base)
TowerBase=3;

// - Diameter of the weight discs/coins (mm)
CoinDiam = 16.5;

// - Thickness of the weight discs/coins (mm)
CoinThk = 1.67;

// - Weight of each disc/coin (g)
CoinWt = 2.3;

// - Target mass of weight (g) (zero for no weights)
TargWt = 60;


/* [Peg Shape] */
// - thickness of each peg (mm)
PegThk = 3;

// - height of text (mm)
TextHt = 8;

// - Thickness of text (mm)
DetDep=0.6;

// - Length of each peg (mm)
PegX = 50;

// - Number of pegs on each side
Pegs = 10; //quantity of pegs

// - Peg/Peg Series Text
Label = "HERO";

// - Peg Batch Size
PegBatchN = 5;


/* [Hidden] */
PegZ  = TextHt+4;
PegFlat = 6; //flat section between notches
// - guide rib height
NotchHt = PegThk*0.6; //normal dist from tower surface
NotchSquare = sqrt(pow(TowerY+2*NotchHt,2)/2);
TowerX = CoinDiam+4*NotchHt+2*PegFlat;
TowerZ = PegZ*Pegs;
TurretZ = NotchSquare*1;

CoinStackZ=TargWt/2/CoinWt*CoinThk; 
PegY=PegThk*2+TowerY;
TowerTotalZ = TowerZ+TurretZ+TowerBase;

if(TowerTotalZ > Headspace) 
    text("Too Tall! Z=TowerBase+(TextHt+4)*Pegs+10");
else 
{
    if(Type=="Tower") Tower();
    if(Type=="OnePeg") Peg(Label);
    if(Type=="PegSet") BatchPegs(Label,PegBatchN);
    if(Type=="FitConfig") FitConfig();
}


module Tower() translate([0,0,TowerBase]) {
    difference() {
        translate([0,0,TowerZ/2]) {
            //body
            cube([TowerX,TowerY,TowerZ],center=true);
            //right guide
            translate([+TowerX/2,0]) rotate([0,0,45])
                cube([NotchSquare,NotchSquare,TowerZ],center=true);
            //left guide
            translate([-TowerX/2,0]) rotate([0,0,45])
                cube([NotchSquare,NotchSquare,TowerZ],center=true);
        }
    }
    //initiative markers
    StartHt=CoinStackZ+PegZ/2;
    TopHt=TowerZ-PegZ/2;
    UnitDist=(TopHt-StartHt)/3;
    for(i=[1:1:4]) {
        txt=str((i+1)*5,"");
        translate([0,-TowerY/2,StartHt+UnitDist*(i-1)]) rotate([90,0])
        linear_extrude(DetDep)
            text(txt,halign="center",valign="center",size=TextHt);
        translate([0,TowerY/2+DetDep,StartHt+UnitDist*(i-1)]) rotate([90,0,180])
        linear_extrude(DetDep)
            text(txt,halign="center",valign="center",size=TextHt);
    }
    
    difference() {
        //coin stack body
        translate([0,0,CoinStackZ/2])
            cube([CoinDiam,CoinDiam*2+TowerY,CoinStackZ],center=true);
        //back coin bin
        translate([0,TowerY/2+CoinDiam/2,CoinStackZ/2]) {
            cylinder(d=CoinDiam,CoinStackZ,center=true);
            cube([CoinDiam,CoinDiam*0.3,CoinStackZ],center=true);
            cube([CoinDiam*0.3,CoinDiam,CoinStackZ],center=true);
        }
        //front coin bin
        translate([0,-TowerY/2-CoinDiam/2,CoinStackZ/2]) {
            cylinder(d=CoinDiam,CoinStackZ,center=true);
            cube([CoinDiam,CoinDiam*0.3,CoinStackZ],center=true);
            cube([CoinDiam*0.3,CoinDiam,CoinStackZ],center=true);
        }
    }
    
    //tower tops
    translate([+TowerX/2,0,TowerZ])
        linear_extrude(TurretZ,scale=0.01) rotate(45)
            square(NotchSquare,center=true);
    translate([-TowerX/2,0,TowerZ])
        linear_extrude(TurretZ,scale=0.01) rotate(45)
            square(NotchSquare,center=true);
    translate([0,0,TowerZ])
        linear_extrude(TurretZ/4,scale=[1,0.01])
            square([TowerX,TowerY],center=true);
    //base
    X1=CoinDiam/2;
    X2=TowerX/2+NotchHt*3;
    Y=CoinDiam+TowerY/2;
    p=[[X2,0],[X1,Y],[-X1,Y],[-X2,0],[-X1,-Y],[X1,-Y]];
    rotate([0,180]) linear_extrude(TowerBase) polygon(p);
}

module Peg(txt="-") scale(0.95) {
    difference() {
        //body
        cube([PegX,PegY,PegZ]);
        //cavity
        translate([0,PegThk]) 
            cube([PegX-PegThk*2,TowerY,PegZ]);
        //cavity radius
        translate([PegX-PegThk-0.5*TowerY,PegY/2,0])
            cylinder(d=TowerY,PegZ);
        //end notch
        translate([0,PegY/2,PegZ/2]) rotate([0,0,45])
            cube([NotchSquare,NotchSquare,PegZ],center=true);
        //mid notch
        translate([NotchHt*2+PegFlat,PegY/2,PegZ/2]) rotate([0,0,45])
            cube([NotchSquare,NotchSquare,PegZ],center=true);
    }
    if(len(txt)>6) {
        translate([PegX/2,0,PegZ/2])
        resize([PegX-(PegZ-TextHt),0,0]) 
        rotate([90,0]) 
        linear_extrude(DetDep)
            text(txt,halign="center",valign="center",size=TextHt);
        translate([PegX/2,PegY,PegZ/2]) 
        resize([PegX-(PegZ-TextHt),0,0]) 
        rotate([90,0,180])
        linear_extrude(DetDep)
            text(txt,halign="center",valign="center",size=TextHt);
    }
    else {
    translate([PegX/2,0,PegZ/2]) 
        rotate([90,0]) linear_extrude(DetDep)
            text(txt,halign="center",valign="center",size=TextHt);
    translate([PegX/2,PegY,PegZ/2]) 
        rotate([90,0,180]) linear_extrude(DetDep)
            text(txt,halign="center",valign="center",size=TextHt);
    }
}

module FitConfig() {
    Tower();
    for(FooZ=[0:1:Pegs-1]) rotate(360*(FooZ/2-ceil(FooZ/2)))
        translate([-2*NotchHt-PegFlat+TowerX/2,-PegY/2,PegZ*FooZ+TowerBase]) {
            DemoLabel = str(floor(0.12345*pow(10,FooZ*0.65)));
            Peg(str("XXXX",DemoLabel));
        }
}

module BatchPegs(txt="TEST",qty=3) {
    for(i=[1:qty]){
        translate([0,(i-1)*PegY*1.3]) Peg(str(txt," #",i));
    }
}

echo(str("TowerZ=",TowerTotalZ));