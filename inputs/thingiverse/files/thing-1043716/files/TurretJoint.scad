//    TurretJoint.scad
//    Copyright 2015, Robert L. Read

//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
// TO BE DONE: Some of the models are "guessed" so that they are not
// really repeatably parametric.
// The naming is poor in many cases.
// 
// NOTE: The Turret Joint is invention created by Public Invention, and 
// Robert L. Read in particular, extending the patent of Kwong, Song, and Kim:
// https://patents.google.com/patent/US20010002964A1/en
// Public Invention has no intention of 
// patenting this. Do not attempt to patent it. That would be fraudulent,
// illegal, and compel us to seek legal redress. However, you are free 
// to manufacture, use, and improve this invention so long as you do 
// not attempt to monopolize it or prevent others from doing so.

// Some parameters for the Turret Joint

// Part to print:
part_to_render = "ball"; // [all, demoturret, rotor, cap, ninecap,lock, ball, tubemount, firgellipushrod, firgellistator, tetrahelixlock, tetrahelixcap]

symmetric_or_tetrahedral = "symmetric"; // [symmetric,tetrahedral]

// Note: equilateral_rotors are currently not really correct. This requires more work!
use_equilateral_rotors = "true" ; // [false,true]


// These units are in mm 
// Ths inner ball of the turret joint
ball_radius = 25.0; 
// The thickness of the moving "rotors"
rotor_thickness = 2.5; 
// The thickness of the locking shell
lock_thickness = 2.5; 
// a tolerance space to allow motion
rotor_gap = 0.75; 

mounting_clevis_height = 25;

// These units are in degrees
// some of these are explicitly created from my Gluss Pusher model
// These will not be used if you choose "symmetric", and will 
least_spread_angle = 19.47;
most_spread_angle = 48.59;

symmetric_spread_half_angle = 15;

screw_hole_radius_mm = 2;

// percent reduction of peg diameter, needed for easy fit
locking_peg_percent_tolerance = 10;


// the edge difference of the rotor to make sure it doesn't fall out
safety_lip_angle = 4;

// the angle of the post (at the surface of the rotor!)
post_half_angle = 3;

ball_locking_peg_width_factor = 10;
ball_locking_peg_height_factor = 4;
ball_locking__peg_tolerance_factor = 1.0;

three_hole_cap_seam_height_mm = 2.5;


tube_mount_inner_radius = 3.0;
tube_mount_out_radius = 4.5;

// firgelli pushod mount cavity width
firgelli_pr_cw=6; 
// firgelli pushod mount shell width
firgelli_pr_sw=3; 
// firgelli pushod mount cavity height
firgelli_pr_ch=9.5; 
// firgelli pushod mount cavity depth
firgelli_pr_cd = 8; 
// offset from center of main body for drill hole (pushrod)
firgelli_pr_hole_center_offset = 2.5; 

// firgelli stator mount cavity width
firgelli_st_cw=9; // cavity_width
// firgelli stator mount shell width
firgelli_st_sw=3; 
// firgelli stator mount shell width
firgelli_st_ch=11; 
// firgelli stator mount shell depth
firgelli_st_cd = 8; 
// offset from center of main body for drill hole (stator)
firgelli_st_hole_center_offset = 2.0; // offset from center of main body for drill hole

firgelli_hole_fit_fudge_factor = 0.8;

module fake_module_so_customizer_does_not_show_computed_values() {
}

// Let's go for some high-res spheres (I don't fully understand this variable!)
$fa = 3;


// Computed parameters...
// Note that I implicitly assuming this hole is centered on the 
// tetrahedronal geomety---that is neither necessary nor obviously
// correct in the case of Gluss Triangle.  I will have to 
// generate the holes by a more general mechanism later.

// These functiona are probably wrong, the central symmetric angle
// when measured from the apex is not 30 degrees.
central_sym_angle = 35.26439; // this is half the dihedral angle, unclear if this is right!
// but more particular arcwin(sqrt(3)/3), which is how I compute this angle.

function msa() = 
(symmetric_or_tetrahedral == "symmetric") ? central_sym_angle+symmetric_spread_half_angle : most_spread_angle; 


function lsa() =
  (symmetric_or_tetrahedral == "symmetric") ? central_sym_angle-symmetric_spread_half_angle :least_spread_angle;    

echo("most_spread");
echo(msa());

hole_angle = msa() - lsa();
radius_at_rotor_outer_edge = ball_radius+rotor_thickness+rotor_gap;
radius_at_rotor_inner_edge = ball_radius+rotor_gap;
radius_at_lock_inner_edge = ball_radius+rotor_thickness+2*rotor_gap;
outermost_radius = radius_at_rotor_outer_edge + lock_thickness;

hole_size_mm = radius_at_lock_inner_edge*2.0*sin(hole_angle/2);



rotor_size_mm = (radius_at_lock_inner_edge)*2.0*sin((hole_angle+2*post_half_angle)/2.0);

post_radius_mm = radius_at_rotor_outer_edge*sin(2*post_half_angle);

rotor_hole_angle = (msa() + lsa()) / 2;


echo("Rotor Hole Angle");
echo(rotor_hole_angle);

//insert

// This code came from "Andrei" http://forum.openscad.org/Cylinders-td2443.html

module cylinder_ep(p1, p2, r1, r2) {
translate(p1)sphere(r=r1,center=true);
translate(p2)sphere(r=r2,center=true);
vector = [p2[0] - p1[0],p2[1] - p1[1],p2[2] - p1[2]];
distance = sqrt(pow(vector[0], 2) + pow(vector[1], 2) + pow(vector[2], 2));
    
translate(vector/2 + p1)
//rotation of XoY plane by the Z axis with the angle of the [p1 p2] line projection with the X axis on the XoY plane
rotate([0, 0, atan2(vector[1], vector[0])]) //rotation
//rotation of ZoX plane by the y axis with the angle given by the z coordinate and the sqrt(x^2 + y^2)) point in the XoY plane
rotate([0, atan2(sqrt(pow(vector[0], 2)+pow(vector[1], 2)),vector[2]), 0])
cylinder(h = distance, r1 = r1, r2 = r2,center=true);
}

// lintrans is the linear translation along the p0 and p1 points to put the box.
module six_hole_box_ep(p1, p2, lintrans, w, d,h) {
vector = [p2[0] - p1[0],p2[1] - p1[1],p2[2] - p1[2]];
distance = sqrt(pow(vector[0], 2) +
pow(vector[1], 2) +
pow(vector[2], 2));
translate(vector*lintrans + p1)
//rotation of XoY plane by the Z axis with the angle of the [p1 p2] line projection with the X axis on the XoY plane
rotate([0, 0, atan2(vector[1], vector[0])]) //rotation
//rotation of ZoX plane by the y axis with the angle given by the z coordinate and the sqrt(x^2 + y^2)) point in the XoY plane
rotate([0, atan2(sqrt(pow(vector[0], 2)+pow(vector[1], 2)),vector[2]), 0])
 difference() { // Cut six holes out!
cube([w,d,h],center=true);
translate([w/4,0,h/4]) rotate([90,0,0]) cylinder(h=(w+h+d),r=screw_hole_radius_mm,center=true);
translate([w/4,0,0]) rotate([90,0,0]) cylinder(h=(w+h+d),r=screw_hole_radius_mm,center=true);
translate([w/4,0,-h/4]) rotate([90,0,0]) cylinder(h=(w+h+d),r=screw_hole_radius_mm,center=true);
translate([-w/4,0,h/4]) rotate([90,0,0]) cylinder(h=(w+h+d),r=screw_hole_radius_mm,center=true);
translate([-w/4,0,0]) rotate([90,0,0]) cylinder(h=(w+h+d),r=screw_hole_radius_mm,center=true);
translate([-w/4,0,-h/4]) rotate([90,0,0]) cylinder(h=(w+h+d),r=screw_hole_radius_mm,center=true);

 }
}
 

module cylindricalize_edges(edges,points,rad) {
    for(e = edges) {
        p0 = points[e[0]];
        p1 = points[e[1]];
        color("red") cylinder_ep(p0, p1, rad, rad, $fn=20);
    }
}

// The purpose here is to produce a matching part that mates to 
// our rotor pegs for mounting a rod (like a carbon-fiber rod with a 
// 1/4" interior diameter, for example).
// This is a sloppy, ugly function --- I did this very hastily.
module six_hole_clevis() {
    p0 = [0,0,0];
    p1 = [100,0,0];
    width = hole_size_mm*0.8;
    depth = post_radius_mm*2;
    height = mounting_clevis_height;
    tolerance = .2;
    // This is for my particular carbon fiber connector rod, this really needs to be parametrized.
    difference() {
        union () {
             translate([0,depth+tolerance,0])
            color("gray") six_hole_box_ep(p0, p1, 0.0, width, depth, height, $fn=20);  
             translate([0,-depth+-tolerance,0])
           color("gray") six_hole_box_ep(p0, p1, 0.0, width, depth, height, $fn=20);  
                translate([-height*.81 + - depth/2,0,0])
            difference() {
            cube([depth*5,depth*3,depth*3],center=true);
                translate([depth*4.5,0,0])
                cube([depth*5,depth+tolerance*3,depth*4],center=true);
            }
        }
   
        translate([-height*1.4,0,0])
        rotate([0,90,0])
        difference() {
            // These are measured numbers in mm, but my STL is 4 times too big! Need to 
            // clean this up.
        color("blue") cylinder(h = depth*4,r = 4.5);
        color("red") cylinder(h = depth*4,r = 3);
        }

    }
}

// The purpose here is to produce a matching part that mates to 
// our rotor pegs for mounting a rod (like a carbon-fiber rod with a 
// 1/4" interior diameter, for example).
// This is a sloppy, ugly function --- I did this very hastily.
module tubular_mount(outer_radius,inner_radius) {
    width = hole_size_mm;
    depth = width*2;
    postgap = lock_thickness+rotor_gap*2;
    fudge = 0.75;
    conjoin = 1.0; // This is a little fudge factor to make sure we have full connectivity
    
    // This is for my particular carbon fiber connector rod, this really needs to be parametrized.  
  difference() {  
   union() { 
//    translate([ball_radius+depth/2+postgap+lock_thickness,0,0])
 //   translate([4,0,0])
    translate([depth/2+postgap,0,0])
    rotate([0,90,0])
    rotor_disc();
    // The post
 
    translate([depth/2,0,0])
    rotate([0,90,0])
    cylinder(r=post_radius_mm,h=(postgap+conjoin),center=false,$fn=20); 
        
    difference() {
        cube([depth,width,width],center=true);
        translate([-depth/1.5,0,0])
        rotate([0,90,0])
        difference() {
        color("blue") cylinder(h = depth,r = outer_radius,$fn=20);
        color("red") cylinder(h = depth,r = inner_radius,$fn=20);
        }

    }
   }
    // now we subtract the rotor hole size to make sure it fits!!
   rotate([0,90,0])
    difference() {
     cylinder(r = rotor_size_mm, h = depth*1.1,center=true,$fn=20);
     cylinder(r = (rotor_size_mm/2)*fudge, h = depth *1.2,center=true,$fn=20);
   }
   // now we subtract 3 #2 mounting holes - 2.032 mm!
   cylinder(r = 2.032/2, h = depth, $fn=20,center = true);
//   translate([depth/4,0,0])
//   cylinder(r = 2.032/2, h = depth, $fn=20,center = true);
      translate([-depth*0.3,0,0])
   rotate([90,0,0])
   cylinder(r = 2.032/2, h = depth, $fn=20,center = true);
   

   }
}

module beamify_edges(edges,points,width,depth,height) {
    for(e = edges) {
        p0 = points[e[0]];
        p1 = points[e[1]];
        color("green") six_hole_box_ep(p0, p1, 0.37, width, depth, height, $fn=20);      
    }
}



// Create a tetrahedron-like strucutre with one point
// centered on the origin, symmetric about z axis,
// with an equilateral triangle as a base
// height - height of the pyrmid
// base - length of one side of the pyramid base
// r - raadius
module create_symmetric_3_member_polygon(height,base,r) {
    h = base*sqrt(3.0)/2.0;
    basehalf = base / 2.0;
    ZH = height;
points = [
    // first point is the origin
[ 0, 0, 0],
[ h*2/3,  0, -ZH],
[-h/3, -basehalf , -ZH],
[-h/3, basehalf, -ZH]];
edges = [
[0,1],
[0,2],
[0,3]
    ];
   cylindricalize_edges(edges,points,r); 
}

// Create a tetrahedron-like strucutre with one point
// centered on the origin, symmetric about z axis,
// with an equilateral triangle as a base
// height - height of the pyrmid
// base - length of one side of the pyramid base
// r - raadius
module create_symmetric_3_member_polygon_cube(height,base,r) {
    h = base*sqrt(3.0)/2.0;
    basehalf = base / 2.0;
    ZH = height;
points = [
    // first point is the origin
[ 0, 0, 0],
[ h*2/3,  0, -ZH],
[-h/3, -basehalf , -ZH],
[-h/3, basehalf, -ZH]];
edges = [
[0,1],
[0,2],
[0,3]
    ];
   beamify_edges(edges,points,hole_size_mm*0.8,post_radius_mm*2,mounting_clevis_height); 
}


module create_symmetric_3_member_polygon_polar(height,angle,r) {
    triangle_height = height*tan(angle)*3/2;
    base = triangle_height* 2 / sqrt(3.0);
    create_symmetric_3_member_polygon(height,base,r);
}

module create_symmetric_3_member_polygon_polar_cube(height,angle,r) {
    triangle_height = height*tan(angle)*3/2;
    base = triangle_height* 2 / sqrt(3.0);
    create_symmetric_3_member_polygon_cube(height,base,r);
}

module ball_locking_peg(width_factor = 10,height_factor = 4, tolerance_factor = 1.0) {
  translate([ball_radius/2,0,0]) cylinder(r = tolerance_factor * ball_radius/width_factor, h = tolerance_factor *ball_radius/height_factor,center = true);
}
module three_locking_pegs(tf) {  
 union() {
    rotate([0,0,0]) ball_locking_peg(tolerance_factor = tf);
    rotate([0,0,120]) ball_locking_peg(tolerance_factor = tf);
    rotate([0,0,240]) ball_locking_peg(tolerance_factor = tf);
 }
}

// I am really making this a hemisphere now
// so that we can see into it.  That of course 
// can be changed later.
module beholderBall(d) {
    difference() {
    union() {
        difference() {
            sphere(d);
            translate([-d,-d,0]) cube(2*d);
        }
        three_locking_pegs(1.0 - locking_peg_percent_tolerance/100.0);
    }
    rotate([0,0,60]) three_locking_pegs(1.0 + locking_peg_percent_tolerance/100.0);
}
}

module beholderLock(d) {
    inner = d + rotor_thickness + rotor_gap*2;
    outer = inner + lock_thickness;
    difference() {
        beholderBall(outer);
        sphere(inner);
    }
    
}

// WARNING: This is using a combination of global and local values
module beholderRotorsShell(d,buffer) {
    inner = d + rotor_gap;
    outer = inner + rotor_thickness;
    difference() {
        beholderBall(outer+buffer);
        sphere(inner-buffer);
    }
}

module equilateral_cut_tool_for_shell(rf) {
    difference() {
       create_symmetric_3_member_polygon_polar(ball_radius*4,rotor_hole_angle,rf);
       beholderBall(ball_radius);
    }
}

module planar_circle_cut_tool() {
              // rotate 30 degrees
            rotate([0,0,30])
            // Lay it onto x axix...
            rotate([0,90,0]) 
            cylinder(ball_radius*4,r=hole_size_mm/2);
}

module bolting_flange() { 
    translate([radius_at_rotor_outer_edge+lock_thickness,0,-post_radius_mm])
    difference() {
    cylinder(r = hole_size_mm*0.4,h = post_radius_mm,$fn=20);
        translate([lock_thickness,0,-post_radius_mm])
         cylinder(r = screw_hole_radius_mm,h = post_radius_mm*4,$fn=20);
        translate([-ball_radius+-lock_thickness/2,-ball_radius/2,-ball_radius/2])
        cube(ball_radius);
    }
}

module flange_capture() {
    nut_size = screw_hole_radius_mm*1.5;
    color("blue")
      translate([radius_at_rotor_outer_edge+lock_thickness,0,-post_radius_mm*2+-post_radius_mm])
    cylinder(r = nut_size,h = post_radius_mm*2,$fn=20);
}

module flange_capture_cut_tool() {
    flange_capture();
    rotate([0,0,120])
    flange_capture();
    rotate([0,0,240])
    flange_capture();
}

module bolting_flanges() {
    bolting_flange();
    rotate([0,0,120])
    bolting_flange();
    rotate([0,0,240])
    bolting_flange();
}

module apical_flange() {
    rotate([0,90,0])
    bolting_flange();
}

module snowflake_planar_cut_tool() {
    rotate([0,0,0]) planar_circle_cut_tool();
    rotate([0,0,60]) planar_circle_cut_tool();
    rotate([0,0,120]) planar_circle_cut_tool();
    rotate([0,0,180]) planar_circle_cut_tool();
    rotate([0,0,240]) planar_circle_cut_tool();
    rotate([0,0,300]) planar_circle_cut_tool();
}

module tetrahedronal_lock() {
    difference() {
    union() {
    difference() {
        beholderLock(ball_radius);
        equilateral_cut_tool_for_shell(hole_size_mm/2);

        // Now we will attempt to make the other cut outs...
        // These should split the angles of the tetrahedron...
        // So they should be rotate 30 degrees from the x-axis
       snowflake_planar_cut_tool();
    }
    color("green") bolting_flanges();
    color("blue") apical_flange();
    }
    // now cut away room for "nut capture" of the bolting flanges.
    // probably could solve this problem better by making the flanges larger,
    // but then my existing pieces would not fit
    flange_capture_cut_tool();
    }
    
}


module create_symmetric_tetrahedron(height,base,r) {
    h = base*sqrt(3.0)/2.0;
    basehalf = base / 2.0;
    ZH = height;
points = [
    // first point is the origin
[ 0, 0, 0],
[ h*2/3,  0, -ZH],
[-h/3, -basehalf , -ZH],
[-h/3, basehalf, -ZH]];
edges = [
[0,1],
[0,2],
[0,3]
    ];
   cylindricalize_edges(edges,points,r); 
}

// At present this a left-handed, (ccw) helix.
// I am going to make it bi-handed by adding another hole!
module tetrahelix_lock() {
    beta = acos(1/3);
    alpha = (180 - beta)/2;
    echo("beta");
    echo(beta);
    echo(alpha);
    unzipping = 7.356105;
    r4 = ball_radius*4;
    difference() {
      union() {
        difference() {
          beholderLock(ball_radius);

           rotate([0,beta/2,0])
           rotate([0,0,60])
           create_symmetric_tetrahedron(ball_radius*4,alpha*2,hole_size_mm/2);
            
           rotate([0,0,120])
           rotate([0,beta/2,0])
           rotate([0,0,60])
           create_symmetric_tetrahedron(ball_radius*4,alpha*2,hole_size_mm/2);
            
            
            points = [
            [0,0,0],
            [r4,0,0]
            ];
         
          // This is approximately correct, but is probably wrong...
          // I need to develop a more general roational system
          // to have any chance to figuring this out.
          // Note that this system also requires either that design 
          // a new cap or do something else to design this.       
           rotate([0,0,unzipping/2])
           rotate([unzipping/2,-unzipping/2,0])
           rotate([0,0,120])
           color("blue")
           cylindricalize_edges([[0,1]],points,hole_size_mm/2);
           
           // This is to produce a structure supporting the "right handed" tetrahelix as well.
           rotate([0,0,-120])
           rotate([0,0,unzipping/2])
           rotate([unzipping/2,-unzipping/2,0])
           rotate([0,0,120])
           color("blue")
           cylindricalize_edges([[0,1]],points,hole_size_mm/2);
   
        }
        rotate([0,0,90])
      color("green") bolting_flanges();
      color("blue") apical_flange();
      }
    // now cut away room for "nut capture" of the bolting flanges.
    // probably could solve this problem better by making the flanges larger,
    // but then my existing pieces would not fit
     rotate([0,0,90])
    flange_capture_cut_tool();
   }  
}

module tetrahelix_cap_cut() {
        beta = acos(1/3);
    alpha = (180 - beta)/2;
    echo("beta");
    echo(beta);
    echo(alpha);
    unzipping = 7.356105;
    r4 = ball_radius*4;
    difference() {
      union() {
        difference() {
          beholderLock(ball_radius);    
            points = [
            [0,0,0],
            [r4,0,0]
            ];
         
          // This is approximately correct, but is probably wrong...
          // I need to develop a more general roational system
          // to have any chance to figuring this out.
          // Note that this system also requires either that design 
          // a new cap or do something else to design this.       
           rotate([0,0,60+-unzipping/2])
           rotate([0,-unzipping/2,0])
           rotate([0,0,120])
           color("blue")
           cylindricalize_edges([[0,1]],points,hole_size_mm/2);
            
           rotate([0,0,120])
           rotate([0,0,60+-unzipping/2])
           rotate([0,-unzipping/2,0])
           rotate([0,0,120])
           color("blue")
           cylindricalize_edges([[0,1]],points,hole_size_mm/2);
        }
        rotate([0,0,90])
      color("green") bolting_flanges();
      }
     rotate([0,0,90])
    flange_capture_cut_tool();
   }  
}

module tetrahelix_cap() {
      // Actually, this is unscientific---we really need it 
    // to be just big enough for the disc to not bump.
    // However, I have not yet figured out that math...nontheless
    // experience has shown this does work with my tirangle stators.
    seam_height_factor = 2.5;
    seam_height = (hole_size_mm/2)*seam_height_factor;
    // Pythagorean theorem
    cap_radius = sqrt(outermost_radius* outermost_radius - seam_height*seam_height);
    rotate([0,0,-60]) 
    union() {
        difference() {  
           rotate([180,0,0])        
           union() {  
                beholderBall(ball_radius);
              tetrahelix_cap_cut();
            }
            translate([0,0,ball_radius/2+seam_height])
                cylinder(r = ball_radius * 2, h = ball_radius,center = true);
        }
       translate([0,0,seam_height])
        cylinder(r = cap_radius, h = lock_thickness,center = true);
    }
}

// This is for a lock that works with a hemisphere
// and provides room for the snowflake cuts but does not use 
// a full ball.
module nine_hole_cap_lock() {
    // Actually, this is unscientific---we really need it 
    // to be just big enough for the disc to not bump.
    // However, I have not yet figured out that math...nontheless
    // experience has shown this does work with my tirangle stators.
    seam_height_factor = 2.5
    ;
    seam_height = (hole_size_mm/2)*seam_height_factor;
    // Pythagorean theorem
    cap_radius = sqrt(outermost_radius* outermost_radius - seam_height*seam_height);
    union() {
        difference() {
           union() {  
                rotate([0,0,30]) rotate([180,0,0]) beholderBall(ball_radius);
                rotate([180,0,0]) tetrahedronal_lock();
            }
            translate([0,0,ball_radius/2+seam_height])
                cylinder(r = ball_radius * 2, h = ball_radius,center = true);
        }
        translate([0,0,seam_height])
        cylinder(r = cap_radius, h = lock_thickness,center = true);
    }
}

module three_hole_cap_lock() {

    seam_height = three_hole_cap_seam_height_mm;
    // Pythagorean theorem
    cap_radius = sqrt(outermost_radius* outermost_radius - seam_height*seam_height);
    union() {
        difference() {
            union() {  
                rotate([0,0,30]) rotate([180,0,0]) beholderBall(ball_radius);
                rotate([180,0,0]) tetrahedronal_lock();
            }
            translate([0,0,ball_radius+seam_height])
                cylinder(r = ball_radius * 2, h = ball_radius*2,center = true);
        }
        translate([0,0,seam_height])
        cylinder(r = cap_radius, h = lock_thickness,center = true);
        color("green") bolting_flanges();
    }
}

module shell(id,od) {
    difference() {
        sphere(od);
        sphere(id);
    }
}
// This needs to be switched to use rotor disc
module tetrahedronal_pegs() {
    union() {
      difference() {
            difference() {
                create_symmetric_3_member_polygon_polar(ball_radius*4,rotor_hole_angle,post_radius_mm);
                sphere(ball_radius + rotor_gap + (rotor_thickness / 2.0));
            }
            shell(ball_radius*1.5,ball_radius*20);
    }
    color("green") create_symmetric_3_member_polygon_polar_cube(ball_radius*4,rotor_hole_angle,post_radius_mm);
   }
}

module tetrahedronal_rotors() {
// Now try to attach "pegs" to the rotor discs....
    union() {
       tetrahedronal_pegs();
    difference() { // clean up
        difference() {
            color("green") beholderRotorsShell(ball_radius,0);
            difference () {
                color("gray") beholderRotorsShell(ball_radius,0.5);
               equilateral_cut_tool_for_shell(rotor_size_mm/2.0);
            } 
        }
    // Needed to clean up artifacts...
        d = ball_radius;
       translate([-d*1.2,-d*1.2,-1]) cube(2.5*d);
    }
    }
}

module one_tetrahedronal_rotor() {
    postgap = rotor_gap*2 + rotor_thickness;
    conjoin_fudge = rotor_gap*1;
    
    // The rotor (I want this to land with the outer edge at the origin.)
    rotor_disc();  
    
    // the post
    rotate([0,180,0])
    translate([0,0,postgap])
    cylinder(r=post_radius_mm,h=(postgap*2)+conjoin_fudge,center=true,$fn=20);
    
    // the six-hole mount
    p0 = [0,0,0];
    p1 = [0,0,-mounting_clevis_height];
    width = hole_size_mm*0.8;
    depth = post_radius_mm*2;
    height = mounting_clevis_height;
    translate([0,0,-postgap])
    color("green") six_hole_box_ep(p0, p1, 0.5, width, depth, height, $fn=20);  
    
}

module spherical_rotor_disc() {
       difference() {         
           beholderRotorsShell(ball_radius,0);
            // now make an cutting tool...
           difference() {
           beholderRotorsShell(ball_radius,5);
                rotate([0,180,0])
               // Note: The is twice, so we double the rotor_size_mm
            cylinder(h = ball_radius*2, r1 = 0, r2 = (rotor_size_mm/2)*2, center = false);         
            }
                // cleanup
            cube([ball_radius*2.5,ball_radius*2.5,ball_radius/10],center=true);
        }
}

module equilateral_rotor_disc() {
    br2 = ball_radius*2.0;
    br = ball_radius;
    
    // Basic plan here is to make cutting tool and cut away fro the shell what we don't want.
    // The cutting tool should leave a cone centered at the origin which gets exactly halfway
    // to the next hole when the peg is at its extreme position. This will be a great circle 
    // on the sphere.  The result should be a spherical equilateral triangle.
    angle = asin((rotor_size_mm/2)/(radius_at_rotor_outer_edge)) ;
    echo("angle =");
    echo(angle);
    translate([0,0,(radius_at_rotor_inner_edge+rotor_thickness)])
      difference() {         
           beholderRotorsShell(ball_radius,0);
            // now make an cutting tool...
           // These need to be changed to use cones....
         union() {
           scale([2.0,2.0,2.0])
          rotate([0,angle,0])
          rotate([0,180,0])
          translate([0,-ball_radius,0])
          color("red") cube(size = ball_radius*2);
    
               rotate([0,0,-120])
             scale([2.0,2.0,2.0])
          rotate([0,angle,0])
          rotate([0,180,0])
                       translate([0,-ball_radius,0])
          color("blue") cube(size = ball_radius*2);
    
           rotate([0,0,120])
             scale([2.0,2.0,2.0])
          rotate([0,angle,0])
         rotate([0,180,0])
                       translate([0,-ball_radius,0])
         color("green") cube(size = ball_radius*2);                          
           }
       }
}

module rotor_disc() {
    if (use_equilateral_rotors != "true") {
        spherical_rotor_disc();
    } else {
        equilateral_rotor_disc();
    }
}

// These cannot be printed horizontally on a Printrbot in PLA for some reason
module one_Firgelli_pushrod_rotor() {
    Firgelli_mount(firgelli_pr_cw,firgelli_pr_sw,firgelli_pr_ch,firgelli_pr_cd,firgelli_pr_hole_center_offset);
}
module one_Firgelli_Stator_rotor() {
      Firgelli_mount(firgelli_st_cw,firgelli_st_sw,firgelli_st_ch,firgelli_st_cd,firgelli_st_hole_center_offset);
}

// cw = cavity_width
// sw = shell_width
// ch = cavity height
// cd = cavity_depth
// Note: These should be printed, hoziontally, not vertically!
module Firgelli_mount(cw,sw,ch, cd,hole_center_distance) {
   d = ball_radius;
   fudge = 0.77;
    
   postgap_fudge = 1.3;
    
   postgap_buffer = 1.3;
   postgap = (lock_thickness+rotor_gap*2)*postgap_buffer;
    
   difference() {
     union() {
        // The spherical part of the rotor -- needs to cut with inverted tool!
       translate([-((cd+sw)/2+(postgap)),0,0])
              rotate([0,270,0])
       rotor_disc();
        // The post
 
        translate([-((cd+sw)/2+(postgap))+-1,0,0])
        rotate([0,90,0])
        cylinder(r=post_radius_mm,h=(postgap*postgap_fudge),center=false,$fn=20); 
        difference() {
        
     // construct the shell
          cube([cd+sw,cw+sw,ch+sw],center=true);
     // construct the cavity
          union() {
            // the real cavity
            cube([cd,cw,ch],center=true);
            // cleanup
            translate([3,0,0])
              cube([cd+4,cw,ch],center= true );
          }
       // drill out the holes
          translate([hole_center_distance,0,0])
          rotate([90,0,0])
          cylinder(r = 2.25+.2, h=ball_radius, center= true,$fn=20);
      }
    }
// now we subtract the rotor hole size to make sure it fits!!
    translate([-(cd+sw*2)/2,0,0])
    rotate([0,90,0])
    difference() {
      cylinder(r = rotor_size_mm, h = (cd+sw*2)*1.1);
      cylinder(r = (rotor_size_mm/2)*firgelli_hole_fit_fudge_factor, h = (cd+sw*2) *1.2);
    }
  }
}


module demo_turret_joint() {
    color( "Purple") beholderBall(ball_radius);
    tetrahedronal_rotors();
   tetrahedronal_lock();
 translate([0,0,25])
 three_hole_cap_lock();
}




if (part_to_render == "all" || part_to_render == "demoturret")
   translate([-ball_radius*3,-ball_radius*6,0])
    demo_turret_joint();

if (part_to_render == "all" || part_to_render == "ninecap")
   translate([-ball_radius*3,-ball_radius*6,0])
   nine_hole_cap_lock();

if (part_to_render == "all" || part_to_render == "cap")
   translate([-ball_radius*3,-ball_radius*3,0])
   color( "green") three_hole_cap_lock();

if (part_to_render == "all" || part_to_render == "ball")
   translate([-ball_radius*3,ball_radius*3,0])
   color( "Purple") beholderBall(ball_radius);

if (part_to_render == "all" || part_to_render == "lock")
   translate([-ball_radius*3,0,0])
   tetrahedronal_lock();

if (part_to_render == "all" || part_to_render == "tubemount")
   translate([ball_radius*2,0])
   tubular_mount(4.5,3.0);

if (part_to_render == "all" || part_to_render == "rotor")   
    translate([0,-ball_radius*2,0])
     rotate([0,-56,0])
     one_tetrahedronal_rotor();

if (part_to_render == "all" || part_to_render == "firgellipushrod") 
    translate([0,ball_radius*2,0])
one_Firgelli_pushrod_rotor();

if (part_to_render == "all" || part_to_render == "firgellistator") 
    translate([30,ball_radius*2,0])
    one_Firgelli_Stator_rotor();

if (part_to_render == "all" || part_to_render == "tetrahelixlock")
 //  translate([-ball_radius*3,ball_radius,0])
   tetrahelix_lock();
//   tetrahelix_cap();

if (part_to_render == "all" || part_to_render == "tetrahelixcap")
   translate([-ball_radius*3,ball_radius,ball_radius*2])
   tetrahelix_cap();







