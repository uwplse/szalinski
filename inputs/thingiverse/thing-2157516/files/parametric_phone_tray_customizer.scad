// Length of phone or object
phone_length = 138; 
// Width of phone or object
phone_width = 68; 
// Thickness of phone. How high to make the walls above top of base.
phone_thickness = 10;
// Radius of corners
corner_radius = 8;  
// Extra room/play/fudge-factor. Use this to adjust fit.
gap = 0; 
// thickness of walls and base
wall_thickness = 1;  
base_thickness = 1;

// 0 solid side walls, 1 for cutawayside cutaway side walls
side_cutaway = 1;       
// 0 solid top/bottom walls, 1 for cutaway top/bottom walls
top_bottom_cutaway = 1; // 0=no top/bottom cutaway
// 0 for solid base, 1 for cutaway in base
base_cutaway = 1;       // 0=no base cutaway

// Height of Lip between top of base and lowest point of cutaway
side_lip = 1; 
// Percentage of side's length to cut away (0-1)
side_percent = 0.75;
// Height of Lip between top of base and lowest point of cutaway
top_bottom_lip = 1; 
// Percentage of length of top/bottom wall to cut away (0-1)
top_bottom_percent = 0.8; 
// Percentage of base to cut away (0-1)
base_cutaway_percent = 0.75; 

module cube_rect_rounded(sx,sy,sz,rad,ct)
{
    // remove radius so shape keeps outer dimensions
    sxp =sx-2*rad;
    syp =sy-2*rad;
    
    hull()
    {
        for(x=[-1,+1])
        for(y=[-1,+1])
            translate([x*sxp/2,y*syp/2,0])
                cylinder(r=rad,h=sz, center=ct);
     }
  
 }


module tray()
{
$fn=100;

// add margin
phone_length = phone_length + gap; 
phone_width  = phone_width + gap; 


// calculate outer dimensions based on inner size and wall thickness
tray_o_ln=phone_length + 2 * wall_thickness;
tray_o_wd=phone_width + 2 * wall_thickness;
tray_o_ht=phone_thickness + base_thickness;
tray_o_rad=corner_radius + wall_thickness;
    
    

    difference()
    {
        // stuff to add
        union()
        {
            difference () 
            {
                cube_rect_rounded(tray_o_ln, tray_o_wd, tray_o_ht, tray_o_rad,false);
                translate([0,0,base_thickness])cube_rect_rounded(phone_length, phone_width,phone_thickness+1,corner_radius,false);
            }                 
        }   
        
        // stuff to subtract
        union()
        {
            if (top_bottom_cutaway != 0) 
            {
                translate([-tray_o_ln,0,tray_o_ht])rotate([0,90,0])scale([2*(phone_thickness-top_bottom_lip),tray_o_wd*top_bottom_percent,1])cylinder(2*tray_o_ln,d=1,true);            
            }
            
            if (side_cutaway != 0) 
            {
              translate([0,tray_o_wd,tray_o_ht])rotate([90,0,0])scale([tray_o_ln*side_percent,2*(phone_thickness-side_lip),1])cylinder(2*tray_o_wd,d=1,true);               
            }
            if (base_cutaway != 0)
            {
                cube([phone_length*base_cutaway_percent,phone_width*base_cutaway_percent,10*tray_o_ht],true);
            }
            
        }
     }
    
}

tray();