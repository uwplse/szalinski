use <write.scad>
include <write/Write.scad>

//LABELS FOR CUSTOMIZER

//boxes

//Applies To Each "Individual" Container
Length_For_Each_Compartment = 20; //[1:50]

//Applies To Each "Individual" Container
Width_For_Each_Compartment = 35; //[1:50]

//Applies To Entire Model
Height_For_Entire_Model = 15; //[1:50]


//number of boxes

number_days = 7; // [1,2,3,4,5,6,7,8,9,10]
number_per_day = 3; // [1,2,3,4,5,6]

//letters

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

//nub parameter

nubs = 0; //[0:Yes,1:No,2]
//Click Yes If You Are Printing A Lid



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

//number of times per day
n = number_per_day-2;

//MODULES
//box designs

//BOX1
module box()
{
difference(){
cube([o_x,o_y,o_z]);
translate([2,2,2]){
cube([i_x,i_y,i_z]);
}}}

//BOX2
module box2()
{
difference(){
cube([o_x,o_y,o_z]);
translate([2,2,2]){
cube([i_x,i_y+2,i_z]);
}}}

//MODULES
//rows
module row()
{
for ( i = [0 : d] )
{
translate([o_x-2,o_y*i,0])box2();   
}
translate([o_x-2,o_y*e,0])box();
}

//ACTUAL SCRIPT

//BOX
if (n < 0)
{
for ( i = [0 : d] )
{
translate([0,o_y*i,0])box2();   
}
translate([0,o_y*e,0])box();
} else {

for ( i = [0 : d] )
{
translate([0,o_y*i,0])box2();   
}
translate([0,o_y*e,0])box();

for ( k = [0 : n] )
{
translate([(o_x-2)*k,0,0])row();   
}
}


//NUBS

if (nubs == 0){

//nub 1
translate([1.5,0,o_z-1.5])rotate([90,0,0])linear_extrude(height=2)circle(r=1);

//nub 2
translate([1.5,(number_days*o_y+2),o_z-1.5])rotate([90,0,0])linear_extrude(height=2)circle(r=1);
}



//WORDS

//ROW 1

for ( i = [0 : e] )
{
translate([length_x/2,(width_y/2)+(width_y*i+2),3])rotate([0,0,90])write(row_one,t=2,h=8,center=true); 
}

//ROW 2

if (number_per_day>1)
{
for ( i = [0 : e] )
{
translate([length_x*1.5-2,(width_y/2)+(width_y*i+2),3])rotate([0,0,90])write(row_two,t=2,h=8,center=true); 
}
}

//ROW 3

if (number_per_day>2){
for ( i = [0 : e] )
{
translate([length_x*2.5-4,(width_y/2)+(width_y*i+2),3])rotate([0,0,90])write(row_three,t=2,h=8,center=true); 
}
}

//ROW 4

if (number_per_day>3){
for ( i = [0 : e] )
{
translate([length_x*3.5-6,(width_y/2)+(width_y*i+2),3])rotate([0,0,90])write(row_four,t=2,h=8,center=true); 
}
}

//ROW 5

if (number_per_day>4){
for ( i = [0 : e] )
{
translate([length_x*4.5-8,(width_y/2)+(width_y*i+2),3])rotate([0,0,90])write(row_five,t=2,h=8,center=true); 
}
}

//ROW 6

if (number_per_day>5){
for ( i = [0 : e] )
{
translate([length_x*5.5-10,(width_y/2)+(width_y*i+2),3])rotate([0,0,90])write(row_six,t=2,h=8,center=true); 
}
}


