//set the type of holder
OpenTo="right"; //["left":left side open, "right":right side open, "cut_for_debug":cut out to see the inside]

//Chalk radius in mm
chalk_r=4.5;

//Chalk holder length in mm
chalk_l=65;

//sponge width in mm
sponge_w=40;

//sponge height in mm
sponge_h=30;

//sponge thickness in mm
sponge_th=20;

//Wall thickness in mm
wall=1;

/* [Hidden] */

$fn=64;

wiggle=.5;
flatlen=15;//for tesa powerstrips
holder_in_r=chalk_r+wiggle;
holder_out_r=chalk_r+wall+wiggle;

edge_cutoff=wall*5;

/*
Chalk and sponge holder
Version 9, February 2015
Written by MC Geisler (mcgenki at gmail dot com)

A convenient storage for your blackboard accessories.

Have fun!

License: Attribution 4.0 International (CC BY 4.0)

You are free to:
    Share - copy and redistribute the material in any medium or format
    Adapt - remix, transform, and build upon the material
    for any purpose, even commercially.
*/

module half_pipe()
{
    //half pipe
    difference()
    {
        cylinder(r=holder_out_r,h=chalk_l,center=true); 
        cylinder(r=holder_in_r,h=chalk_l*2,center=true);
        translate([0,chalk_l/2,0])
            cube([chalk_l,chalk_l,chalk_l+2],center=true);
    }

    //stabilize the half pipe
    //translate([-chalk_r-wiggle-wall/2,-flatlen/2,0])
    //    cube([wall,flatlen,chalk_l],center=true);

    //half pipe edges rounded
    edge_pos=chalk_r+wiggle+wall/2;
    translate([-edge_pos,0,0])
        cylinder(r=wall/2,h=chalk_l,center=true);
    translate([edge_pos,0,0])
        cylinder(r=wall/2,h=chalk_l,center=true);
}
            
module box_rounded(a,b,c,edge_cutoff)
{
    difference()
    {
        cube([a,b,c],center=true);

        translate([a/2,0,-c/2])
            difference()
            {
                cube([edge_cutoff,b*2,edge_cutoff],center=true);
                
                translate([-edge_cutoff/2,0,edge_cutoff/2])
                    rotate([90,0,0])
                        cylinder(r=edge_cutoff/2,h=b*2,center=true);
            }
   }
}

module sponge_box()
{       
    outer_th=sponge_th+2*(wall+wiggle);
    outer_h=sponge_h+2*(wall+wiggle);
    outer_w=sponge_w+2*(wall+wiggle);
    
    //sponge box
    translate([     outer_th/2-holder_out_r,
                    -outer_h/2-holder_out_r+wall,
                    outer_w/2-chalk_l/2      ])
        difference()
        {
            union()
            {
                //outer cube
                box_rounded(outer_th,outer_h,outer_w,edge_cutoff);
                                
                //stabilize the half pipe with a wall adder
                translate([-sponge_th/2-wiggle-wall/2,
                        -flatlen/2+sponge_h/2+wiggle+holder_out_r,
                        -(sponge_w+2*(wall+wiggle))/2+chalk_l/2 ])
                    cube([wall,flatlen,chalk_l],center=true);
            }

            //cut out sponge
            translate([0,0,sponge_w/2])
                box_rounded(sponge_th+2*wiggle,sponge_h+2*wiggle,sponge_w+2*wiggle+sponge_w,edge_cutoff-wall*2);
            
           //cut out the stabilizer
           translate([0,0,sponge_w/2+sponge_w+wiggle*2+wall])
                cube([sponge_th*2,sponge_h+2*wiggle,sponge_w+2*wiggle+sponge_w],center=true);
            
            //cut out for the fingers
            translate([0,0,sponge_w/2+(wall+wiggle)])
                rotate([0,90,0])
                    cylinder(r=(sponge_h+2*wiggle)/2,h=sponge_th*2,center=true);

            //cut off side edges to be safer
            translate([outer_th/2,outer_h/2*0,outer_w/2])
                difference()
                {
                    cube([edge_cutoff,sponge_h*2,edge_cutoff],center=true);
                    translate([-edge_cutoff/2,0,-edge_cutoff/2])
                        rotate([90,0,0])
                            cylinder(r=edge_cutoff/2,h=sponge_h*2,center=true);
                }
               
        }
}                                 

module holder()
{
    half_pipe();
    sponge_box();
}

if (OpenTo=="left")
{
    holder();
}
else
{
    if (OpenTo=="right")
    {
        rotate([0,180,0])
            mirror([0,0,1])
            {
                holder();
            }
    }
    else
    {
        if (OpenTo=="cut_for_debug")
        {
            rotate([0,180,0])
                mirror([0,0,1])
                {
                    difference()
                    {
                        holder();
                        translate([0,-25,-50]) cube(30);
                    }
                }
        }        
    }  
}
