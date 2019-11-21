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
l = number_per_day-1;




//MODULE - subtraction

module inside(){
union()
{
translate([-1,1,1])cube([((length_x*number_per_day)-(2*l)+2),(width_y*number_days)+1,6]);

translate([3,-1,3])
{
rotate([270,0,0]){cylinder(400,2,2);
}
}
}
}

difference(){
translate([0,0,0])cube([((length_x*number_per_day)-(2*l)+2),(width_y*number_days)+3,6]);
inside();
}

