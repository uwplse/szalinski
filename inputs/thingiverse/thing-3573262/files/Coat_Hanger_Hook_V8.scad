//Print orientation
orientation="on_the_side";//[on_the_side,turned_45_degree]


//Width of the hook at its base
hookwidth=45;

//Select number of hooks to generate
Num_hooks=2;

//Width in between hooks if there are several
hookdistance=90;

//inner width of the corner
inner_width=35;

//thickness of the corner wall
wall_th=3;

//Radius of the rounded ends of the corner
rounded_corner_r=5;

//How much does the hook angle out? 20 degrees seems little, but its super sturdy then.
Hook_out_angle=20;

//Radius at hook tip
hook_r=3;

//To stabilize the hook
hook_percent_thicker=.2;

/* [Hidden] */
//-------------------------------------------------------------------------------
/*
Hook
Version 7, April 2019
Written by MC Geisler (mcgenki at gmail dot com)

This is a configurable coat hook.
Have fun!

License: Attribution 4.0 International (CC BY 4.0)

You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
    for any purpose, even commercially.
*/

//Total length of the bar, should not exceed your maximum print height (z)
length=hookwidth*Num_hooks+hookdistance*(Num_hooks-1);


module rounded_square(inner_width,wall_th,length,rounded_corner_r)
{
    hull()
    {
        //translate([0,0,0])
        //    cube(wall_th);
        translate([wall_th/2,wall_th/2,0])
            cylinder(r=wall_th/2,h=wall_th,$fn=32);   
        
        //translate([0,0,length])
        //    cube(wall_th);
        translate([wall_th/2,wall_th/2,length-wall_th])
            cylinder(r=wall_th/2,h=wall_th,$fn=32);
        
        //translate([inner_width,0,length])
        //    cube(wall_th);
        translate([inner_width+(wall_th-rounded_corner_r),wall_th,length-rounded_corner_r])
            rotate([90,0,0])
                cylinder(r=rounded_corner_r,h=wall_th,$fn=32);
        //translate([inner_width,0,0])
        //    cube(wall_th);
        translate([inner_width+(wall_th-rounded_corner_r),wall_th,rounded_corner_r])
            rotate([90,0,0])
                cylinder(r=rounded_corner_r,h=wall_th,$fn=32);
    }
}

module hook(hookwidth,wall_th,inner_width)
{
    hull()
    {
        zpos1=rounded_corner_r;
        zpos2=hookwidth-rounded_corner_r;
        
        translate([inner_width+(wall_th-rounded_corner_r),wall_th,zpos1])
            rotate([90,0,0])
                cylinder(r=rounded_corner_r,h=wall_th,$fn=32);  

        translate([inner_width+(wall_th-rounded_corner_r),wall_th,zpos2])
            rotate([90,0,0])
                cylinder(r=rounded_corner_r,h=wall_th,$fn=32);
        
        translate([inner_width*(1-hook_percent_thicker)+(wall_th-rounded_corner_r),wall_th,hookwidth/2])
            rotate([90,0,0])
                cylinder(r=rounded_corner_r,h=wall_th,$fn=32);
        
        out_y=(inner_width-hook_r)*tan(Hook_out_angle);
        
        translate([hook_r,-out_y,hookwidth/2])
            rotate([90,0,0])
                sphere(r=hook_r,$fn=50);
        
        //echo(hookwidth/2,(zpos1+zpos2)/2);
    }
}

module complete_hook()
{
    rounded_square(inner_width,wall_th,length,rounded_corner_r);
    translate([wall_th,0,0])
        rotate([0,0,90])        
            rounded_square(inner_width,wall_th,length,rounded_corner_r);

    hookmidwidth=length-hookwidth;
    if (Num_hooks==1)
        hook(hookwidth,wall_th,inner_width);
    else
    {
        for(i = [0 : Num_hooks-1])
            translate([0,0,hookmidwidth/(Num_hooks-1)*i])
                hook(hookwidth,wall_th,inner_width);
    }
}
//---------------------------------------

if (orientation=="turned_45_degree")
{
    rotate([-45,0,0])
        rotate([0,90,0])
            complete_hook();
}
else
{
    complete_hook();
}