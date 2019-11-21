
$fn=36;  //quality of render.  default=0   //number of faces.

casing_diameter = 5.6;  //wikipedia=5.7   measured=5.6
casing_height = 15.5+4;   //wikipedia=15.6  measured=15.5 
rim_diameter = 6.9;     //wikipedia=7.1   measured=6.7
rim_height = .7;         //wikipedia=1.1   measured=1,0.8
total_height = 25;      //wikipedia=25.4  measured=25
slot_start = 6.6;       //measured=6.6
slot_width = 1.5;       //measured=1.3
slot_length = 11;     //measured=10.3  //10.8 //11.3 

casing_radius = casing_diameter/2; 

module complete_bullet()
{
//casing
cylinder(h=casing_height, d1=casing_diameter, d2=casing_diameter, center=false);

//rim
cylinder(h=rim_height, d1=rim_diameter, d2=rim_diameter, center=false);

//bullet taper to half
//translate([0,0,casing_height])
//cylinder(h=total_height-casing_height, r1=casing_radius, r2=casing_radius/2, center=false);

//bullet rounded tip
//cylinder(h=total_height-casing_radius, d1=casing_diameter, d2=casing_diameter, center=false);
//translate([0,0,total_height-casing_radius]) sphere(d=casing_diameter);
    
//bullet taper plus rounded tip
taper_end = .6;
translate([0,0,casing_height])
cylinder(h=total_height-casing_height-casing_radius*taper_end, 
    d1=casing_diameter, d2=casing_diameter*taper_end, center=false);
translate([0,0,total_height-casing_radius*taper_end]) sphere(r=casing_radius*taper_end);    
}

module feed_slot()
{
translate([-10,-slot_width/2,slot_start]) cube([20,slot_width,slot_length],center=false);
}

difference()
{
complete_bullet();
feed_slot();
}

