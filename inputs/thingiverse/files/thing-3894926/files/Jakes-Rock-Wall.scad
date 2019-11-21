// customizable paramters.

sphere_radius=40;
hold1=25;
hold2=25;
hold3=25;
hold4=25;





//Jake Majors Rock Wall

$fn = 100;
// Setting up Initial Sphere to work off of.


difference(){
    union(){
    difference(){
    scale([1,1,1])
// size of the sphere in the middle
        sphere(sphere_radius);
 

}
// Setting up the four outside hold
difference(){
    union(){
    translate([-30,-40,0])
    rotate(a=50,v=[0,1,0])
    scale([1,2,.5])
//size of hand hold 1
        sphere(hold1);
}
}
difference(){
    union(){
    translate([-30,40,0])
    rotate(a=50,v=[0,1,0])
    scale([1,2,.5])
// size of hand hold 2
        sphere(hold2);
        
}
}
difference(){
    union(){
    translate([30,-40,0])
    rotate(a=130,v=[0,1,0])
    scale([1,2,.5])
 // size of hand hold 3       
        sphere(hold3);
}        
}

difference(){
    union(){
    translate([30,40,0])
    rotate(a=130,v=[0,1,0])
    scale([1,2,.5])
// size of hand hold 4
        sphere(hold4);
}
}
}
// done with the 4 outside holds
// Cut out Holes for Rock Wall Mount   
translate([0,0,0])
    cylinder(h=200, r=5.5);
translate([0,0,8])
    cylinder(h=100, r=12.5);

translate([0,0,-100])
        cylinder(h=100,r=300);

// Finger Holds 3 per hold part

translate([50,25,10])
    scale([.5,.5,1.1])
    sphere(20);

translate([55,50,10])
    scale([.75,.5,1])
    sphere(20);

translate([55,70,10])
    scale([.75,.5,.9])
    sphere(20);
//// BREAK


translate([-50,25,10])
    scale([.5,.5,1.1])
    sphere(20);

translate([-55,50,10])
    scale([.75,.5,1])
    sphere(20);

translate([-55,70,10])
    scale([.75,.5,.9])
    sphere(20);

//////BREAK


translate([50,-25,10])
    scale([.5,.5,1.1])
    sphere(20);

translate([55,-50,10])
    scale([.75,.5,1])
    sphere(20);

translate([55,-70,10])
    scale([.75,.5,.9])
    sphere(20);

/////BREAK

translate([-50,-25,10])
    scale([.5,.5,1.1])
    sphere(20);

translate([-55,-50,10])
    scale([.75,.5,1])
    sphere(20);

translate([-55,-70,10])
    scale([.75,.5,.9])
    sphere(20);

////END OF FINGERHOLDS

}




