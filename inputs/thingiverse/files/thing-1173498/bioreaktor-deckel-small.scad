
//LABELS FOR CUSTOMIZER

// Adjust parameters here:
/*[Main]*/
Height = 9; //
RimHeight = 12; //
OuterDiameter = 58; // 95
InnerDiameter = 40; //  78
WallThickness = 3;


/*[Holes]*/
PipeHoles = 3; //
HoleDiameter = 8.7; // to fit 8mm pipe
HolePosition = 95; // 100% is outer limit
CenterHole = 6.5; //
HexHole = 6; //

/*[Hidden]*/
fn=30;  //100 is good, 30 is for viewing
fnLid=10;  //10 is cool

module SolidLid(){
    //Main
    color("deeppink") translate([0,0,0]) cylinder(h=Height,d=OuterDiameter+8, $fn = fnLid); 
    color("pink") translate([0,0,Height*1]) cylinder(h=6,d=InnerDiameter, $fn = fn); 
    
    // Outer Rim
    SolidLidRim();
    
    //Rim
   translate([0,0,Height]) cylinder(h=2,d1=OuterDiameter-4, d2=InnerDiameter, $fn = fn);
}

module SolidLidRim(){
    difference(){
    color("deeppink") translate([0,0,Height]) cylinder(h=RimHeight,d=OuterDiameter, $fn = fn); 
        translate([0,0,WallThickness+5]) cylinder(h=Height*5,d=53, $fn = fn); 
    }
    for(i = [0 : 3]) color("deeppink") rotate([0, 0,i*90]) translate([52/2,0,RimHeight+Height-2]) scale([0.11,1,1]) cylinder($fn = fn, h = 2, d = 20);
}



difference(){
    SolidLid();
    //Center
    translate([0,0,WallThickness+5]) cylinder(h=Height*5,d=InnerDiameter-2*WallThickness, $fn = fn); 
    //Rim for steel spring
    translate([0, 0, Height-4]) rotate_extrude(convexity = 10, $fn = fnLid) translate([OuterDiameter/2+5, 0, 0]) circle(r = 2, $fn = fn);
    
    translate([0, 0, Height+3]) rotate_extrude(convexity = 10, $fn = fn) translate([InnerDiameter/2+1, 0, 0]) circle(r = 1.5, $fn = fn);
    
    translate([0,0,-2]) cylinder(h=40,d=CenterHole, $fn = fn); 
    
    rotate([0, 0, 0]) translate([0.9*(InnerDiameter/2-WallThickness-HexHole/2), 0, -5])  rotate([0, 0, 30]) cylinder($fn = 6, h = 50, d = HexHole);
    
    for(i = [0 : PipeHoles-1]) rotate([0, 0, ((i +2)* (360 / (PipeHoles+3)))]) translate([HolePosition/100*(InnerDiameter/2-WallThickness-HoleDiameter/2), 0, -5]) cylinder($fn = fn/2, h = 50, d = HoleDiameter);
        


}


    
