//Customizable Clip On Bushing and Carriage Mount, by ggroloff 9.18.2018

//Use this to make a model for a bushing/housing all in one that just clips around the guide rods. That way you can take off your carriages without removing the guide rods.
//I had better results (tighter tolerance with less friction) by using thin 8 mm bushings over the convention of using 24 mm bushings. YMMV, but I'm really happy with their performance.


//sets rod position from carriage, default 11.5
rod_position = 11.5;

//sets rod diameter for bushing, default 8.05
rod_diameter = 8.05;

//sets the length of the bushing
bushing_length= 8;

//sets the width of the mount plate
mount_width = 32;

//sets the diameter of the screw holes in the mount plate
mount_diameter = 3.9;

//sets the coordinates of the mount points, [x,y,z], leave z at 0. Set coordinates outside of the model volume [100,0,0] if not being used
mount1 = [-12,0,0];
mount2 = [12,0,0];
mount3 = [100,0,0];
mount4 = [100,0,0];

/*[Hidden}*/
//code starts here

module body() {
translate([0,0,1.75]) cube ([mount_width,bushing_length,3.5], center=true);
translate([0,0,(rod_position+8)/2]) cube ([17,bushing_length,rod_position+8], center=true);
}

module mount_points() {
 translate  (mount1) cylinder(d= mount_diameter, h = 30, center = true, $fn =64);
 translate  (mount2) cylinder(d= mount_diameter, h = 30, center = true, $fn =64);
 translate  (mount3) cylinder(d= mount_diameter, h = 30, center = true, $fn =64);
 translate  (mount4) cylinder(d= mount_diameter, h = 30, center = true, $fn =64);
}

module rod() {
        cylinder (d=1.0825*rod_diameter,h=50,center=true,$fn=8);//render octagon of rod_diameter width
}


//rod();

rotate ([-90,0,45]) //positions model for print

{
difference() {    
    body();//render body
    mount_points();//drill out mount screws
    translate ([0,0,rod_position]) rotate ([90,22.5,0]) rod();//drill out rod
    translate ([0,bushing_length/2,rod_position]) rotate ([90,22.5,0]) cylinder (r2=1.0825*4,r1=1.0825*4.1+1,h=1,center=true,$fn=8);//drill out rod chamfer
    translate ([0,bushing_length/2,0]) rotate ([45,0,0]) cube ([33,.75,.75], center = true);//drill out base chamfer
    translate ([-5,-.005,7.5]) rotate ([0,0,0]) cube([15,bushing_length+.01,8], center=true);//drill out rod slot
}
translate ([3,0,5]) rotate ([0,45,0]) cube ([4,bushing_length,8],center=true);//add ramp
}