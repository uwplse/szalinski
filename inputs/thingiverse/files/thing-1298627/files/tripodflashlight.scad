h = 4; //Height
wlow = 38; //Bottom width
whigh = 29; // Top width
depth = 50;
difference() {
    union() {
        rotate([90,0,0])linear_extrude(height=depth,center=true,convexity=10,twist=0)
        {
            polygon(points = [[-wlow/2,0],[-whigh/2,h],[whigh/2,h],[wlow/2,0]]);
            
        }
        translate([0,0,7])cube([min(whigh*0.8,25),10,10],center=true);
        translate([3,-5,7])rotate([0,-20,0])cube([20,10,5]);
        rotate([0,0,180])translate([3,-5,7])rotate([0,-20,0])cube([20,10,5]);
        translate([-16,0,10])cylinder(d=8.5,$fn=40,h=3.2);
        translate([16,0,10])cylinder(d=8.5,$fn=40,h=3.2);
    }
    translate([-16,0,9])cylinder(d=3,$fn=40,h=20);
    translate([16,0,9])cylinder(d=3,$fn=40,h=20);
    
    hd = 6;
    
   /* translate([-16,0,10])rotate([0,0,360/12])cylinder(d=hd,$fn=6,h=2.5);
    translate([16,0,10])cylinder(d=hd,$fn=6,h=2.5);*/
}

translate([wlow/2+10,0,5])rotate([90,0,90])difference() {
    union(){
        
        translate([0,0,9.5])cube([10,10,5],center=true);
        translate([3,-5,7])rotate([0,-20,0])cube([20,10,5]);
        rotate([0,0,180])translate([3,-5,7])rotate([0,-20,0])cube([20,10,5]);
        translate([-16,0,10])cylinder(d=8.5,$fn=40,h=3.2);
        translate([16,0,10])cylinder(d=8.5,$fn=40,h=3.2);
    }
    translate([-16,0,8.7])cylinder(d=3,$fn=40,h=20);
    translate([16,0,8.7])cylinder(d=3,$fn=40,h=20);
    
    hd = 6;
    
    //translate([-12,0,8.7])rotate([0,0,360/12])cylinder(d=hd,$fn=6,h=2.5);
    //translate([12,0,8.7])cylinder(d=hd,$fn=6,h=2.5);
}
