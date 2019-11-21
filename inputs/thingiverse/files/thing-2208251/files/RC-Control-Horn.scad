/*
*Created by Howard Chen (Jan 19 / 2017)
*Updated (Jan 20 / 2017) +User Editable Values
*Updated (Jan 21 / 2017) =Fixed Tangential Vectors
*Updated (Jan 22 / 2017) +Ability to change connection point
*Updated (Jun 14 / 2017) +Attachment Holes
*For Elgin Park Secondary
*Open source - 
*Feel free to alter and change things to your liking :)
*
*FOR RC PLANE AELERONS FLAPS WITH STEEL ROD SERVO SYSTEMS
*
*/


        
/*
---Edit these variables---
*/
control_horn_thickness = 2.2;    //Minimum = 1.3; Default = 2.2
control_horn_height = 6.5;       //Minimum = 6.5; Default = 6.5
control_horn_length = 50;        //Minimum = 18;  Default = 50
triangle_margin_top_bottom = 2;  //Minimum = 1;   Default = 2
triangle_margin_left = 2;        //Minimum = 1;   Default = 2
control_rod_circle_radius = 3.1; //Minumum = ?;   Default = 3.1
attachment_pos_left = 0;         //Minimum = 0;   Default = 0
attachment_pos_right = 18;       //Minimum = 5;   Default = 18
attachment_hole = false;         //Boolean;       Default = false
attachment_hole_radius = 1.5;    //Minimum = 0.2; Default = 1.5
    
//xpos and ypos calculated from (0,3)
control_rod_xpos = -27.4;        //Minimum = 0;   Default = -27.4
control_rod_ypos = 7.9;          //Minimum = 7;  Default = 7.9
/*
---Do not change after this---
*/
    
module control(){
    
    
    
    
    
    
    //DO NOT EDIT BELOW THIS LINE PLEASE :)
    //----------------------------------------------------------//
    control_rod_circle_xpos = control_rod_xpos;
    control_rod_circle_ypos = control_rod_ypos + 3;    
    
    posl = -18 + attachment_pos_left;
    posr = -18 + attachment_pos_right;
    
    triangle_margin_top = triangle_margin_top_bottom; //How far away the triangles have to be from the top
    triangle_margin_bottom = triangle_margin_top_bottom; //bottom
    triangle_height = control_horn_height - 
                      (triangle_margin_top + triangle_margin_bottom);
    
    translate([0,0,control_horn_thickness/2])
    linear_extrude(height = control_horn_thickness, center = true, convexity = 10,slices = 20, scale = 1) {
        
        a = [[-18,3 - control_horn_height],
            [-18,3],
            [control_horn_length -18,3],
            [control_horn_length -18,3 - control_horn_height]];
        
        tmp = -18 + triangle_margin_left + (triangle_height / 2); //middle x point
        ttc = 3 - triangle_margin_top; //top_coord
        tbc = 3 - control_horn_height+triangle_margin_top;//bot_coord
        tlc = 0 - (triangle_height/2); //left_coord
        trc = 0 + (triangle_height/2); //right_coord
        
        th = triangle_height;
        
        b = [[tlc,tbc],[trc,tbc],[0,ttc]];
        
        overlap = 3-triangle_margin_top;
        offset_y = (overlap* 2 - triangle_height);
        
        triangle_unit = triangle_height + triangle_margin_left;
        
        num_triangles_bot = floor((control_horn_length - triangle_margin_left) / triangle_unit);
        num_triangles_top = floor((control_horn_length- triangle_margin_left-(triangle_height/2)) / triangle_unit);
        
       
        
        r = control_rod_circle_radius;
        
        p1x = posr;
        p1y = 3;
        d1x = control_rod_circle_xpos - p1x;
        d1y = control_rod_circle_ypos - p1y;
        d1 = sqrt(pow(d1x,2) + pow(d1y,2));
        dt = asin(r/d1);
        da = atan2(d1y, d1x);
        
        t1 = da - dt;
        t2 = da + dt;
        a1 = t1 - 90;
        
        tp1 = [r * sin(t1) + control_rod_circle_xpos, r * -cos(t1) + control_rod_circle_ypos];
        tp2 = [r * -sin(t2) + control_rod_circle_xpos, r * cos(t2) + control_rod_circle_ypos];
        
        p1x_ = posl;
        p1y_ = 3;
        d1x_ = control_rod_circle_xpos - p1x_;
        d1y_ = control_rod_circle_ypos - p1y_;
        d1_ = sqrt(pow(d1x_,2) + pow(d1y_,2));
        dt_ = asin(r/d1_);
        da_ = atan2(d1y_, d1x_);
        t1_ = da_ - dt_;
        t2_ = da_ + dt_;
        a1_ = t1_ - 90;
        
        tp1_ = [r * sin(t1_) + control_rod_circle_xpos, r * -cos(t1_) + control_rod_circle_ypos];
        tp2_ = [r * -sin(t2_) + control_rod_circle_xpos, r * cos(t2_) + control_rod_circle_ypos];
        
        /*
        *DRAW OBJECTS
        */
        difference(){
            union(){
                difference(){
                    polygon(a);
                    for(i=[0:1:num_triangles_bot-1])
                        translate([tmp + i * (triangle_unit),0,0])
                            polygon(b);
                
                    for(i=[0:1:num_triangles_top-1])
                        translate([tmp + triangle_unit/2,offset_y,0])
                                rotate(180){
                                    translate([-(triangle_unit * i),0,0])
                                        polygon(b);  
                                } 
                }
                
                
                polygon([tp2,tp1,[posr,3]]);
                polygon([tp2_,tp1_,[posl,3]]);
                polygon ([[posr,3],[posl,3],[control_rod_circle_xpos,control_rod_circle_ypos]]);
                
                translate([control_rod_circle_xpos,control_rod_circle_ypos,0])
                    circle(control_rod_circle_radius, $fn=246);
            }   
            if(attachment_hole)
                translate([control_rod_circle_xpos,control_rod_circle_ypos,0])
                    circle(attachment_hole_radius, $fn=246);
        }
    }
}

control();