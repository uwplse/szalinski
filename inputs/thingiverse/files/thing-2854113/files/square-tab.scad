// #Openscad Long square pdr pull plate based on my
// PDR_tab -> https://www.thingiverse.com/thing:2849868
// #Paintless dent repair, #Paintless dent removal #tab
// for pulling dents out of cars or hotbeds! 
// I suppose at some force point the top will brake off,
// Can also be used to check force of first layer
// adhesion on 3d printers!
// enjoy!!! 
// version= v1 2018-04
//////////

// resultion default 100 use something like 25 if too long
$fn=100; 

// how many tabs long, defaults to 1 with no number,  

tabs(2);

////////////////
// things to mess with!
//

// how wide is the base, default 30
x=30;

// how long is the base, default 30
y=30;

// how thick is the base, default 1.5
base_hight=1.5;

// the link space between tabs (the red connecting bits), default=5
link_size=3;

// width of links, default = y/2
link_width=y/2;

// center_hight, is the blue center cylinder and support hight. default=12.
center_hight=(12);

// curve of base plate, default 4, 
// can be 0.1 for more square
//strange things happen if you make it too big!
m=4;

/*-----End of settings----*/

module tabs(how_long=1){
    for(i = [0:x+m+link_size:(x+m+link_size)*(how_long-1)]){
        translate([i,0,0])
        union(){
            tab();
           // join plates
            echo ((x+m+link_size)*(how_long-1),i);
            if ((x+m+link_size)*(how_long-1)==i){}
            else{
            color("red")translate([(x+m)/2+(link_size/2),0,0])
            cube([link_size,link_width,base_hight],center=true);
            ;}
        }
    }
}
module tab(){
  
    // top to bottom, press F5 to see colors in openscad
    color("lime")translate([0,0,center_hight+2])cylinder(d=12,h=7);
    // The Purple cylinder, helps print the top nob.
    color("Purple")translate([0,0,center_hight])cylinder(d1=6.5,d2=12,h=2);
    color("blue")translate([0,0,base_hight/2])cylinder(d=6.5,h=center_hight+3);
    
    // supports at bottom of post
    
    color("yellow")translate([0,0,base_hight/2])cylinder(d1=15, d2=6.5,h=3);

    // base plate with curve      
    color("green")
    minkowski(){
        cube(size = [x-m,y-m,base_hight/2],center=true);
        cylinder(h=base_hight/2,r=m,center=true);                   
   }

}


