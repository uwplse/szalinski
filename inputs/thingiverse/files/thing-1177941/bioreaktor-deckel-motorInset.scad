
//LABELS FOR CUSTOMIZER

// Adjust parameters here:
/*[Main]*/
Height = 8; //
RimHeight = 8; //
OuterDiameter = 95; // 95, 70
InnerDiameter = 78; //  78, 40
WallThickness = 2.5;


/*[Holes]*/
PipeHoles = 3; //
HoleDiameter = 8.8; // to fit 8mm pipe
HolePosition = 95; // 100% is outer limit
CenterHole = 10; //
MotorHole =20; //
HexHole = 0; //

/*[Hidden]*/
fn=30;  //100 is good, 30 is for viewing
fnLid=16;  //10 is cool

module SolidLid(){
    //Main
    color("deeppink") translate([0,0,0]) cylinder(h=Height,d=OuterDiameter, $fn = fnLid); 
    color("pink") translate([0,0,Height*1]) cylinder(h=6,d=InnerDiameter, $fn = fn); 
    
    // Outer Rim
    //SolidLidRim();
    
    //Rim
   translate([0,0,Height]) cylinder(h=2,d1=OuterDiameter-WallThickness*2+0, d2=InnerDiameter, $fn = fn);
}

module SolidLidRim(){
    difference(){
    color("deeppink") translate([0,0,Height]) cylinder(h=RimHeight,d=OuterDiameter, $fn = fn); 
        translate([0,0,WallThickness]) cylinder(h=Height*5,d=OuterDiameter-WallThickness*2, $fn = fn); 
    }
    for(i = [0 : 3]) color("deeppink") rotate([0, 0,i*90]) translate([(OuterDiameter-WallThickness*2-2)/2,0,RimHeight+Height-2]) scale([0.12,0.8,1]) cylinder($fn = fn, h = 2, d = 20);
}



difference(){
    SolidLid();
    //Center
    translate([0,0,WallThickness+1]) cylinder(h=Height*5,d=InnerDiameter-2*WallThickness, $fn = fn); 
    //Rim for steel spring
    translate([0, 0, Height-4]) rotate_extrude(convexity = 10, $fn = fnLid) translate([OuterDiameter/2, 0, 0]) circle(d = 2.5, $fn = fn);
    //Rim for o-ring
    translate([0, 0, Height+3]) rotate_extrude(convexity = 10, $fn = fn) translate([InnerDiameter/2+1, 0, 0]) circle(r = 1.5, $fn = fn);
    
    //holes: Center
     translate([0,0,-2]) cylinder(h=40,d=CenterHole, $fn = fn); 
    //holes: MotorIntent
    translate([4,0,-2]) cylinder(h=WallThickness+1,d=MotorHole, $fn = fn); 
    translate([4,-7,-2]) cylinder(h=80,d=3, $fn = fn); 
    translate([4,7,-2]) cylinder(h=80,d=3, $fn = fn); 
    //holes: Hexagonal
    rotate([0, 0, 0]) translate([0.9*(InnerDiameter/2-WallThickness-HexHole/2), 0, -5])  rotate([0, 0, 30]) cylinder($fn = 6, h = 50, d = HexHole);
    //holes: Circumference
    for(i = [0 : PipeHoles-1]) rotate([0, 0, ((i +2)* (360 / (PipeHoles+3)))]) translate([HolePosition/100*(InnerDiameter/2-WallThickness-HoleDiameter/2), 0, -5]) cylinder($fn = fn/2, h = 50, d = HoleDiameter);
        
}
difference(){
for(i = [0 : PipeHoles-1]) rotate([0, 0, ((i +2)* (360 / (PipeHoles+3)))]) translate([HolePosition/100*(InnerDiameter/2-WallThickness-HoleDiameter/2), 0, 0]) cylinder($fn = fn, h = 16, d = HoleDiameter+2*WallThickness);
    
   for(i = [0 : PipeHoles-1]) rotate([0, 0, ((i +2)* (360 / (PipeHoles+3)))]) translate([HolePosition/100*(InnerDiameter/2-WallThickness-HoleDiameter/2), 0, -1]) cylinder($fn = fn/2, h = 30, d1= HoleDiameter, d2 = HoleDiameter*0.9);
     
    for(i = [0 : PipeHoles-1]) rotate([0, 0, ((i +2)* (360 / (PipeHoles+3)))]) translate([HolePosition/100*(InnerDiameter/2-WallThickness-HoleDiameter/2), -8, WallThickness+1]) cube([1,16,50]);
        
}

    
