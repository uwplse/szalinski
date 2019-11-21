//Width of the clip (mm)
width = 76.2;  // label width (mm)

//Height of the label maker tape (standard Brother is 12 mm)
label_ht = 12; //standard size is 12 mm for a Brother Label

ridge = 2*1; //width of the ridge around the label
height = label_ht + 2* ridge + 2; // 1 mm for top and bottom and additional for ridge
thickness = 2*1; //thickness (mm) of the plate
clip_width = 4*1;
clip_spacing = 16*1;
wire_diameter = 3.5*1; // ClosetMaid standard width is 3.4 mm (#10 BWG) (0.1 mm for tolerance)
wall_thickness = 1.5*1; // wall thickness of clip (mm)



//establish the number of wires to maximize the spacing of the clips
spacing = floor(width/clip_spacing);

num_wire_spacing = spacing > (width -2*(wire_diameter/2+wall_thickness))/clip_spacing ? spacing -1 : spacing;


//combine the clip and plate
union(){
//create the plate for the label
difference(){
linear_extrude(height = thickness) square([width,height]);
translate([ridge,ridge,thickness -0.5]) linear_extrude(height=0.5) square([width-ridge*2,height-ridge*2]);
}


//create the dual clips
translate([(width-clip_spacing*num_wire_spacing)/2,0,0]) union(){
translate([num_wire_spacing*clip_spacing,(height-clip_width)/2,thickness-0.5]) rotate([0,90,90]) standard_clip(clip_spacing, clip_width, wire_diameter, wall_thickness);

translate([0,(height-clip_width)/2,thickness-0.5]) rotate([0,90,90]) standard_clip(clip_spacing, clip_width, wire_diameter, wall_thickness);
}

}






//create a standard clip
module standard_clip(clip_spacing, clip_width, wire_diameter, wall_thickness){

translate([wire_diameter/2+wall_thickness,0,0]) union(){
arc(wall_thickness,clip_width,wire_diameter/2+wall_thickness,180);
rotate([0,0,30]) arc(wall_thickness,clip_width,wire_diameter/2+wall_thickness,30);
rotate([0,0,180]) arc(wall_thickness,clip_width,wire_diameter/2+wall_thickness,30);
}
}




















/* 
 * Excerpt from... 
 * 
 * Parametric Encoder Wheel 
 *
 * by Alex Franke (codecreations), March 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
*/
 
module arc( height, depth, radius, degrees ) {
    // This dies a horible death if it's not rendered here 
    // -- sucks up all memory and spins out of control 
    render() {
        difference() {
            // Outer ring
            rotate_extrude($fn = 100)
                translate([radius - height, 0, 0])
                    square([height,depth]);
         
            // Cut half off
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
            // Cover the other half as necessary
            rotate([0,0,180-degrees])
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
        }
    }
}