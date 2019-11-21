eps = 0.01*1;
$fn = 50*1;

// Increase this if your slicer or printer make holes too tight (default 0.1)
extra_radius = 0.05*1;

// Major diameter of metric 3mm thread
m3_major = 2.85*1;
m3_radius = m3_major / 2 + extra_radius;
m3_wide_radius = m3_major / 2 + extra_radius + 0.2;

// Select your desired type of sensor mount
mount_type = 1;  // [0:Clip, 1:Screw]

// Diameter of mounting hole for sensor (if you wish tolerances +/-, add them here!)
sensor_diameter = 18; //[6:0.1:25]


/* [Parameters Sensor Mount CLIP] */

// CLIP MOUNT ONLY - Thickness of the clip holding the sensor (default: 3)
sensor_thickness_wall = 3; //[2:0.1:8]

// CLIP MOUNT ONLY - Height of the clip holding the sensor (default: 6)
sensor_height_wall = 6;  //[2:0.1:8]

// CLIP MOUNT ONLY - Width of the gap in the front of the clip (default: 4)
sensor_gap = 4; //[0:0.1:8]


/* [Parameters Sensor Mount SCREW] */

// SCREW MOUNT ONLY - How thick is the material (square) surrounding the sensor - should be thick enough to withstand the screw forces (default: 7)
sensor_thickness_wall_s = 7; //[5:0.1:8]

/* [General Parameters Sensor Mount] */

// Add inner thread structure to sensor clamp
threaded = 1; // [0:No, 1:Yes]

// Thread pitch of sensor - see data sheet, for M18 sensor commonly '1' (default: 1)
thread_pitch = 1; //[0.5:0.1:2.5]


/* [General Mounting Options] */

// Width of back plate - should match the width of the linear bearing housing (for stock Anet A8: 30)
mount_width = 30;  //[20:0.1:60]

// Height of back plate (default: 12.7)
mount_height = 12.7; //[10:0.1:50]

// Thickness of back plate (default: 2.5)
mount_thickness = 2.5; //[2:0.1:10]

// Give an offset of the sensor to the linear bearing in printers y-direction (default: 0)
sensor_offset_mount = 0; //[-4:0.1:10]

// Diameter of screw head(s) (default: 5.5)
dia_screw_head = 5.5; //[4:0.1:7]

// How far should the mount holes be away from the top bezel - should match the geometry of linear bearing housing (for stock Anet A8: 3.7)
mount_hole_vert_offset = 3.7; //[2.5:0.1:5]
mount_height_holes = mount_height - mount_hole_vert_offset;

// Horizontal distance of linear bearing mounting holes in mm (default: 18)
mount_hole_dist = 18; //[10:0.1:30]

// Diameter of screw hole for mount to linear bearing - should be smaller than screw for effective dowel and MUST BE SMALLER by an amount of around twice the nozzle width than dia mounting hole! (recommended: 2.8) 
dia_screw_hole = 2.8; //[2:0.1:4]
// Nonconical: 2.6

// Diameter of screw hole at the end of the dowel - conical for best dowel effect, i.e. smaller than value above (recommended: 2)
dia_screw_hole2 = 2;  //[1:0.1:4]

// Diameter of the hole of linear bearing - must be larger then diameter of screw hole (default: 3.4)
dia_mounting_hole = 3.4; //[1:0.1:5]

// Length of dowels (default: 10)
dowel_length = 10; //[6:0.1:20]

// Add bevel to dowels for easier insertion (reduces effective dowel length slightly)
add_bevels = 1;  // [0:No, 1:Yes]

rotate([0,0,180])
difference(){
    union(){
        backwall(mount_width, mount_height, mount_thickness);
        if(mount_type == 0){
            sensor_clip(sensor_diameter, sensor_thickness_wall,sensor_height_wall, sensor_offset_mount);
        }
        else{
            sensor_screw_splitted(sensor_diameter, sensor_thickness_wall_s,  sensor_thickness_wall_s, sensor_offset_mount);
        }
    }
    
    // Ensure screws are accessible
    mirror2([1,0,0])
            translate([mount_hole_dist/2,-eps,mount_height_holes])
                rotate([-90,0,0])
                    cylinder(r1=dia_screw_head/2, r2=0, h = 20);
}
    
        





module backwall(w, h, th){
    thickness_slices = 1;
    angle_bevel = 35;
    
    difference(){
        union(){
            translate([0, -th/2, h/2])
                cube([w, th, h], center=true);
            
            //Cylinders for dowels
             mirror2([1,0,0])
                translate([mount_hole_dist/2,-th+eps,mount_height_holes])
                    rotate([90,0,0])
                        cylinder(r=dia_mounting_hole/2, h = dowel_length);
            
            //Dowel support
             mirror2([1,0,0])
                translate([mount_hole_dist/2,-th+eps,mount_height_holes])
                    rotate([90,0,0])
                        cylinder(r1=dia_mounting_hole/2*1.3, r2=dia_mounting_hole/2, h = 0.5);
        
        }
    
        // Holes for screws
        mirror2([1,0,0])
            translate([mount_hole_dist/2,eps,mount_height_holes])
                rotate([90,0,0])
                    cylinder(r1=dia_screw_hole/2,r2=dia_screw_hole2/2, h = th+dowel_length+3*eps);
        
        // Holes for screwheads
        mirror2([1,0,0])
            translate([mount_hole_dist/2,eps,mount_height_holes])
                rotate([90,0,0])
                    cylinder(r=dia_screw_head/2, h = 1);
        
        // Slices for dowels
        mirror2([1,0,0])
            translate([mount_hole_dist/2-thickness_slices/2,-th-0.5-dowel_length,mount_height_holes-dia_mounting_hole/2])
                cube([thickness_slices,dowel_length+3*eps,dia_mounting_hole+2*eps]);
        
        // Bevel
        if(add_bevels)
             mirror2([1,0,0])
                translate([mount_hole_dist/2-dia_mounting_hole/2,-th-dowel_length-dia_mounting_hole,mount_height_holes-dia_mounting_hole/2+(sin(angle_bevel)*dia_mounting_hole)])
                    rotate([-angle_bevel,0,0])
                        cube([dia_mounting_hole+2*eps,dia_mounting_hole,dia_mounting_hole*2]);
    }
}


module sensor_clip(dia, th_wall, h_wall, y_offset) {


    // Generate points for curvature
    points= concat([[0,dia/2+5+y_offset]],cos_line_i(+dia/2+th_wall,mount_width/2,dia/2+5+y_offset,0,30), [[0,0]]);
    
    difference(){
        union(){
            difference(){    
                union(){
                    translate([0,dia/2+5+y_offset,0])
                        cylinder(r=dia/2+th_wall, h = h_wall);      
                    
                    mirror2([1,0,0])
                        linear_extrude(height = h_wall)
                            polygon(points); 
                    
                }
                
                translate([0,dia/2+5+y_offset,-eps])
                        cylinder(r=dia/2, h = h_wall+2*eps);     
            }
            
            
            // Threaded
            if(threaded)
                translate([0,dia/2+5+y_offset,0])
                     thread_in(dia, h_wall, thread_pitch);  
            
        }
    // Gap
    translate([0, dia+5+y_offset , h_wall/2])
        cube([sensor_gap, dia, h_wall+2*eps], center=true);
    
}
    
}

module sensor_screw(dia, th_wall, h_wall, y_offset) {


    // Generate points for curvature
    points= concat([[0,dia/2+5+y_offset]],cos_line_i(+dia/2+th_wall,mount_width/2,dia/2+5+y_offset,0,30), [[0,0]]);
    
    difference(){
        union(){
            difference(){    
                union(){
                    translate([0,dia/2+5+y_offset,0])
                        cylinder(r=dia/2+th_wall, h = h_wall);
              
                    *translate([-dia/2-th_wall,dia/2+5+y_offset,0])
                        cube([dia+2*th_wall, (dia/2+th_wall)*0.5, h_wall]); 
                    
                    mirror2([1,0,0])
                        linear_extrude(height = h_wall)
                            polygon(points); 
                    
                }
                
                translate([0,dia/2+5+y_offset,-eps])
                        cylinder(r=dia/2, h = h_wall+2*eps); 
            
                translate([-mount_width/2-eps, -10+eps , -eps])
                       cube([mount_width+2*eps, 10, mount_height+2*eps]);  
              
              // Holes for screws
                mirror2([1,0,0])
                    translate([(dia+th_wall)/2, dia/2+y_offset+5+2*eps, th_wall/2])
                        rotate([90,0,0])
                            cylinder(r=m3_radius, h = dia/2+y_offset);
                
                // Holes for screw wide
                mirror2([1,0,0])
                    translate([(dia+th_wall)/2,dia/2+y_offset+5-eps,th_wall/2])
                        rotate([-90,0,0])
                            cylinder(r=m3_wide_radius, h = dia/2+th_wall);
              
              // Holes for screw heads
                mirror2([1,0,0])
                    translate([(dia+th_wall)/2,dia/2+y_offset+5+eps+5,th_wall/2])
                        rotate([-90,0,0])
                            cylinder(r=dia_screw_head/2, h = dia/2+th_wall);  
            }
            
            
            // Threaded
            if(threaded)
                translate([0,dia/2+5+y_offset,0])
                     thread_in(dia, h_wall, thread_pitch);  
            
        }
    
}
    
}

// sensor screw splitted in printable parts
module sensor_screw_splitted(dia, th_wall, h_wall, y_offset)
{
	
	intersection()
	{
		sensor_screw(dia, th_wall, h_wall, y_offset);
        translate([-max(dia+2*th_wall+eps,mount_width)/2-eps,-(mount_thickness+dowel_length+2*eps)-eps,-eps])
            cube([max(dia+2*th_wall+eps,mount_width)+2*eps, (dia/2+y_offset+5)+(mount_thickness+dowel_length+2*eps)+2*eps, mount_height+2*eps]);
	}
	
	translate([0, 5,0])
			difference()
			{
				sensor_screw(dia, th_wall, h_wall, y_offset);
                translate([-max(dia+2*th_wall+eps,mount_width)/2-eps,-(mount_thickness+dowel_length+2*eps)-eps,-eps])
            cube([max(dia+2*th_wall+eps,mount_width)+2*eps, (dia/2+y_offset+5)+(mount_thickness+dowel_length+2*eps)+2*eps, mount_height+2*eps]);
			}
	
}

module thread_in(dia,hi,p=1,thr=36)
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	t = (hi-p)/p;			// number of turns
	n = t*thr;				// number of segments
	echo(str("dia=",dia," hi=",hi," p=",p," h=",h," Rmin=",Rmin," s=",s));
	difference()
	{
		cylinder(r = (dia/2)+1.5,h = hi);
		translate([0,0,-1]) cylinder(r = (dia/2)+0.1, h = hi+2);
	}
	for(sg=[0:n])
		th_in_pt(Rmin+0.1,p,s,sg,thr,h,(hi-p)/n);
}

module th_in_pt(rt,p,s,sg,thr,h,sh)
// rt = radius of thread (nearest centre)
// p = pitch
// s = segment length (degrees)
// sg = segment number
// thr = segments in circumference
// h = ISO h of thread / 8
// sh = segment height (z)
{
//	as = 360 - (((sg % thr) * s) - 180);	// angle to start of seg
//	ae = as - s + (s/100);		// angle to end of seg (with overlap)
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100);		// angle to end of seg (with overlap)
	z = sh*sg;
	pp = p/2;
	//         2,5
	//          /|
	//  1,4 /  | 
 	//        \  |
	//          \|
	//         0,3
	//  view from front (x & z) extruded in y by sg
	//  
	polyhedron(
		points = [
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z],				//0
			[cos(as)*rt,sin(as)*rt,z+(3/8*p)],						//1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/4*p)],		//2
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh],			//3
			[cos(ae)*rt,sin(ae)*rt,z+(3/8*p)+sh],					//4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+(3/4*p)+sh]],	//5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

function cos_line(x_min,x_max,y_min,y_max,fn=180)=
    [for(i=[180:180/fn:360])
    [x_min+((i-180)/180)*(x_max-x_min),y_min+(cos(i)+1)/2*(y_max-y_min)]
];
function cos_line_i(x_min,x_max,y_min,y_max,fn=180)=
    [for(i=[180:180/fn:360])
    [x_min+(cos(i)+1)/2*(x_max-x_min),y_min+((i-180)/180)*(y_max-y_min)]
];
    
module mirror2(v) {
    children();
    mirror(v) children();
}
