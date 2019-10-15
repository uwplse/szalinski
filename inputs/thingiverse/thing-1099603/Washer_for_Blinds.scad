/*

By Harlo
 - 29/10/2015
 - Customizable Ring Washer 

*/



/////////////////////////////////////////////
//////////////// VARIABLES
/////////////////////////////////////////////

// Resolution of circle
res = 120; //[32, 64, 120, 200]
// Inner diameter in mm that will be cut out
inner_dia = 7; //[1:0.5:199]
// Outer diameter in mm that will form the main body of the washer
outer_dia = 20; //[10:0.5:200]
// Thickness/Depth in mm of the washer 
thickness = 0.5; //[0.5:0.5:10] 

/////////////////////////////////////////////
//////////////// RENDERS
/////////////////////////////////////////////


final();

/////////////////////////////////////////////
//////////////// MODULES
/////////////////////////////////////////////

module final(){
    difference(){
        outer_circle();
        inner_circle();
    }


}

module outer_circle(){
    
    cylinder (h = thickness, d = outer_dia, center = true, $fn = res);


}

module inner_circle(){
     cylinder (h = thickness+1, d = inner_dia, center = true, $fn = res);


}