//the length of the box
box_length = 150; 
//the width of the box
box_width  = 100;
//the height of the box
box_height  = 40;
//Box label
box_label = "your text" ;
//Font size
font_size = 12;
//Define how far the lable will come out of the box
box_label_width = 5;//[2:12]
//Moves label to the right or left
box_label_movement_left_right = 3;//[0:100]
//Moves label up or down
box_label_movement_up_down = 5;//[0:100]
//Do you want box separators over the length (yes/no)?
box_separators_over_length = "yes";//[yes,no]
//How many do you want?
box_separator_number_length = 2; 
//Do you want box searators over the width (yes/no)?
box_separators_over_width = "yes";//[yes,no]
//How many do you want?
box_separator_number_width = 3;
//How thick do you want the separators?
separator_thickness = 2;
//Do you want a locking system (yes/no)?
lock_system = "yes";//[yes,no]
//Do you want a lid (yes/no)?
lid = "yes";//[yes,no]
//Do you want the box (yes/no)?
box = "yes";//[yes,no]
//Is this the most bottom box? Removes the floor for stacking
down_box = "no";//[yes,no]
//Do you want to print the rings (yes/no)?
rings = "yes";//[yes,no]

//the box
module box(width, length, height, label,down){
    translate([0,0,-(height/2)+1.5])
    cube([width+1.1, length+1.1,3], center = true);  
if (down == "no"){    
    translate([0,0,-(height/2)])
    cube([width-6, length-6,5], center = true);}
    translate([-width/2,-length/2,0])
    minkowski(){
        translate([(width/2), (length/2) , 0])
        cylinder(h= height/2, r= width/50, center=true, $fn=100);
    render() difference(){
    cube([width, length, height/2],center = true);
    translate([0,0,0])
    cube([width-2, length-2, height/2],center = true);}}
//the text on the box    
    rotate([90,0,0])
    translate([-width/box_label_movement_left_right,box_label_movement_up_down,(length/2)])
    linear_extrude(height = label, $fn=100){
        text(box_label, font_size);}}
//print the box
if (box == "yes"){
box(box_width,box_length,box_height, box_label_width,down_box);}
//the separators
if (box_separators_over_length == "yes"){
    for (i = [-box_length/2:box_length/box_separator_number_length:box_length/2])
    {translate([0,i,0])
        cube([box_width,separator_thickness, box_height -8],center = true);}}
 
if (box_separators_over_width == "yes"){
    for (i = [-box_width/2:box_width/box_separator_number_width:box_width/2])
    {translate([i,0,0])
        cube([separator_thickness,box_length, box_height -8],center = true);}}
//the lock system
if (box == "yes"){
if (lock_system == "yes"){
translate([-box_width/2 - 3,0,(box_height/2)-2.5])        
rotate([0,90,0])
cylinder(h= 7, r= 2.5, center=true, $fn=100);
translate([box_width/2 + 3,0,(box_height/2)-2.5])        
rotate([0,90,0])
cylinder(h= 7, r= 2.5, center=true, $fn=100);
if (down_box == "no"){
translate([-box_width/2 - 3,0,-(box_height/2)+2.5])        
rotate([0,90,0])
cylinder(h= 7, r= 2.5, center=true, $fn=100);
translate([box_width/2 + 3,0,-(box_height/2)+2.5])        
rotate([0,90,0])
cylinder(h= 7, r= 2.5, center=true, $fn=100);}
//the locking rings
if (rings == "yes"){
translate ([box_width + 5,0,-box_height/2])
render() difference(){
hull($fn=100){
    {translate([-4,0,0])
    cylinder (h = 4, r= 3.5, center = true);
    translate([4.5,0,0])
    cylinder (h = 4, r=3.5, center = true);
    cube([10.5, 8, 4],center = true);}}
hull($fn=100){
    {translate([-4,0,0])
    cylinder (h = 6, r= 2.8, center = true);
    translate([4.5,0,0])
    cylinder (h = 4, r = 2.8, center = true);
    cube([5.5, 6, 4],center = true);}}}}
    
if (rings == "yes"){
translate ([-box_width + -5,0,-box_height/2])
render() difference(){
hull($fn=100){
    {translate([-4,0,0])
    cylinder (h = 4, r= 3.5, center = true);
    translate([4.5,0,0])
    cylinder (h = 4, r=3.5, center = true);
    cube([10.5, 8, 4],center = true);}}
hull($fn=100){
    {translate([-4,0,0])
    cylinder (h = 6, r= 2.8, center = true);
    translate([4.5,0,0])
    cylinder (h = 4, r = 2.8, center = true);
    cube([5.5, 6, 4],center = true);}}}}}}

//the lid
if (lid == "yes"){
translate ([0,-box_length -10,-box_height/2])
{{translate([0,0,-(height/2)])
    cube([box_width-6, box_length-6,5], center = true);
translate([0,0,4.5])    
cube([box_width +2, box_length+2,5], center = true);}
if (lock_system == "yes"){
{translate([-box_width/2 - 3,0,4.5])        
rotate([0,90,0])
cylinder(h= 7, r= 2.5, center=true, $fn=100);
translate([box_width/2 + 3,0,4.5])        
rotate([0,90,0])
cylinder(h= 7, r= 2.5, center=true, $fn=100);
}  }}}
