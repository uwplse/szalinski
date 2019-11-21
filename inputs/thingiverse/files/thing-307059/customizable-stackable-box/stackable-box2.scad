//	Thingiverse Customizer Template v1.2 by MakerBlock
//	http://www.thingiverse.com/thing:44090
//	v1.2 now includes the Build Plate library as well

//	Uncomment the library/libraries of your choice to include them
//	include <MCAD/filename.scad>
//	include <pins/pins.scad>
//	include <write/Write.scad>
//	include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES

box_width=60;
box_depth=70;
box_height=35;
//thickness of box wall
thick=2;
//front side wall angle(degree)
angle=40;
//length of front side wall - ratio to box depth
front_side_wall_length_ratio = .40;
//thickness of front wall
front_thick=8;

//How wide the stack guide is
stack_guide_width_ratio=3.5;
//Stack guide - number of face
stack_guide_fn=6;

//CUSTOMIZER VARIABLES END

//should not be displayed in option
size=[box_width,box_depth,box_height]*1;
drawer_len=size[2]*front_side_wall_length_ratio;
drawer_height=drawer_len*sin(angle);
drawer_depth =drawer_len*cos(angle);
floor_size=[size[0],size[1]-drawer_depth,thick]*1;
stack_guide_w=thick*3.5;


//currently not used option
top_depth_ratio=.1*1;
top_depth=0*1;


module center_xy_cube(v){
    translate([-v[0]/2,-v[1]/2,0]) cube(v);
}

module side_wall(x){
    x2 = x > 0 ? x-thick/2 : x+thick/2;
    translate([x2,0,0])
    rotate([90,0,90])
    translate([-floor_size[1]/2,0,-thick/2])
    linear_extrude(height=thick)
    polygon([ [0,0], [floor_size[1],0], [floor_size[1],size[2]],
		[top_depth,size[2]],
		[-drawer_depth,drawer_height] ]);

    translate([x2,floor_size[1]/2,size[2]]) rotate([90,30,0]) cylinder(r=stack_guide_w/2, h=floor_size[1]-top_depth, $fn=stack_guide_fn);
	
}
module front_wall(){
    rotate([90,0,90])
    translate([-floor_size[1]/2,0,-size[0]/2])
    linear_extrude(height=size[0])
    polygon([
	    [0,0],
	    [1,thick],
	    [-drawer_depth+thick*tan(90-angle),drawer_height],
	    [-drawer_depth,drawer_height]
	    ]);
}

module back_wall(){
    translate( [0,floor_size[1]/2-thick/2,0] ) center_xy_cube([size[0],thick,size[2]]);
    translate( [-size[0]/2,floor_size[1]/2-thick/2,size[2]] ) rotate([00,90,00]) cylinder(r=stack_guide_w/2, h=size[0], $fn=stack_guide_fn);
}


module box(){
    center_xy_cube(floor_size);
    for( x = [size[0]/2,-size[0]/2] ){
	side_wall(x);
    }
    front_wall();
    back_wall();
}

difference( ){
    box();
    hull(){
	translate([0,0,size[2]-.1]) center_xy_cube(floor_size*1.02);
	translate([0,0,size[2]-.2+stack_guide_w/2]) center_xy_cube(floor_size*1.03);
    }
}



