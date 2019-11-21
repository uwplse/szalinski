// A tool for creating custom saw inserts
//
// Lisenced under creative commons, attribution, share-alike
// For the attribution requirement, please provide a link to:
//	http://www.thingiverse.com/thing:1024418

// the units that all of the measurements below will be in
units=0; // [0:mm,1:inch]

// how big around the top of the insert is
top_d=69.68;

// how big around the top of the insert is (if zero, uses top_d)
bottom_d=68.5;

// size of a chamfer for the top (can be zero)
top_chamfer=0.5;

// size of a chamfer for the bottom (can be zero)
bottom_chamfer=0.5;

// the width of the blade slot (can be zero for no kerf)
kerf_width=1.5;

// how long to make the slot for the blade (can be zero for no kerf)
kerf_len=52.7;

// EXPERIMENTAL: tilt the kerf on each side so that dust falls out easier
kerf_crud_drainage=1; //[0:off,1:try it]

// how thick the insert is
thickness=5.21;

// how wide to make a key (fits into blade installation slot to keep insert from turning)  Can be zero.
key_width=2.75;

// What angle you want the key to be at
key_orientation=0; //[0,45,90,135,180,225,270,315]

// Add sub-support to drop even deeper (zero = no sub support)
sub_dia=59.76;

// Add sub-support to drop even deeper (zero = no sub support)
sub_thickness=4.75;

// flip upside-down for easier printing
print_orientation=1; // [0:view,1:print]

hole_diameter = 6.0;
hole_spacing = 10.0;


/* [hidden] */

units_table=[1,25.4];

hole_r = tomm(hole_diameter)/2;
hole_d = tomm(hole_spacing);
plate_h = tomm(thickness+sub_thickness);
throat_l = tomm(kerf_len);

//------------------------------------------------------------------

// control the number of facets on cylinders
facet_epsilon = 0.01;
function facets(r) = 180 / acos(1 - (facet_epsilon / r));

//------------------------------------------------------------------

// small tweak to avoid differencing artifacts
epsilon = 0.05;

//------------------------------------------------------------------


function tomm(x)=x*units_table[units];

module hole(x,y) {
  translate([x,y, -epsilon]) {
    cylinder(h=plate_h + 2 * epsilon, r=hole_r, $fn=facets(hole_r));
  }
}

module holes() {
  hole(throat_l/2,0);
  posn = [
    [0,1],[0,2],[0,-1],[0,-2],
    [1,1],[1,2],[1,-1],[1,-2],
    [-1,1],[-1,2],[-1,-1],[-1,-2],
    [2,1],[2,-1],
    [-2,1],[-2,-1],
  ];
  for (x = posn) {
    hole(x[0] * hole_d, x[1] * hole_d);
  }
}


module doTheThing(){
	top_d=tomm(top_d);
	bottom_d=bottom_d<=0?top_d:tomm(bottom_d);
	top_chamfer=top_chamfer<=0?0.001:tomm(top_chamfer);
	bottom_chamfer=bottom_chamfer<=0?0.001:tomm(bottom_chamfer);
	kerf_width=tomm(kerf_width);
	kerf_len=tomm(kerf_len);
	thickness=tomm(thickness);
	key_width=tomm(key_width);
	sub_dia=tomm(sub_dia);
	sub_thickness=sub_dia<=0?0:tomm(sub_thickness);
	cd_angle=10;
	translate([0,0,print_orientation==1?thickness+sub_thickness:0]) rotate([print_orientation==1?180:0,0,0]) difference(){
		union(){
			// blank
			translate([0,0,sub_thickness]) cylinder(r1=bottom_d/2-bottom_chamfer,r2=bottom_d/2,h=bottom_chamfer,$fn=72);
			translate([0,0,sub_thickness+bottom_chamfer]) cylinder(r1=bottom_d/2,r2=top_d/2,h=thickness-bottom_chamfer-top_chamfer,$fn=72);
			translate([0,0,sub_thickness+thickness-bottom_chamfer]) cylinder(r1=top_d/2,r2=top_d/2-top_chamfer,h=top_chamfer,$fn=72);
			if(sub_thickness>0){
				cylinder(r=sub_dia/2,h=sub_thickness,$fn=72);
			}
			//key
			if(key_width>0){
				rotate([0,0,key_orientation]) translate([top_d/2-top_chamfer,key_width/2,thickness/2+sub_thickness]) rotate([90,0,0]) rotate([0,0,180/8]) cylinder(r=thickness/2,h=key_width,$fn=8);
			}
		}
        union(){
		//kerf
		if(kerf_width>0&&kerf_len>0){
			if(kerf_crud_drainage==0){
				translate([-top_d/2-thickness,-kerf_width/2,-thickness/2]) cube([kerf_len+thickness,kerf_width,thickness*2+sub_thickness]);
			}else translate([-top_d/2-thickness,0,thickness+sub_thickness+0.01]) hull(){
				rotate([cd_angle/2,0,0]) translate([0,-kerf_width/2,-thickness*2-sub_thickness]) cube([kerf_len+thickness,kerf_width,thickness*2+sub_thickness]);
				rotate([-cd_angle/2,0,0]) translate([0,-kerf_width/2,-thickness*2-sub_thickness]) cube([kerf_len+thickness,kerf_width,thickness*2+sub_thickness]);
			}
		}
        //holes
        if(hole_diameter>0&&hole_spacing>0){
            holes();
        }
        }
	}
}

doTheThing();