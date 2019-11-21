/*CHANGES FOR THINGIVERSE 
*Removed on/off switch hole
*Cover and tab height back to 2
*Customization options
*added holes on back aswell as front
*/

//CUSTOMIZATION START

//Render Quality
render_quality = 200; //[20:Low Quality, 40:Higher Quality, 60:Production Quality]

$fn = render_quality+0;

//change the length
length = 73;  //[50:200]

//change the width
width = 47; //[25:150]

//change the thickness (note: cover will add 2mm to thickness)
thickness = 25; //[5:50]

//Add a celtic circle?
celtic_circle = 0; //[0:Yes, 1:No]

//Add a tree hook?
tree_hook = 0; //[0:Yes, 1:No]

//Add some holes?
num_of_holes = 4; //[0, 1, 2, 3, 4]

//View
view = 1; //[0:Separated View, 1:Assembled View]

//CUSTOMIZATION END
rotate([0, 45, -45])
scale([length/73, width/47, thickness/25]){
    color("lime")
//////////////////////////////MAIN OBJECT//////////////////////////////////
    difference(){
        //solid objects
        union(){
            //center cube
            cube([10, 10, 25], center = true);
            
            //bottom of large vertical part
            translate([5, 0, 0]){
                hull(){
                    cube([.1, 10, 25], center = true);
                    translate([42.5, 0, 0])
                        cube([2, 25, 25], center = true);
                }
            }
            
            //top of large vertical part
            translate([-5, 0, 0]){
                hull(){
                    cube([.1, 10, 25], center = true);
                    translate([-17.75, 0, 0])
                        cube([2, 25, 25], center = true);
                }
            }
            
             //left side of horizontal cross section (when looking from bottom)
            translate([0, -5, 0]){
                hull(){
                    cube([10, .1, 25], center = true);
                    translate([0, -17.75, 0])
                        cube([25, 2, 25], center = true);
                }
            }
            
            //right side of horizontal cross section (when looking from bottom)
            translate([0, 5, 0]){
                hull(){
                    cube([10, .1, 25], center = true);
                    translate([0, 17.75, 0])
                        cube([25, 2, 25], center = true);
                }
            }
            
            //celtic circle
            if(celtic_circle == 0){
                difference(){
                    cylinder(25, d = 44, center = true);
                            //MINUS//
                    translate([0, 0, 2])
                        cylinder(30, d = 34, center = true);
                }
            }
            
            //tabs to hold cover in place
            //right side (when looking from bottom)
            translate([0, 22.5, 13.5])
                //equations are so the tabs are exactly 1mm smaller than the slots no matter what the scale is
                cube([10 - (1/(length/73) * 1), 2 - (1/(width/47) * 1), 3 + (1/(thickness/25) * 1)], center = true);  
            //left side (when looking from bottom)
            translate([0, -22.5, 13.5])
                cube([10 - (1/(length/73) * 1), 2 - (1/(width/47) * 1), 3 + (1/(thickness/25) * 1)], center = true);   
        }
//////////////////////////////////MINUS/////////////////////////////////// 
        //hollow objects
        union(){
            //center cube
            translate([0, 0, 3]){
                cube([8, 13, 25], center = true);
                translate([1, 0, 0])
                    cube([15, 8, 25], center = true);
            }
            
             //bottom of large vertical part
            translate([7.5, 0, 3]){
                scale([.9, .8, 1]){
                    hull(){
                        cube([.1, 10, 25], center = true);
                        translate([42.5, 0, 0])
                            cube([2, 25, 25], center = true);
                    }
                }
            }
            
            //top of large vertical part
            translate([-6.3, 0, 3]){
                scale([.85, .8, 1]){
                    hull(){
                        cube([.1, 10, 25], center = true);
                        translate([-17.75, 0, 0])
                            cube([1, 25, 25], center = true);
                    }
                }
            }
            
             //left side of horizontal cross section
            translate([0, -6.3, 3]){
                scale([.8, .8, 1]){
                    hull(){
                        cube([10, .1, 25], center = true);
                        translate([0, -17.75, 0])
                            cube([25, 2, 25], center = true);
                    }
                }
            }
            
            //right side of horizontal cross section
            translate([0, 6.3, 3]){
                scale([.8, .8, 1]){
                    hull(){
                        cube([10, .1, 25], center = true);
                        translate([0, 17.75, 0])
                            cube([25, 2, 25], center = true);
                    }
                }
            }
            
            if(tree_hook == 0){
                //tree hook on top 
                translate([-25, 0, 0]){
                    rotate([0, 90, 0]){
                        difference(){
                            cylinder(10, d = 10, center = true);
                                    //MINUS//
                            cube([10, 3, 10], center = true);
                        }
                    }
                }
            }
            //lightbulb hole on top
            if(num_of_holes == 1 || num_of_holes >= 3){
                translate([-16, 0, -2])
                cylinder(24, d = 6, center = true); 
            }
                    
            //lightbulb holes on sides
            if(num_of_holes >= 2){
                //lightbulb hole on left (when looking from top)
                translate([0, 16, -2])
                cylinder(24, d = 6, center = true); 
                        
                //lightbulb hole on right (when looking from top)
                translate([0, -16, -2])
                cylinder(24, d = 6, center = true);
            }
                    
            //lightbulb hole on bottom
            if(num_of_holes == 4){
                translate([41, 0, -2])
                cylinder(24, d = 6, center = true); 
            }
        }
    }
////////////////////////////COVER//////////////////////////////////////////
color("red")
translate([0, view*60 - 60, (view/(thickness/25))*thickness/2 + 1]){ 
        difference(){
            //solid object
            union(){
                //center cube
                cube([10, 10, 2], center = true);
                
                //bottom of large vertical part
                translate([5, 0, 0]){
                    hull(){
                        cube([.1, 10, 2], center = true);
                        translate([42.5, 0, 0])
                            cube([2, 25, 2], center = true);
                    }
                }
                    
                //top of large vertical part
                translate([-5, 0, 0]){
                    hull(){
                        cube([.1, 10, 2], center = true);
                        translate([-17.75, 0, 0])
                            cube([2, 25, 2], center = true);
                    }
                }
                    
                //left side of horizontal cross section
                translate([0, -5, 0]){
                    hull(){
                        cube([10, .1, 2], center = true);
                        translate([0, -18.25, 0])
                            cube([25, 5, 2], center = true);
                    }
                }
                    
                //right side of horizontal cross section
                translate([0, 5, 0]){
                    hull(){
                        cube([10, .1, 2], center = true);
                        translate([0, 18.25, 0])
                            cube([25, 5, 2], center = true);
                    }
                }
            }
    /////////////////////////////////////MINUS/////////////////////////////////
//hollow objects
            union(){      
                //lightbulb hole on top
                if(num_of_holes == 1 || num_of_holes >= 3){
                    translate([-16, 0, -2])
                    cylinder(24, d = 6, center = true); 
                }
                    
                //lightbulb holes on sides
                if(num_of_holes >= 2){
                    //lightbulb hole on left (when looking from top)
                    translate([0, 16, -2])
                    cylinder(24, d = 6, center = true); 
                        
                    //lightbulb hole on right (when looking from top)
                    translate([0, -16, -2])
                    cylinder(24, d = 6, center = true);
                }
                    
                //lightbulb hole on bottom
                if(num_of_holes == 4){
                    translate([41, 0, -2])
                    cylinder(24, d = 6, center = true); 
                }
                    
                //slots for cover tabs to fit into
                //right side (when looking from bottom)
                translate([0, 22.5, 0])
                    cube([10, 2, 3], center = true);  
                //left side (when looking from bottom)
                translate([0, -22.5, 0])
                    cube([10, 2, 3], center = true);  
            }
        }
    }     
}