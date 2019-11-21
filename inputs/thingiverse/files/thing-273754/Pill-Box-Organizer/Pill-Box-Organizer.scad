use <write.scad>
include <write/Write.scad>

//LABELS FOR CUSTOMIZER

//boxes

//Part to print
part = "all"; //["box":Box, "lid":Lid, "all":All parts]

//Applies To Each "Individual" Container
Length_For_Each_Compartment = 25; //[1:150]

//Applies To Each "Individual" Container
Width_For_Each_Compartment = 20; //[1:150]

//Applies To Entire Model
Height_For_Entire_Model = 15; //[1:50]


//number of boxes

number_days = 7; // [1:10]
number_per_day = 2; // [1:6]

//nub parameter
nubs = 0; //[0:Yes,1:No,2]
//Click Yes If You Are Printing A Lid

//Walls thicknes
wall = 1; //[1:4]

/*[Letters]*/
//Write day names
day_names = 1; //[1:Yes,0:No]

//Write names per day
day_time_names = 1; //[1:Yes,0:No]

//Size of text labels
text_h = 8; //[4:15]

//One Letter Works Best
row_one = "B"; 

//One Letter Works Best
row_two = "L";

//One Letter Works Best
row_three = "D";

//One Letter Works Best
row_four = "4";

//One Letter Works Best
row_five = "5";

//One Letter Works Best
row_six = "6";

/*[Advanced]*/

//Some clearance to ease the lid closing
layer = 0.5;

//Distance to nubs (as multiplifyer to wall thickness); Also used to calculate lid height.
Distance_to_nub = 3; //[2:6]

support_nub_width = 0.6; //[0:2]

/*[Hidden]*/
days = ["Su","Mo","Tu","We","Th","Fr","Sa","Su","Mo","Tu"];
rows = [row_one,row_two,row_three,row_four,row_five,row_six];

w = wall;
dnub = w*Distance_to_nub;

//MODEL VARIABLES

//box
length_x = Length_For_Each_Compartment;
width_y = Width_For_Each_Compartment;
height_z = Height_For_Entire_Model;
o_x = length_x;
o_y = width_y;
o_z = height_z;
i_x = o_x-4;
i_y = o_y-4;
i_z = o_z;

//number of days
d = number_days-2;
e = number_days-1;

x_len = (o_x+w)*number_per_day+w;
y_len = (o_y+w)*number_days+w;

if (part=="box") print_box();
else if(part=="lid") print_lid();
else if(part=="all"){
	print_box();
	translate([-x_len-w*3,0,w+layer])
		print_lid();
}
else if(part=="open"){
	print_box();
	translate([dnub,0,o_z+w-dnub])
		rotate([0,-90*$t,0])
			translate([x_len-dnub,0,dnub])
				rotate([0,180,0])
%					print_lid();
}
else {
	print_box();
	%translate([x_len,0,o_z+w])
		rotate([0,180,0])
			print_lid();
}
//number of times per day
n = number_per_day-2;

//MODULES
//box designs

//BOX1
module box()
{
	difference(){
		cube([o_x+w*2,o_y+w*2,o_z+w]);
		translate([w,w,w])
			cube([o_x,o_y,o_z+1]);
		
	}
}


module print_box(){
	difference(){
		union(){
			for(i=[0:number_days-1]){
				for(j=[0:number_per_day-1]){
					translate([j*(o_x+w),i*(o_y+w),0])
					{
						box();
						if (day_time_names == 1)
						translate([(o_x+w)-text_h/2-w*2,(o_y+w)/2,w])
							rotate([0,0,90])
								write(rows[j],t=w,h=text_h,center=true); 
					}
				}
				if (day_names == 1)
				translate([text_h/2+w*2,i*(o_y+w)+(o_y+w)/2,w])
					{
						rotate([0,0,90])
							write(days[i],t=w,h=text_h,center=true); 
					}
			}
			assign(y_lid = y_len+w+layer)
			if (nubs == 0){
				for(i=[0,180]){
					translate([dnub,(number_days*(o_y+w)+w)/2,o_z+w-dnub])
					rotate([0,0,i])
					translate([0,(number_days*(o_y+w)+w)/2+w+layer,0])
						rotate([90,0,0])
							union(){
								difference(){
									cylinder(r=1,h = w*2+layer, $fn=16);
									translate([0,0,-1])
										difference(){
											cylinder(r=2, h=3, $fn=16);
											translate([0,0,3])
										   	sphere(r=2, $fn=16);
										}
								}
								if(support_nub_width > 0)
								translate([support_nub_width/2,-0.9,w+layer])
								rotate([0,90,0])
								rotate([180,0,0])
								linear_extrude(height=support_nub_width)
									polygon(points=[[0,0],[0,w*2+layer],[w+layer,0]], path=[0,1,2]);
							}
					
				}
				for(i=[0,1]){
//					translate([dnub, i*(number_days*(o_y+w)+w*2+layer), o_z+w-dnub])
//						rotate([90,0,0]){
//							difference(){
//								linear_extrude(height=w+layer)
//									circle(r=1, $fn=16);
//								translate([0,0,w-1.5+(3)*i+i*(-w+layer-2)])
//									difference(){
//										cylinder(r=2, h=2, $fn=16);
//										translate([0,0,2*i])
//									   	sphere(r=2, $fn=16);
//								}
//							}
////							
//						}
//					translate([x_len-dnub,i*(number_days*(o_y+w)+w-layer*2)+layer,o_z+w-dnub])
					translate([x_len-dnub,i*(number_days*(o_y+w)+w),o_z+w-dnub])
					intersection(){
							sphere(r=1, $fn=16);
							translate([0,i==0?-1+layer:1-layer,0])
								cube([2,1,2],true);
					}
				}
				translate([dnub,y_len,o_z+w-dnub])
				rotate([90,0,0])
					linear_extrude(height=y_len)
						intersection(){
							difference(){
								circle(r=dnub, $fn=16);
								circle(r=dnub-w, $fn=16);
							}
							translate([-2-dnub,0])
								square(2+dnub);
						}
			}
		}//union
		if (nubs == 0){
			translate([dnub,y_len+1,o_z+w-dnub])
				rotate([90,0,0])
					linear_extrude(height=y_len+2)
						difference(){
							translate([-2-dnub,0])
								square(2+dnub);
							circle(r=dnub, $fn=16);
						}
		}
	}
}

module print_lid(){
	x_len = (o_x+w)*number_per_day+w;
	y_len = (o_y+w)*number_days+w;
	dx = nubs == 0 ? layer+w+1 : 0;
	lid_h = dnub*2 > o_z+w+layer ? o_z+w+layer : dnub*2;
	
	//print1();
	difference(){
		translate([-w-layer,-w-layer,-w-layer])
			cube([x_len+w*2+layer*2,y_len+w*2+layer*2,lid_h+w+layer]);
		translate([-layer,-layer,-layer])
			cube([x_len+dx+layer*2,y_len+layer*2,lid_h+w+layer+1]);
		if (nubs == 0){
			for(i=[0,1]){
				translate([x_len-dnub,i*(number_days*(o_y+w)+w*2+layer+1),dnub])
					rotate([90,0,0])
						linear_extrude(height=layer+w+1)
							circle(r=1+layer/2, $fn=16);
				translate([dnub,i*(number_days*(o_y+w)+w)+(i==0?layer:-layer),dnub])
					sphere(r=1+layer, $fn=16);
			}
			translate([x_len,-1-w-layer,-1-w-layer])
				cube([w*2,y_len+w*2+layer*2+2,o_z+lid_h+layer+w+2]);
			
		}
	}
}

