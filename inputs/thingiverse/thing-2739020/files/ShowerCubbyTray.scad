  //////////////////////////
 // Customizer Settings: //
//////////////////////////

//Cubby Width (mm)
w=100;
//Cubby Depth (mm). Does NOT include nose radius (h/2). 
d=75;   
//Height of main beams (mm). Does NOT include feet, lips, or tails
h=10; // [5:20]
//Thickness of all parts (mm)
t=2;  // [1:5]

//Do you want feet on the bottom? 
feet="y"; // ["y":Yes, "n":No]
//Do you want a tail sticking up on the rear? 
tail="n"; // ["y":Yes, "n":No]
//Do you want a lip sticking up on the front? 
lip="n"; // ["y":Yes, "n":No]    


  //////////////////////
 // Static Settings: //
//////////////////////
$fn=35*1;     //Polygon face count - higher values render slower but create smoother circles

for(n = [((w-t)%10)/2 : 10 : w-((w-t)%10)/2]) {
    translate([h/2,n,0]) base();                            //base beams
}
translate([d/4,0,20]) rotate([-90,0,90]) crossbeam();       //rear crossbeam
translate([3*d/4,0,20]) rotate([-90,0,90]) crossbeam();     //front crossbeam

module base() {
    translate([0,0,-h/2]) cube([d-h/2,t,h]);                        //main base beam
    translate([d-h/2,0,0]) rotate([-90,0,0]) cylinder(r=h/2,h=t);   //main nose
    translate([0,0,0]) rotate([-90,0,0]) cylinder(r=h/2,h=t);       //main butt
    
    if (feet=="y") {
        translate([h/4,0,-h/4]) rotate([-90,0,0]) cylinder(r=3*h/4,h=t);  //back foot
        translate([3*d/4,0,-h/4]) rotate([-90,0,0]) cylinder(r=3*h/4,h=t);  //front foot
    } 
    
    if (lip=="y") {    
        translate([d-h/4,0,h/2]) rotate([-90,0,0]) cylinder(r=h/4,h=t); //optional lip
        translate([d-h/2,0,0]) cube([h/2,t,h/2]);                       //optional lip riser
    }
    
    if (tail=="y") { 
        translate([-h/4,0,3*h/4]) rotate([-90,0,0]) cylinder(r=h/4,h=t);    //optional tail tip
        translate([-h/2,0,0]) cube([h/2,t,3*h/4]);                           //optional tail riser
        //translate([-h/2,0,0]) cube([h/2,t,h/2]);                          //optional tail bed
    }
}

module crossbeam() {
translate([0,2*h,0]) rotate([0,90,-90]) difference() {
    cube([t,w,h/2]);
}}