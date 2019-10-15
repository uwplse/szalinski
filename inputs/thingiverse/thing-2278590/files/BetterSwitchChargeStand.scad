buildHeight = 90;
viewingAngle = 45;
supportAngle = 90;

//The following does not need to be edited
viewLength = buildHeight/sin(viewingAngle);
ztran = (0.5*viewLength)*sin(viewingAngle);
xtran = (0.5*viewLength)*cos(viewingAngle);
union() {
    cube([90, 90, 3], true);
    
    translate([-xtran +45,0,ztran])rotate([0, viewingAngle, 0])union(){
    cube([viewLength, 90, 3],true);
    
        translate([10,0,0]){translate([-1.25,0,18])cube([5,90,3],true);
        
    difference(){
        translate([0,0,8])cube([3,90,18],true);
        translate([0,0,9.25])cube([10,18,12],true);
        }
       translate([15, 40,0]) rotate([0,-45,0])cylinder(21,r=2,true);
       translate([15, -40,0]) rotate([0,-45,0])cylinder(21,r=2,true);
    
        
        translate([1,0,1])rotate([0,-110,0]){
            translate([3.5,0,7])rotate([0,20,0])cube([2.1,7,10.4],true);
    intersection(){
    translate([4,0,8.5])rotate([0,20,0])cube([2,7,11],true);
    difference(){
        $fn=50;{translate([5,0,10.5])sphere(3.9);}
        translate([4,0,8.5])rotate([0,20,0])cube([10,8,7.25],true);
    }
}}}
        
    }
    /*rotate([0,0,3.5]) {
translate([10,0,1.5]){scale([3,3,2]){
translate([1, -1, 0]){
difference(){
translate([-1,0,-.5])cylinder(h=1.5, r1=8, r2=8);
translate([0,1,-.5])cylinder(h=1.5, r1=7, r2=7);
}
rotate([0,0,-50])translate([-15, -1, -.5])cube([7,2.5,1.5]);
rotate([0,0,50])translate([-15, 0, -.5])cube([15,2.5,1.5]);
rotate([0,0,50])translate([-3, -2, -.5])cube([4,7,1.5]);}}}}*/
    losr = sin(180-(viewingAngle+supportAngle))/90;
    supLength = sin(viewingAngle)/losr;
    
    ztran2 = (0.5*supLength)*sin(supportAngle);
    xtran2 = (0.5*supLength)*cos(supportAngle);
    translate([xtran2 - 45,0,ztran2])rotate([0, -supportAngle, 0])cube([supLength, 90, 3],true);
    
}