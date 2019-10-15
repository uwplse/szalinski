//Copyright Hsiao-yu Chen 2016

//Pen Loop, Style 1



//model for a simple pen loop for notebooks and journals.
//


// 
// Designed #1: for simple mounting on front of back covers of a notebook. 

//Parameters:

//height: the length of pen section to hold
height = 10;

//inner_dia : should be the diameter of pen with a bit of slack
inner_dia = 14;
//thickness : thickness of both tab and loop
thickness = 1.1;
//tab_width : how wide the tab is
tab_width = 25;


module pen_loop_1(height, inner_dia, thickness, tab_width, smoothness = 180){
    radius = inner_dia / 2.0;
    

    difference(){
        union () {
            //a tab to attach to paper
            translate([0, radius, 0])
                cube(size =[tab_width, thickness / 2.0, height]);
      
            //main body cylindar
            cylinder($fn=smoothness, h=height, d=inner_dia+thickness);
            
            //fillet
            translate([0,0 ,0]) cube(size=[radius, inner_dia / 2.0, height]);
        }; //union
        
        //hallow out inner_diameter cylindar
        cylinder($fn=smoothness,  h=height, d=inner_dia);
        };
} //module
        


//Examples:
//LAMY Safari butt
//pen_loop_1(10, 13, 1.1, 25, 180);
//LAMY Safari Cap:
//pen_loop_1(10, 15, 1.1, 25, 180);

//Rotring Artpen cap
//pen_loop_1(35, 14, 1.1, 25, 180);

pen_loop_1(height, inner_dia, thickness,tab_width);
