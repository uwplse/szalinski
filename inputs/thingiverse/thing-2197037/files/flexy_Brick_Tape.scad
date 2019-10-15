// * LEGO®, the LEGO® logo, the Brick, DUPLO®, and MINDSTORMS® are trademarks of the LEGO® Group. ©2012 The LEGO® Group.
 //

/* [General] */

// Width of the block, in studs
block_width = 2;

// Length of the block, in studs
block_length = 4;

//Do you want the flexible grooves?
Grooves =false; //true or false

// What type of tape should this be? Stud or tile? (Stud is top side only & Tile is bottom side of lego only)
block_type = 0; // [1 = stud tape, 0 = tile tape]



// Height of the block. A ratio of "1" is a standard LEGO brick height; a ratio of "1/3" is a standard LEGO plate height; "1/2" is a standard DUPLO plate.
//RECOMENDED: Use 0.1 for stud tape and .34 for tile tape. This is left as user editible in case your filament is more/less flexible than mine. 
//Tring .25mm for 7x7 hard top for cuitcuit cover, .3 thick for chassis
    block_height_ratio = .34; // [.33333333333:1/3, .5:1/2, 1:1, 2:2, 3:3, 4:4, 5:5, 6:6, 7:7, 8:8, 9:9, 10:10]

/* Hidden */



knob_diameter=4.896*1.0;		//knobs on top of blocks

knob_height=1.8;
knob_spacing=8.0;
wall_thickness=1.45;
roof_thickness=.800;
block_height=9.6*block_height_ratio;
pin_diameter=3.2*1.00;		//pin for bottom blocks with width or length of 1
post_diameter=6.5137;
reinforcing_width=.6;
axle_spline_width=2.0;
axle_diameter=5;
cylinder_precision=0.05;
overall_length=block_length*8;
overall_width=block_width*8;
    
difference(){
    block(block_width ,block_length,1,axle_hole=false,reinforcement=true);
    if (Grooves == true) {
    grooves();
    }
    
       //These translated cubes cut out .1mm form the ends of each side of the brick for clearance to the next brick.
    translate([block_length*knob_spacing/2,0,0]){
        cube([.2,8*block_width+.01,block_height*2.01], center = true);
    }
     translate([-block_length*knob_spacing/2,0,0]){
        cube([.2,8*block_width+.01,block_height*2.01], center = true);
    }
     translate([0,-block_width*knob_spacing/2,0]){
        cube([8*block_length+.01,.2,block_height*2.01], center = true);
    }
     translate([0,block_width*knob_spacing/2,0]){
        cube([8*block_length+.01,.2,block_height*2.01], center = true);
    }
}
                

module grooves(height){
        	translate([-overall_length/2,-overall_width/2-.01,0]) {              
        for (ycount=[1:block_width-1]){
							for (xcount=[1:block_length-1]) {	
                                translate([xcount*knob_spacing,block_width*knob_spacing/2,block_height-1.5/4+.01]){
                                cube([.75,block_width*knob_spacing,1.5/2], center = true); 
                                    //y axisgrooves
                                } 
                                translate([block_length*knob_spacing/2,ycount*knob_spacing,block_height-1.5/4+.01]){
                                cube([block_length*knob_spacing,.75,1.5/2], center = true);
                                    //x axis grooves
                                   
                                }
                                
                            }
                        }
                    }
                }
                
                
module block(width,length,height,axle_hole,reinforcement) {
    //overall_length=(length-1)*knob_spacing+knob_diameter/stud_rescale+wall_thickness*2;
	//overall_width=(width-1)*knob_spacing+knob_diameter/stud_rescale+wall_thickness*2;
    overall_length=block_length*8;
    overall_width=block_width*8;
	start=(knob_diameter/2+knob_spacing/2+wall_thickness);
	translate([-overall_length/2,-overall_width/2,0])
		union() {
			difference() {
				union() {
					cube([overall_length,overall_width,height*block_height]);
					translate([knob_diameter/2+wall_thickness,knob_diameter/2+wall_thickness,0]) 
						for (ycount=[0:width-1])
							for (xcount=[0:length-1]) {	
                                translate([xcount*knob_spacing,ycount*knob_spacing,0])
                                cylinder(r=knob_diameter*block_type/2,h=block_height*height+knob_height,$fs=cylinder_precision);
						}
				}
				

                            
                if(block_type == 0){
                    translate([wall_thickness,wall_thickness,-roof_thickness]) cube([overall_length-wall_thickness*2,overall_width-wall_thickness*2,block_height*height]);
              						}
                    
				if (axle_hole==true)
					if (width>1 && length>1) for (ycount=[1:width-1])
						for (xcount=[1:length-1])
							translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,-block_height/2])  axle(height+1);
                        //grooves();
        
			}
	
			if (reinforcement==true && width>1 && length>1)
				difference() {
					for (ycount=[1:width-1])
						for (xcount=[1:length-1])
							translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,0]) reinforcement(height);
					for (ycount=[1:width-1])
						for (xcount=[1:length-1])
							translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,-0.5]) cylinder(r=post_diameter/2-0.1, h=height*block_height+0.5, $fs=cylinder_precision);
				}
	
			if (width>1 && length>1) for (ycount=[1:width-1])
				for (xcount=[1:length-1])
					translate([(xcount-1)*knob_spacing+start,(ycount-1)*knob_spacing+start,0]) post(height,axle_hole);
	
			if (width==1 && length!=1)
				for (xcount=[1:length-1])
					translate([(xcount-1)*knob_spacing+start,overall_width/2,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);   
         
            if (width==1 && length!=1)
				for (xcount=[1:length-1])
					translate([(xcount-1)*knob_spacing+start,overall_width/2,block_height/2]) cube([reinforcing_width,7,height*block_height],center=true);     
  
         
			if (length==1 && width!=1)
				for (ycount=[1:width-1])
					translate([overall_length/2,(ycount-1)*knob_spacing+start,0]) cylinder(r=pin_diameter/2,h=block_height*height,$fs=cylinder_precision);
            if (length==1 && width!=1)
				for (ycount=[1:width-1])
                    translate([overall_length/2,(ycount-1)*knob_spacing+start,block_height/2]) cube([7,reinforcing_width,height*block_height],center=true);  

            }
}

module post(height,axle_hole=false) {
	difference() {
		cylinder(r=post_diameter/2, h=height*block_height,$fs=cylinder_precision);
		translate([0,0,-0.5])
            cylinder(r=knob_diameter/2, h=height*block_height+1,$fs=cylinder_precision);

	}
}

module reinforcement(height) {
	union() {
		translate([0,0,height*block_height/2]) union() {
			cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height],center=true);
			rotate(v=[0,0,1],a=90) cube([reinforcing_width,knob_spacing+knob_diameter+wall_thickness/2,height*block_height], center=true);
		}
	}
}


module axle(height) {
	translate([0,0,height*block_height/2]) union() {
		cube([axle_diameter,axle_spline_width,height*block_height],center=true);
		cube([axle_spline_width,axle_diameter,height*block_height],center=true);
	}
}
			