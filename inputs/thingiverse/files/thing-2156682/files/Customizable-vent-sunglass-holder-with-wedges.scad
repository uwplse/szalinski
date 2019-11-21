/* Sunglass holder for car vent fins w/ball and socket */
/* Version 2.0 with Wedges
/* Created by Solarmax (Thingiverse) */

/* Parameters */

// Width of car vent fin 
vent_fin_width = 4.75; // [0.2:0.1:8] 
// Length of the fingers of clamp 
length_of_fingers = 25; // [10:40] 
// Width of fingers of clamp
width_of_fingers = 1.6;
// Inner Diameter to fit sunglass temple (arm)
inner_diameter = 18; // [5:50]

/* *********************************************************** */

// ignore variable values
inner_radius = inner_diameter / 2; 
$fn = 100;

/* draw the main cylinder for sunglass holder */
union() {
    difference() {
        cylinder(h=10, r=inner_radius+2);
        translate([0,0,-0.5])
        cylinder(h=11, r=inner_radius);
    }

    /* post for ball in socket */
    translate([inner_radius,0,5])
    rotate([0,90,0])
    cylinder (h=7,d=4);

    /* ball for socket */
    translate([inner_radius+8,0,5])
    sphere(d=5.5);
}

difference() {
    
    /* structure for socket */
    union() {
        translate([inner_radius+8,0,5])
        cube(10, center=true);
        
        translate([inner_radius+8,(vent_fin_width/2),0])
        cube([length_of_fingers+5,width_of_fingers,10]);
        
        translate([inner_radius+8,-(vent_fin_width/2)-width_of_fingers,0])
        cube([length_of_fingers+5,width_of_fingers,10]);
        
        /* Build the wedges for better holding */
        
        polyhedron
        ( points  = [
        [inner_radius+8+length_of_fingers+5,-(vent_fin_width/2),0],
        [inner_radius+8+length_of_fingers+5,-(vent_fin_width/2),10],
        [inner_radius+8+length_of_fingers,-(vent_fin_width/2),10],
        [inner_radius+8+length_of_fingers,-(vent_fin_width/2),0],
        [inner_radius+8+length_of_fingers+2.5,-(vent_fin_width/2)*.25,0],
        [inner_radius+8+length_of_fingers+2.5,-(vent_fin_width/2)*.25,10]
        ],
        faces = [
        [0,3,2,1],[3,4,5,2],[4,0,1,5],[4,3,0],[1,2,5]
        ]
        ); 

       polyhedron
        ( points  = [
        [inner_radius+8+length_of_fingers+5,(vent_fin_width/2),0],
        [inner_radius+8+length_of_fingers+5,(vent_fin_width/2),10],
        [inner_radius+8+length_of_fingers,(vent_fin_width/2),10],
        [inner_radius+8+length_of_fingers,(vent_fin_width/2),0],
        [inner_radius+8+length_of_fingers+2.5,(vent_fin_width/2)*.25,0],
        [inner_radius+8+length_of_fingers+2.5,(vent_fin_width/2)*.25,10]
        ],
        faces = [
        [1,2,3,0],[2,5,4,3],[5,1,0,4],[0,3,4],[5,2,1]
        ]
        ); 
    }
    
    /* socket */
    translate([inner_radius+8,0,5])
    sphere(d=7.5);

    /* hole for post for ball */
    translate([inner_radius+2,0,5])
    rotate([0,90,0])
    cylinder(h=4,d=5);
}
