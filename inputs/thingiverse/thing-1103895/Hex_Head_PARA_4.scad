/////////////////////////////////////////////
//////////////// VARIABLES
/////////////////////////////////////////////

/////INTERNAL VARIABLES

/*
Diameter Sizes: 

    MUST BE DEFINED FIRST

[Diameter of bolt, 
    Diameter of nut = MAX,
    Depth of the nut - MAX]
*/

//ignore variable values
M3 = [3, 6.01, 2.12]*1;  //*1 is to hide the variables from Customizer
M4 = [4, 7.66, 2.92]*1; 
M5 = [5, 8.79, 3.65]*1; 
M6 = [6, 11.05, 4.15]*1; 
M7 = [7, 12.12, 4.95]*1;
M8 = [8, 14.38, 5.45]*1;
M10 = [10, 18.9, 6.56]*1;
M12 = [12, 21.1, 7.68]*1;
M14 = [14, 24.49, 8.98]*1;
M16 = [16, 26.75, 10.18]*1;
M18 = [18, 30.14, 11.72]*1;
M20 = [20, 33.53, 12.72]*1;
M22 = [22, 35.72, 14.22]*1;
M24 = [24, 39.98, 15.22]*1;
M27 = [27, 45.2, 17.35]*1;
M30 = [30, 50.85, 19.12]*1;
M33 = [33, 55.37, 21.42]*1;
M36 = [36, 60.79, 22.92]*1;
M39 = [39, 66.44, 25.43]*1;
M42 = [42, 71.3, 26.42]*1;
M45 = [45, 76.95, 28.42]*1;
M48 = [48, 82.60, 30.42]*1;

//FOR TESTING
exploded = 0*1;
res = 1*120;

////////////////////////EXTERNAL VARIABLES


//Metric Bolt Type
user_bolt_type = "M3"; //[M3, M4, M5, M6, M7, M8, M10, M12, M14, M16, M18, M20, M22, M24, M27, M30, M33, M36, M39, M42, M45, M48]

//Render the full bolt, just the head or a hex head with a bolt protuding from both ends:
show = "through"; //[full, through, head]

// Tolerance Adjustment in mm - increase to account for material shrinkage - 0.5 is a good start for ABS: 
tolerance = 0.5; //[0: 0.1: 2.0]

//Manually set bolt length in mm (over-rides the standard multiplier below): 
manual_bolt_length = 10;

//Length of bolt x bolt head size multiplier: 
bolt_length_multiplier = 2; //[0:0.5:10]

//Extra Hex Head depth in mm (over standard):
extra_head_depth = 0; //[0:0.25:50]


//Multiplier for through value:
bolt_length_through = bolt_length_multiplier * 2; //MUST follow other variables.




/////////////////////////////////////////////
//////////////// RENDERS
/////////////////////////////////////////////

bolt_type_if_statements();


/////////////////////////////////////////////
//////////////// MODULES
/////////////////////////////////////////////



//renders the final bolt dependant on what display variable is set
module final(h_l, h_s, b_s){
b_l = b_s * bolt_length_multiplier;
head(h_l, h_s);
if (show != "head"){

    if(show == "through"){

            bolt_blank(b_l, b_s, h_l);
            mirror([0,0,1]){
                bolt_blank(b_l, b_s, h_l);
                }
            }
            
    else {
        bolt_blank(b_l, b_s, h_l);
        }
}
}

//generates the bolt's HEX head
module head(h_l, h_s){

cylinder(h = h_l + tolerance + extra_head_depth, d = h_s + tolerance, center = true, $fn = 6);

}

//handles positioning of the blank dependant on whether a manual bolt length is selected or not, among other factors
module bolt_blank(b_l, b_s, h_l){
    
    if (manual_bolt_length != 0){
        translate([0,0,(h_l/2)+(manual_bolt_length/2)+exploded + (extra_head_depth/2)]){
    blank_a(manual_bolt_length, b_s);
    
        }
    }
    
    else {
    translate([0,0,(h_l/2)+(b_l/2)+exploded + (extra_head_depth/2)]){
    blank_a(b_l, b_s);
    }
    
    }
}

//Main blank for the circular bolt section
module blank_a(b_l, b_s){
    
        cylinder(h = b_l, d = b_s + tolerance, center = true, $fn = res);
}


//Handles the different bolt types that could be selected
module bolt_type_if_statements(){

if (user_bolt_type == "M3"){
final(M3[2], M3[1], M3[0]);
}

if (user_bolt_type == "M4"){
final(M4[2], M4[1], M4[0]);
}

if (user_bolt_type == "M5"){
final(M5[2], M5[1], M5[0]);
}

if (user_bolt_type == "M6"){
final(M6[2], M6[1], M6[0]);
}

if (user_bolt_type == "M7"){
final(M7[2], M7[1], M7[0]);
}

if (user_bolt_type == "M8"){
final(M8[2], M8[1], M8[0]);
}

if (user_bolt_type == "M10"){
final(M10[2], M10[1], M10[0]);
}

if (user_bolt_type == "M12"){
final(M12[2], M12[1], M12[0]);
}

if (user_bolt_type == "M14"){
final(M14[2], M14[1], M14[0]);
}

if (user_bolt_type == "M16"){
final(M16[2], M16[1], M16[0]);
}

if (user_bolt_type == "M18"){
final(M18[2], M18[1], M18[0]);
}

if (user_bolt_type == "M20"){
final(M20[2], M20[1], M20[0]);
}

if (user_bolt_type == "M22"){
final(M22[2], M22[1], M22[0]);
}

if (user_bolt_type == "M24"){
final(M24[2], M24[1], M24[0]);
}

if (user_bolt_type == "M27"){
final(M27[2], M27[1], M27[0]);
}

if (user_bolt_type == "M30"){
final(M30[2], M30[1], M30[0]);
}

if (user_bolt_type == "M33"){
final(M33[2], M33[1], M33[0]);
}

if (user_bolt_type == "M36"){
final(M36[2], M36[1], M36[0]);
}

if (user_bolt_type == "M39"){
final(M39[2], M39[1], M39[0]);
}

if (user_bolt_type == "M42"){
final(M42[2], M42[1], M42[0]);
}

if (user_bolt_type == "M45"){
final(M45[2], M45[1], M45[0]);
}

if (user_bolt_type == "M48"){
final(M48[2], M48[1], M48[0]);
}
}