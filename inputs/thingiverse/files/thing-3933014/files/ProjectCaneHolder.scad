$fn=100;

//to offset printer errors
printer_offset = 5; //ensure that when subtracting two objects for difference, the printer sufficiently remove the difference object 
overlap_offset = 1; //ensure that when overlapping two objects to unionise, the printer does not leave space

//table top parameters
base_len = 80;
base_width = 15;
base_height = 25;

//cane clamp parameters
clamp_width = 15;
clamp_len = 88.9; 
clamp_height = 25; 

//arc for the hook parameters
arc_width = clamp_width;
arc_len = 53.5; 
arc_height = clamp_height; 

//hook parameters 
hook_ledge = 15; 

//cylinder based clamp for the cane
cane_thickness = 12;
cane_clamp_radius = (cane_thickness/2)+1; // +1 to be able to add two tiny cylinders for the cane to fit snugly.
cane_clamp_outer_radius = base_width-4;
cane_clamp_height = clamp_len+printer_offset;


    //**general J shape of clamp holder**//
    difference(){ //to cut weights into the base

   difference(){ //to cut the cane holder from the clamp
       
   union(){
    
   difference(){

   //creating a smooth edge on the sides
   hull(){
       union(){
        rotate([90,90,95])
        translate([-base_height+1,base_width-8,overlap_offset])
        cylinder(r=2,h=clamp_len+printer_offset);
       
        rotate([90,90,95])
        translate([-1,base_width-8,overlap_offset])
        cylinder(r=2,h=clamp_len+printer_offset);
        
        translate([base_len+clamp_width-overlap_offset-1,base_width,-1])
        cylinder(r=2,h=6);
        
        translate([base_len+clamp_width-overlap_offset-1,base_width,base_width+4])
        cylinder(r=2,h=6);
       
       }
       
    difference(){
    //creating a slight slope on the table top base 
    cube([base_len, base_width, base_height], center=false);

    translate([0,0,-overlap_offset])
    linear_extrude(height = base_height+printer_offset, center = false, convexity = 0, twist = 0)
    polygon(points = [ [-printer_offset, base_width-7], [base_len+printer_offset, base_width], [0, base_width+printer_offset]]);
        }
    }
    //creating a contour for user to insert cane's rubber band for addition hold
        translate([base_len-printer_offset-1, base_width-0.8,-1])
        cylinder(r=2,h=base_height+printer_offset); 
    
    }
    
    //creating the clamp holder
    
    union(){
        hull(){
    translate([base_len-overlap_offset,-clamp_len+base_width,0])
    cube([clamp_width, clamp_len, clamp_height], center=false);
    
    //creating hull to smooth the edges
        union(){
    rotate([90,0,0]){
    translate([clamp_len+printer_offset-2,4,-clamp_width])
    cylinder(r=5,h=clamp_len+printer_offset);
    
    translate([clamp_len+printer_offset-2,clamp_height-4,-clamp_width])
    cylinder(r=5,h=clamp_len+printer_offset);
        }
        }
    }

    //creating the arc
    hull(){
    union(){
    rotate([90,0,-40]){
    translate([clamp_len+arc_len-base_height,clamp_height-2,overlap_offset])
    cylinder(r=3,h=arc_len+10);
        
    translate([clamp_len+arc_len-base_height,2,overlap_offset])
    cylinder(r=3,h=arc_len+10);
    }
    }
    
    union(){
    translate([-overlap_offset, overlap_offset, 0])
    linear_extrude(height = arc_height, center = false, convexity = 0, twist = 0)
    polygon(points = [ [base_len, -clamp_len+base_width], [base_len+clamp_width, -clamp_len+base_width], [base_len+clamp_width-3*arc_width, -clamp_len+base_width-arc_len],[base_len+clamp_width-4*arc_width,-clamp_len+base_width-arc_len]]);
    }
    }
    
    
    //**start of cane clamp holder**//
    //translating to the side of the clamp holder
    translate([base_len+clamp_width-printer_offset, base_width, cane_thickness+1])
    
    //rotating to the side of the clamp holder
    rotate([90,90,0]){
    cylinder(r=cane_clamp_outer_radius,h=cane_clamp_height);
    }
    }
    
    }
    
    
    union(){
    //snap-on cane clamp
    translate([base_len+clamp_width-4, base_width+printer_offset, cane_thickness+1])
    rotate([90,90,0]){
    union(){
    cylinder(r=cane_clamp_radius,h=cane_clamp_height+printer_offset+20);
    translate([0,5,0])
    cylinder(r=cane_clamp_radius,h=cane_clamp_height+printer_offset+20);
        }
    }
    }
    }
    
    //for weights to be inserted into
    union(){
    translate([base_len/1.24,6.5,clamp_width-2.5])
    rotate([90,0,0]){
    cylinder(r=10,h=7);
    }
    translate([base_len/2,6.5,clamp_width-2.5])
    rotate([90,0,0]){
    cylinder(r=10,h=7);
    }
    translate([base_len/5,6.7,clamp_width-2.5])
    rotate([90,0,0]){
    cylinder(r=10,h=7);
    }
    }
    }
    

    //translate to edge 1 of 2 of the clamp
    hull(){
    translate([base_len+clamp_width-printer_offset, base_width, cane_thickness+1])
    rotate([90,90,0]){
    translate([cane_clamp_radius, base_width-cane_clamp_radius+1.5,0])
    cylinder(r=1.5,h=clamp_len+printer_offset);
    }
        rotate([90,0,0]){
    translate([clamp_len+printer_offset+overlap_offset,2.5,-clamp_width])
    cylinder(r=3,h=clamp_len+printer_offset);
    }
    }
    
    //translate to edge 2 of 2 of the clamp   
    hull(){ 
    translate([base_len+clamp_width-printer_offset, base_width, cane_thickness+1])
    rotate([90,90,0]){
    translate([-cane_clamp_radius, base_width-cane_clamp_radius+1.5,0])
    cylinder(r=1.5,h=clamp_len+printer_offset);
    }
    rotate([90,0,0]){
    translate([clamp_len+printer_offset+overlap_offset,clamp_height-2.5,-clamp_width])
    cylinder(r=3,h=clamp_len+printer_offset);
    }
    }
    
    //**end of cane clamp holder**//

    
    union(){
    //creating the hook 
    translate([-overlap_offset, overlap_offset, 0])
    linear_extrude(height = arc_height, center = false, convexity = 0, twist = 0)
    polygon(points = [ [base_len+clamp_width-3*arc_width, -clamp_len+base_width-arc_len],[base_len+clamp_width-4*arc_width,-clamp_len+base_width-arc_len], [0, -clamp_len-base_width+printer_offset],[arc_width,-clamp_len-base_width+printer_offset]]);

    //creating the ledge of the hook
    hull(){
    translate([arc_width/2-overlap_offset,-clamp_len,0])
    cylinder(h=arc_height, d=arc_width, center=false);

    translate([-overlap_offset, overlap_offset, 0])
    linear_extrude(height = arc_height, center = false, convexity = 0, twist = 0)
    polygon(points = [ [0, -clamp_len-base_width+printer_offset],[arc_width,-clamp_len-base_width+printer_offset], [arc_width, -clamp_len-base_width+hook_ledge],[0,-clamp_len-base_width+hook_ledge]]);
    }
    }
   
