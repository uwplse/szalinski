razordiameter=13;
brushdiameter=26;

 $fn=50;
 translate([60,0,60]) difference(){
   rotate([0,90,90])difference(){
        cylinder(h=50, d=120);
        translate([0,0,-3]) cylinder(h=55, d=115);
    }
    translate([10,-1,-50])cube([120,52,120]);
    translate([-3,25,52])cylinder(h=10, d=razordiameter);
    translate([-3,(50/2)-(razordiameter/2),52])rotate([0,0,0])cube([24,razordiameter,15]);
}
translate([-46,0,0])cube([100,50,3]);
difference(){
    translate([-44,0,60])cube([45,50,3]);
    translate([-20,25,59])cylinder(h=10, d=brushdiameter);
    translate([-50,(50/2)-(brushdiameter/2),59])cube([30,brushdiameter,10]);
}