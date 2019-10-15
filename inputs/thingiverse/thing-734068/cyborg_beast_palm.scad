//Nathaniel Stenzel's attempt to clone the Cyborg Beast palm in openscad.

detail=40; //[20:80]
fine_detail=80; //[40:120]
make_digit_1=true; //[true:Yes,false:No]
make_digit_2=true; //[true:Yes,false:No]
make_digit_3=true; //[true:Yes,false:No]
make_digit_4=true; //[true:Yes,false:No]
make_digit_5=true; //[true:Yes,false:No]
palm_width_scale=100;//[50:150]
palm_length_scale=100;//[50:150]
palm_height_scale=100;//[50:150]
scale_the_screw_holes=true;//[true:Yes,false:No]

module line(point_a,point_b,diameter){
    hull(){
    translate(point_a)sphere(d=diameter);
    translate(point_b)sphere(d=diameter);
    }
}

module scaled_line(point_a,point_b,diameter,line_scale=[1,1,1]){
    scaled_a = [point_a[0]*line_scale[0], point_a[1]*line_scale[1], point_a[2]*line_scale[2]];
    scaled_b = [point_b[0]*line_scale[0], point_b[1]*line_scale[1], point_b[2]*line_scale[2]];
    line(scaled_a,scaled_b,diameter);
}

module pinky_side_wrist_joint(scale,scale_wrist_screws=true){
    scalex=scale[0];
    scaley=scale[1];
    scalez=scale[2];
	difference(){
		hull(){
		translate([-30.5*scalex,50*scaley,-22*scalez])cube([2,10*scaley,10*scalez]);
		translate([-29.5*scalex,20*scaley,-22*scalez])cube([2,20,1]);
		translate([-30.5*scalex,66*scaley,-17*scalez])rotate([0,90,0])cylinder(d=10*scalex,h=3);
		}
		if(scale_wrist_screws==true)translate([-34*scalex,64.8*scaley,-17.3*scalez])rotate([0,90,0])cylinder(d=5*scalex,h=8*scalex);
                if(scale_wrist_screws==false)translate([-34*scalex,64.8*scaley,-17.3*scalez])rotate([0,90,0])cylinder(d=5,h=8*scalex);
	}
}

module thumb_side_wrist_joint(scale,scale_wrist_screws=true){
    scalex=scale[0];
    scaley=scale[1];
    scalez=scale[2];
	difference(){
		hull(){
		translate([22.5*scalex,46*scaley,-22*scalez])cube([2,21*scaley,10*scalez]);
		translate([22*scalex,66*scaley,-17*scalez])rotate([0,90,0])cylinder(d=10*scalex,h=3);
		}
                if(scale_wrist_screws==true)translate([21*scalex,65*scaley,-17.3*scalez])rotate([0,90,0])cylinder(d=5*scalex,h=8);
                if(scale_wrist_screws==false)translate([21*scalex,65*scaley,-17.3*scalez])rotate([0,90,0])cylinder(d=5,h=8);
	}
}

module palm(digits=[true,true,true,true,true],scale=[1,1,1],scale_screws=true){
    scalex=scale[0];
    scaley=scale[1];
    scalez=scale[2];
	difference(){
		union(){
			if (digits[0]){
				echo("thumb");
				thumb_side_wrist_joint(scale,scale_wrist_screws=scale_screws);
                                translate([28*scalex,56*scaley,-11*scalez])rotate([230,-2,-2])scale([scalex,scalex,scalex])thumb_mount(scalex);
			}
			pinky_side_wrist_joint(scale,scale_wrist_screws=scale_screws);
			scale(scale)hull(){
                            translate([-12.2,54,8])cube([21,8,5]);//wire block
                            translate([-12.2,54,8])cube([21,8,2]);
                            translate([-30.2,10,-19])cube([55.2,4,2]);
                            translate([-3,46,-18])sphere(d=55,$fn=fine_detail);
                            translate([-2.8,60,-15])rotate([87,0,0])cylinder(h=10,d=55.5,$fn=fine_detail);
			}//end of hull
			scale([scalex,scalex,scalex])translate([-28.2,9,-22])cube([51.2,18,11]);//block over fingers
                       scale([scalex,scalex,scalex])translate([-30.2,10,-18])rotate([0,90,0])cylinder(d=8,h=55.2);//knockle cylinder
		}//end of union	

		//finger knuckle gaps
                scale([scalex,scalex,scalex]){
                    translate([-26.3,10,-20])rotate([0,90,0])cylinder(d=16,h=4.8);
                    translate([-12.3,10,-20])rotate([0,90,0])cylinder(d=16,h=4.8);
                    translate([2.4,10,-20])rotate([0,90,0])cylinder(d=16,h=4.8);
                    translate([16.3,10,-20])rotate([0,90,0])cylinder(d=16,h=4.8);
                    //finger knuckle axel hole
                    if(scale_screws==true)translate([-35,10.5,-18])rotate([0,90,0])cylinder(d=4,h=66);
                }
                //finger knuckle axel hole
                if(scale_screws==false)scale([scalex,1,1])translate([-35,10.5*scalex,-18*scalex])rotate([0,90,0])cylinder(d=4,h=66);
		scale(scale)hull(){ //make room for the flesh
			translate([-7,45,-17])sphere(d=42);
			translate([1,45,-17])sphere(d=42);
			translate([-13,35,-20])sphere(d=30);
			translate([7.5,35,-20])sphere(d=30);
			translate([-3,65,-17])sphere(d=51);
		}
		//make room for more thumbs and fingers
                scale(scale)union(){
		if(digits[4] == false){
                    translate([-25.7,30,-20])rotate([90,0,0])cylinder(d=15,h=30);
                    translate([-35.7,22,-21])rotate([0,90,0])cylinder(d=15,h=20);
                }
		if(digits[3] == false){
                    translate([-10,30,-20])rotate([90,0,0])cylinder(d=14,h=30);
                    translate([-25,22,-21])rotate([0,90,0])cylinder(d=15,h=25);
                }
		if(digits[2] == false){
                    translate([5.4,30,-20])rotate([90,0,0])cylinder(d=14,h=30);
                    translate([-4.6,22,-21])rotate([0,90,0])cylinder(d=15,h=25);
                }
		if(digits[1] == false){
                    translate([21,30,-20])rotate([90,0,0])cylinder(d=15,h=30);
                    translate([11,22,-21])rotate([0,90,0])cylinder(d=15,h=25);
                }
		if(digits[0] == false) translate([20,59,-20])sphere(d=30);
		translate([-62,0,-57])cube([130,130,35]);
		translate([0,100,-10])sphere(d=74);
                }
                
		//translate([-30,10,-10])rotate([35,0,0])cube([60,40,10]);
		translate([-2*scalex,34*scaley,-10])cylinder(d=5*scalex,h=20*scalez);//1st big hole
		//translate([16,48*scaley,-10])cylinder(d=5,h=20);//2nd big hole
		//elastic tie down spots for the fingers
		translate([-24*scalex,13*scaley,-22])rotate([0,0,0])cylinder(d=2,h=20);
		translate([-10*scalex,13*scaley,-22])rotate([0,0,0])cylinder(d=2,h=20);
		translate([5*scalex,13*scaley,-22])rotate([0,0,0])cylinder(d=2,h=20);
		translate([18*scalex,13*scaley,-22])rotate([0,0,0])cylinder(d=2,h=20);
		//5 holes near wrist through the top for finger wires
                scaled_line([-13.5,48,10],[-7.5,68,11],2,line_scale=scale);//digit 5(pinky) wire
                scaled_line([-5.5,48,11],[-5,68,11],2,line_scale=scale);//digit 4 wire
                scaled_line([1.5,48,11],[-2,68,11],2,line_scale=scale);//digit 3 wire
                scaled_line([8,48,11],[1.5,68,11],2,line_scale=scale);//digit 2 wire
                scaled_line([10,58.6,11], [4,68,11], 2,line_scale=scale);//digit 1(thumb)wire
		//thumb wire groove
                scaled_line([10,58.6,11.1], [17,57.3,4], 2,line_scale=scale);
                scaled_line([17,57.6,6], [23,56,-6], 2,line_scale=scale);
		//4 grooves for finger wires
                scaled_line([-23.8,20,-9],[-13.5,48,13],2,line_scale=scale);//digit 5(pinky) wire
                scaled_line([-23.8,21,-7],[-13.5,48,10],2,line_scale=scale);//digit 5(pinky) wire
                scaled_line([-10,23,-2],[-5,48,17],2,line_scale=scale);//digit 4 wire
                scaled_line([-10,20,3],[-5.5,48,11],2,line_scale=scale);//digit 4 wire
                scaled_line([5,21.7,-4],[1.5,48,17],2,line_scale=scale);//digit 3 wire
                scaled_line([5,21.7,2],[1.5,48,11],2,line_scale=scale);//digit 3 wire
                scaled_line([18,21,-9],[8,48,13],2,line_scale=scale);//digit 2 wire
                scaled_line([18,21,-7],[8,48,11],2,line_scale=scale);//digit 2 wire
		//4 holes near fingers through the top for finger wires
                scaled_line([-23.8,25,5],[-23.8,15,-25],,2,line_scale=scale);//digit 5(pinky) wire
                scaled_line([-10,25,5],[-10,15,-25],2,line_scale=scale);//digit 4 wire
                scaled_line([5,25,5],[5,15,-25],2,line_scale=scale);//digit 3 wire
                scaled_line([18,25,5],[18,15,-25],2,line_scale=scale);//digit 2 wire
	}
	echo(digits);
}


module thumb_mount(scale,scale_thumb_screws=true){
	difference(){
		hull(){
			translate([-8,-7,-10])cube([1,1,10.5]);
			translate([0,0,-10])cylinder(d=7,h=10.5);
			translate([0,0,-10])cylinder(d=7,h=10.5);
			translate([10,10.5,-10])cylinder(d=12,h=10.5);
			translate([-5,-6,-10])cube([1,22,10.5]);
		}
		hull(){
			translate([0,0,-8.3])cube([1,40,7]);
			translate([10,16,-8.3])cube([15,1,7]);
		}
		translate([4,2.7,-14])cylinder(d=3,h=20);
		translate([10,10.5,-14])cylinder(d=3,h=20);//this one is the thumb knuckle axle hole
		translate([0,0,-14])cylinder(d=3,h=116);
		translate([0,20,-4.5])rotate([90,0,-10])cylinder(d=3,h=30);
	}
}

palm(digits=[make_digit_1,make_digit_2,make_digit_3,make_digit_4,make_digit_5],$fn=detail,scale=[palm_width_scale/100,palm_length_scale/100,palm_height_scale/100],scale_screws=scale_the_screw_holes);
//palm(digits=[true,true,true,true,true],$fn=detail);//,scale=[1.60,1.80,1.60],scale_screws=false);//color("red")translate([0, 0, 0])rotate([0, 0, 0])translate([-0.0, -0.0, 0]) import("R palm.stl");
