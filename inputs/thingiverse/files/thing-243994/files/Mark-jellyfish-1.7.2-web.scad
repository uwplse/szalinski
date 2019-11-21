//jellyfish creator - drooloops- deliberatly printing in the air!
//mark peeters Feb 4th, 2013
//this file prints fine without fancy settings, just make sure you have enought infill for the top to look good, I like 17%
// I used ovaltube thanks! OpenSCAD Shapes Library (www.openscad.org) Copyright (C) 2010-2011  Giles Bathgate, Elmo MÃ¤ntynen
//more details are posted here: http://www.thingiverse.com/thing:243994
// preview[view:south, tilt:top diagonal]

/* [jellyfish body] */
//bell radius (keep this in 5 to 14 range)
jf_radius=10;
//bell height, adjusts top curve vs flatness, make equal to radius for spherical top(keep this in 1 to jf_radius range)
jf_height=8;
//radius center post support and oral arms (keep this in 2 to 3 range)
jf_support_radius=2;
//tentacles length (also controls print total height) MUST BE GREATER THAN THAN BELL RADIUS (keep this in 20 to 70 range, AND less than half your horizontal print area)
jfl_outer_length=60;
//tentacles drag, how much should they drag (also controls print total height) (keep this in 5 to 30 range)
jfl_outer_drag=30;
//number of tentacles (keep this in 5 to 12 range) there are 2 tentacle layers
jfl_outer_num=5;
//twist between tentacles layers
jfl_outer_twist=36;
//oral arms length (keep this in 0 to 10 range)
jfl_inner_length=7;
//oral arm numbers per layer 0 for none, (keep this in 0 to 4 range)
jfl_inner_num=2;
//oral arms twist between layers nice values (number,twist) (1&2&3&4,33), (2,46)
jfl_inner_twist=46;
//oral arms RATIO ZERO TO ONE! how far up the bottom of the bell do we keep making oral arms? MUST BE BETWEEN 0 AND 1
jfl_inner_ratio=.7;


/* [advanced parameters] */
//pointy parts on the base so you do not have to add brim
stigma=1;//[0:no,1:yes]
//Stigma layer symmetry (keep this in 3 to 9 range)
stig_number=5;
//Stigma radius, (keep this in 0 to 10 range)
stig_radius=7;
//Stigma width at base, keep small (keep this in 0 to 4 range)
stig_width=2;
//Stigma height (keep this in 0 to 4 range)
stig_height=2;
//drooloop width - match with slicer wall width setting you will use
dl_width=0.8;
//drooloop height - match with slicer layers setting you will use
dl_height=0.2;


/* [hidden] */

//let's make some drooloop jellies!!!!
//make the bell
translate([0,0,jfl_outer_length-jfl_outer_drag])
jfbody45(jf_radius,jf_height,jf_support_radius);

//add support cylinder for oral arms
cylinder(r=jf_support_radius,h=jfl_outer_length-jfl_outer_drag-(jf_radius-jf_support_radius-0.1)+0.3,$fn=50);//add 0.3 to be sure no holes

//add base legs so you don't have to print with brim
if (stigma==1){
stigma(stig_number,stig_radius,stig_width,stig_height);
}

//adding oral arms part 1 - just cover the support
drooloops(jfl_inner_num,jfl_inner_twist,jf_support_radius,jf_support_radius,jfl_inner_length,jfl_inner_length,jfl_inner_length/2,jfl_outer_length-jfl_outer_drag-(jf_radius-jf_support_radius-0.1),dl_width,dl_height);//cover support

//adding oral arms part 2 - go up bell's under side (the 45 degree part) BUT only as far as jfl_inner_ratio says
drooloops(jfl_inner_num,jfl_inner_twist,jf_support_radius,jf_radius*jfl_inner_ratio,jfl_inner_length,jfl_inner_length,jfl_outer_length-jfl_outer_drag-(jf_radius-jf_support_radius-0.1),jfl_outer_length-jfl_outer_drag-(jf_radius-jf_support_radius-0.1)*(1-jfl_inner_ratio),dl_width,dl_height);

//adding the tentacles
drooloops(jfl_outer_num,jfl_outer_twist,jf_radius,jf_radius,jfl_outer_length,jfl_outer_length,jfl_outer_length-jfl_outer_drag+0.4,jfl_outer_length-jfl_outer_drag+0.4,dl_width,dl_height);
//that's it! we're done the rest is just modules


//!jfbody45(jf_radius,jf_height,jf_support_radius);//uncomment for testing
//*****module 45 min angle jellyfishbody**********************************************
//NOTE TO USERS - I left $fn=50 since rendering can take a long time on web, feel free to increase for at home use!
module jfbody45(jf_r,jf_h,jf_s_r) {
hull() {
difference(){
scale([1,1,jf_h/jf_r])sphere(jf_r,$fn=50);//making $fn=100 will make smoother jellies
translate([0,0,-jf_r*1.1])cylinder(r=jf_r*1.1,jf_r*1.1);
}//end top difference
translate([0,0,-(jf_r-jf_s_r-0.1)])cylinder(r=jf_s_r,h=.1,$fn=50);//making $fn=100 will make smoother jellies
}//end hull
//make pattern
translate([0,0,0.4]) union(){//added 0.4 for pattern to show
difference(){//diff1 start
for (i=[0:4]) {//loop start
rotate ([0,0,i*360/4])
translate([0,jf_radius/2,0])
ovaltube(jf_r*1.2,jf_r*0.2,jf_r*0.4,jf_r*0.05,center=false,$fn=50);
}//loop end
difference(){//diif2 start
cube(jf_radius*3,center=true);
scale([1,1,jf_h/jf_r])sphere(jf_r,$fn=50);//making $fn=100 will make smoother jellies
}//diff2 end
}//diff1 end
}//unino end
}//module end
//end module******************************************************

//drooloops(dl_number,dl_twist,dl_l_radius,dl_u_radius,dl_l_lenght,dl_u_lenght,dl_s_height,dl_e_height,dl_width,dl_height);//uncomment for testing
//*******module drooloops***************************************************
module drooloops(dl_n,dr_t,dl_l_r,dl_u_r,dl_l_l,dl_u_l,dl_s_h,dl_e_h,dl_w,dl_h) {
dl_vnum=(dl_e_h-dl_s_h)/dl_h;// total numnber of petal vertical layers
dl_v_count=dl_vnum-1;// for loop 
dl_l_step=(dl_u_l-dl_l_l)/dl_v_count;//per layer drooloop length steps
dl_r_step=(dl_u_r-dl_l_r)/dl_v_count;//per layer center raduis displacement
for (j=[0:dl_v_count]) {//drooploop horizontal layers
	rotate([0,0,j*dr_t]) translate([0,0,dl_s_h+j*dl_h]) 
		for (i=[1:dl_n]) {//single petal layer
			rotate ([0,0,i*360/dl_n])
   		translate([0,dl_l_r+dl_r_step*j-1,0])
			rotate ([0,0,90])//straight out always
			color ("blue")
			petal(dl_l_l+dl_l_step*j,dl_w,dl_h);
		}//end i single petal layer
} //end j horizontal layers
}//end module***************************************************

//petal(20,.8,.2);//uncomment and use ! for testing****************        
module petal(p_l,p_w,p_h) {
union() {
cube([p_l,p_w,p_h]);//petal shaft
translate([p_l,p_w/2,0]) cylinder(r=p_w/2,p_h);//petal smooth tip
}//end union
}//end module petal*********************************************

// !stigma(1,10,2,5);//uncomment and use ! for testing****************        
module stigma(s_n,s_r,s_w,s_h) {//(number,radius,width,height)
stig_points=[ [s_r,0,0],[0,-s_w,0],[0,s_w,0], // the three points at base
           [0,0,s_h]  ];                      		   // the apex point
stig_triangles=[ [0,1,3],[1,2,3],[2,0,3],          // each triangle side
              [0,2,1] ];               			 // one triangle base
for (i=[1:s_n])     {
rotate([0,0,i*(360/s_n)]) polyhedron(stig_points,stig_triangles);
			}
}//end module stigma*********************************************

module ovaltube(height, rx, ry, wall, center = false) {
  difference() {
    scale([1, ry/rx, 1]) cylinder(h=height, r=rx, center=center);
    scale([(rx-wall)/rx, (ry-wall)/rx, 1]) cylinder(h=height, r=rx, center=center);
  }
}


