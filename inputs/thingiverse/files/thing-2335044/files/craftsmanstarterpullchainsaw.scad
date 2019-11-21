module starter(){
totalZ=1.5;
startD=.75;
startZ=.7;
startwall=.125;
startwallZ=.25;

res=90;

rotate([180,0,0])
difference(){
    cylinder(d=startD+startwall,h=startwallZ, center=false, $fn=res);
    cylinder(d=startD, h=startZ, center=false, $fn=res);
    rotate([0,0,202.5]) cube([(startD+2*startwall)/2,.7/2,startwallZ], center=false);
}

dia=2.85;

difference(){
    cylinder(d=dia, h=startwall, center=false, $fn=res);
    cylinder(d=startD, h=startZ, center=false, $fn=res);
    translate([0,dia/2,0]) cylinder(d=.175,h=startwall,center=false, $fn=res);
    translate([0,-(startD+2*startwall)/2-.325/2,0]) cylinder(d=.325,h=startwall, center=false,$fn=res);
}

difference(){
translate([0,0,startwall]) cylinder(d=1.3, h=.21, center=false, $fn=res);
translate([0,0,startwall]) cylinder(d=startD, h=.21, center=false, $fn=res);
    
translate([0,-(startD+2*startwall)/2-.325/2,startwall]) cylinder(d=.325,h=.21, center=false,$fn=res);
}

    translate([dia/2-.175/2,0,2*startwall+.21]) cylinder(d=.175,h=startwall/2,center=false, $fn=res);

difference(){
translate([0,0,startwall+.21]) cylinder(d=dia, h=startwall, center=false, $fn=res);
    translate([0,0,startwall+.21]) cylinder(d=startD, h=startZ, center=false, $fn=res);

    translate([0,dia/2,startwall+.21]) cylinder(d=.175,h=startwall,center=false, $fn=res);
    translate([0,-(startD+2*startwall)/2-.325/2,startwall+.21]) cylinder(d=.325,h=startwall, center=false,$fn=res);
     for (i=[0:8])
        {rotate([0,0,i*360/8])
       rotate([0,0,360/16])translate([0,dia/2+1.25/3,startwall+.21]) cylinder(d=1.25,h=startwall, center=false,$fn=res);}
}


difference(){
translate([0,0,2*startwall+.21]) cylinder(d=1.2, h=.866, center=false, $fn=res);
    translate([0,0,3*startwall+.21]) cylinder(d=.675, h=.866-startwall, center=false, $fn=res);
    translate([0,0,2*startwall+.21]) cylinder(d=.5, h=startwall, center=false, $fn=res);
    rotate([0,0,45])linear_extrude(h=.866) spiralcut();
    rotate([0,0,45])linear_extrude (h=.866) rotate ([0,0,90]) spiralcut();
}
    
module spiralcut (){

difference(){
circle(d=1.21, $fn=30);
scale([.76,1]) circle(d=1.2, $fn=res);
    square([.6,.6]);
    rotate([0,0,180]) square([.6,.6]);
}
}
}

scale([25.4,25.4,25.4]) starter();
