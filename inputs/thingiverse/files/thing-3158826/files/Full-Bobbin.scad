//Customizable Bobbin for a Yarn Spinning Thingymabob


//Left Circle Diameter
l_sphere_d = 68.4;
//Left Side Thickness
l_thickness = 12.8;
//Right Sphere Diameter
r_sphere_d = 58.0;
//Right Circle Thickness
r_thickness = 8.0;
//Middle Sphere Diameter
m_sphere_d = 77.0;
//Middle Circle Thickness
m_thickness = 8.82;
//Gap Between Right and Middle Circles
r_m_gap = 1;
//Length of Rod between Left and Middle Circles
middle_rod_length = 93.0;
//Inner Rod Diameter
ID = 9.5;
//Outer Rod Diameter
OD = 12;
$fn = 100;
full_right_thick = r_thickness+m_thickness+r_m_gap;



module Leftside() {
    difference(){
        hull(){
            sphere(d = l_sphere_d,center=true);
            translate([0,0,-.75*l_thickness])cylinder(d = l_sphere_d, h = l_sphere_d,center=true);
        }
        translate([0,0,-l_thickness])cube([l_sphere_d,l_sphere_d,l_sphere_d],center=true);
}
}

module InsideRight(){
    difference(){
        hull(){
            sphere(d=2*r_sphere_d,center=true);
            translate([0,0,-.6*r_thickness])cylinder(d=r_sphere_d, h = 2*r_sphere_d, center = true);
}
        translate([0,0,-.7*r_thickness])cube([2*r_sphere_d,2*r_sphere_d,2*r_sphere_d],center=true);
}
}
module OutsideRight(){
    difference(){
        hull(){
            sphere(d=2*r_sphere_d,center=true);
            translate([0,0,-.25*r_thickness])cylinder(d=r_sphere_d, h = 2*r_sphere_d, center = true);
}
        translate([0,0,-.3*r_thickness])cube([2*r_sphere_d,2*r_sphere_d,2*r_sphere_d],center=true);
}
}
module Right(){
    hull(){
        translate([0,0,-(r_sphere_d-r_thickness)])InsideRight();
        mirror([0,0,1])translate([0,0,-r_sphere_d])OutsideRight();
}
}

module Middle(){
    difference(){
        hull(){
            sphere(d = m_sphere_d,center=true);
            translate([0,0,-.75*m_thickness])cylinder(d = m_sphere_d, h = m_sphere_d,center=true);
        }
        translate([0,0,-m_thickness])cube([m_sphere_d,m_sphere_d,m_sphere_d],center=true);
}
}

module TransMiddle(){
translate([0,0,-(m_sphere_d/2-m_thickness)])Middle();
}

module FullRight(){
    union(){
        Right();
        mirror([0,0,1])translate([0,0,-(full_right_thick)])TransMiddle();
        translate([0,0,.5*r_thickness])cylinder(d = OD+4,h = r_thickness);
    }
}

module centerrod(){
    difference(){
        translate([0,0,-(full_right_thick)])cylinder(d=OD,h = (middle_rod_length+full_right_thick+l_thickness));
        translate([0,0,-(full_right_thick)])cylinder(d=ID,h = (middle_rod_length+full_right_thick+l_thickness));
}
}
module r_side_w_hole(){
    difference(){
        translate([0,0,-(full_right_thick)])FullRight();
        translate([0,0,-(full_right_thick)])cylinder(d=OD+1,h = (middle_rod_length+full_right_thick+l_thickness));
    }
}
module l_side_w_hole(){
    difference(){
        translate([0,0,middle_rod_length])translate([0,0,-(l_sphere_d/2-l_thickness)])Leftside();
        translate([0,0,-(full_right_thick)])cylinder(d=OD+1,h = (middle_rod_length+full_right_thick+l_thickness));
    }
}
centerrod();
r_side_w_hole();
l_side_w_hole();

module trans_l_side(){
    translate([0,0,-middle_rod_length])l_side_w_hole();
}

module trans_centerrod(){
    translate([0,0,full_right_thick])centerrod();
}
