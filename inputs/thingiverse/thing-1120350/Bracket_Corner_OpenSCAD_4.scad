/*
Adjustable Corner Bracket -- Version 2
* Print Unsupported
* by Harlo_DX
* 9/11/2015
*/

//brackets sizing
//Width in of the bracket (mm): 
c_w = 5.5; //[5:0.5:100]
//Height of the bracket (mm):
c_h = 20; //[11:0.5:100]
//Depth of the bracket (mm):
c_d = 3; //[0.5:0.25:20]

//Bolt hole diameter in mm:
diameter = 2.5; //[0.25:0.25:30]

//Number of bolt holes:
bolt_holes = 2; //[0,1,2]

//Extra space between bolts:
seperation = 3; //[0.5:0.25:20]


////////////////////
//INTERNAL VARIABLES
////////////////////

hole_size = diameter/2; //radius (multiply by 2 for the diameter)
multiplier = 1*1;  // affects the smoothness of the chamfer -- keep turning up **gradually** to reduce sharp edges.
spread = c_h/5; //NOT FINAL



//////////////////////////////
////////////////////////RENDER
//////////////////////////////

rotate([0,-90,180]){
// initial side of bracket
cut_bracket(); //WORKING
// internal chamfer
corner_chamfer(); //WORKING

//bottom bracket  //WORKING
translate([0,c_d,0]){
    rotate (90, [1,0,0]){ // handles the pivot action
        cut_bracket();
        }
    }
}
//////////////////////////////
/////////////////////FUNCTIONS
//////////////////////////////    
 
module corner_chamfer () {
    
    difference(){
    //cube
    translate([0,-c_d,0]){
    cube([c_w, c_d*2, c_d*2], false);
    }
    
    //cylinder
    translate([-0.5,-c_d,c_d*2]){
        rotate(90, [0,1,0]){
        cylinder(c_w+1, c_d*multiplier, c_d*multiplier, false, $fn = 50);
        }
    }
}
    
}

module cut_bracket(){
    difference(){
        union(){
            //corner_chamfer(); //TEST
            bracket_side(); //WORKING
        }
        if (bolt_holes == 1){
            cut_out();
        }
        
        if (bolt_holes == 2){
        dual_cut_out();
        }
}
}    

module bracket_side () {
    cube([c_w, c_d, c_h], false);
    curved_tip();
}

module curved_tip () {
        translate([0,c_d/2,c_h]){
            rotate(90, [0,1,0]){
                cylinder(c_w, (c_d/2)*multiplier, (c_d/2)*multiplier, false, $fn = 50);
                }
           }
    }
    
module dual_cut_out(){
        translate([0, 0, -(hole_size + seperation)]){
        cut_out();
        }
        translate([0, 0, hole_size + seperation]){
        cut_out();
        }        
        }

module cut_out (){
    
    //This hull function lets you print without support
    hull(){
        
        $fn=50; //defines resolution

    translate([
        c_w/2
        ,c_d+1
        ,(c_h +(c_w/2)+(hole_size/2))*0.5]){
        rotate(90, [1,0,0]){
            cylinder(c_d+5, hole_size, hole_size, false);
        }
    }
    
    translate([
    (c_w/2)+((hole_size)*1.5) //Shifts across by an extra 50% of the hole_size value
    ,c_d+1
    ,(c_h+(c_w/2)+(hole_size/2))*0.5])
        {
        rotate(90, [1,0,0]){
            cylinder(c_d+5, hole_size*0.01, hole_size*0.01, false);
        }
    }
}

}