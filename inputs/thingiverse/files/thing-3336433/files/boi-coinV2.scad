/* [General Parameters] */

//Do you want to print a coin or a heart?
type = "Coin"; // ["Coin", "Heart"]

//Do you want to use custom paramters from the corresponding section?
UseCustomParameters = false;


/* [Custom Parameters] */

//(in mm) diameter of the objcet
diameter = 18; //[5 : 1 : 30]

//(in mm) height of the object
height = 1.8; //[0.1 : 0.1 : 5]

//(in mm) changes nothing for the heart
engravingDepth = 0.5 ; //[0.1 : 0.1 : 2.5]

//render quality
$fn=100;


//render the selected battery
if (type == "Coin"){
    if(UseCustomParameters){
        coin(diameter,height,engravingDepth);
    } else {
        coin(15,1.2,0.4);
    }
} else if (type == "Heart"){
    if(UseCustomParameters){
        heart(diameter,height);
    } else {
        heart(20,2);
    }
}


module coin(d,h,e){scale([d/20,d/20,1])color([1,1,1])union(){difference(){
cylinder(h,10,10);
translate([0,0,-0.01])cylinder(e+0.01,10-1.5,10-1.5);
translate([0,0,h-e])cylinder(e+0.01,10-1.5,10-1.5);
    }
scale([-1.5,1.5,1])face(h/2);
translate([0,0,h/2])scale([-1.5,-1.5,1])face(h/2);
}
}

module face(h){difference(){
scale([0.9,1,1])cylinder(h,5,5);
translate([-0.45,-2.7,0])eye(h);
translate([-0.45,2.7,0])eye(h);
translate([-2.4,0,0])mouth(h);
}}

module eye(h){difference(){
translate([0,0,-0.01])cylinder(h+0.02,1.3,1.3);
translate([0.35,0.3,0])cylinder(h,0.65,0.65);
}}
    
module mouth(h){intersection(){
translate([0,0,-0.01])scale([1,0.85,1])cylinder(h+0.02,1.5,1.5);
translate([0,-2,-0.01])cube([4,4,h+0.02]);
}}

module heart(s,h){color([1,0,0])union(){
translate([-s/4,0,0])cylinder(h,s/4,s/4);
translate([s/4,0,0])cylinder(h,s/4,s/4);
translate([-s/4,-s/4,0])cube([s/2,s/4,h]);
    difference(){
        intersection(){
            translate([s*0.288,s*0.21,0])cylinder(h,s*0.828,s*0.828);
            translate([-s*0.288,s*0.21,0])cylinder(h,s*0.828,s*0.828);
    }
        translate([-s,-s*0.1,-0.01])cube([s*2,s*2,h+0.02]);
    }
}}