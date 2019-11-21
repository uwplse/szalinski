// (c) Nicholas Brookins, http://www.thingiverse.com/knick

//preview the whole thing, or choose which part of the model to build in print orientation
build_mode = 0;//[0:Preview Vertically, 1:Build Top Half, 2:Build Bottom Hlaf, 3:Build Both]

//which style of mount to create, a standard gopro tab mount, or the quick release buckle
mount_type = 2;//[0:none, 1:GoPro Tab Mount, 2:Quick Release Buckle Mount]
//optionally rotate the mount on the clamp
mount_rotate =90; //[0,90]
//optionally rotate the buckle mount to just out sideways
mount_rotate_side = 90;//[0,90]
//Whether to center the buckle on the clamp (assuming the buckle is wider than the clamp is), or to line up one side for easier printing
gopro_buckle_centered = 0; //[0: offset for easy printing, 1: centered on clamp]


//height of the mount from the clamp up to the center of the gopro bolt hole
gopro_mount_height = 8.5;
//height of the overall buckle mount
gopro_buckle_height = 1* 10;
//lenghth of the buckle mount, I had to tweak this depending on the printer settings.
gopro_buckle_length = 23.5;
//width of the notch cut out of the overhang
gopro_buckle_notch_width = 3.75;

//width of the tube that this will mount to.  I use roughly 1.75" for rollcage on my RZR
clamp_tube_diameter=44;
//thickness of the clamp around the tube.  Make sure it is thick enough to support the mounting bolts
clamp_thickness =8;
//the width of this clamp
clamp_width = 12;
//Style of hole for bolt clearance on top half
clamp_top_hole_style = 2; //[0:None, 1:Round, 2:HexNut]
//Style of hole for bolt clearance on bottom half
clamp_bottom_hole_style = 1;//[0:None, 1:Round, 2:HexNut]

//diamter of the bolt holes in the clamp, plus some clearance - at least .25, I use .5
clamp_bolt_diameter = 4.5;
//width of the faces on the hex nut.  Build your own clearnace into this depending on your printer, I had to add 1mm above the measurement of the nut, in order to get an easy fit.
clamp_bolt_nut_width = 9.8;
//width of the bolthead for the clamp
clamp_bolt_head_width = 1*clamp_bolt_nut_width;
//an offset for bolt holes away from the middle, to ensure there's enough thickness in the clamp
clamp_bolt_offset = .5;
//the thickness of the contect area that the bolt squeezes on the clamp
clamp_contact_thickness = 4;


//width of the gorpo mount
gopro_mount_width = 1* 14.5;
//width of the tab that hangs off the gopro
gopro_mount_tab_width = 1* 9.5;
//with of the middle slot in the gopro tab
gopro_mount_tab_slot_width = 1* 3.2;
//width of the gopro bolt nut
gopro_mount_nut_width= 1* 8.25;
//diamter of the gopro bolt
gopro_mount_bolt_diameter = 1* 4.95;
//inset of mount into clamp - set this appropriately to ensure the mount attaches fully to the clamp
gopro_mount_inset = 1* 1;

//overall width of the buckle mount
gopro_buckle_width = 1* 35;
//inside width of the area the buckle slides into
gopro_buckle_inside_width = 1* 28.5;
//inside height of the buckle slot 
gopro_buckle_inside_height = 1* 4.8;
//width of the little alignment ridge in center
gopro_buckle_ridge_width = 1*3.3;
//height of the alignment ridge
gopro_buckle_ridge_height = 1*1.9;
//overhang over the buckle
gopro_buckle_overhang = 1*3.3;
//thickness of the buckle overhang
gopro_buckle_overhang_thickness = 1*2;
//how far inset the buckle mount is into the clamp
gopro_buckle_inset = 1*3.2;
//rounding of the buckle mount
rounding = 1*1;
ridge_rounding = 1*.5;

//auto vars
gopro_nut_flare = 1*1.5;
gopro_nut_flarewidth = 1*2.5;
fnv = 1 * 120;
v_offset = clamp_tube_diameter/2+clamp_thickness;



//MAIN
if(build_mode==0 || build_mode==3){
	rot = (build_mode==3) ? 90 : 0;
	rotate([rot,0,0]){
		make_clamp(make_mount_type=mount_type, clamp_bolt_hole_style=clamp_top_hole_style);
		translate([0,0,-10])
		rotate([0,180,0])
		make_clamp(clamp_bolt_hole_style=clamp_bottom_hole_style);
	}
}

if(build_mode==1){
	rotate([90,0,0])
	make_clamp(make_mount_type=mount_type,clamp_bolt_hole_style=clamp_top_hole_style);
}

if(build_mode==2){
	rotate([90,0,0])
	make_clamp(clamp_bolt_hole_style=clamp_bottom_hole_style);
}

module make_clamp(make_mount_type=0, clamp_bolt_hole_style=0){
	union(){
	difference(){
		union(){
			//main clamp 
			rotate([90,0,0])
			cylinder(d=clamp_tube_diameter+clamp_thickness*2, h=clamp_width, center=true, $fn=fnv);
		}

		//tube hole in clamp
		rotate([90,0,0])
		cylinder(d=clamp_tube_diameter, h=clamp_width+.01, center=true, $fn=fnv);
		
		//calulate offset for bolts and corresponding holes
		side_offset = (clamp_tube_diameter/2+clamp_thickness/2 + clamp_bolt_offset);
		//loop to do for each side
		for (i=[-1:2:1]){
			//bolt holes
			translate([i* side_offset, 0, -1])
			cylinder(d=clamp_bolt_diameter, h=clamp_tube_diameter, $fn=fnv);
			//nut holes
			if(clamp_bolt_hole_style==2)
			translate([i* side_offset,0, clamp_contact_thickness])
			rotate([0,0,30])
			cylinder(d=clamp_bolt_nut_width, h=clamp_tube_diameter, $fn=6);
			//bolt head clearance
			if(clamp_bolt_hole_style==1)
			translate([i*side_offset,0, clamp_contact_thickness])
			cylinder(d=clamp_bolt_head_width, h=clamp_tube_diameter, $fn=fnv);			
		}
		
		//chop in half
		size = (clamp_tube_diameter+clamp_thickness)*2;
		translate([0,0,-size/2])
		cube([size,size,size], center=true);
	}
	rotate([0,0,mount_rotate]){
		translate([0,0,v_offset]){
			if(make_mount_type == 1)
			translate([0,0,-gopro_mount_inset])
			make_gopro_mount();
	
			cenZ = (mount_rotate_side == 90) ? gopro_buckle_length/2 + gopro_buckle_inset*2: 0;
			
			cenX1 = (mount_rotate == 0 && gopro_buckle_centered==0) ? (gopro_buckle_width-clamp_width)/4: 0;
						
			cenY1= (mount_rotate_side == 90 && mount_rotate==90) ? -clamp_width/2:0; 
			cenY2= (mount_rotate_side == 90 && mount_rotate==0) ? -gopro_buckle_height/2:0; 
			cenY3 = (mount_rotate_side !=90 && mount_rotate == 90 && gopro_buckle_centered==0) ? (gopro_buckle_length)/2: 0;
			
			if(make_mount_type == 2){
				translate([cenY1 + cenY2 + cenY3, cenX1 , -gopro_buckle_inset +cenZ ])
				rotate([0,mount_rotate_side,0])
				make_gopro_buckle();
			}
		}
	}
}
}

module make_gopro_mount(){
	difference(){
		union(){
			//mount body
			translate([0,0, gopro_mount_height/2])	
			cube([gopro_mount_width, clamp_width, gopro_mount_height], center=true);
			//rounded top
			translate([0,0, gopro_mount_height])
			rotate([0,-90,0])
			cylinder(d=clamp_width, h=gopro_mount_width, $fn=fnv, center=true);

			//nut flare and hole
			translate([-gopro_mount_width/2,0, gopro_mount_height])
			rotate([0,-90,0])
			difference(){
				cylinder(r1=clamp_width/2, r2=gopro_mount_nut_width/2 + gopro_nut_flare, h=gopro_nut_flarewidth, $fn=fnv);
				translate([0,0,-.01])
				cylinder(d=gopro_mount_nut_width, h=gopro_nut_flarewidth+.02, $fn=6);
			}
		}
		//GoPro Bolt Hole
		translate([0,0, gopro_mount_height])
		rotate([0,-90,0])
		cylinder(d=gopro_mount_bolt_diameter, h=gopro_mount_width*2, center=true, $fn=fnv);
		
		//gopro tab and slot
		translate([0,0,gopro_mount_height ])
		difference(){
			cube([gopro_mount_tab_width, clamp_width+.1, gopro_mount_height*2], center=true);
			cube([gopro_mount_tab_slot_width, clamp_width+.15, gopro_mount_height*2], center=true);
		}
	}
}

module make_gopro_buckle(){
	difference(){
		union(){
			//main block
			translate([0,0,gopro_buckle_height/2])
			cubeX([gopro_buckle_width, gopro_buckle_length, gopro_buckle_height], center=true, radius=rounding);
		}
		
		//cut out ceiling
		translate([0,0,gopro_buckle_height-gopro_buckle_overhang_thickness/2+-.01])
		union(){
			w =  gopro_buckle_inside_width-gopro_buckle_overhang*2;
			cube([w, gopro_buckle_length+.1, gopro_buckle_overhang_thickness+.02], center=true);
			//cut corner parts
			n = gopro_buckle_notch_width;
			translate([ w/2-.01, -gopro_buckle_length/2,0])
			make_triangle(n,gopro_buckle_overhang_thickness+.02);
			
			translate([ -w/2+.01, gopro_buckle_length/2,0])
			rotate([0,0,180])
			make_triangle(n,gopro_buckle_overhang_thickness+.02);	
			
			translate([ -w/2+.01, -gopro_buckle_length/2,0])
			rotate([0,0,90])
			make_triangle(n,gopro_buckle_overhang_thickness+.02);
			
			translate([ w/2-.01, gopro_buckle_length/2,0])
			rotate([0,0,-90])
			make_triangle(n,gopro_buckle_overhang_thickness+.02);
		}
		
		//cut out floor
		translate([0,0,gopro_buckle_height-gopro_buckle_inside_height/2 - gopro_buckle_overhang_thickness])
		difference(){
			cube([gopro_buckle_inside_width, gopro_buckle_length+.1, gopro_buckle_inside_height], center=true);
			//ridge
			translate([0,0,(-gopro_buckle_inside_height + gopro_buckle_ridge_height- ridge_rounding)/2 ])
			cubeX([gopro_buckle_ridge_width, gopro_buckle_length+.01, gopro_buckle_ridge_height+ridge_rounding], center=true, radius=ridge_rounding);
		}
	}
		
}

module make_triangle(width=0, thickness=0){
	linear_extrude(height = thickness, center = true, convexity = 1, twist = 0)
	polygon(points=[[0,0],[width,0],[0,width]], paths=[[0,1,2]]);

}


module cubeX( size, radius=1, rounded=true, center=false ){
	// Simple and fast corned cube!
	// Anaximandro de Godinho.
	l = len( size );
	if( l == undef ) _cubeX( size, size, size, radius, rounded, center );
	else _cubeX( size[0], size[1], size[2], radius, rounded, center );
}

module _cubeX( x, y, z, r, rounded, center ){
	if( rounded )
		if( center )
			translate( [-x/2, -y/2, -z/2] )
			__cubeX( x, y, z, r );
		else __cubeX( x, y, z, r );
	else cube( [x, y, z], center );
}

module __cubeX(	x, y, z, r ){
	//TODO: discount r.
	rC = r;
	hull(){
		$fn=60;
		translate( [rC, rC, rC] )sphere( r );
		translate( [rC, y-rC, rC] )sphere( r );
		translate( [rC, rC, z-rC] )sphere( r );
		translate( [rC, y-rC, z-rC] )sphere( r );
		translate( [x-rC, rC, rC] )sphere( r );
		translate( [x-rC, y-rC, rC] )sphere( r );
		translate( [x-rC, rC, z-rC] )sphere( r );
		translate( [x-rC, y-rC, z-rC] )sphere( r );
	}
}
