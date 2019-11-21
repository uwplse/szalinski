// table leg top plate for upright

// input parameters
// timber
upright_width = 32;     // assumes square
upright_clearance=1;    // clearance each side
// socket dims
wall_thickness = 3.2;
wall_rad=1.6;
wall_height=30;
// top plate and stiffeners
corner_rad=5;
rib=3.2;
top_plate = 4.8;
screw_offset = 10;
screw_edge=10;
// clearance hole for screws
screw_dia = 4.5;

//working variables
corner_distance=(upright_width/2+upright_clearance+wall_thickness);
socket_width=upright_width+2*upright_clearance;
cap_edge=corner_distance+screw_offset+screw_edge;
screw_centre=corner_distance+screw_offset;

// smooth
$fn = 50;

//make the socket
{
    difference(){
        hull(){
            for (side=[0:90:360]) // sides = 1 to 4
                {
                    rotate([0,0,side])
                    translate([corner_distance-wall_rad,-(corner_distance-wall_rad),-wall_height/2])
                    cylinder(h=wall_height,r=wall_rad,center=true);
                }
        }
          
        translate([-socket_width/2,-socket_width/2,-(wall_height+1)])
          cube([socket_width,socket_width,wall_height+2]);
        translate([-corner_distance-1,0,-wall_height/2])
          rotate([0,90,0])
          cylinder(h=wall_thickness+2,d=screw_dia);
    }
}

// add the cap plate
{
    difference(){
        hull(){
            translate([corner_rad-corner_distance,corner_rad-cap_edge,top_plate/2])
                cylinder(h=top_plate,r=corner_rad,center=true);
            translate([cap_edge-corner_rad,corner_rad-cap_edge,top_plate/2])
                cylinder(h=top_plate,r=corner_rad,center=true);
            translate([cap_edge-corner_rad,cap_edge-corner_rad,top_plate/2])
                cylinder(h=top_plate,r=corner_rad,center=true);
            translate([corner_rad-corner_distance,cap_edge-corner_rad,top_plate/2])
                cylinder(h=top_plate,r=corner_rad,center=true);
            }
 
        translate([screw_centre,-screw_centre,top_plate/2])
            cylinder(h=top_plate+2,d=screw_dia,center=true);
        translate([screw_centre,screw_centre,top_plate/2])
            cylinder(h=top_plate+2,d=screw_dia,center=true);
        }
}

//And finally, stiffening ribs
for (side=[-90:90:90]) // sides = 1 to 3
    rotate([0,0,side])
    hull(){
        translate([corner_distance,-rib/2,-wall_height])
            cube(rib);
        translate([cap_edge-rib,-rib/2,-rib])
            cube(rib);
        translate([cap_edge-rib,-rib/2,0])
            cube(rib);
        translate([corner_distance,-rib/2,0])
            cube(rib);
    }