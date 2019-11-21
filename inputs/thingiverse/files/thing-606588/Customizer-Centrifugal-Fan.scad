//CUSTOMIZER VARIABLES

//Facet Number
Definition = 75;


//Number of vertical slices in warped blades
Slice_Number = 15;

//Object to be rendered
Object = "blade"; // [blade,case,lid]

//Radius of the blade assembly base
Blade_Base_Radius = 46;

//Height of the blade assembly base
Blade_Base_Height = 3;

//Top radius of the center cone
Blade_Cone_Radius = 10;

//Height of the center cone
Blade_Cone_Height = 20;

//Size of the shaft hole
Blade_Hole_Size = 10;

//Shape of the shaft hole
Blade_Hole_Type = "square"; // [circle,square]

//Type of blades
Blade_Type = "front"; // [front,radial,back]

//Number of blades
Blade_Number = 10;

//Distance of blades from rotor center
Blade_Distance = 20;

//Tilt of blade base in degrees
Blade_Angle = 10; // [-90:90]

//Length of blade
Blade_Length = 25;

//Thickness of blade at base
Blade_Thickness = 3;

//Height of blades
Blade_Height = 25;

//Type of warp applied to blades
Warp_Type = "atgen"; // [atgen,postgen,off]

//Angle of twist, in degrees
Warp_Severity = 30;

//Scale of top relative to bottom
Warp_Scale = 0.8;

//Horizontal gap between rotor and case
Case_Side_Gap = 3;

//Vertical gap between rotor and blades
Case_Vertical_Gap = 3;

//Case Hole size (should be larger than blade hole size)
Case_Hole_Size = 15;

//Case and cover wall thickness
Case_Thickness = 5;

//Length of output slot
Case_Slot_Length = 70;

//Width of output slot
Case_Slot_Width = 30;

//Size of the input hole
Lid_Hole_Size = 20;

/*
centfan mudule - creates the blade assembly

br = base radius
bh = base height
ctr = center cone top radius
ch = center cone height
hs = hole size
ht = hole type: "circle" or "square"
b = blade #
d = blade distance from rotor center
a = blade tilt (in degrees)
l = blade length
t = blade thickness (at base)
h = blade height
m = type of blade: "back", "radial" or "front"
w = warp type: "atgen", "postgen" or "off"
t = twist amount
s = top object relative scale
*/

module centfan(br,bh,ctr,ch,hs,ht,b,d,a,l,t,h,m,w,i,s,sn){

	difference(){

		union(){
		
			translate([0,0,bh])union(){
			
				if(m == "front"){
					
					if(w == "atgen"){

						for(n=[0:b]){

							rotate(n*(360/b))translate([d,0,0])linear_extrude(height=h,twist = i, scale = s,slices = sn)rotate(-a)translate([0,-l+t/2,0])difference(){

								circle(l);

								translate([t/2,-t,0])circle(l);

								translate([-l,0,0])square([l*2,l*2],true);
		
							};

						};
					
					};
					
					if(w == "postgen"){

						linear_extrude(height=h,twist = i, scale = s, slices = sn)for(n=[0:b]){

							rotate(n*(360/b))translate([d,0,0])rotate(-a)translate([0,-l+t/2,0])difference(){

								circle(l);

								translate([t/2,-t,0])circle(l);

								translate([-l,0,0])square([l*2,l*2],true);
		
							};

						};
					
					};
					
					if(w == "off"){

						linear_extrude(height=h)for(n=[0:b]){

							rotate(n*(360/b))translate([d,0,0])rotate(-a)translate([0,-l+t/2,0])difference(){

								circle(l);

								translate([t/2,-t,0])circle(l);

								translate([-l,0,0])square([l*2,l*2],true);
		
							};

						};
					
					};

				};
	
				if(m == "radial"){

					for(n=[0:b]){

						rotate(n*(360/b))translate([d,-t/2,0])rotate(a)cube([l,t,h]);
	
					};
				};
	
				if(m == "back"){
					
					if(w == "atgen"){

						for(n=[0:b]){

							rotate(n*(360/b))translate([d,0,0])linear_extrude(height=h,twist = -i, scale = s, slices = sn)rotate(a)translate([0,l+t/2,0])difference(){

								circle(l);

								translate([t/2,t,0])circle(l);

								translate([-l,0,0])square([l*2,l*2],true);
		
							};

						};
					
					};
					
					if(w == "postgen"){

						linear_extrude(height=h,twist = -i, scale = s, slices = sn)for(n=[0:b]){

							rotate(n*(360/b))translate([d,0,0])rotate(a)translate([0,l+t/2,0])difference(){

								circle(l);

								translate([t/2,t,0])circle(l);

								translate([-l,0,0])square([l*2,l*2],true);
		
							};

						};
					
					};
					
					if(w == "off"){

						linear_extrude(height=h)for(n=[0:b]){

							rotate(n*(360/b))translate([d,0,0])rotate(a)translate([0,l+t/2,0])difference(){

								circle(l);

								translate([t/2,t,0])circle(l);

								translate([-l,0,0])square([l*2,l*2],true);
		
							};

						};
					
					};

				};
	
			};

			translate([0,0,bh])cylinder(ch,d,ctr);

			cylinder(bh,br,br);

		};

		if(ht == "square"){

			translate([-hs/2,-hs/2,-0.5])cube([hs,hs,bh+ch+1]);

		};

		if(ht == "circle"){

			translate([0,0,-0.5])cylinder(bh+ch+1,hs/2,hs/2);

		};

	};

};

/*
cencase module - creates the bottom section of the centrifugal fan case. should be called using values from the centfan module

rr = rotor radius
rh = rotor height
sg = side gap
vg = vertical gap
hs = hole size
t = wall thickness
sl = slot length
sw = slot width
*/

module centcase(rr,rh,sg,vg,hs,t,sl,sw){

	difference(){

		union(){
			
			cylinder(1.5*t+2*vg+rh,t+sg+rr,t+sg+rr);

			translate([-(t+sg+rr),0,0])cube([sw+2*t,sl,1.5*t+2*vg+rh]);
			
		};

		translate([0,0,t])cylinder(.5*t+2*vg+rh+0.5,sg+rr,sg+rr);

		translate([-(sg+rr),0,t])cube([sw,sl+0.5,.5*t+2*vg+rh+0.5]);
	
		translate([0,0,-0.5])cylinder(t+1,hs/2,hs/2);

	};

};

/*
centtop module - creates a cover for the centcase module. see centcase for more information

rr = rotor radius
sg = side gap
ths = top hole size
t = thickness
sl = slot length
sw = slot width
*/

module centtop(rr,sg,ths,t,sl,sw){

	difference(){

		union(){
		
			cylinder(t/2,t+sg+rr,t+sg+rr);

			translate([rr+sg+t-(sw+2*t),0,0])cube([sw+2*t,sl,t/2]);

			cylinder(t,sg+rr,sg+rr);

			translate([rr+sg-sw,0,0])cube([sw,sl,t]);
		
		};

		translate([0,0,-0.5])cylinder(t+1,ths,ths);

	};

};

if (Object == "blade"){
centfan(Blade_Base_Radius,Blade_Base_Height,Blade_Cone_Radius,Blade_Cone_Height,Blade_Hole_Size,Blade_Hole_Type,Blade_Number,Blade_Distance,Blade_Angle,Blade_Length,Blade_Thickness,Blade_Height,Blade_Type,Warp_Type,Warp_Severity,Warp_Scale,Slice_Number,$fn = Definition);
};

if (Object == "case"){
centcase(Blade_Base_Radius,Blade_Base_Height + Blade_Height,Case_Side_Gap,Case_Vertical_Gap,Case_Hole_Size,Case_Thickness,Case_Slot_Length,Case_Slot_Width,$fn = Definition);
};

if (Object == "lid"){
centtop(Blade_Base_Radius,Case_Side_Gap,Lid_Hole_Size,Case_Thickness,Case_Slot_Length,Case_Slot_Width,$fn = Definition);
};
