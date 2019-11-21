// #Openscad Basic pdr pull plate 
// #Paintless dent repair, #Paintless dent removal #tab
// for pulling dents out of cars or hotbeds! 
// I suppose at some force point the top will brake off,
// Can also be used to check force of first layer
// adhesion on 3d printers!
// enjoy!!! 
// version= v8 2018-04
//////////

// resultion default 100 use 25 if too long
$fn=100; 

// outside diamater size in mm, defalut 35
tab(35); 

// how thick is the base, default 1
base_hight=1;
////////////////
module tab(size){
    // center_hight, is the blue center cylinder and support hight.
    center_hight=(size/3)+2.5;
    // top to bottom, press F5 to see colors in openscad
    color("lime")translate([0,0,center_hight+2])cylinder(d=12,h=7);
    // The Purple cylinder, helps print the top nob.
    color("Purple")translate([0,0,center_hight])cylinder(d1=6.5,d2=12,h=2);
    color("blue")translate([0,0,1])cylinder(d=6.5,h=center_hight+3);
    
    // only supports if above size default 20
    if (size>20){
        color("yellow")translate([0,0,1])cylinder(d1=15, d2=6.5,h=3);
    }
    // red support, default every 45 degrees.    
    if (size>30){
        for (i = [0:45:360]){
            color("red")rotate([0,0,i])
            translate([-1,0,base_hight]) prism(2,size/2.2, center_hight-7);
        }
    }
    
    // base plate
    difference(){
        color("green")cylinder(d1=size,d2=size/1.05,h=base_hight);
    }
}
/////////
// the support master shape
module prism(w,l, h){
        polyhedron(
         points=[[0,0,0], [w,0,0], [w,l,0], [0,l,0], [w,0,h],[0,0,h]],
         faces=[[0,1,2,3],[3,2,4,5],[5,4,1,0],[0,3,5],[1,4,2]]
        );
 }
