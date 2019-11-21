    
// Bore twin holes (not needed?)
twin_holes = "No"; //[Yes,No]
// Bore center hole, needed only for front supports 
center_hole = "Yes"; //[Yes,No]

// (mm) Extra height to add to the support
extra_height = 0.01; //[0.01:0.1:10]

module stop_var_parsing(){}

inner_diam_small_circle = 5.8;// the inner diameter of the circular holes
dist_small_circles = 13;      // the distance between the outer borders of the two holes
sidewall_thickness = 2.5;     // the sidewall thickness of the 1st part
sidewall_height = 6.8;        // the sidewall height of the 1st part

outer_diam_small_circle = inner_diam_small_circle+2*sidewall_thickness; // add border thickness to circle diam
obj_len=2*inner_diam_small_circle+4*sidewall_thickness+dist_small_circles;  // total object length for the 1st part

translate([obj_len/2,0,-sidewall_height/2])
    difference()
    {
        minkowski()
        {
            cube([outer_diam_small_circle+dist_small_circles,0.01,sidewall_height],true);
            cylinder(d=outer_diam_small_circle,h=0.01, center=true);
        }
        
        if("Yes" == twin_holes)
        {
            translate([obj_len/2-inner_diam_small_circle/2-sidewall_thickness, 0, -sidewall_height])    // the distance from center where to position hole
                cylinder(2*sidewall_height+0.05, d=inner_diam_small_circle,true);
            
            translate([-obj_len/2+inner_diam_small_circle/2+sidewall_thickness, 0, -sidewall_height])   //the distance from center where to position hole
                cylinder(2*sidewall_height+0.05, d=inner_diam_small_circle, true);
        }
        
       if("Yes" == center_hole)
       {
            cube( [dist_small_circles, 6, sidewall_height+0.05], true);
       }
    }




$fn=400;

large_elipse_diameter = 21.5;                       
small_elipse_diameter = outer_diam_small_circle;   

translate([(outer_diam_small_circle+dist_small_circles+small_elipse_diameter)/2,0,extra_height/2])
    minkowski()
    {
        cube([outer_diam_small_circle+dist_small_circles,0.01,extra_height],true);
        cylinder(h=5,d1=large_elipse_diameter,d2=small_elipse_diameter);
    }