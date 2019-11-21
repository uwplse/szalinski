/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Customizable Fishing Rod Clips
* Benjamen Johnson <workshop.electronsmith.com>
* 20180613
* Version 4
* openSCAD Version: 2015.03-2
*******************************************************************************/

// Diameter of the bottom section
inner_dia_1 = 9;

// Diameter of the top section
inner_dia_2 = 4;

// Wedge angle of the cut (how many degrees of the circle to cut)
wedge_angle = 60;

// Thickness of the clip
wall_thickness = 4;

// Distance between the sections
distance = 15;

// Height of the clip
height = 8;

// how round? The higher the rounder
facets=100;

/*[hidden]*/
// add a slight amount to holes so the model renders properly
render_offset = 0.01;

// calculate the outer diameters
outer_dia_1 = inner_dia_1+2*wall_thickness;
outer_dia_2 = inner_dia_2+2*wall_thickness;

linear_extrude(height+render_offset,center=false, convexity=10, twist=0,center=true)
union() {
// move so the outer wall of the bottom clip lines up with the X-axis    
translate([0,outer_dia_1/2,0]) difference() {
    circle(d=outer_dia_1, center=true,$fn=facets);
    circle(d=inner_dia_1, center=true,$fn=facets);
    rotate([0,0,90]) wedge(outer_dia_1*2,height+render_offset,wedge_angle);

}
// move so the outer wall of the top clip lines up with the X-axis    
translate([0,outer_dia_2/2,0]) difference() {
    translate([distance,0,0])circle(d=outer_dia_2, center=true,$fn=facets);  
    translate([distance,0,0])circle(d=inner_dia_2, center=true,$fn=facets);
    translate([distance,0,0])rotate([0,0,90]) wedge(outer_dia_2*2,height+render_offset,wedge_angle);

}
// join the two clips
translate([distance/2,wall_thickness/2])square([distance,wall_thickness],center=true);
}

module wedge(x=1,z=1,angle=45){
    angle=angle/2; 
    
        polygon([[0,0],
              [x*cos(angle),x*sin(angle)],
              [x*cos(angle),-x*sin(angle)]]);
        
    }