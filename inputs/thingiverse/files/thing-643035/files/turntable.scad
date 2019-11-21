$fa=3;




main_radius=48;
inter_plates=1;
top_plate_height=5;
bottom_plate_height=5;
skirt_height=4;
skirt_thickness=1.2;
skirt_space=1;
ball_radius=3;
//groove radii
gradii=[40,30,20];

//screw home radius
r_screwhole=1;
screwhead=4;


//skirt thickness
skirt_thickness=1.2;
//space between inner wall of the skirt and bottom plate's outer wall
skirt_spacing=1;

//check 
//~ translate([0,0,-(bfloor+tfloor+br*2)/2])cylinder(r=10,h=bfloor+tfloor+br*2);

//anti coplanar csg
epsilon=0.1;

module torus(tradius,cradius){
	rotate_extrude(convexity = 10)
		translate([tradius, 0, 0])
			circle(r = cradius,$fs=1);
	}

module grooves(br){
	for(ir=gradii) {torus(ir,br);}
	}
	
module plate(pr,ph,ip,br){
	difference(){
		cylinder(r=pr,h=ph);
		translate([0,0,ph+ip/2]) grooves(br);
		}
	}

	
	
	
module skirt(or,tk,ht){
	difference(){
		cylinder(r=or,h=ht);
		translate([0,0,-epsilon])cylinder(r=or-tk,h=ht+epsilon*2);
		}
	}

	
module bot_plate(pr,ph,ip,br){
	difference() {
		plate(pr,ph,ip,br);
		//trou / cylindre plein pour recevoir la vis
		union()
			{
			translate([0,0,-ph])cylinder(r=r_screwhole,h=ph*3);
			translate([0,0,-screwhead/2])sphere(r=screwhead);
			}
		}
	
	}	
	
	
module top_plate(pr,ph,sh,st,ip,br){
	difference() {
		union() {
			plate(pr,ph,ip,br);
			translate([0,0,ph]) skirt(pr,st,sh);
			}
		//trou / cylindre plein pour recevoir la vis
		translate([0,0,ph*0.3])cylinder(r=r_screwhole,h=ph);
		}
	
	}
	
module plateau(	mr,ip,tph,bph,sh,st,sp,br)
	{
	bot_plate(mr-st-sp,bph,ip,br);		//bottom plate
	translate([0,0,tph+bph+ip]) 	//top plate
		rotate([180,0,0]) top_plate(mr,tph,sh,st,ip,br);
	}
	
module parts(	mr,ip,tph,bph,sh,st,sp,br)
	{
	translate([sqrt(2*mr*mr)+1,sqrt(2*mr*mr)+1,0]) 	
	bot_plate(mr-st-sp,bph,ip,br);		//bottom plate
	
		//~ rotate([180,0,0]) 
		top_plate(mr,tph,sh,st,ip,br);
	}



difference() //cross cut
{

//~ plateau(main_radius,inter_plates,top_plate_height,bottom_plate_height,skirt_height,skirt_thickness,skirt_space,ball_radius);
parts(main_radius,inter_plates,top_plate_height,bottom_plate_height,skirt_height,skirt_thickness,skirt_space,ball_radius);

//~ translate([0,0,-main_radius])cube(main_radius*2);
}// </cross cut>