/*
Made by Jan Hünnemeyer
https://www.thingiverse.com/Horstage/about
Thanks to
tutch: https://www.thingiverse.com/thing:506479
popeye: https://www.thingiverse.com/thing:809432

*/
// preview[view:south east, tilt:top]
/* [Global] */
/* [Simple] */
//How much higher shall your drone be in mm
additional_height=20;
//Width of the stand in mm:
Thickness=10; //[5:35]

//in mm: 
Wall_Thickness=2; //[1:0.1:7]



/* [Expert] */
//in mm:
gap=1; //[0.1:0.1:3]
//Lower to Higher in mm:
shift=0.5; //[-2:0.1:2]
// Radius of the inner pin
inner_r=2;
// Radius of the part to grab
outer_r=4.5;

/* [Hidden] */
// Depth of the pin
clamp_x=8.5;
// Height of the part to grab
clamp_y=9;
Pool_Noodle_Diameter=65;
eps=0.01;
fn=200;
noodle_r=Pool_Noodle_Diameter/2;
noodle=false;
wall=Wall_Thickness;
total_x=clamp_x+2*wall+gap;
add_h=additional_height+(outer_r-inner_r+shift);


linear_extrude(height = Thickness)
difference()
{
union()
{  
    if (noodle)
    {
    translate([total_x/2+noodle_r+wall,0,0])
        circle(r=noodle_r+wall,$fn=fn);
    }
translate([0,total_x/2,0])
difference()
{
    union()
    {
        translate([total_x/2,0,0])
            circle(r=total_x/2,$fn=fn);
        square([total_x,add_h-total_x/2],center=false);        
    }
    translate([wall+gap+clamp_x/2,add_h+inner_r-shift-total_x/2,0])
        circle(r=outer_r,$fn=fn);
    
    translate([total_x/2,0,0])
        circle(r=(clamp_x+gap)/2,$fn=fn);
    translate([wall,0,0])
        square([clamp_x+gap,add_h-total_x/2+eps],center=false);
    
}
translate([wall/2,add_h,0])
{
    scale([wall/2,2*inner_r,1])
            circle(r=1,$fn=fn);
        square([clamp_x-inner_r,2*inner_r]);
}

//translate([total_x-clamp_x,add_h+inner_r-outer_r-shift-2*wall,0])
translate([total_x-clamp_x,add_h+inner_r-clamp_y/2-2*wall-shift+eps,0])
{
    difference()
    {
        square([clamp_x-wall,wall]);
        
        scale([clamp_x-wall,wall,1])
            circle($fn=fn);
    }
}
translate([wall+gap,add_h+inner_r,0])
{
    difference()
    {
        *offset(wall,$fn=fn)
            translate([wall,-clamp_y/2-shift,0])
                square([clamp_x-wall,clamp_y]);
        *translate([0,-clamp_y/2-shift-wall,0])
            square([clamp_x+wall,clamp_y+2*wall]);
        offset(wall/2,$fn=fn)
            translate([wall/2,-clamp_y/2-shift-wall/2,0])
                square([clamp_x,clamp_y+wall]);
    
    translate([clamp_x/2,0,0])
    difference()
    {
        translate([0,-shift,0])
        circle(r=outer_r,$fn=fn);
        circle(r=inner_r,$fn=fn);
        translate([-outer_r+eps,-inner_r,0])
            square([outer_r+eps,2*inner_r+eps],center=false);
        *translate([-gap-outer_r,-outer_r-shift,0])
            square([outer_r,outer_r]);
    }
    translate([-eps,-outer_r-shift,0])
            square([clamp_x+eps-2*inner_r,outer_r-inner_r+shift]);
    translate([-eps,inner_r,0])
            square([clamp_x+eps-2*inner_r,outer_r-inner_r-shift]);
}
    
}
}
if (noodle){
    translate([total_x/2+noodle_r+wall,0,0])
    circle(r=noodle_r,$fn=fn);
}
}