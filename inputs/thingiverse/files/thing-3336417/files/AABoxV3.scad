/* [General Parameters] */

//battery type: custom values can be set in the Custom Parameters Tab
tp = "AA"; // ["AA", "AAA", "B18650", "Custom"]



//battery count
c = 4; //[1:10]

//wall thickness
t = 1.5; //[0.5 : 0.1 : 3]

RenderBottom = true;
    RenderTop = true;

//render quality
$fn=100;


/* [Custom Parameters] */

//battery length (this only applies if battery part is Custom)
l = 50; //[0.5 : 0.1 : 100]

//battery diameter (this only applies if battery part is Custom)
d = 10; //[1 : 0.1 : 40]



//render the selected battery
if (tp == "AA"){
    box(51,15);
} else if (tp == "AAA"){
    box(45,11);
} else if (tp == "B18650"){
    box(68,19);
} else {
    box(l,d);
}


//select the parts to render
module box(l,d){
    if(RenderBottom) batteryBoxB(l,d);
    if(RenderTop) batteryBoxT(l,d);
}

//bottom part
module batteryBoxB(l,d){difference(){
union(){
base(l,d);
translate([-l/2-t,0,0])rotate([0,90,0])cylinder(l/4+t-0.4,3,3); //left tube
translate([-l/2-t,0,0])rotate([45+180,0,0])cube([l/4+t-0.4,3,5]); 
translate([l/4+0.4,0,0])rotate([0,90,0])cylinder(l/4+t-0.4,3,3); //righttube
translate([l/4+0.4,0,0])rotate([45+180,0,0])cube([l/4+t-0.4,3,5]); 
    
    }
translate([-l/4-0.4,0,0])rotate([0,90,0])cylinder(l/2+0.8,3.5,3.5); //middle tube
translate([-l/4-0.4,0,0])rotate([45+180,0,0])cube([l/2+0.8,5,3.5]); //middle tube
translate([-l/4-t-0.01,0,0])rotate([0,90,0])cylinder(l/2+2*t+0.02,1.7,1.7); //axis tube
    
translate([0,3+1.5*t+d*c,-3])cube([8,t+d,2],true);    

}}

//top part
module batteryBoxT(l,d){union(){
    difference(){
union(){
rotate([0,0,180])base(l,d);
translate([-l/4,0,0])rotate([0,90,0])cylinder(l/2,3,3); //middle tube
translate([-l/4,0,0])rotate([45+180,0,0])cube([l/2,4,3]); //middle tube
rotate([180,0,0])translate([0,3+2*t+d*c,0])latch(l,d); //latch
    }
translate([-l/2-t-0.01,0,0])rotate([0,90,0])cylinder(l/4+t+0.01,3.5,3.5); //left tube
translate([-l/2-t-0.01,0,0])rotate([45+180,0,0])cube([l/4+t+0.01,3.5,5]); 
translate([l/4,0,0])rotate([0,90,0])cylinder(l/4+t+0.01,3.5,3.5); //right tube
translate([l/4,0,0])rotate([45+180,0,0])cube([l/4+t+0.01,3.5,5]);
}
translate([-l/4,0,0])rotate([0,90,0])sphere(1.5);
translate([l/4,0,0])rotate([0,90,0])sphere(1.5);
}}

module latch(l,d){difference(){union(){
translate([0,0,-3.57])rotate([45,0,0])cube([8-0.4,3,2],true);
translate([0,1.25,-2])cube([8-0.4,2.25,6.45],true);
translate([0,0.5,t/4+d/4])cube([8-0.4,3.75,d/2+t-2],true);
}
translate([0,-1.2,-4-0.3])rotate([-25,0,0])cube([8,6*1.5,2],true);
translate([0,1*t+0.3,d/2+0.64-1])rotate([45,0,0])cube([8,1.5*2,d+t],true);
}}
    
module base(l,d){translate([-l/2-t,3,-d/2-t])difference(){
translate([t/1,-2.5+t/1,t/1])minkowski(){
    cube([l+2*t-(t/1*2),d*c+2*t+2.5-(t/1*2),d/2+t-(t/1*2)]);
    sphere(t/1);
    } 
translate([t,t,t+d/2-d/5])cube([l,d*c,d/5]);
translate([t,t,t])batterys(l,d);
translate([t+d/2,t+d/2,-0.01])cube([l-d,d*(c-1),d/2+t+0.02]);

translate([-0.01,-3,+d/2+t])rotate([45+180,0,0])translate([0,3,0])cube([l+2*t+0.02,3,10]);
translate([-0.01,d*(c-0.2)+2*t,0])rotate([-45,0,0])translate([0,0,0])cube([l+2*t+0.02,3,10]);
}}

module batterys(l,d){translate([0,d/2,d/2])union(){
for (i =[0:(c-1)])translate([0,d*i,0])rotate([0,90,0])cylinder(l,d/2,d/2);
}}