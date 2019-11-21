
///////////////////////////////////////////////////////////////////////////////////
/////////Definition of user defined variables/////////////////////////////////

//What resolution should I render at?  Keep this low (8) for preview and high (25) for a final output.
resolution=8; //[5:25]

//What's the total height you want, minus any hair?
height=100;

//How far back should the head be tilted?  Around 40 makes for easier printing.
head_tilt=20; //[0:60]

//How wide should the top of the face be?
top_width= 4; //[1:10]

//How wide should the bottom of the face be?
bottom_width = 3; //[1:10]

//How thick should the neck be?
neck = 4; //[1:10]

//What type of hair does it have?
hair_type="average guy"; //[average guy,bald,bowl cut,bob,long,top bun,pony,buzz,fro,monster fro,male pattern,flattop]

//How long is the hair?  This only affects buzz, male pattern, flattop, mullet, and average guy cuts
hair_length = 5; //[1:15]

//What type of eyes should it have?
eye_type="eye roll";//[average,surprised,sleepy,eye roll]

//How big should the eyes be?
eye_size= 6; //[1:10]

//Are the eyes angled?
eye_angle=-8;//[-30:30]

//How far apart should the eyes be spaced?
eye_spacing=4; //[1:10]

//Does it wear glasses?
glasses="hipster"; //[none,hipster,circle,coke bottle]

//How thick are the eyebrows?
eyebrow_thickness=7;//[1:10]

//How long are the eyebrows?
eyebrow_length=7;//[1:10]

//How much are the eyebrows tilted?
eyebrow_tilt=15;//[-15:15]

//Does it have facial hair?
facial_hair="full beard";//[none,full beard,chin strap,goatee,stache,chops,soul patch]

//How long is the facial hair?
facial_hair_length=1;//[1:10]

//What type of nose should it have?
nose_type="average";//[pointy,upturned,high bridge,wide,average,button,piggy,clown]

//How big should the nose be?
nose_size=5; //[1:10]

//How wide should the nose be?
nose_width=5; //[1:10]

//How high on the face should the nose be?
nose_height=5;//[1:10]

//What type of mouth should it have?
mouth_type="agape"; //[agape,smiling,chiclet teeth,lipstick,half smile,um...,not feeling well,just stache,oh no]

//How big should the mouth be?
mouth_size=5; //[1:10]

//How high on the face should the mouth be?
mouth_height=7;//[1:10]

//What type of ears should it have?
ear_type="average"; //[average,monkey,long,pill shaped,viking horn]

//How big should the ears be?
ear_size=5; //[1:10]

//How much should the ears stick out?
ear_angle=2; //[1:10]

///////////////////////////////////////////////////////////////////////////////////////
//////////////////////Calculation of key variables/////////////////////////////////

rec=resolution; //cylindrical resolution
res=resolution*2; //spherical resolution

//////////////head dimensions
h=100*1;
rs=h/4.1*(top_width+10)/10;
rc=h/4.1*(bottom_width+10)/10;
rn=rc*(neck+3)/15;
hm=h-rs-rc;
theta=asin((rs-rc)/hm);

//////////////eye dimensions
eyer=(eye_size/10)*(rs*3/10);
eyemax=rs*3/10;
eyesp=eyer+(eye_spacing/10)*(rs*3/5-2*eyer);
eyex=pow(pow(rs,2)-pow(eyesp,2),1/2)-rs+rc;

/////////////nose dimensions
nosez=(1/2)*rc+(h/2-(1/2)*rc)*(nose_height-1)/9;

/////////////mouth dimensions
mouthmax=(h/2-eyemax)/2*.8;
mouthd=mouthmax*(mouth_size+5)/15;
mouthr=mouthd/2;
mouthz=nosez*(mouth_height+3)/13;

/////////////////////////////////////////////////////////////////////////////////////
///////////////////////Main rendering code//////////////////////////////////////

color("lightblue")rotate([0,0,-90])scale([height/100,height/100,height/100])difference(){
	translate([0,0,-rc*(1-cos(head_tilt))])union(){
		translate([0,0,rc])
		rotate([0,(-head_tilt+theta),0])
		translate([0,0,-rc])
		union(){
			difference(){
				head();
				mouth_blank();
			}
			eyes();
			mouth();
			ears();
			nose();
			hair();
			beard();
			brows();

		}	
		translate([-rc*2/3+rn,0,0])cylinder(r=rn,h=rc+hm,$fn=rec);
	}
	translate([0,0,-50])cube(100,center=true);
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
///////////                                                                              /////////
///////////                        MAIN       MODULES                          /////////
///////////                                                                              /////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////
///////////////////////Create the basic head shape//////////////////////////

module head(){
	translate([0,0,rc])rotate([0,-theta,0])hull(){
		translate([0,0,hm])sphere(rs,$fn=res);
		sphere(rc,$fn=res);
	}	
}

////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////Create blanks from which to carve eyes and mouth//////////////

module eye_blank(){
	intersection(){
		translate([0,0,h/2])rotate([0,90,0])linear_extrude(h=rs+10)for(i=[1,-1])hull(){
			translate([0,eyemax*i])circle(eyemax,$fn=rec);
			translate([-eyemax/2,-eyemax*i])circle(eyemax/2,$fn=rec);
		}
		head();
	}
}

module mouth_blank(){
	intersection(){
		translate([0,0,mouthz])rotate([0,90,0])scale([1,1.25,1])cylinder(r=mouthmax,h=rc+10,$fn=rec);
		head();
	}
}

//////////////////////////////////////////////////////////////////////////////////////////
///////////////////Create eyes /////////////////////////////////////////////////////////
////[normal,surprised,sleepy,eye roll]

module eyes(){

		if(glasses!="coke bottle")
		for(i=[1,-1])translate([eyex-eyer/2,eyesp*i,h/2])rotate([eye_angle*i,0,0]){
			if(eye_type=="average")eyeball(eyer,6);
			if(eye_type=="surprised")eyeball(eyer,15);
			if(eye_type=="sleepy")eyeball(eyer,2);
			if(eye_type=="eye roll")rotate([0,-30,-30])eyeball(eyer,5);
		}

		if(glasses=="hipster")translate([eyex+2,0,h/2])rotate([0,5,0])square_glasses();
		if(glasses=="circle")translate([eyex+2,0,h/2])rotate([0,5,0])circle_glasses();
		if(glasses=="coke bottle")translate([eyex+2,0,h/2])rotate([0,5,0])coke_bottle();

}

			


//////////////////////////////////////////////////////////////////////////////////////////
///////////////////Create mouth /////////////////////////////////////////////////////////

module mouth(){

	difference(){
		mouth_blank();

		if(mouth_type=="agape"){
				if(mouthz<rc)translate([pow(pow(rc,2)-pow(rc-mouthz,2),.5),0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])intersection(){
				scale([1,1,.7])sphere(10,$fn=res);
				translate([0,0,-28])sphere(30,$fn=res);}
			if(mouthz>=rc)translate([rc,0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])intersection(){
				scale([1,1,.7])sphere(10,$fn=res);
				translate([0,0,-28])sphere(30,$fn=res);}
		}

		if(mouth_type=="smiling"){
			if(mouthz<rc)translate([pow(pow(rc,2)-pow(rc-mouthz,2),.5),0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])difference(){
				scale([1,1,.7])sphere(10,$fn=res);
				translate([0,7,20])sphere(20,$fn=res);}
			if(mouthz>=rc)translate([rc,0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])difference(){
				scale([1,1,.7])sphere(10,$fn=res);
				translate([0,7,20])sphere(20,$fn=res);}
		}

		if(mouth_type=="oh no"){
			if(mouthz<rc)translate([pow(pow(rc,2)-pow(rc-mouthz,2),.5),0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])difference(){
				scale([1,1,.7])sphere(10,$fn=res);
				translate([0,-7,-20])sphere(20,$fn=res);}
			if(mouthz>=rc)translate([rc,0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])difference(){
				scale([1,1,.7])sphere(10,$fn=res);
				translate([0,-7,-20])sphere(20,$fn=res);}
		}

		if(mouth_type=="not feeling well"){
			
			translate([rc,0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])rotate([0,90,0])rotate([0,0,90])linear_extrude(height=50,center=true){
				intersection(){
					translate([-5,-3.5])difference(){
						circle(5,$fn=20);
						circle(2,$fn=20);
					}
					translate([-15,-3.5])square(10);
				}
				hull(){
					translate([-5,0])circle(1.5,$fn=20);
					translate([6,0])circle(1.5,$fn=20);
				}
			}
		}

		if(mouth_type=="um..."){
			
			translate([rc,0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])rotate([0,90,0])rotate([0,0,90])linear_extrude(height=50,center=true){
				hull(){
					translate([-5,0])circle(1.5,$fn=20);
					translate([6,0])circle(1.5,$fn=20);
				}
			}
		}

		if(mouth_type=="half smile"){
			
			translate([rc,0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])rotate([0,90,0])rotate([0,0,90])linear_extrude(height=50,center=true){
				intersection(){
					translate([-5,3.5])difference(){
						circle(5,$fn=20);
						circle(2,$fn=20);
					}
					translate([-15,-6.5])square(10);
				}
				hull(){
					translate([-5,0])circle(1.5,$fn=20);
					translate([6,0])circle(1.5,$fn=20);
				}
			}
		}

		if(mouth_type=="chiclet teeth"){
			if(mouthz<rc)translate([pow(pow(rc,2)-pow(rc-mouthz,2),.5),0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])difference(){
				intersection(){
					scale([1,1,.7])sphere(10,$fn=res);
					translate([0,0,-28])sphere(30,$fn=res);}
				for(j=[0,1])translate([-1*j-5,0,-4.5*j-3])
					for(i=[-10.5,-7.5,-4.5,-1.5,1.5,4.5,7.5,10.5])translate([0,i,0])hull(){
						translate([0,.5,1])sphere(1,$fn=10);
						translate([0,-.5,1])sphere(1,$fn=10);
						translate([0,.5,5])sphere(1,$fn=10);
						translate([0,-.5,5])sphere(1,$fn=10);
				}
			}
			if(mouthz>=rc)translate([rc,0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])difference(){
				intersection(){
					scale([1,1,.7])sphere(10,$fn=res);
					translate([0,0,-28])sphere(30,$fn=res);}
				for(j=[0,1])translate([-1*j-5,0,-4.5*j-3])
					for(i=[-10.5,-7.5,-4.5,-1.5,1.5,4.5,7.5,10.5])translate([0,i,0])hull(){
						translate([0,.5,1])sphere(1,$fn=10);
						translate([0,-.5,1])sphere(1,$fn=10);
						translate([0,.5,5])sphere(1,$fn=10);
						translate([0,-.5,5])sphere(1,$fn=10);
				}
			}
		}
	}

	if(mouth_type=="lipstick"){
		intersection(){
			translate([rc,0,mouthz])scale([mouth_size/5,mouth_size/5,mouth_size/5])scale([.6,.6,.6])rotate([0,270,0])linear_extrude(height=50,center=true){
				difference(){
					intersection(){
						translate([30,0])circle(40,$fn=30);
						for(i=[1,-1])translate([3,0])rotate([0,0,15*i])translate([-30,0])circle(30,$fn=30);
					}
					for(i=[1,-1])translate([-2,0])rotate([0,0,15*i])translate([-50,0])circle(50,$fn=30);
				}
				
				translate([-1,0])intersection(){
					translate([30,0])circle(40,$fn=30);
					for(i=[1,-1])translate([3,0])rotate([0,0,15*i])translate([-30,0])circle(30,$fn=30);
					for(i=[1,-1])translate([-2,0])rotate([0,0,15*i])translate([-50,0])circle(50,$fn=30);
				}
			}

			translate([3,0,0])mouth_blank();
		}
	}

	if(mouth_type=="just stache"){
		translate([rc,0,mouthz+5])
		scale([mouth_size/5,mouth_size/5,mouth_size/5])scale([.7,.7,.7])
		difference(){
			translate([0,0,5])cube([10,30,10],center=true);
			translate([8,0,0])rotate([0,-15,0])translate([0,0,25])cube([10,30,50],center=true);
			for(i=[-15:3:15]){
				translate([3,i*pow(2,.5),0])rotate([0,-15,0])rotate([0,0,45])translate([0,0,6])cube([1,1,12],center=true);
				translate([0,i*pow(2,.5),10])rotate([45,0,0])cube([10,1,1],center=true);
			}
		}
	}
}

//////////////////////////////////////////////////////////////////////////////////////////
///////////////////Create ears /////////////////////////////////////////////////////////

module ears(){
	for(i=[1,-1])
		scale([1,i,1])
		translate([0,0,rc])
		rotate([0,-theta,0])
		translate([0,rs,hm])
		rotate([-theta,0,0])
		translate([0,0,h/2-rc-hm])
		scale([ear_size/4,ear_size/4,ear_size/4]){
		
			if(ear_type=="average")ear_model(Ear_Length=15,Ear_Shape=60,ear_thickness=3,taper=70);
		
			if(ear_type=="monkey")ear_model(Ear_Length=9,Ear_Shape=10,ear_thickness=3,taper=70);

			if(ear_type=="long")ear_model(Ear_Length=25,Ear_Shape=30,ear_thickness=3,taper=70);

			if(ear_type=="pill shaped")ear_model(Ear_Length=15,Ear_Shape=100,ear_thickness=3,taper=70);

			if(ear_type=="viking horn")rotate([15+theta,0,0])horn(hornrad=45,hornshaft=8,hornsweep=60,horncut=5);

		}
}

//////////////////////////////////////////////////////////////////////////////////////////
///////////////////Create nose /////////////////////////////////////////////////////////

//[pointy,upturned,wide,piggy,clown]

module nose(){

	translate([rc,0,nosez])scale([nose_size/5,nose_size/5*nose_width/5,nose_size/5]){

		if(nose_type=="pointy")
			nose_model(
				nwidth=12,
				bridge_width=1,
				bridge_prominance=1,
				tip_width=1,
				tip_height=0,
				nheight=16,
				nose_length=8,
				softness=4,
				nostril_length=4,
				nostril_weight=3,
				nostril_width=7,
				nostril_bulge=0);

		if(nose_type=="upturned")
			nose_model(
				nwidth=10,
				bridge_width=3,
				bridge_prominance=-4,
				tip_width=3,
				tip_height=3,
				nheight=16,
				nose_length=6,
				softness=9,
				nostril_length=4,
				nostril_weight=3,
				nostril_width=9,
				nostril_bulge=0);
                
 		if(nose_type=="wide")
			nose_model(
				nwidth=18,
				bridge_width=4,
				bridge_prominance=1,
				tip_width=5,
				tip_height=1,
				nheight=16,
				nose_length=8,
				softness=7,
				nostril_length=8,
				nostril_weight=5,
				nostril_width=9,
				nostril_bulge=.2);

 		if(nose_type=="average")
			nose_model(
				nwidth=14,
				bridge_width=4,
				bridge_prominance=-3,
				tip_width=6,
				tip_height=0,
				nheight=16,
				nose_length=7,
				softness=8,
				nostril_length=5,
				nostril_weight=7,
				nostril_width=9,
				nostril_bulge=.2);

 		if(nose_type=="high bridge")
			nose_model(
				nwidth=12,
				bridge_width=2,
				bridge_prominance=3,
				tip_width=4,
				tip_height=0,
				nheight=16,
				nose_length=10,
				softness=8,
				nostril_length=4,
				nostril_weight=4,
				nostril_width=7,
				nostril_bulge=.2);

 		if(nose_type=="button")
			nose_model(
				nwidth=12,
				bridge_width=2,
				bridge_prominance=-8,
				tip_width=6,
				tip_height=1,
				nheight=10,
				nose_length=5,
				softness=8,
				nostril_length=4,
				nostril_weight=4,
				nostril_width=7,
				nostril_bulge=0);
				
		if(nose_type=="piggy")scale([1,5/nose_width,1])translate([0,0,7])rotate([0,90,0])difference(){
					intersection(){
						cylinder(r=7,h=14,center=true,$fn=rec);
						scale([7/14,7/14,1])sphere(r=14,$fn=res);
					}
					for(i=[1,-1])scale([1,i,1])translate([0,2,7])scale([1,.5,1])sphere(r=2.5,$fn=res);
				}
                
 		if(nose_type=="clown")scale([1,1,nose_width/5])translate([3,0,10])sphere(r=10,$fn=res);
	
	}
}

//////////////////////////////////////////////////////////////////////////////////////////
///////////////////Create hair /////////////////////////////////////////////////////////

module hair(){
	if(hair_type=="bowl cut")bowlcut(hairlen=4);
	if(hair_type=="bob")bob(hairlen=4);
	if(hair_type=="long")long(hairlen=4);
	if(hair_type=="buzz")buzz(hairlen=hair_length);
	if(hair_type=="mullet")mullet(hairlen=hair_length,toplen=5/7*rs,topwidth=0.9);
	if(hair_type=="fro")buzz(hairlen=20);
	if(hair_type=="monster fro")buzz(hairlen=30);
	if(hair_type=="male pattern")intersection(){
		buzz(hairlen=hair_length);
		rotate([0,-theta,0])cylinder(r=100,h=h/2+13,$fn=rec);
	}
	if(hair_type=="flattop")flattop(hairlen=hair_length,toplen=rs,topwidth=.95);
	if(hair_type=="average guy")flattop(hairlen=hair_length,toplen=4/7*rs,topwidth=0.9);
	if(hair_type=="top bun")topbun(hairlen=1);
	if(hair_type=="pony")pony(hairlen=1);
}


/////////////////////////////////////////////////////////////////////////////////////////
//////////////////////     Create Facial Hair    ///////////////////////////////////////

module beard(){
	if(facial_hair=="full beard")fullbeard(facial_hair_length);
	if(facial_hair=="chin strap")chinstrap(facial_hair_length);
	if(facial_hair=="chops")chops(facial_hair_length);
	if(facial_hair=="stache")stache(facial_hair_length);
	if(facial_hair=="soul patch")soulpatch(facial_hair_length);
	if(facial_hair=="goatee")goatee(facial_hair_length);
}


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
///////////                                                                              /////////
///////////                        SUPPORTING       MODULES              /////////
///////////                                                                              /////////
/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////
///////////////////Eye features////////////////////////////////////////////////////////

module eyeball(eye_radius,awake){
	
	theta1=55*awake/10-10;
	theta2=45*awake/10+10;
	
	union(){
		difference(){
			sphere(eye_radius*9/10,$fn=res);
			rotate([0,90,0])cylinder(r1=0,r2=eye_radius/1.5,h=eye_radius,$fn=res);
		}
		difference(){
			sphere(eye_radius*8/10,$fn=res);
			rotate([0,90,0])cylinder(r1=0,r2=eye_radius/4,h=eye_radius,$fn=res);
		}
	
		rotate([0,theta2,0])difference(){
			sphere(eye_radius,$fn=res);
			translate([-eye_radius,-eye_radius,0])cube(2*eye_radius);
		}
		rotate([0,-180-theta1,0])difference(){
			sphere(eye_radius,$fn=res);
			translate([-eye_radius,-eye_radius,0])cube(2*eye_radius);
		}
	}

}

module square_glasses(){

	rotate([90,0,-90])union(){
	
		linear_extrude(height=2){
			for(i=[1,-1])scale([i,1])translate([6,-6])difference(){
				minkowski(){
					square([16,12]);
					circle(r=2.5,$fn=rec);
				}
				minkowski(){
					square([16,12]);
					circle(r=1,$fn=rec);
				}
			}
			
			difference(){
				translate([0,1.5])square([7,9],center=true);
				translate([0,6])circle(r=3.5,$fn=rec);
				translate([0,-3])circle(r=3.5,$fn=rec);
			}
		}

		linear_extrude(height=20)intersection(){
			for(i=[1,-1])scale([i,1])translate([6,-6])difference(){
				minkowski(){
					square([16,12]);
					circle(r=2.5,$fn=rec);
				}
				minkowski(){
					square([16,12]);
					circle(r=1,$fn=rec);
				}
			}
			
			translate([0,-57])square([100,100],center=true);
			
		}
		
		linear_extrude(height=40){
			for(i=[1,-1])scale([i,1])translate([25.5,0]){
				translate([0,1.5])square([2,6],center=true);
			}
		}
	}
}


module circle_glasses(){

	rotate([90,0,-90])union(){
	
		linear_extrude(height=2){
			for(i=[1,-1])scale([i,1])translate([14,1])difference(){
				circle(r=12,$fn=rec);
				circle(r=9,$fn=rec);
			}
			
			intersection(){
				difference(){
					translate([0,-2])circle(r=6.5,$fn=rec);
					translate([0,-2])circle(r=3.5,$fn=rec);
				}
				translate([-4,0])square([8,10]);
			}
		}

		linear_extrude(height=20)intersection(){
			for(i=[1,-1])scale([i,1])translate([14,1])difference(){
				circle(r=12,$fn=rec);
				circle(r=9,$fn=rec);
			}
			
			translate([0,-58])square([100,100],center=true);
		}
		
		linear_extrude(height=40){
			for(i=[1,-1])scale([i,1])translate([25.5,0]){
				translate([0,1.5])square([2,6],center=true);
			}
		}
	}
}

module coke_bottle(){

	circle_glasses();
	for(i=[1,-1])translate([-2,14*i,1])rotate([0,90,0])cylinder(r=10,h=1,$fn=rec);
	intersection(){
		for(i=[1,-1])translate([-9,14*i,1])rotate([eye_angle*i,0,0])eyeball(13,5);
		translate([48,0,0])cube(100,center=true);
	}

}

//////////////////////////////////////////////////////////////////////////////////////////
///////////////////Nose Features/////////////////////////////////////////////////////////


module nose_model(nwidth,bridge_width,bridge_prominance,tip_width,tip_height,nheight,nose_length,softness,nostril_length,nostril_weight,nostril_width,nostril_bulge){
	
	nrad=pow(pow(nose_length,2)+pow(tip_height,2)+pow(nwidth/2,2),1/2)*nostril_length/20;
	nostrad=nostril_width/10*nwidth/4;
	
	rtop=bridge_width/2*softness/10;
	rtip=tip_width/2*softness/10;

	resnose=10;
	
	nthtz=atan(-nwidth/2/nose_length);
	nthty=atan(-tip_height/nose_length);
	
	translate([0,0,nrad*nostril_weight/10])difference(){
		union(){
			hull(){				
				for(i=[1,-1])scale([1,i,1])translate([0,nwidth/2,0])rotate([0,nthty,nthtz])translate([nrad,0,0])scale([1,nostril_weight/10,nostril_weight/10])sphere(nrad,$fn=resnose);
				
				for(i=[1,-1])scale([1,i,1])translate([-nrad,nwidth/2-nrad,0])sphere(r=rtip,$fn=resnose);
	
				for(i=[1,-1])scale([1,i,1])translate([nose_length-rtip,tip_width/2-rtip,tip_height])sphere(r=rtip,$fn=resnose);	
	
				for(i=[1,-1])scale([1,i,1])translate([(nose_length-rtip)/3+(nose_length-rtip)*2/3*bridge_prominance/10,bridge_width/2-rtop,tip_height+(nheight-tip_height)*2/3])sphere(r=rtop,$fn=resnose);
				
				translate([-rtop,0,nheight-rtop])sphere(r=rtop,$fn=resnose);
			}	

			for(i=[1,-1])scale([1,i,1])translate([0,nwidth/2,0])rotate([0,nthty,nthtz])translate([nrad,0,0])scale([1,nostril_weight/10,nostril_weight/10])sphere(nrad+nostril_bulge,$fn=resnose);			

		}
	
		for(i=[-1,1])scale([1,i,1])translate([nostrad/2+(nose_length-nostrad)/10,nostrad+(nwidth/2-nostrad)/10,-nheight/4])rotate([0,-atan(nose_length/2/nheight),0])cylinder(r1=nostrad,r2=0,h=nheight*2/3,$fn=rec);
	}

}


//////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////Ear Features////////////////////////////////////////

module ear_model(Ear_Length,Ear_Shape,ear_thickness,taper){


	Top_Radius=5;
	
	soft=ear_thickness/6;
	Bottom_Radius=1+(Top_Radius-1)*Ear_Shape/100;
	
	topr=Top_Radius;
	botr=Bottom_Radius;
	eart=ear_thickness;
	cutr=(Ear_Length-topr-botr)/2;
	
	
	rotate([0,0,-45*ear_angle/10])translate([-topr*2/3,0,0])rotate([270,0,0])difference(){
		
		hull(){
				cylinder(r1=topr*taper/100,r2=topr,h=eart,$fn=rec*2,center=true);
				translate([topr-botr,Ear_Length-topr-botr,0])cylinder(r1=botr*taper/100,r2=botr,h=eart,$fn=rec*2,center=true);
				translate([(topr-botr)/2,Ear_Length-topr,-eart/2])cylinder(r1=botr*taper/200,r2=0,h=eart*3/2,$fn=rec*2,center=true);
				translate([0,0,ear_thickness/2])scale([1,1,ear_thickness/3/topr])sphere(topr,$fn=res);
				translate([topr-botr,Ear_Length-topr-botr,ear_thickness/2])scale([1,1,ear_thickness/5/botr])sphere(botr,$fn=res);
		}

		
		hull(){
			translate([0,0,ear_thickness/2+ear_thickness/3/topr])scale([1,1,ear_thickness/2/topr])sphere(topr-soft,$fn=res);
			translate([topr-botr,Ear_Length-topr-botr,ear_thickness/2+ear_thickness/5/topr])scale([1,1,ear_thickness/4/botr])sphere(botr-soft,$fn=res);
		}
	
		translate([topr,(Ear_Length-topr-botr)/2,ear_thickness*(1/2+1/3)])scale([1,1,ear_thickness*(1/2+1/3)/cutr])sphere(cutr,$fn=res);
	
	}

}

module horn(hornrad,hornshaft,hornsweep,horncut){

	radstep=hornshaft/(horncut);
	rotstep=hornsweep/(horncut);

	rotate([0,0,-90])
	rotate([0,-90,0])
	translate([hornrad+hornshaft,0,0])
	for(i=[1:1:horncut]){
		hull(){
			rotate([0,rotstep*(i-1),0])translate([-hornrad,0,0])cylinder(r1=hornshaft-radstep*(i-1),r2=0,h=.1);
			rotate([0,rotstep*i,0])translate([-hornrad,0,-.1])cylinder(r1=radstep/5,r2=hornshaft-radstep*i,h=.1);
	
		}
	}
}




//////////////////////////////////////////////////////////////////////////////////////////
///////////////////Hair features////////////////////////////////////////////////////////

module bob(hairlen){
	difference(){
		translate([0,0,rc])rotate([0,-theta,0])hull(){
			translate([0,0,hm])sphere(rs+hairlen,$fn=res);
			sphere(max(rc,rs)+hairlen,$fn=res);
		}
		rotate([0,-theta,0])translate([50,0,eyer*1.8-rs])cube([100,100,h],center=true);
		rotate([0,-theta,0])translate([50+rs,0,h/2-50+eyer*1.8])cube([100,100,h],center=true);
		rotate([0,-theta,0])translate([rs,0,h/2+eyer*1.8-rs])rotate([90,0,0])cylinder(r=rs,h=125,center=true,$fn=rec);
		cube([100,100,rc],center=true);
	}
}

module long(hairlen){
	difference(){
		translate([0,0,rc])rotate([0,-theta,0])hull(){
			translate([0,0,hm])sphere(rs+hairlen,$fn=res);
			translate([0,0,-rc])sphere(max(rc+hairlen,rs+hairlen)+hairlen,$fn=res);
		}
		rotate([0,-theta,0])translate([50,0,eyer*1.8-rs])cube([100,100,h],center=true);
		rotate([0,-theta,0])translate([50+rs,0,h/2-50+eyer*1.8])cube([100,100,h],center=true);
		rotate([0,-theta,0])translate([rs,0,h/2+eyer*1.8-rs])rotate([90,0,0])cylinder(r=rs,h=125,center=true,$fn=rec);
		translate([0,0,-rc/2])cube([100,100,rc],center=true);
	}
}

module bowlcut(hairlen){
	difference(){
		translate([0,0,rc])rotate([0,-theta,0])hull(){
			translate([0,0,hm])sphere(rs+hairlen,$fn=res);
			sphere(rc+hairlen,$fn=res);
		}
		rotate([0,-theta,0])translate([0,0,eyer*1.2])cube([100,100,h],center=true);
	}
}

module buzz(hairlen){
	intersection(){
	
		translate([0,0,h+hairlen-rs/2])rotate([0,75,0])cylinder(r=rs*1.5+hairlen,h=150,$fn=res,center=true);
	
		difference(){
			translate([0,0,rc])rotate([0,-theta,0])hull(){
				translate([0,0,hm])sphere(rs+hairlen,$fn=res);
				sphere(rc+hairlen,$fn=res);
			}
			translate([0,0,rc])rotate([0,-theta,0])translate([0,0,-rc]){
				translate([50+rs*2/5,0,-h/2+rs/6+rc+hm])cube([100,125,h],center=true);
				translate([50+rs*(2/5+1/4),0,-h/2+rs/4+rs/6+rc+hm])cube([100,125,h],center=true);
				translate([rs*(2/5+1/4),0,rc+hm+rs/6])rotate([90,0,0])cylinder(r=rs/4,h=125,center=true,$fn=rec);
				translate([50-5*2/3*ear_size/4-2-5*ear_size/4,0,.1])cube([100,125,h],center=true);
				translate([-5*2/3*ear_size/4,0,h/2])rotate([90,0,0])cylinder(r=2+5*ear_size/4,h=125,center=true,$fn=rec);
			}
		}
	}
}

module mullet(hairlen,toplen,topwidth){
	difference(){
			translate([0,0,rc])rotate([0,-theta,0])hull(){
				translate([0,0,hm])sphere(rs+hairlen,$fn=res);
				translate([0,0,hm])cylinder(r=(rs+hairlen)*topwidth,h=toplen,$fn=res);
				translate([0,0,-rc])cylinder(r=max(rc,rs)+hairlen,h=1,$fn=rec);
			}
			translate([0,0,rc])rotate([0,-theta,0])translate([0,0,-rc]){
				translate([50+rs*2/5,0,-h/2+rs/6+rc+hm])cube([100,125,h],center=true);
				translate([50+rs*(2/5+1/4),0,-h/2+rs/4+rs/6+rc+hm])cube([100,125,h],center=true);
				translate([rs*(2/5+1/4),0,rc+hm+rs/6])rotate([90,0,0])cylinder(r=rs/4,h=125,center=true,$fn=rec);
				translate([50-5*2/3*ear_size/4-2-5*ear_size/4,0,.1])cube([100,125,h],center=true);
				translate([-5*2/3*ear_size/4,0,h/2])rotate([90,0,0])cylinder(r=2+5*ear_size/4,h=125,center=true,$fn=rec);
			}
	}
}

module flattop(hairlen,toplen,topwidth){
	intersection(){
	
		translate([0,0,h+hairlen-rs/2])rotate([0,75,0])cylinder(r=rs*1.5+hairlen,h=125,$fn=res,center=true);
	
		difference(){
			translate([0,0,rc])rotate([0,-theta,0])hull(){
				translate([0,0,hm])sphere(rs+hairlen,$fn=res);
				translate([0,0,hm])cylinder(r=(rs+hairlen)*topwidth,h=toplen,$fn=res);
				sphere(rc+hairlen,$fn=res);
			}
			translate([0,0,rc])rotate([0,-theta,0])translate([0,0,-rc]){
				translate([50+rs*2/5,0,-h/2+rs/6+rc+hm])cube([100,125,h],center=true);
				translate([50+rs*(2/5+1/4),0,-h/2+rs/4+rs/6+rc+hm])cube([100,125,h],center=true);
				translate([rs*(2/5+1/4),0,rc+hm+rs/6])rotate([90,0,0])cylinder(r=rs/4,h=125,center=true,$fn=rec);
				translate([50-5*2/3*ear_size/4-2-5*ear_size/4,0,.1])cube([100,125,h],center=true);
				translate([-5*2/3*ear_size/4,0,h/2])rotate([90,0,0])cylinder(r=2+5*ear_size/4,h=125,center=true,$fn=rec);
			}

		}
	}
}

module topbun(hairlen){
	rotate([0,-theta*1.5,0])translate([0,0,h])scale([1,1,.7])sphere(r=rs/2,$fn=res);
	buzz(hairlen);
}

module pony(hairlen){
	rotate([0,0,0])translate([-rs,0,rc+hm])rotate([0,-90-theta,0])union(){
		translate([0,0,rs/7])sphere(r=rs/5,$fn=res);
		hull(){
			translate([-rs/3,0,rs/3.5])sphere(r=rs/4.5,$fn=res);
			translate([-rs/3-rs/2,0,rs/5])sphere(r=rs/6,$fn=res);
		}
		hull(){
			translate([-rs/3-rs/2,0,rs/5])sphere(r=rs/6,$fn=res);
			translate([-rc-hm,0,rs/3])sphere(r=2,$fn=res);
		}
	}
	buzz(hairlen);
}


////////////////////////////////////////////////////////////////////////////////////
////////////////////   Beard Features  ///////////////////////////////////////////

module fullbeard(beardlen){

	rbcut=h/2-nosez+4;
	rbscale=(rc+beardlen-rs*2/5)/rbcut;
					
	intersection(){

		difference(){
			translate([0,0,rc])rotate([0,-theta,0])hull(){
				translate([0,0,(h/2-rc)])sphere(beardlen+rc+(rs-rc)*((h/2-rc)/hm),$fn=res);
				translate([rc/3,0,0])scale([2/3,.9,1])sphere(rc+beardlen,$fn=res);
			}
			translate([0,0,rc])rotate([0,-theta,0])translate([0,0,-rc]){
				translate([0,0,h])cube([100,125,h],center=true);
				translate([-50+3+5*1/3*ear_size/4,0,0])translate([0,0,h/2])rotate([0,theta,0])translate([0,0,-h/2])cube([100,125,1.5*h],center=true);
				translate([rbcut*rbscale+rs*(2/5),0,h/2])scale([rbscale,1,1])rotate([90,0,0])cylinder(r=rbcut,h=125,center=true,$fn=rec);
				translate([0,0,mouthz-rc*sin(theta)])scale([1,1.7,1])rotate([0,90,0])intersection(){
					cylinder(r=rc/4,h=50,$fn=rec);
					translate([rc/2-rc/10,0,0])cylinder(r=rc/2,h=50,$fn=rec*2);
				}
			}
		}
	}
}

module chinstrap(beardlen){

	rbcut=h/2+beardlen;
	rbscale=(rc+beardlen-rs*2/5)/rbcut;
					
	intersection(){
		difference(){
			translate([0,0,rc])rotate([0,-theta,0])hull(){
				translate([0,0,(h/2-rc)])sphere(beardlen+rc+(rs-rc)*((h/2-rc)/hm),$fn=res);
				translate([rc/3,0,0])scale([2/3,.9,1])sphere(rc+beardlen,$fn=res);
			}
			translate([0,0,rc])rotate([0,-theta,0])translate([0,0,-rc]){
				translate([0,0,h])cube([100,125,h],center=true);
				translate([-50+3+5*1/3*ear_size/4,0,0])translate([0,0,h/2])rotate([0,theta,0])translate([0,0,-h/2])cube([100,125,1.5*h],center=true);
				translate([rbcut*rbscale+rs*(2/5),0,h/2])scale([rbscale,1,1])rotate([90,0,0])cylinder(r=rbcut,h=125,center=true,$fn=rec);
			}
		}
	}
}

module chops(beardlen){

	rbcut=h/2-nosez+4;
	rbscale=(rc+beardlen-rs*2/5)/rbcut;
					
	intersection(){

		difference(){
			translate([0,0,rc])rotate([0,-theta,0])hull(){
				translate([0,0,(h/2-rc)])sphere(beardlen+rc+(rs-rc)*((h/2-rc)/hm),$fn=res);
				translate([rc/3,0,0])scale([2/3,.9,1])sphere(rc+beardlen,$fn=res);
			}
			translate([0,0,rc])rotate([0,-theta,0])translate([0,0,-rc]){
				translate([0,0,h])cube([100,125,h],center=true);
				translate([-50+3+5*1/3*ear_size/4,0,0])translate([0,0,h/2])rotate([0,theta,0])translate([0,0,-h/2])cube([100,125,1.5*h],center=true);
				translate([rbcut*rbscale+rs*(2/5),0,h/2])scale([rbscale,1,1])rotate([90,0,0])cylinder(r=rbcut,h=125,center=true,$fn=rec);
				translate([0,0,.15*h])rotate([0,-30,0])translate([0,0,-h/4])cube([100,100,h/2],center=true);

			}
		}
	}
}

module soulpatch(beardlen){

	rbcut=h/2-nosez+4;
	rbscale=(rc+beardlen-rs*2/5)/rbcut;
					
	intersection(){
		difference(){
			translate([0,0,rc])rotate([0,-theta,0])hull(){
				translate([0,0,(h/2-rc)])sphere(beardlen+rc+(rs-rc)*((h/2-rc)/hm),$fn=res);
				translate([rc/3,0,0])scale([2/3,.9,1])sphere(rc+beardlen,$fn=res);
			}
			translate([0,0,rc])rotate([0,-theta,0])translate([0,0,-rc]){
				translate([0,0,h])cube([100,125,h],center=true);
				translate([-50+3+5*1/3*ear_size/4,0,0])translate([0,0,h/2])rotate([0,theta,0])translate([0,0,-h/2])cube([100,125,1.5*h],center=true);
				translate([rbcut*rbscale+rs*(2/5),0,h/2])scale([rbscale,1,1])rotate([90,0,0])cylinder(r=rbcut,h=125,center=true,$fn=rec);
				translate([0,0,mouthz-rc*sin(theta)])scale([1,1.7,1])rotate([0,90,0])intersection(){
					cylinder(r=rc/4,h=50,$fn=rec);
					translate([rc/2-rc/10,0,0])cylinder(r=rc/2,h=50,$fn=rec*2);
				}
			}
		}
		translate([0,0,nosez-4-rc/4])scale([1,.5,1])rotate([0,90,0])intersection(){
			cylinder(r=rc/4,h=50,$fn=rec);
			translate([rc/2-rc/10,0,0])cylinder(r=rc/2,h=50,$fn=rec*2);
		}
	}
}

module stache(beardlen){

	rbcut=h/2-nosez+4;
	rbscale=(rc+beardlen-rs*2/5)/rbcut;
					
	intersection(){
		difference(){
			translate([0,0,rc])rotate([0,-theta,0])hull(){
				translate([0,0,(h/2-rc)])sphere(beardlen+rc+(rs-rc)*((h/2-rc)/hm),$fn=res);
				translate([rc/3,0,0])scale([2/3,.9,1])sphere(rc+beardlen,$fn=res);
			}
			translate([0,0,rc])rotate([0,-theta,0])translate([0,0,-rc]){
				translate([0,0,h])cube([100,125,h],center=true);
				translate([-50+3+5*1/3*ear_size/4,0,0])translate([0,0,h/2])rotate([0,theta,0])translate([0,0,-h/2])cube([100,125,1.5*h],center=true);
				translate([rbcut*rbscale+rs*(2/5),0,h/2])scale([rbscale,1,1])rotate([90,0,0])cylinder(r=rbcut,h=125,center=true,$fn=rec);
				translate([0,0,mouthz-rc*sin(theta)])scale([1,1.7,1])rotate([0,90,0])intersection(){
					cylinder(r=rc/4,h=50,$fn=rec);
					translate([rc/2-rc/10,0,0])cylinder(r=rc/2,h=50,$fn=rec*2);
				}
			}
		}
		translate([0,0,nosez-4])scale([1,1.7,1])rotate([0,90,0])intersection(){
			cylinder(r=rc/4,h=50,$fn=rec);
			translate([rc/2-rc/10,0,0])cylinder(r=rc/2,h=50,$fn=rec*2);
		}
	}
}

module goatee(beardlen){

	rbcut=h/2-nosez+4;
	rbscale=(rc+beardlen-rs*2/5)/rbcut;
					
	intersection(){

		difference(){
			translate([0,0,rc])rotate([0,-theta,0])hull(){
				translate([0,0,(h/2-rc)])scale([1,.7,1])sphere(beardlen+rc+(rs-rc)*((h/2-rc)/hm),$fn=res);
				translate([rc/3,0,0])scale([2/3,.7,1])sphere(rc+beardlen,$fn=res);
			}
			translate([0,0,rc])rotate([0,-theta,0])translate([0,0,-rc]){
				translate([0,0,h])cube([100,125,h],center=true);
				translate([-50+3+5*1/3*ear_size/4,0,0])translate([0,0,h/2])rotate([0,theta,0])translate([0,0,-h/2])cube([100,125,1.5*h],center=true);
				translate([rbcut*rbscale+rs*(2/5),0,h/2])scale([rbscale,1,1])rotate([90,0,0])cylinder(r=rbcut,h=125,center=true,$fn=rec);
				translate([0,0,mouthz-rc*sin(theta)])scale([1,1.7,1])rotate([0,90,0])intersection(){
					cylinder(r=rc/4,h=50,$fn=rec);
					translate([rc/2-rc/10,0,0])cylinder(r=rc/2,h=50,$fn=rec*2);
				}
			}
		}
		rotate([0,90,0])cylinder(r=nosez,h=50,$fn=rec*2);
	}
}

module brows(){

	translate([0,0,h/2+eyer-hm])rotate([0,-theta,0])translate([0,0,hm])
	for(i=[1,-1])scale([1,i,1])
	rotate([0,0,atan(-1.2*eyesp/rs)])
	rotate([eyebrow_tilt,0,0])
	intersection(){
		rotate_extrude(convexity=10,$fn=res)translate([rs-eyebrow_thickness/30*3,0,0])circle(r=eyebrow_thickness/10*3,$fn=rec);
		rotate([0,90,0])cylinder(r1=0,r2=rs*eyebrow_length/14,h=2*rs,$fn=rec*2);
	}

}

