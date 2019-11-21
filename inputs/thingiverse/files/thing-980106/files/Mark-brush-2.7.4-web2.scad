//bottle brush creator - v2.7.4
//Mark G. Peeters August 16, 2015 CC BY-SA
//inspired by drooloops flowers
//more details are posted here:
//https://www.youmagine.com/designs/bottle-brush-customizable/
//http://www.thingiverse.com/thing:980106
// preview[view:west, tilt:top diagonal]


/* [choose parts to print] */
//print what?
print=0;//[0:bristles_layer,1:centerpost]
//for keyed center only (see post settings tab) - number stagger layers used
staggers=2;//[2:two stagger parts,3:three stagger parts]
//which stagger to print, generate one at a time, NOTE!- there will be a notch made in the center support corresponding the the part number. So 1st part has one notch, 2nd part has 2 notches, etc
stag_num=1;//[1:1st stagger part,2:2nd stagger part,3:3rd stagger part]

/* [brush settings] */
//number of bristle per layer
b_number=40; //[1:50]
//outer radius of brush bristle
brush_od=25;//25
//center support radius outer OD
center_support=5.6;//5.6
//center support radius of hole ID
center_hole=4;//4

/* [central post settings] */
//center keyed? this make center a D hole
center_key=0;//[0:no,1:yes]
//decimal percent key depth from center zero to one
center_key_depth=0.6;//0.6
//length of central post
post_z=16;//16
//mount hole radius
post_mount_hole=2.2;//2.2
//fit tolerance, radius value
tol=0.2;//0.2

/* [advanced settings] */
//bristle width - flatness
b_width=0.8;//0.8
//bristle height - thickness
b_height=0.3;//0.3
//bristle layer spacing on shaft - how far in between bristles (NOTE: minimum setting is equal to bristle height
b_space_z=2;//2
//bristle rise above print bed, zero for flat, 0.3 or more for drooloop
b_rize=0.0;//0.0
//central post transition at tip
post_tip_z=0.7;//0.7
//central post mm to shrink at tip
post_tip_shrink=0.7;//0.7

/* [Hidden] */

//key rotation
key_rot=(360/b_number)/staggers;
//key_rot=40;

//handle parameters
//brush handle or mount hole (not used in 2.7)
handle=0;//[0:handle,1:mount hole]
handle_length=50;//length of handle if used
handle_radius=5;//radius for handle if used make smaller that hole
$fn=100;

if (print==0){//print bristle layer
   
    if (center_key==1){
   difference(){//put layer indicator on bristle
       union(){
  layer(b_number,b_width,brush_od,b_height,center_hole,center_support,b_space_z,b_rize);  
    holekey(center_hole,key_rot*stag_num,b_space_z,center_support,center_key_depth);
       }//end union
    translate([0,0,b_space_z-0.2])bristles_ind(stag_num,b_width,brush_od,b_height);
   }//end diff bristle indicator
  }
  
  if (center_key==0){
  layer(b_number,b_width,brush_od,b_height,center_hole,center_support,b_space_z,b_rize);  
  }
}
//end print choices



if (print==1){//print center post
    
if (handle==1){//add handle    
post(center_hole,post_z,center_key_depth,tol,post_tip_z,post_tip_shrink);
    translate([0,0,post_z])cylinder(r=handle_radius,h=handle_length);
}//end add handle          
  
   if (handle==0){//make hole    
   rotate([180,0,0])difference(){
post(center_hole,post_z,center_key_depth,tol,post_tip_z,post_tip_shrink);
    translate([0,0,-(post_tip_z+1)])cylinder(r=post_mount_hole,h=post_z+post_tip_z+5,$fn=100);
   }//end diff
}//end add hole  

//add cap
rotate([180,0,0])difference(){
translate([center_hole*3,0,post_z])cylinder(r=center_hole+1,h=1);
translate([center_hole*3,0,-(post_tip_z+1)])cylinder(r=post_mount_hole,h=post_z+post_tip_z+5,$fn=100);
   }//end diff
   
   
}
//end print choices



//make a layer-------------------------------------------
module layer(b_number,b_width,brush_od,b_height,center_hole,center_support,b_space_z,b_rize){
difference(){
// make the too long bristle shape
difference(){
    union(){
        translate([0,0,b_rize])bristles(b_number,b_width,brush_od+2,b_height);
        ring(center_hole,center_support,b_space_z);
    }//end union
    translate([0,0,-1])cylinder(r=center_hole,h=b_space_z+2);
  };//end diff
//trimm the bristles
  translate([0,0,-1])ring(brush_od,sqrt(brush_od*brush_od+(b_width*b_width)/4)+4,b_space_z+2);
  }//end layer diff
  
  
  }
  //end mod layer
  
  
//add key?-------------------
  module holekey(center_hole,key_rot,b_space_z,center_support,center_key_depth){
if (center_key==1){
difference(){
    translate((center_hole*(0.5+center_key_depth))*[sin(key_rot), -cos(key_rot),0])
    translate([0,0,b_space_z/2])
    rotate([0,0,key_rot])
    cube([center_support*2,center_hole,b_space_z],center=true);
    
    translate([0,0,-1])ring(center_support,center_support*2,b_space_z+2);
            }//end diff
            }//-----end add key------------------
        }
//end mod holekey---------------------------
  
     
//!bristles(b_number,b_width,brush_od,b_height);
module bristles(b_number,b_width,brush_od,b_height){
    for (i=[1:b_number]) {//single petal layer
			rotate ([0,0,i*360/b_number])
			color ("blue")
    translate([-b_width/2,0,0])cube([b_width,brush_od,b_height]);
		}//end i single petal layer
    };//end modle bristles
module ring(ring_inside,ring_outside,ring_height){
   difference(){
        cylinder(r=ring_outside,h=ring_height);
    translate([0,0,-1])cylinder(r=ring_inside,h=ring_height+2);
   }//end diff    
}//end mod ring

module bristles_ind(b_number,b_width,brush_od,b_height){
    for (i=[1:b_number]) {//single petal layer
			rotate ([0,0,i*30])
			color ("blue")
    translate([-b_width/2,0,0])cube([b_width,brush_od+2,b_height]);
		}//end i single petal layer
    };//end modle bristles




//!post(center_hole,tol);
module post(center_hole,post_z,center_key_depth,tol,post_tip_z,post_tip_shrink){
//main 
    keyed_cylinder(center_hole,post_z,center_key,center_key_depth,tol);
//tip for easy assembly
    hull(){
    keyed_cylinder(center_hole,0.01,center_key,center_key_depth,tol);
    translate([0,0,-post_tip_z])
    //scale([.9,.9,1])
    keyed_cylinder(center_hole-post_tip_shrink,0.01,center_key,center_key_depth,tol);
    }//end hull
//collar
    translate([0,0,post_z])cylinder(r=center_hole+1,h=1);   
};//end mod post


//!keyed_cylinder(center_hole,post_z,center_key,center_key_depth,tol);
module keyed_cylinder(od,tall,center_key,center_key_depth,tol){
    if (center_key==1){
difference(){
    cylinder(r=od-tol,h=tall);
    translate([0,((od*(0.5+center_key_depth))-tol),0])
    translate([0,0,tall/2])
    cube([od*2,od,tall+2],center=true);
    }//end diff
}//end if keyed
if (center_key==0){
cylinder(r=od-tol,h=tall);
}//end if not keyed
}
//end module keyed_cylinder
