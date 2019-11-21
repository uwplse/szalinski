use <MCAD/screw.scad>;

precision = 10; // higher is more precise

upper = 10; // Elevation of foot from the socle

feet_diameter = 26; // diameter of the feet at the higher penetration point
feet_ground_diameter = 26; // diameter of the feet on the ground (if the feet is a cylinder, it should be equal to "feet_diameter". Either case, it should be equal or less than value of feet_diameter
square_feet = false;
feet_thickness = 5; // the thickness of support around the existing feet
screw_size = 0; //0 = disable (in case you'll need to add a screw to maintain the foot, not tested)
type = "cone"; // or "socle". Cone is more stable but it is also possible to build a socle
height_ratio = 3; // higher is more stable. This ration indicate the part of the foot which enter in the support depending on its elevation. For example a heigh_ration of 1 means that the part of the current feet entering in the support is equal to the elevation (minus the socle size)

socle = 5; // size of the socle below the support
join_size= upper*height_ratio; // in case you wanna discard the ratio and input your own size.
builder(upper, feet_diameter, feet_ground_diameter, square_feet, feet_thickness, screw_size, type, height_ratio, socle, join_size);

module builder(upper, feet_diameter, feet_ground_diameter, square_feet, feet_thickness, screw_size, type, height_ratio, socle, join_size) 
{
union() {
difference(){
    if (type == "cone")
        cylinder(h=join_size+upper, r2=(feet_diameter+feet_thickness)/2, r1=(feet_diameter+feet_thickness+socle)/2, $fn=precision*(feet_diameter+feet_thickness)/2);
    if (type == "socle")
        cylinder(h=join_size+upper, r=(feet_diameter+feet_thickness)/2,$fn=precision*(feet_diameter+feet_thickness));
    if (feet_ground_diameter != feet_diameter)
        translate([0,0,upper+feet_thickness])
            cylinder(h=join_size-feet_thickness, r1=feet_ground_diameter/2,r2=feet_diameter/2,$fn=precision*feet_diameter/2);
    else
        if (square_feet)
            translate([0,0,upper+feet_thickness])
            cube([feet_diameter,feet_diameter,(join_size-feet_thickness)*2], center = true);
        else
            translate([0,0,upper+feet_thickness])
            cylinder(h=join_size-feet_thickness, r=feet_diameter/2,$fn=precision*feet_diameter/2);
    
    translate([0,feet_diameter+feet_thickness*3,upper+feet_thickness+join_size/2])
        rotate([90,0,0])
            auger(pitch=4, length=feet_thickness*4, outside_radius=screw_size, inner_radius=screw_size-1);
    }
    translate([0,0,-feet_thickness])
        cylinder(h=feet_thickness, r=(feet_diameter+feet_thickness+socle)/2, $fn=precision*(feet_diameter+feet_thickness+socle)/2);
} 
}