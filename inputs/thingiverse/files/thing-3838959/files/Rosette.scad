pipe_diameter=18; // [10:50]
// 18 and 23
pipe_distance=40; // [10:60]
height=15; // [5:50]
wall_thickness = 4; //[2:10]
bottom_extra=4; //[0:20]
tolerance=.3;
// Which one would you like to see?
part = "both"; // [first:male part,second:female part,both:both parts]

/* [Hidden] */
zungenlaenge=8;
zungenspitze=1;
zungenbreite=1.5;
zungencham=.5;
//.5

$fn = 60;// high resolution circles, takes longer to render!

module zunge(_bottom_extra,_zungenlaenge,_zungenspitze,_zungenbreite,_zungencham, _height){
linear_extrude(height=_height, center=false)
polygon([[0,0],[0,_zungenlaenge],[_zungenbreite,_zungenlaenge],[_zungenbreite+_zungenspitze, _zungenlaenge-_zungenspitze],[_zungenbreite,_zungenlaenge-_zungenspitze*2],[_zungenbreite,_zungencham],[_zungenbreite+_zungencham,0]]);
}

module prism(l, w, h) {
       polyhedron(points=[
               [0,0,h],           // 0    front top corner
               [0,0,0],[w,0,0],   // 1, 2 front left & right bottom corners
               [0,l,h],           // 3    back top corner
               [0,l,0],[w,l,0]    // 4, 5 back left & right bottom corners
       ], faces=[ // points for all faces must be ordered clockwise when looking in
               [0,2,1],    // top face
               [3,4,5],    // base face
               [0,1,4,3],  // h face
               [1,2,5,4],  // w face
               [0,3,5,2],  // hypotenuse face
       ]);
}

module rose() {
    hull () {
        cylinder(r1=pipe_diameter/2+wall_thickness+bottom_extra, r2=pipe_diameter/2+wall_thickness, h=height, center=false);
        translate([pipe_distance,0,0])
        cylinder(r1=pipe_diameter/2+wall_thickness+bottom_extra, r2=pipe_diameter/2+wall_thickness, h=height, center=false);
    }  
}

module halbeRose() {
    difference() {
        rose();
        cylinder(r1=pipe_diameter/2+bottom_extra, r2=pipe_diameter/2,h=height);
        
        translate([pipe_distance,0,0])
        cylinder(r1=pipe_diameter/2+bottom_extra, r2=pipe_diameter/2,h=height);
        translate([-(pipe_diameter+wall_thickness*3),0,0])
        cube([pipe_distance+2*pipe_diameter+wall_thickness*4+20,pipe_diameter/2+wall_thickness*3+30,height+20]);
    }

    translate([pipe_diameter/2,-pipe_diameter/2-wall_thickness+1,0])
    cube([pipe_distance-pipe_diameter,pipe_diameter/2+wall_thickness-1,height]);

}

module klammer(){
    translate([pipe_diameter/2,0,0])
    zunge(bottom_extra,zungenlaenge,zungenspitze,zungenbreite,zungencham, max(height-wall_thickness,3));
    
    translate([pipe_distance-pipe_diameter/2,0,0])
    mirror([1,0,0])
    zunge(bottom_extra,zungenlaenge,zungenspitze,zungenbreite,zungencham, max(height-wall_thickness,3));
    
    translate([-pipe_diameter/2-bottom_extra-wall_thickness/2,0,0])
    cube([wall_thickness/2,2,2]);

    translate([pipe_distance+pipe_diameter/2+bottom_extra,0,0])
    cube([wall_thickness/2,2,2]);
    
    translate([pipe_distance-pipe_diameter/2,0,height])
    rotate([0,0,90])
    prism(pipe_distance-pipe_diameter,2,-2);
}

module part1(){
    union(){
        halbeRose(); 
        klammer();
    }
}


module part2(){
    difference(){
        mirror([0,1,0])
        halbeRose();
        minkowski() {//make it thicker
            klammer();
            sphere(tolerance);
        }
        translate([pipe_diameter/2,0,0])
        mirror([1,0,0])
        cube([min(5,pipe_diameter/2),zungenlaenge,max(height-wall_thickness,3)]);
        translate([pipe_distance-pipe_diameter/2,0,0])
        cube([min(5,pipe_diameter/2),zungenlaenge,max(height-wall_thickness,3)]);
    }
}

module print_part() {
	if (part == "first") {
		part1();
	} else if (part == "second") {
        mirror([0,1,0])
		part2();
	} else if (part == "both") {
		part1();
        translate([0,zungenlaenge+2,0])
        part2();
	}
}

print_part();
