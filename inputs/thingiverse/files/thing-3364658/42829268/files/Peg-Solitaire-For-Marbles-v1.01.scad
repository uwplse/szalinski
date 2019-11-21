/*---------------------------------------------------------
Parametric Peg Solitaire for Marbles/ Ball Bearings.
Design by Jon Frosdick em: jon@bee53.com on 17-Jan-2019.

licenced under Creative Commons :
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)
http://creativecommons.org/licenses/by-nc-sa/4.0/

Basic Instructions - OpenSCAD:
1. The parameters below can be adjusted, though not all need to be.
2. make any required changes then hit F5 to view the model.
3. Press F6 to render and then export to STL.
4. Slice in your favourite software and print.
5. How to play -> https://en.wikipedia.org/wiki/Peg_solitaire

disclaimer: This is my first design with openSCAD, please excuse inefficiencies and badly named variables, I ran out of time to optimise/tidy before heading to work, I'll try to update later.   

v1.01 - Modified $fn variable to try to get it playing nicely with Customizer.
v1.0 - First upload
---------------------------------------------------------*/

//CUSTOMIZER VARIABLES
//these most likely should be changed

//Select the shape of the base of the solitaire game (note: octagon is slow to render).
base_shape = "circle"; //[square, octagon, circle]

//true for standard board, false for European variant (four extra holes).
standard_board = "true"; //[true,false]

//Select a height in mm for the base, around 12 is often good enough.
base_z = 12; //[6:25]

//Select the diameter of marble/ball you're going to use, this affects the diameter of the holes and groove, I used 14mm marbles. Increase this by 1 if you want the holes a little larger than the balls/marbles.
hole_d = 14; //[6:20]

//these most likely shouldn't need to be changed
//Optionally change the depth of each hole in mm
hole_z = 5.5; //[2:10]

//distance between the centres of each hole, note: must be greater than hole_d.
hole_spacing = 22; //[6:30]

//depth of the groove.
groove_z = 6.5; //[2:20]

//distance in mm between holes and groove note some of the base shapes have naturally ocurring inner space.
groove_inner_spacing = 2.5; //[0:10]

//distance in mm between groove and outside of the board.
groove_outer_spacing = 5; //[0:10]

//corner radius (actually diamter) of base bottom corners.
bot_cr = 3; //[0:10]

//corner radius (diameter) of base top corners.
top_cr = 6; //[0:10]

//Select number of fragments for rendering. This affects smoothness of curves but increases rendering time. OpenSCAD may handle larger numbers easier than Customizer.
rendering_fragments = 24; //[16:64] 
//CUSTOMIZER VARIABLES END

//---------------------------------------------------------------------------------------

$fn = rendering_fragments;






//edits below this line may break the 3d model (or quite possibly they may improve it...)
base_auto = true; //if set to true, base size is calculated from ball size and spacing [true].
base_x = groove_outer_spacing * 2 + groove_inner_spacing * 2 + hole_d * 3 + hole_spacing * 6;

if (base_shape == "square") {
    make_square_base(); 
} else if (base_shape == "octagon") {
    make_octagon_base();
} else if (base_shape == "circle") {
    make_circle_base();
} else {
    echo ("Error - base_shape value incorrect");
}
base_y = base_x;  


module make_square_base(){
    difference(){
        //board
        hull(){
            //upper corners
            ttemp_z = base_z-top_cr/2;
            tl = top_cr/2;
            tr = base_x - tl;
            tb = tl;
            tt = base_y-tb;
            translate([tr, tt, ttemp_z]) //rt
            sphere(d=top_cr);
            translate([tl, tt, ttemp_z]) //lt
            sphere(d=top_cr);
            translate([tr, tb, ttemp_z]) //rb
            sphere(d=top_cr);
            translate([tl, tb, ttemp_z]) //lb
            sphere(d=top_cr);
            
            //lower corners
            temp_z = bot_cr/2;
            l = bot_cr/2;
            r = base_x - l;
            b = l;
            t = base_y-b;
            translate([r, t, temp_z]) //rt
            sphere(d=bot_cr);
            translate([l, t, temp_z]) //lt
            sphere(d=bot_cr);
            translate([r, b, temp_z]) //rb
            sphere(d=bot_cr);
            translate([l, b, temp_z]) //lb
            sphere(d=bot_cr);    
        }
        make_hole_pattern(base_x/2, base_y/2);
        //groove
        gl = groove_outer_spacing + hole_d/2;
        gt = base_y - hole_d/2 - groove_outer_spacing;
        gb = groove_outer_spacing + hole_d/2;
        gr = base_x - hole_d/2 - groove_outer_spacing;
        gz = base_z - groove_z + hole_d/2;
        
        hull(){
            translate([gl, gt, gz])
            sphere(d = hole_d);
            translate([gl, gb, gz])
            sphere(d = hole_d);
        }
        hull(){
            translate([gl, gt, gz])
            sphere(d = hole_d);
            translate([gr, gt, gz])
            sphere(d = hole_d);
        }
        hull(){
            translate([gr, gt, gz])
            sphere(d = hole_d);
            translate([gr, gb, gz])
            sphere(d = hole_d);
        }
        hull(){
            translate([gr, gb, gz])
            sphere(d = hole_d);
            translate([gl, gb, gz])
            sphere(d = hole_d);
        }
    }
}
module make_circle_base(){
    tmpx = base_x * 1.05; //modifier as circle needs a little more space than other shapes
    echo ("Total width is ", tmpx, " mm.");
    
    difference(){
        //board
        translate([tmpx/2, tmpx/2, 0])
        hull(){
            //upper donut
            translate([0,0, base_z-top_cr/2])
            rotate_extrude(convexity = 10, $fn = 100)
            translate([tmpx/2-top_cr/2, 0, 0])
            circle(d = top_cr, $fn = 100);
            
            //lower donut        
            translate([0,0, bot_cr/2])
            rotate_extrude(convexity = 10, $fn = 100)
            translate([tmpx/2-bot_cr/2, 0, 0])
            circle(d = bot_cr, $fn = 100);
        }
        
        make_hole_pattern(tmpx/2, tmpx/2);
        
        //groove
        gz = base_z - groove_z + hole_d/2;
        
        translate([tmpx/2, tmpx/2, gz])
        rotate_extrude(convexity = 10, $fn = 100)
        translate([tmpx/2 - bot_cr/2 - groove_outer_spacing*2, 0, 0])
        circle(d = hole_d+1, $fn = 100);
        }//difference
} 

module make_octagon_base(){
    difference(){
        //board
        hull(){
            //upper corners
            trad = ((base_x-top_cr)/2) / cos(22.5);   
            translate([base_x/2, base_y/2, base_z-top_cr/2])       
            for (i = [22.5: 45: 337.5]){
                translate([trad * cos(i), trad * sin(i), 0])
                sphere(d=top_cr);
            }
            
            //lower corners
            t2rad = ((base_x-bot_cr)/2) / cos(22.5);   
            translate([base_x/2, base_y/2, bot_cr/2])       
            for (i = [22.5: 45: 337.5]){
                translate([t2rad * cos(i), t2rad * sin(i), 0])
                sphere(d=bot_cr);
            }
        }
        make_hole_pattern(base_x/2, base_y/2);
        
        //groove
        gz = base_z - groove_z + hole_d/2;
        t3rad = ((base_x-bot_cr)/2-groove_outer_spacing*2) / cos(22.5);   
              
        for (i = [22.5: 45: 337.5]){
            translate([base_x/2, base_y/2, gz]) 
            hull(){
                translate([t3rad * cos(i), t3rad * sin(i), 0])
                sphere(d=hole_d);
                translate([t3rad * cos(i+45), t3rad * sin(i+45), 0])
                sphere(d=hole_d);
            }
        }
    }
}


module make_hole_pattern(xx, yy){ 
    //xx, yy is centre point
    tz = base_z + hole_d/2 - hole_z;
    ty = yy - (4 * hole_spacing);

    for (b = [1: 7]) {
        if (b == 1 || b == 7 ){
            make_holes(3, xx, ty + (b * hole_spacing), tz);
        } else if ((b == 2 && standard_board=="true") || (b == 6 && standard_board=="true")) {
            make_holes(3, xx, ty + (b * hole_spacing), tz);
        } else if ((b == 2 && standard_board=="false") || (b == 6 && standard_board=="false")) {
            make_holes(5, xx, ty + (b * hole_spacing), tz);
        } else {
            make_holes(7, xx, ty + (b * hole_spacing), tz);
        }
    }
}

module make_holes(qty, px, py, pz){ //px, py, pz = centre point
    start_x = px - (round(qty / 2) * hole_spacing);
    
    for (a = [1: qty]) {
        translate([start_x + (hole_spacing * a), py, pz])
        sphere(d=hole_d);
    }
}












