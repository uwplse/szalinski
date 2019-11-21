// variable description
// Width of the Box
box_width=87;

// Length of the Box
box_length=102;

// Depth of the battery hole
hole_depth=15;

// Diameter of the hole: AAA=10.5 AA=14.5
hole_diameter=11;

// Minimum wall and bottom thickness
wall_size=5; // [2:1:5]

/* [Hidden] */
$fn=50;
bottom=wall_size-2;

difference () {
hull () {
    union () {
        translate ([wall_size,wall_size,0]) cylinder(hole_depth-bottom,wall_size,wall_size);
        translate([wall_size,wall_size,hole_depth-bottom]) sphere(wall_size);
    }
    union () {
        translate ([box_width-wall_size,wall_size,0]) cylinder(hole_depth-bottom,wall_size,wall_size);
        translate([box_width-wall_size,wall_size,hole_depth-bottom]) sphere(wall_size);
    }
    union () {
        translate ([wall_size,box_length-wall_size,0]) cylinder(hole_depth-bottom,wall_size,wall_size);
        translate([wall_size,box_length-wall_size,hole_depth-bottom]) sphere(wall_size);
    }
    union () {
        translate ([box_width-wall_size,box_length-wall_size,0]) cylinder(hole_depth-bottom,wall_size,wall_size);
        translate([box_width-wall_size,box_length-wall_size,hole_depth-bottom]) sphere(wall_size);
    }
}

anzb=round(((box_width-2*wall_size)/(hole_diameter+0.2))-0.5);
anzl=round(((box_length-2*wall_size)/(hole_diameter+0.2))-0.5);
vx=((box_width-2*wall_size)-anzb*hole_diameter)/(anzb+1);
vy=((box_length-2*wall_size)-anzl*hole_diameter)/(anzl+1);

for(y=[0:anzl-1]) {
    for(x=[0:anzb-1]) {
        #translate([vx+wall_size+hole_diameter/2+x*(hole_diameter+vx),vy+wall_size+hole_diameter/2+y*(hole_diameter+vy),wall_size-bottom]) cylinder(hole_depth,hole_diameter/2,hole_diameter/2);
    }
}
}