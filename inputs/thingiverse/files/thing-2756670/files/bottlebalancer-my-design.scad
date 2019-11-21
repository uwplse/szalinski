bottleneck = 30.5;
largerad=20;
length = 80;
$fn=80;
height1=38;
supportheight=105;
supporthick=6;
topthick=supporthick;
footwide=50;
bottletorquebardiam=3;
bottledelta=5;
supportangle=5;
step=35;
holes=false;


module outside(){
    minkowski(){
    cube([length-2*largerad,0.01,0.01],center=true);
    cylinder(h=height1,r=largerad,center=false);
    }
    translate([-length/2+1,-supporthick/2,0])
    rotate([0,0,90])
    cube([supporthick,supportheight,height1],center=false);
//    translate([-length/2+1,0,4])
//    rotate([0,0,90])
//    cube([supporthick,supportheight-3,height1-8],center=false);
    translate([-length/2-supportheight-0.7*(footwide/2)+0.96,-0.6193*(footwide/2),height1/2])
    rotate([0,0,130])
    cube([supporthick,footwide,height1],center=true);
}
    


module inside(){
    translate([0,0,-1])
    minkowski(){
    cube([length-2*largerad,0.01,0.01],center=true);
    cylinder(h=height1+5,r=largerad-topthick,center=false);
    }
    translate([0,0,height1/2])
    rotate([90,0,0])
    cylinder(h=350,r=bottleneck/2,center=false);
    
    
if (holes==true){ 
    translate([-length/2-largerad/2,10,height1/2])
    rotate([90,0,0])
    cylinder(h=350,r=bottleneck*0.4,center=true);
    
    translate([-length/2-largerad/2-step,10,height1/2])
    rotate([90,0,0])
    cylinder(h=350,r=bottleneck*0.4,center=true);
    
    translate([-length/2-largerad/2-2*step,10,height1/2])
    rotate([90,0,0])
    cylinder(h=350,r=bottleneck*0.4,center=true);
    
    translate([-length/2-largerad/2-3*step,10,height1/2])
    rotate([90,0,0])
    cylinder(h=350,r=bottleneck*0.4,center=true);
    
    translate([-length/2-largerad/2-4*step,10,height1/2])
    rotate([90,0,0])
    cylinder(h=350,r=bottleneck*0.4,center=true);
}
    
}

difference(){
    outside();
    inside();
}
//union(){
//    translate([bottleneck/2,0,height1/2+bottledelta+bottletorquebardiam/2])
//    rotate([90,0,0])
//    cylinder(h=2*largerad-0.5, d=bottletorquebardiam, center=true);
//    translate([bottleneck/2,0,height1/2-bottledelta-bottletorquebardiam/2])
//    rotate([90,0,0])
//    cylinder(h=2*largerad-0.5, d=bottletorquebardiam, center=true);
//}

module support(){
    difference(){ 
        translate([0,0,height1/2])
        rotate([90,0,0])
        cylinder(h=2*largerad-1, d=bottleneck+4, center=true);
        translate([-bottleneck+3,-largerad,0]) 
        cube([bottleneck+5,2*largerad,height1+4], center=false);
        translate([0,bottleneck,height1/2])
        rotate([90,0,0])
        cylinder(h=350,r=bottleneck/2,center=false);
    }
}
    
    
support();