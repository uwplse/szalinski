/*                                                
 * A Bahtinov mask generator.
 * Units in mm, default values are for
 * a Sigma 70-300mm 1:4-5.6 APO lens.
 *
 * Copyright 2017, Andreas Dietz
 * License: CC-BY-SA
 *
 * Based on the work by Ella Astashonok
 *
 * Original design by Brent Burton
 * ver. 2.1.0
 */

/* [primary] */

// The telescope focus length 
focus = 185; // [10:1000]

// The telescope light's path diameter.
aperture = 58; // [30:200]

// This is the inner diameter of the mask.
inner_Diameter = 66; // [31:250]

// Height of mask
mask_Height = 2; // [1:10]

// Diameter of secondary mirror holder. If no secondary, set to 0.
center_Hole_Diameter = 0; // [0:90]

// Height of outer border
outer_Height = 20; // [0:50]

//Inner border around center hole. Can be used as handle. 0 for no border. Negative values generate border on oposite side. Not recomended - hard to print. 
inner_Height = 0; // [-50:+50] 

// Split 4 parts distance (-1 for one pice mask)
split_Distance = -1; //[-1:20]

/* [Advanced] */

//Select part to print
part = "all"; //[tl:Top Left, tr:Top Right, bl:Bottom Left, br:Bottom Right, all: All parts]

// Bahtinov factor used for calculate slot size. (should be from 150 to 200. You shouldn't need to tweak this unless your slots are too narrow for printing, in which case, divide the factor by 3)
bahtinov_factor = 50; // [50:200] 

// Width of the gaps and the bars (0-for auto calculate).
slot_Size = 0.8; // [0:10]

// Width of central bars (0 foor same as bars and gaps)
central_bars_width = 0; //[0:20]

// Angle of slots
slots_Orientation = 30; // [20:45]

// Layer size used to calculate separation distance when making splitted mask
split_layer_width = 0.3;


outerDiameter = inner_Diameter + 2 * mask_Height;
maskHeight=mask_Height;
outerHeight=outer_Height;
handle = inner_Height;
bahtinov = bahtinov_factor;
slotSize = slot_Size;
slotsOrientation = slots_Orientation;
central_bars = central_bars_width;
split_layer = split_layer_width;

layer = split_Distance >= 0 || part != "all" ? split_layer : 0;
gap = slotSize > layer*2 ? slotSize : getGap(focus, bahtinov) < layer*2 ? getGap(focus, bahtinov / 3)  : getGap(focus, bahtinov);
cBars1 = central_bars > 0 ? (central_bars > gap ? central_bars : gap) : gap;
cBars = cBars1 > layer*5 || split_Distance < 0 ? cBars1 : layer*5;
centerHoleDiameter = center_Hole_Diameter > 0 && center_Hole_Diameter < cBars ? cBars : center_Hole_Diameter;
splitDistance = split_Distance > 0 && split_Distance < cBars ? cBars : split_Distance;
split = part != "all" && splitDistance < cBars*2 ? cBars*2 : (splitDistance < 0 ? 0 : splitDistance); 
//split = splitDistance < 0 ? 0 : splitDistance;
handleHeight = abs(handle);
echo("Gap size: ", gap);	

print_main(part);

function getGap(focus, bahtinov) = round(focus/bahtinov*100+0.5)/200;

/* create a series of bars covering roughly one half of the
 * scope aperture. Located in the +X side.
 */
module bars(gap, width, num=5, split) {
    num = round(num);
    for (i=[-num:0]) {
        translate([width/2+split,i*2*gap-split+gap]) square([width,gap], center=true);
    }
    for (i=[0:num]) {
        translate([width/2+split,i*2*gap+split+gap]) square([width,gap], center=true);
    }
}

module bahtinovBars(gap,width, split) {
    numBars = round(aperture/2 / gap / 2 + 0.5);
    // +X +Y bars
	 translate([split, split, 0]) 
	 intersection() {
		rotate([0,0,slotsOrientation]) bars(gap, width, numBars, 0);
		square([outerDiameter/2, outerDiameter/2], center=false);
	 }
	 // +X -Y bars
	 translate([split, -split, 0]) 
	 intersection() {
		rotate([0,0,-slotsOrientation]) bars(gap, width, numBars, 0);
		translate([0,-outerDiameter/2]) square([outerDiameter/2, outerDiameter/2], center=false);
	 }
	 // -X bars
	 rotate([0,0,180]) bars(gap, width, numBars, split);
}

$fn=300;
module bahtinov2D() {
    width = aperture/2+1;
    difference() {                          // overall plate minus center hole
        union() {
				difference(){							  // trims the mask to aperture size
					
					for( pos = [0:3]){
							rotate([0, 0, pos*90]) 
								translate([split, split]) 
									circle(r=aperture/2+1);
					}
	            bahtinovBars(gap,width, split);
				}
            
				for( pos = [0:90:359]){
					rotate([0, 0, pos]) 
						translate([split, split])
							intersection(){ 
								difference() {                  // makes the outer margin
	            				circle(r=outerDiameter/2);
	            				circle(r=aperture/2);
	            			}
								translate([0,layer/2,0]) square([outerDiameter/2, outerDiameter/2]);
							}
				}

            // Add center hole margin if needed:
				
            if (centerHoleDiameter > 0) {
					for(i = [0:90:359])
						rotate([0,0,i])
							translate([split, split])
                			intersection(){
									circle(r=(centerHoleDiameter+gap)/2);
									square([centerHoleDiameter/2+gap, centerHoleDiameter/2+gap]);
								}
            }
				

        	}//union
        	
         // Add center hole if needed:
			if (centerHoleDiameter > 0) {
				for(i = [0:90:359])
					rotate([0,0,i]){
	               intersection(){
							translate([split, split])
								circle(r=centerHoleDiameter/2);
							square([centerHoleDiameter/2+split,centerHoleDiameter/2+split]);
						}
					}
			}

		}//difference
      
}

module fakeMask(){
	for(i=[0:90:359]){
		rotate([0,0,i])		
			intersection(){
				translate([split,split,0])
					difference(){
						cylinder(r=outerDiameter/2, h=maskHeight);
						translate([0,0,-1])cylinder(r=centerHoleDiameter/2, h=maskHeight+2);
					}
				cube([outerDiameter/2+split,outerDiameter/2+split,maskHeight]);
			}
	}
}

module triangleX(x, y, z){
		translate([0, y/2,0])
       rotate([90,0,0])
			linear_extrude(height=y) polygon(points=[[0, 0],[x, 0],[0, z]], path=[[0,1,2]]);
}

module connector(width, height, depth, layer){
	w1 = width*3/2-layer*2;
	w2 = width/2-layer*2;
	h = height;
	translate([0,0,-depth/2])
		linear_extrude(height=depth)
			polygon(points=[[-w1/2, h/2], [w1/2, h/2], [w2/2, -h/2], [-w2/2, -h/2]], path=[0,1,2,3]);
}

module horisontalSplit(length,height,depth,connector_width,split){
		// Add split structural bars
		bar_hgt = height / 6;
		connector_hgt = height*2/3;
		union(){
			//%cube([cBars,layer,3],true);
			difference(){
				union(){
					translate([split+length/2,(split-bar_hgt/2+height/2), 0]) //bar1
						cube([length, bar_hgt, depth], true);
					translate([split+length/2, -(split-bar_hgt/2+height/2), 0]) //bar2
						cube([length, bar_hgt, depth], true);
				}
				if(centerHoleDiameter<=0)
					translate([split,0,-1]) //bar2
						cube([height*2/3, split*2+height, depth+2], true);
				else
					union(){
						translate([split-centerHoleDiameter/2+gap/2,split,-depth/2-1]) //bar2
							cylinder(r=centerHoleDiameter/2, h=depth+2);
						translate([split-centerHoleDiameter/2+gap/2,-split,-depth/2-1]) //bar2
							cylinder(r=centerHoleDiameter/2, h=depth+2);
					}
			}
			intersection(){
				for(i=[connector_width*3/2-bar_hgt*3:connector_width*2:length+connector_width]){
					translate([i+split,-(split-connector_hgt/2+height/2-bar_hgt+layer),0])
						connector(connector_width-layer/2, connector_hgt, depth, layer);
					//if(i+connector_width*2 <= length+connector_width*2/3) 
					translate([i+split+connector_width,split-connector_hgt/2+height/2-bar_hgt+layer,0])
					rotate([0,0,180])
						connector(connector_width-layer/2, connector_hgt, depth, layer); 
				}
				translate([split+length/2/*+height/2-bar_hgt-layer*/, 0, 0])
					cube([length, split*2+height, depth], true);
				
			}
		}
	
}

module cylinderLocks(dOut,dIn,w,lock_h,layer,split){
	//Making outer border lock
	assign(wall = (dOut-dIn)/2)
 		for(i=[0:90:359]){ //outer lock
	 		rotate([0,0,i])
	   	translate([split,split,0]){
				intersection(){ //OuterLock
					difference(){ 
						cylinder (r=dOut/2, h=lock_h); //Outer wall 
						cylinder (r=dOut/2-(wall/2)+layer/2, h=lock_h); //Inner wall
	    			}
					translate([0,-w/3+layer,0])
						cube([dOut/2,w*2/3-layer,lock_h]);
				}
				rotate([0,0,90])
				intersection(){ //InterLock
					difference(){ 
						cylinder (r=dOut/2-(wall/2)-layer/2, h=lock_h); //Outer wall 
						cylinder (r=dIn/2, h=lock_h); //Inner wall
	    			}
					translate([0,-w/3,0])
						cube([dOut/2,w*2/3-layer,lock_h]);
			}
		}
 }
}

module print_main(part="all"){
	echo ("Printing part:", part);

	translate([part!="all"?(outerDiameter/4+split/2):0,part!="all"?(outerDiameter/4+split/2):0,0])
	rotate([0,0,part=="tl"?90:part=="tr"?180:part=="br"?-90:0])
	intersection(){
		union() {
		difference(){
		union() {
			
		    linear_extrude(height=maskHeight) bahtinov2D();
			 //fakeMask();

			 //Outer Border
		    if(outerHeight > 0){
			 	for(i=[0:90:359]){
					rotate([0,0,i])
					  translate([split,split,maskHeight]){
							difference(){
								intersection(){
						    		union(){
										difference(){ 
											cylinder (r=outerDiameter/2, h=outerHeight-maskHeight); //Outer wall 
											translate([0,0,-1])
												cylinder (r=outerDiameter/2-(maskHeight), h=outerHeight-maskHeight+2); //Inner wall
						    			}
									}
									cube([outerDiameter/2,outerDiameter/2,outerHeight-maskHeight]); 
								}
							}
					  }
				}
			 }
			 
			 //Inner border / handle
			 assign(ht=handle<0?handleHeight:handleHeight-maskHeight)
		    if(handleHeight > 0){
				if (centerHoleDiameter > 0){
					translate([0,0,handle<0?handle-maskHeight:0])
					union(){
						for(i=[0:90:395]){
							rotate([0,0,i])
							  translate([split,split,maskHeight]){
									difference(){
										intersection(){
							    			difference(){ 
												cylinder (r=(centerHoleDiameter+gap)/2, h=ht); //Outer wall 
												translate([0,0,-1])
													cylinder (r=(centerHoleDiameter)/2, h=ht+2); //Inner wall
							    			}
											//translate([0,0,0])
											cube([centerHoleDiameter/2+gap/2,centerHoleDiameter/2+gap,ht]); 
										}
									}
							  }
						}
					}//union
				}//holeDiameter > 0
			 }//Handle

		}//union
			//Split parts
			assign(maxpl= max(outerHeight,maskHeight,handle>0?handle:0))
			assign(maxh = max(maskHeight, handleHeight, outerHeight, maxpl-handle))
			{
				echo("maxh:",maxh," maxpl:",maxpl," handle:",handle);
				translate([0,0,(handle<0?(maxpl+handle)/2:maxpl/2)]){//(maxh/2)*sign(handle)+(handle<0?maskHeight:0)]){
					cube([outerDiameter+split*2,cBars*2/3+split*2,maxh+2],true);		
					cube([cBars*2/3+split*2,outerDiameter+split*2,maxh+2],true);
				}
			}		
		}//difference
			 //Make connectors
			 assign(
				con_delta = (centerHoleDiameter > 0 ? (centerHoleDiameter)/2-(cBars/4-cBars/12) : 0),
				con_length=outerDiameter/2-(centerHoleDiameter > 0 ? (centerHoleDiameter)/2 : 0)
			 )
			 for(i=[0:90:359]){
				rotate([0,0,i])
					intersection(){
						difference(){
							translate([con_delta,0,maskHeight/2]){						
								if(splitDistance>=0 || part != "all")
									horisontalSplit(con_length, cBars, maskHeight, cBars, split);
								else
									translate([con_length/2,0,0])
										cube([con_length, cBars,maskHeight],true);

							}
							intersection(){
								union(){
									translate([split,split,-1])
										cylinder(r=(centerHoleDiameter+gap)/2+layer, h=maskHeight+2);
									translate([split,-split,-1])
										cylinder(r=(centerHoleDiameter+gap)/2+layer, h=maskHeight+2);
								}
								translate([split+outerDiameter/4,0,maskHeight/2])
									cube([outerDiameter/2,cBars*2/3+split*2,maskHeight+2],true);
							}
						}
						union(){
							translate([split,split,-1])	
								cylinder(r=outerDiameter/2-maskHeight-layer, h=maskHeight+2);
							translate([split,-split,-1])	
								cylinder(r=outerDiameter/2-maskHeight-layer, h=maskHeight+2);
						}
					}
			 }

			 //Making outer border lock
			 cylinderLocks(outerDiameter,outerDiameter-maskHeight*2,cBars,outerHeight > 0 ? outerHeight : maskHeight,layer,split);

			 //Making inner border lock
			 if(centerHoleDiameter > 0)
				assign(ht=handle<0?handleHeight:handleHeight-maskHeight)
				translate([0,0,handle<0?handle:0])
					assign(h=handle != 0 ? (maskHeight+(handle>0?handleHeight-maskHeight:handleHeight)) : maskHeight)
			 		cylinderLocks(centerHoleDiameter+gap,centerHoleDiameter,cBars,h,layer,split);
			
		}//union
		if (part != "all"){
			if (part == "tl"){
				translate([-(outerDiameter/2+1+split),0,handle < 0 ? handle : 0])
					cube([outerDiameter/2+1+split,outerDiameter/2+1+split,maskHeight+max(handleHeight, outerHeight, outerHeight-handle)]);
			}
			if (part == "tr"){
				translate([0,0,handle < 0 ? handle : 0])
					cube([outerDiameter/2+1+split,outerDiameter/2+1+split,maskHeight+max(handleHeight, outerHeight, outerHeight-handle)]);
			}
			if (part == "bl"){
				translate([-(outerDiameter/2+1+split),-(outerDiameter/2+1+split),handle < 0 ? handle : 0])
					cube([outerDiameter/2+1+split,outerDiameter/2+1+split,maskHeight+max(handleHeight, outerHeight, outerHeight-handle)]);			
			}
			if (part == "br"){
				translate([0,-(outerDiameter/2+1+split),handle < 0 ? handle : 0])
					cube([outerDiameter/2+1+split,outerDiameter/2+1+split,maskHeight+max(handleHeight, outerHeight, outerHeight-handle)]);
			}
			
		}
	}//intersection

}//main_print
