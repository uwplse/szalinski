//loopy flower creator - deliberatly printing in the air!
//mark peeters DEC 29, 2013
//You may want to turn off fans once the petals start printing, unless you like the blown effect
//more details are posted here: http://
// preview[view:south, tilt:bottom diagonal]

/* [flower center parameters] */

//the flower is upside down when modeled and printed
// Petal layer symmetry
p_number=4; //[1:16]
// Twist angle between each petal layer..  good pair values for (p_number,twist) are (8,26),(7&8&9,33),(3&4&5&6,42),(4&5,46) more fun angles (26.832,32.863,37.947,42.426,46.476,50.2,53.666)
twist=33;
// Flower center cylinder lower radius(remember printing upside down)
plower_radius=2.5;
// Flower center cylinder top radius(remember printing upside down)
ptop_radius=2.5;
// radius for area sticking to bed-! DO NOT MAKE rc>plower_radius - ALSO if using stigma this can be small
rc=2.5;

/* [petal parameters] */
// Flower total height
total_height=20;
// Petals start at this height, for spherical center set equal to "plower_radius" 
p_start_height=15;
//petal lenght lower layer (remember printing upside down)
p_lenght_lower=30;
//petal lenght top layer (remember printing upside down)
p_lenght_top=40;

/* [Stigma parameters] */
//the stimga is the pointy parts on the end of the Pistil, yes for Pistil, No if doing a disk/spherical type center
stigma=1;//[0:no,1:yes]
//Stigma layer symmetry
stig_number=5;//[2:12]
//Stigma radius, make >plower_radius or it will not show
stig_radius=5;
//Stigma width at base, keep small
stig_width=2;
//Stigma height OR how far up the Style will it go?(remember printing upside down)
stig_height=8;

/* [advanced parameters] */
//petal width, - SET TO THE SLICE WALL VALUE that you will use.(I like 0.8mm and ignore nozzle, it seems to work well for both 0.4mm and 0.35mm nozzles I use, and makes the inside of the flower two passes, zero infill, no top)
p_width=.8;
//petal height - SET TO THE SLICE LAYER VALUE that you will use. (I LIKE 0.2mm, i want a good string coming out when printing in air. if you see petals dissapear in gcode/layer previews, make this value a bit bigger like 0.11mm for slicing at 0.1mm or 0.21mm if slicing at 0.2mm)
p_height=.2;
//petal angle at cylinder surface, 90 is straight out 180 tangent.
p_angle=90;
//Turning direction.
direction=-1;//[-1:counterclockwise,1:clockwise]

/* [hidden] */

//CALULATED VALUES
p_vnum=(total_height-p_start_height)/p_height;// total numnber of petal vertical layers
p_vertical_count=p_vnum-1;// for loop 
p_length_step=(p_lenght_top-p_lenght_lower)/p_vertical_count;//per layer petal length steps
p_raduis_step=(ptop_radius-plower_radius)/p_vertical_count;//per layer petal displacement , gotta keep this shit together you know
hdown=plower_radius-sqrt(plower_radius*plower_radius-rc*rc);//height needed to get proper area for bed sticking , it's a "spherical cap" calculation based on rc&rs


//****flower center-pistil*********************************
//hull just insures smooth transtion from sticking area if you make p_start_height<plower_radius, other wise it's not really needed 
hull () {    //start hull
difference() {   //start ovary (more or less)
translate([0,0,plower_radius-hdown]) sphere(plower_radius,$fn=50);//flower center sphere
translate([-rc,-rc,-rc*2]) cube(rc*2);//remove bottom to get desired rc area sticking to bed
translate([0,0,plower_radius*2]) cube(plower_radius*2,center=true);//trim top of sphere
			} //end ovary
translate([0,0,p_start_height])
cylinder($fn=100,r1=plower_radius,r2=ptop_radius,total_height-p_start_height);//core base for petal section
			}//end hull
if (stigma==1){
stigma(stig_number,stig_radius,stig_width,stig_height);
}
//*****end flower center-pistil*************************

//****flower assemble petals*********************************
for (j=[0:p_vertical_count]) {//petal horizontal layers
	rotate([0,0,j*twist]) translate([0,0,p_start_height+j*p_height]) 
		for (i=[1:p_number]) {//single petal layer
			rotate ([0,0,i*360/p_number])
   		translate([0,plower_radius+p_raduis_step*j-1,0])
			rotate ([0,0,p_angle])
			color ("blue")
			petal(p_lenght_lower+p_length_step*j,p_width,p_height);
		}//end i single petal layer
} //end j horizontal layers

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
