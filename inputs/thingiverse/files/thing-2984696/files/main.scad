//outline = "main.dxf";


//	  linear_extrude(height=1.3, convexity=5) {
//	       import(file=outline, layer="0", $fn=180);
//	     }
//
//	  linear_extrude(height=5, convexity=5) {
//	       import(file=outline, layer="1", $fn=180);
//	     }
//
//

//	translate([0,10,8])
//     rotate([0,90,0])
//     cylinder(h = 50, r = 4.1, center = true, $fn=32);

top_radius = 63 / 2.0;
top_height = 1.5
;
         
bottom_radius = 36 / 2.0;
bottom_height = 7;
bottom_wall = 2;

hole_spacing = 4;         

hole_side = 3;
         

top();

bottom();

module bottom()
{
        
        translate([0,0,top_height])
        bottom_hole(bottom_height);
    
        
        translate([0,0,0])
        color([1,1,1]) bottom_hole(top_height);
        
}
module bottom_hole(height) {
    
    
    difference() {
        
        bottom_part(height);
        
        cylinder(h=height+2, r= bottom_radius-bottom_wall, center = false, $fn=32);
    }
    
}
module top() {        
    translate([0,0,0]);
    
    difference() {
            top_part();
            full_grid();           
    }
    bottom_top();
    
}
module bottom_top()
{
    difference() {
        top_part();
        bottom_part(bottom_height);
    }
}
module top_part()
{  
     color([0,0,1]) cylinder(h=top_height, r= top_radius, center = false, $fn=32);
}
module bottom_part(height)
{
     color([1,0,0])  cylinder(h=height, r= bottom_radius, center = false, $fn=32);
}
// translate([0,0,-10]) square(hole_spacing,false);

spacing = hole_spacing+hole_side;

module full_grid()
{

grid_quadrant(0,spacing, bottom_radius,0, spacing, bottom_radius);
grid_quadrant(0,-spacing, -bottom_radius, 0, spacing, bottom_radius);
grid_quadrant(0,-spacing, -bottom_radius, 0, -spacing, -bottom_radius);
grid_quadrant(0,spacing, bottom_radius, 0, -spacing, -bottom_radius);

}

module grid_quadrant(x_start, x_spacing, x_end, y_start, y_spacing, y_end)
{
    pos = 0;
    for (pos_y = [y_start:y_spacing:y_end]) {
    for (pos_x = [x_start:x_spacing:x_end]) {
            
            translate([pos_x , pos_y , -(top_height/2.0)-0.1]) color([0,1,0]) {
                rotate([0,0,45])
                cylinder ( h=bottom_height+0.1, r=hole_side, center=false, $fn=4);
            }
            
    //            color([0,1,1]) translate([pos-hole_spacing,0,0]) square(hole_spacing,true);

    }
    }
}
 
    