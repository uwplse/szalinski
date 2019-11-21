use <text_on/text_on.scad>

type = 1; // [1:Circle, 2:Arc, 3:5x1, 4:3x2]
// coin holder height
height=25;
// Hall below coins
base_hall = 0; // [1:Yes, 0:No]
//Number indicators
base_numbers = 1 ;// [1:Yes, 0:No]
//Base Height
base_h = 2;
//Base extend
base_xtnd = 2;

/* [Hidden] */
$fn=100;
walls = 2.8;
coin2_d = 25.75+1; //2 euro dia 25.75
coin2_h = height; //h 2.20

coin1_d = 23.35+1; //1 euro dia 23.35
coin1_h = height; //h 2.33

coin50_d = 24.25+1; //0.50 euro dia 24.25
coin50_h = height; //h 2.38

coin20_d = 22.75+1; //0.20 euro dia 22.75
coin20_h = height; //h 2.14

coin10_d = 19.75+1; //0.10 eur dia 19.75
coin10_h = height; //h 1.93

difference(){
	coinholders();
	hallopenings();
}

module coinholders(){
	if (type == 1){
		//circle
		rotate([0,0,90+54.69])coinHolder(coin2_d,coin2_h,2);
		translate([-7.76-1,26.24+1,0])rotate([0,0,68.25])coinHolder(coin1_d,coin1_h,1);
		translate([15.5,40.5,0])rotate([0,0,-5.75])coinHolder(coin50_d,coin50_h,0.5);
		translate([36.5,23,0])rotate([0,0,-78.78])coinHolder(coin20_d,coin20_h,0.2);
		translate([27.5,-0.5,0])rotate([0,0,215.29])coinHolder(coin10_d,coin10_h,0.1);
		translate([14,18.3])cylinder(d=23,h=2);
	}
	else if (type == 2){
		//arc
		rotate([0,0,180-52,16])coinHolder(coin2_d,coin2_h,2);
		translate([-6.71-1,26.57+1,0])rotate([0,0,180-52.16-47.33])coinHolder(coin1_d,coin1_h,1);
		translate([7.59+1,49.04+1,0])rotate([0,0,180-52.16-47.33-45.93])coinHolder(coin50_d,coin50_h,0.5);
		translate([33.36+2,54.46,0])rotate([0,0,180-52.16-47.33-45.93-45.38])coinHolder(coin20_d,coin20_h,0.2);
		translate([53.91+2,41.87-2,0])rotate([0,0,-52.16])coinHolder(coin10_d,coin10_h,0.1);
	}
	else if (type == 3){
		//5x1
		coinHolder(coin2_d,coin2_h,2);
		translate([coin2_d/2+coin1_d/2+walls,0,0])coinHolder(coin1_d,coin1_h,1);
		translate([coin2_d/2+coin1_d+coin50_d/2+walls*2,0,0])coinHolder(coin50_d,coin50_h,0.5);
		translate([coin2_d/2+coin1_d+coin50_d+coin20_d/2+walls*3,0,0])coinHolder(coin20_d,coin20_h,0.2);
		translate([coin2_d/2+coin1_d+coin50_d+coin20_d+coin10_d/2+walls*4,0,0])coinHolder(coin10_d,coin10_h,0.1);

	}
	else{
		// 3x2
		coinHolder(coin2_d,coin2_h,2);
		translate([coin2_d/2+coin1_d/2+walls,0,0])coinHolder(coin1_d,coin1_h,1);
		translate([coin2_d/2+coin1_d+coin50_d/2+walls*2,0,0])coinHolder(coin50_d,coin50_h,0.5);
		translate([(coin2_d/2+coin1_d/2+walls)/2+1.8,coin20_d/2+12.5,0])coinHolder(coin20_d,coin20_h,0.2);
		translate([coin2_d/2+coin1_d/2+walls+coin50_d/2+walls/4+0.2,coin10_d/2+12,0])coinHolder(coin10_d,coin10_h,0.1);
	}
}

module hallopenings(){
	if (type == 1){
		//circle
		rotate([0,0,90+54.69])hallopening(coin2_d,coin2_h);
		translate([-7.76-1,26.24+1,0])rotate([0,0,68.25])hallopening(coin1_d,coin1_h);
		translate([15.5,40.5,0])rotate([0,0,-5.75])hallopening(coin50_d,coin50_h);
		translate([36.5,23,0])rotate([0,0,-78.78])hallopening(coin20_d,coin20_h);
		translate([27.5,-0.5,0])rotate([0,0,215.29])hallopening(coin10_d,coin10_h);
		translate([14,18.3,-0.1])cylinder(d=16,h=2.1);
		hull(){
			translate([14,18.3,2-1])cylinder(d=16,h=1);
			translate([14,18.3,2])cylinder(d=18,h=1);
		}
	}	

	else if (type == 2){
		//arc
		rotate([0,0,180-52,16])hallopening(coin2_d,coin2_h);
		translate([-6.71-1,26.57+1,0])rotate([0,0,180-52.16-47.33])hallopening(coin1_d,coin1_h);
		translate([7.59+1,49.04+1,0])rotate([0,0,180-52.16-47.33-45.93])hallopening(coin50_d,coin50_h);
		translate([33.36+2,54.46,0])rotate([0,0,180-52.16-47.33-45.93-45.38])hallopening(coin20_d,coin20_h);
		translate([53.91+2,41.87-2,0])rotate([0,0,-52.16])hallopening(coin10_d,coin10_h);
	}

	else if (type == 3){
		//5x1
		hallopening(coin2_d,coin2_h);
		translate([coin2_d/2+coin1_d/2+walls,0,0])hallopening(coin1_d,coin1_h);
		translate([coin2_d/2+coin1_d+coin50_d/2+walls*2,0,0])hallopening(coin50_d,coin50_h);
		translate([coin2_d/2+coin1_d+coin50_d+coin20_d/2+walls*3,0,0])hallopening(coin20_d,coin20_h);
		translate([coin2_d/2+coin1_d+coin50_d+coin20_d+coin10_d/2+walls*4,0,0])hallopening(coin10_d,coin10_h);

	}
	else{
		// 3x2
		hallopening(coin2_d,coin2_h,2);
		translate([coin2_d/2+coin1_d/2+walls,0,0])hallopening(coin1_d,coin1_h,1);
		translate([coin2_d/2+coin1_d+coin50_d/2+walls*2,0,0])hallopening(coin50_d,coin50_h,50);
		translate([(coin2_d/2+coin1_d/2+walls)/2+1.8,coin20_d/2+12.5,0])hallopening(coin20_d,coin20_h,20);
		translate([coin2_d/2+coin1_d/2+walls+coin50_d/2+walls/4+0.2,coin10_d/2+12,0])hallopening(coin10_d,coin10_h,10);
	}
}

module coinHolder(diam,height,coin){
	opening = diam*3.14*20/100;
	cut_point_X = (opening/2) + ((opening/2)*(walls/2)/(diam/2));
	cut_point_Y = (sqrt(pow(diam/2,2)-pow(opening/2,2))) + (sqrt(pow(diam/2,2)-pow(opening/2,2))*(walls/2)/(diam/2));
	f_corn = atan(cut_point_X/cut_point_Y);
	difference(){
		union(){
			difference(){
				union(){
					cylinder(d=diam+walls*2, h=height+base_h);
					hull(){
						cylinder(d=diam+walls*2+base_xtnd*2, h=base_h-1);
						translate([0,0,base_h-1])cylinder(d=diam+walls*2+base_xtnd*2-2, h=1);
					}
				}
				//opening
				translate([-opening/2,-diam/2-walls,base_h])cube([opening,diam+walls*2,height+0.1]);
				rotate([0,0,f_corn])translate([0,0,base_h])cube([opening/2,30,height+0.1]);
				rotate([0,0,-f_corn])translate([-opening/2,0,base_h])cube([opening/2,30,height+0.1]);
				rotate([0,0,f_corn+180])translate([0,0,base_h])cube([opening/2,30,height+0.1]);
				rotate([0,0,-f_corn+180])translate([-opening/2,0,base_h])cube([opening/2,30,height+0.1]);
			}
			//opening roundings
			translate([cut_point_X,cut_point_Y,base_h])rotate([0,0,f_corn+45])cylinder(d=walls,h=height,$fn = 60);
			translate([cut_point_X,-cut_point_Y,base_h])rotate([0,0,f_corn+90])cylinder(d=walls,h=height,$fn=60);
			translate([-cut_point_X,cut_point_Y,base_h])rotate([0,0,f_corn+90])cylinder(d=walls,h=height,$fn=60);
			translate([-cut_point_X,-cut_point_Y,base_h])rotate([0,0,f_corn+45])cylinder(d=walls,h=height,$fn=60);
		}
		//coin hall
		translate([0,0,base_h])cylinder(d=diam,h=height+0.1);
		//bottom hall
		translate([0,0,-0.1])cylinder(d=diam-walls*2,h=base_h+0.1);
		hull(){
			translate([0,0,base_h-1])cylinder(d=diam-walls*2,h=1);
			translate([0,0,base_h])cylinder(d=diam-walls*2+2,h=1);
		}
	}
	//base
	if (!base_hall){
		difference(){
			cylinder(d=diam-walls*2,h=1);
			if (base_numbers){
				rotate([0,0,180])translate([0,0,1])text_extrude(str(coin),extrusion_height=0.6,size=6,font="Spin Cycle OT",center=true);	
			}
		}
	}
}

module hallopening(diam,height){
	hull(){
		translate([0,0,base_h+height-1])cylinder(d=diam,h=1);
		translate([0,0,base_h+height])cylinder(d=diam+2,h=1);
	}
}
