PenRadius = 8;
pAngleAdjust = "false"; // [yes,no]
pClosedEnd = "no"; // [yes,no]
pPrintMode = "yes"; // [yes,no]


/* [HIDDEN] */
AngleAdjust = (pAngleAdjust=="yes");
FundoFechado = (pClosedEnd=="yes");
PrintMode = (pPrintMode=="yes");

if(PrintMode){
    explode = 0;
    translate([30,0,5]){
        translate([0,-40,0])
            rotate([0,-180,0]) 
                PenSocket(PenRadius,3,true);
        translate([0,35,0])
            rotate([0,-180,0]) 
                PenSocket(PenRadius,3,!FundoFechado);
    }
    if(AngleAdjust){
        HolderBase();
        translate([-40,0,0])
            rotate([0,-180,0])
                PenBase();
    }else{
        translate([0,0,5]){
            translate([0,0,25]) 
                rotate([0,-180,0]) HolderBase(); 
            PenBase();
        }
    }
}
else{
    explode = 5;

    translate([0,-40,(AngleAdjust?60:50)+explode*2])
        rotate([-90,0,0]) PenSocket(PenRadius,3,true);
    translate([0,35,(AngleAdjust?60:50)+explode*2])
        rotate([-90,0,0]) PenSocket(PenRadius,3,!FundoFechado);

    HolderBase();
    translate([0,0,35+explode+(AngleAdjust?10:0)]) 
        PenBase();
}    

module PenSocket(InternalRaius,Thickness,Screw){
    $fn=50;
    difference(){
        translate([0,0,-2.4])
            cylinder(h=15,r=InternalRaius+Thickness/2,center=true);
        translate([0,0,(Screw?0:-2)-2.4])
            cylinder(h=16,r=InternalRaius,center=true);
        if(Screw){
            for(a=[0:120:360])
                rotate(a=[90,0,a]){
                    translate([0,0,7])
                        cylinder(h=11,d=4.5,center=true);
                }
        }
    }
    translate([-5,InternalRaius-0.2,0]) 
        cube([10,10,5]);    
}

module PenBase(){
    rotate(a=[180,0,0]){
        translate([0,0,2.5]) cube([12,80,5],center=true);
        if(AngleAdjust)
            translate([0,0,5]) 
                RotationSocket1(10,3,3);
    }
}


module HolderBase(){
    cylinder(h=30,r1=20,r2=12,$fn=50);
    if(AngleAdjust)
        translate([0,0,30]) 
            RotationSocket2(10,3,6.5,3);
}
module RotationSocket1(SocketRadius,HoleRadius,WallThickness){
    rotate(a=[0,-90,0]){
        difference(){
            3DArc(WallThickness,0,180,SocketRadius);            
            translate([SocketRadius/2,0,0]) 
                cylinder(r=HoleRadius,h=25,center=true,$fn=50);
        }
    }
}
module RotationSocket2(SocketRadius,HoleRadius,Spacing,WallThickness,Count){
    rotate(a=[0,-90,0]){
        difference(){
            union(){
                translate([0,0,Spacing/2]) 
                    3DArc(WallThickness,0,180,SocketRadius);
                translate([0,0,-Spacing/2]) 
                    3DArc(WallThickness,0,180,SocketRadius);
            }
            translate([SocketRadius/2,0,0]) 
                cylinder(r=HoleRadius,h=25,center=true,$fn=50);
        }
    }
}



module 3DArc(Height,StartAngle,EndAngle,Radius){
    linear_extrude(height=Height,center=true)
    2DArc(StartAngle,EndAngle,Radius);
}
module 2DArc(StartAngle,EndAngle,Radius){
    points = [ 
        for (a = [StartAngle : EndAngle]) 
            Radius * [ sin(a), cos(a) ] ];
    polygon(concat(points, [[0, 0]]));
}