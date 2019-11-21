//Google Pixel 3a case by J. Pickens CC non commercial, share alike, attribution license.
//Modified for thinner walls larger USB opening Larger Headphone opening 05-18-19
//Modified by EdX for added protection and overhand issue 2019-05-23


$fn=80; //modified by EdX from 50 to 80 for better resolution

//pixelbody();

module pixelbody(){ 
minkowski() {
    linear_extrude(height = 0.01, center = true, convexity = 10, twist = 0) {
        minkowski() {
            square([53.2,135],true);
            circle(5.25);
        }
    }
    sphere(4.25);
}
}

//shell();

//bodyplus();

module bodyplus(){ 
    //pixelbody plus openings
    
    union(){
    pixelbody();
        translate([0,-76,0])rotate([90,0,0])usbc();
        translate([36,6.75,0])rotate([90,0,90])switches();
        translate([20.6,60.25,-5]) camera();
        translate([0,33.0,-5]) finger();
        translate([-13.4,77.5,0]) headphone();
        translate([15.6,77.5,0]) microphone();
    }
}
module shell(){ 
minkowski() {
    linear_extrude(height = 1.6, center = true, convexity = 10, twist = 0)//modified by EdX height from 1.25 to 1.6 2019-05-23
    {
        minkowski() {
            square([54,136],true);
            circle(5.50);
        }
    }
    sphere45d(4.5);//modified by EdX to resolve overhang issue see module 2019-05-23
}
}

//screen();

module screen(){   
minkowski() {
    linear_extrude(height = 5, center = true, convexity = 10, twist = 0) {
        minkowski() {
            square([53.2,135.5],true);
            circle(7);
        }
    }
    }
}

case();

module case(){
difference(){
  
        shell();
        bodyplus();
        
        translate([0,0,5])screen();
        translate([0,0,8])cube([80,160,5],center=true);//cutoff top
        
}
//added by EdX for corner bumbers 2019-05-23
resizex = 0.05;
resizey = resizex*0.5;
scale([1+resizex,1+resizey,1])difference(){
  
        shell();
        bodyplus();

        scale([1-resizex,1-resizey,1])translate([0,0,5])screen();
        translate([0,0,8])cube([80,160,5],center=true);//cutoff top  
        cube([50,160,15],center=true);
        cube([80,130,15],center=true);
}
}

//cutouts

//translate([0,-76,0])rotate([90,0,0])usbc();

module usbc(){ //usbc plus speakers
    
    hull(){
        translate ([3,0]) cylinder(  5,    3.25,    3.5,        true);
        translate ([-3,0]) cylinder(  5,    3.25,    3.5,        true);
    }
    
    hull(){
        translate ([11,0.45]) cylinder(  5,    1.4,    1.4,        true);
        translate ([18,0.45]) cylinder(  5,    1.4,    1.4,        true);
    }
    hull(){
        translate ([-11,0.45]) cylinder(  5,    1.4,    1.4,        true);
        translate ([-18,0.45]) cylinder(  5,    1.4,    1.4,        true);
    }
}

//translate([36.1,7.75,0])rotate([90,0,90])switches();

//switches();

module switches(){ //side switch cutouts
    
    hull(){
        translate ([-8.5,0]) cylinder(  5,    3,    3,        true);
        translate ([30.5,0]) cylinder(  5,    3,    3,        true);
        translate ([-8.5,9,0]) cylinder(  5,    3,    3,        true);
        translate ([30.5,9,0]) cylinder(  5,    3,    3,        true);
    }
  
}
    
//camera();

module camera(){ //camera and flash cutouts
    
    hull(){
        translate ([0,0,0]) cylinder(  2,    7,    6,        true);
        translate ([-11.5,0,0]) cylinder(  2,    4,    3,        true);
        
    }
  
}

//finger();

module finger(){ //fingerprint sensor cutout
        
        translate ([0,0,0]) cylinder(  2,    8,    6,        true);     
}

//headphone();

module headphone(){ //headphone jack cutout
        
    hull(){
        translate ([1,0,-0.5]) rotate ([0,90,90]) cylinder(  8,    3,    3,        true);  
        translate ([-1,0,-0.5]) rotate ([0,90,90]) cylinder(  8,    3,    3,        true);
        translate ([1,0,3.75]) rotate ([0,90,90]) cylinder(  8,    3,    3,        true);  
        translate ([-1,0,3.75]) rotate ([0,90,90]) cylinder(  8,    3,    3,        true);
}
}
//microphone();

module microphone(){ //microphone cutout
        
        rotate ([0,90,90]) cylinder(  4,    0.8,    0.8,        true);     
}
//added by EdX to fix sphere overhang problems 2019-05-23
module sphere45d(radius){   
    difference(){
        union(){
            sphere(radius);
            translate([0,0,radius*sin(45)])cylinder(h=radius,r1=radius*cos(45),r2=0);
            mirror([0,0,1])translate([0,0,radius*sin(45)])cylinder(h=radius,r1=radius*cos(45),r2=0);
        }
        difference(){
            cube(radius*4, center=true);
            cube(radius*2, center=true);
        }       
    }
}

