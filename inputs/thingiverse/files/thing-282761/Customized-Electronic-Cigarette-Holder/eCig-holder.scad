//Diameter of cigarette
cigarete_diameter = 24; //[10:30]

//Length of holder
holder_length = 70; //[40:100]

//Thikness of holder walls
wall_thikness = 1; //[1:3]

//Mount holes diameter
holes_diameter = 3.5; //[2:5]

// in n*wall_thikness
//angle_round = 3; //[1-6]


/*[Hidden]*/
ed=cigarete_diameter;
el=holder_length;
w=wall_thikness;
//dr=angle_round;

m4d = holes_diameter;


tw = ed+w*2;
tl = el+w*2;
dn_h = w*3;
up_h = w*6;
b_dpth = tw/2;


holder();


module shape5(){
	x1 = tw; 
	x2 = b_dpth;
	x3 = tw*2/3;
	r1 = x3-x2;
	r2 = r1/2;
	dr = (x3-x2)/2;
	r = r1;
	y1 = dn_h;
	y2 = tl/2;
	y4 = tl;
	union(){
		difference(){
			polygon(points=[
				[x1,y1],[x2+r,y1],[x2,y1+r],[x2,y2-r/2],[x3,y2+r/2],[x3,y4-r],[x2,y4],[x2,y4+1],[x1,y4+1]
				],path=[0,1,2,3,4,5,6,7,8]
			);
			translate([x2+r,y2-r+(r/2)/sqrt(2)-r/4])
				for(i=[0:5:45]){
					rotate([0,0,-i])
						translate([-r-r/4,0])
							square([r/2,r],true);
			}
			translate([x2,y4-r])
				circle(r, $fn=16);
		}
		translate([x2+r,y1+r])
			circle(r, $fn=16);
		for(i=[0:5:45]){
			translate([x3-r,y2+r-(r/2)/sqrt(2)+r/4])
				rotate([0,0,-i])
					translate([r+r/4,0])
						square([r/2,r],true);
		}
	}
}



module shape(){
//	hull()
	difference(){
		square([tw,tl]);
		shape2();
	}
}

module holder(){
	translate([0,-tw/4,0])
		difference(){
			union(){
				linear_extrude(height=tl, convexity = 2){
					square([tw,tw/2],true);
					translate([0,-tw/4])
						circle(r=tw/2);		
				}
				translate([-tw/2,tw/4,0])
					cube([tw,w,tl]);			
			}
			translate([0,-tw/4,w])
				cylinder(r=ed/2,h=tl);
	//		translate([-tw/2-1,-tw,w*3])
	//			#cube([tw+2,tw,tl*3/4]);
			rotate([90,0,-90])
				translate([-tw/4,0,-tw/2-1])
				linear_extrude(height=tw+2, convexity = 2)
					shape5();
			for(i=[tl/4,tl*3/4])
				translate([0,tw/4,i])
					rotate([90,0,0])
						hole(m4d);
			assign(lnth=ed-w)
			translate([-lnth/2,-tw*3/4,tl/3])
				cube([lnth,tw/2,tl*2/3+1]);
		}
}

module hole(diam){
	l1=w*5;
	l2=diam/2;
	l3=w*5;
	translate([0,0,-l1])
		cylinder(r=diam/2, h=l1+1, $fn=16);
	translate([0,0,0])
		cylinder(r1=diam/2, r2=diam, h=l2, $fn=16);
	translate([0,0,l2])
		cylinder(r=diam, h=l3, $fn=16);
}