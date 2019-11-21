//how many sides the bottle will have
resolution = 48;//[12,24,36,48,96]

//how many sides the bottle will have
sides = 48;//[3,4,5,6,7,8,12,24,48:Round]

//height of the bottle, in mm
total_bottle_height = 90;//[20:320]

//radius of the rounding on the shoulders of the bottle
shoulder_roundedness = 10;//[3:30]

//diameter of the bottle, in mm
bottle_width = 60;//[35:120]

//change the bottom. A positive value will increase the bottle's total diameter.
bottom_weight = 0; //[-30:30]

//radius of curve on the bottom
rounded_bottom_radius = 6; //[.1:15]

//total height of the neck
neck_height = 26;//[19:40]

//mouth diameter, should be smaller than bottle width
opening_diameter = 40;//[16:70]

//neck finish, this decides what caps can fit
threads = 9; //[4:400(1 Thread Turn), 9:415(2 Thread Turns)]

//ooblong proportions
ooblong_weight = 0;//[0:10]

//Cap
cap = 1;//[1:Yes, 0:No]



ooblong = 1-(ooblong_weight/20);
radius1 = shoulder_roundedness;
bottle_height= total_bottle_height - neck_height;
$fn= resolution;
width2 = bottle_width +  bottom_weight;
height1 = bottle_height;
neck_radius = opening_diameter/2;





difference(){
scale([1,ooblong,1])
rotate_extrude(convexity = 20, $fn=sides){
translate([0, 0, 0])
difference(){
		hull(){
			translate([(width2/2)-rounded_bottom_radius, rounded_bottom_radius, 0])
				circle(r = rounded_bottom_radius);

					translate([(bottle_width/2)-radius1, height1-(radius1*1), 0])
						difference(){
							circle(r = radius1, $fn = 100);
							translate([-3*radius1,-1.5*radius1])
								square([3*radius1,3*radius1]);
						};


			translate([0, 0, 0])
				square([opening_diameter/2, bottle_height]);
		}
translate([-bottle_height, -bottle_height/2, -20])
	cube([bottle_height, bottle_height*2, 40]);
}
	}
	translate([0, 0, bottle_height-2])
	cylinder(r=opening_diameter/2 - 2, h=neck_height,center=true);
	scale([.95,.95,.95])
	translate([0, 0, 2])
	scale([1,ooblong,1])
	rotate_extrude(convexity = 20, $fn=sides){
		hull(){
			translate([(width2/2)-rounded_bottom_radius, rounded_bottom_radius, 0])
			circle(r = rounded_bottom_radius);

					translate([(bottle_width/2)-radius1, height1-radius1, 0])
						difference(){
							circle(r = radius1);
							translate([-3*radius1,-1.5*radius1])
								square([3*radius1,3*radius1]);
						};

			translate([0, 0, -5])
			square([opening_diameter/2, bottle_height]);
		}
	}
}

translate([0,0,bottle_height])
difference(){
	union(){
//neck threads	
		translate([0,0,neck_height-threads-3])
		thread(5,opening_diameter+3,threads,10);
		translate([0,0,neck_height/2-1])
		cylinder(r=opening_diameter/2 - .5, h=neck_height+2,center=true);
	}
	translate([0,0,neck_height/2])
	cylinder(r=opening_diameter/2 - 2, h=neck_height+21,center=true);

}
//ring at bottom of neck
translate([0,0,bottle_height+neck_height-threads-7])
rotate_extrude(convexity = 10)
translate([opening_diameter/2, 0, 0])
circle(r = 2);









if(cap==1){
//cap
if(threads == 9){
translate([(bottle_width/2)+opening_diameter+bottom_weight+15,0,17.5])
rotate([0,180,0])
difference(){
	translate([0,0,2.5])
	cylinder(r=opening_diameter/2 + 3.5, h=15);
	union(){
		translate([0,0,2.5])
		thread(5,opening_diameter+4.5,threads,10);
		cylinder(r=opening_diameter/2 +0, h=14.5);
		}

	}
}


if(threads == 4){
translate([(bottle_width/2)+opening_diameter+bottom_weight+15,0,19.5])
rotate([0,180,0])
difference(){
	translate([0,0,2.5])
	cylinder(r=opening_diameter/2 + 4, h=10);
	union(){
		translate([0,0,2.5])
		thread(5,opening_diameter+5,threads,10);
		cylinder(r=opening_diameter/2 + .5, h=10);
			}

		}
	}
}















module screwthread_triangle(P) {
	difference() {
		translate([-sqrt(3)/3*P+sqrt(3)/2*P/8,0,0])
		rotate([90,0,0])
		cylinder(r=sqrt(3)/3*P,h=0.00001,$fn=3,center=true);

		translate([0,-P/2,-P/2])
		cube([P,P,P]);
	}
}
module screwthread_onerotation(P,D_maj,step) {
	H = sqrt(3)/2*P;
	D_min = D_maj - 5*sqrt(3)/8*P;

	for(i=[0:step:360-step])
	hull()
		for(j = [0,step])
		rotate([0,0,(i+j)])
		translate([D_maj/2,0,(i+j)/360*P])
		screwthread_triangle(P);
}
module thread(P,D,h,step) {
	for(i=[0:h/P])
	translate([0,0,i*P])
	screwthread_onerotation(P,D,step);
}







