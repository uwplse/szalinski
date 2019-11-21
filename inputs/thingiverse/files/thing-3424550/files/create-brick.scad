//Number of studs long
length = 4;

//Number of studs wide
width = 2;

//Nozzle Size
// Used to avoid generating support lines too skinny to print well. If you want exact lines, lie and set this to something small like .1mm.
nozzle_size = 0.4;

// This adjustment will be removed from the thickness of the wall on *both sides* and does impact the overall size of the resulting brick.
wall_adjustment = 0.2;

//Additional spacing factor between individual pieces. This adjustment will reduce the length of walls on *both sides*.
gap_factor = -0.088; 

//Amount to remove from brick height. Divided by three for plates/bases. Typically full-height bricks are already okay, but plates may need a height reduction.
height_adjustment = 0;

//Amount to remove from the height of studs
stud_height_adjustment = 0.1;

//Amount to remove from the radius of studs
stud_radius_adjustment = -0.02;

//Amount to remove from the radius of the supports posts. Only used on 2xN pieces. Default is one quarter of the standard play factor
support_post_radius_adjustment = 0.025;

//Full-height brick vs plate vs base. A base is a plate with a completely flat bottom. Base is NOT SUPPORTED yet. You will end up with a plate.
block_type = "brick"; // [brick:Brick, plate:Plate, base:Base]

//Normal has studs, tiles do not
surface_type = "normal"; // [normal:Normal, tile:Tile]


/* No need to modify anything else */

/* [Hidden] */

lego_unit = 1.6;
LU = lego_unit; //short-hand

unit_span = 5*LU;
SU = unit_span; //short-hand (stands for: Stud Unit)

//TODO: way to make the top wall skinner for larger nozzle sizes
//TODO: ridge adjustments (needed because of wall and nozzle adjustments)

/* STUD HEIGHT:
 There is debate over this.
 Some people say 1.8, some say 1.7, and some say one lego unit (1.6).
 I believe actual lego studs are 1.8, *but this includes the "lego" emboss.*
 Thus, a more practical default printing height is 1.7.
 So, since we also have a height adjustment defaulted to .1,
  I will use 1.8 for the height starting point.
*/
base_stud_height = 1.8;

stud_height = base_stud_height - stud_height_adjustment;

wall_thickness = lego_unit - (2 * wall_adjustment);

//Supports across the underside of the brick.
// Do not appear on plates.
// They bridge up to a 3.2mm gap about 1.6mm above the build surface, so set this to "No" if the gap will cause a problem for your printer
include_cross_supports = "Y"; // [Y:Yes, N:No]
/* Note for above: moved to hidden section, because if you can't bridge that you're gonna have problems anyway when it's time to print the top wall */


//brick is default. If we don't understand this, default to brick height
brick_height = ((block_type == "plate" || block_type == "base")? (2*LU) : 6*LU);

final_height_adjustment = height_adjustment / ((block_type == "plate" || block_type == "base")? 3 : 1);

w = (width > length)?length:width;
l = (width > length)?width:length; //TODO: l vs 1 can be hard to see
h = brick_height - final_height_adjustment;

G = gap_factor; //short-hand
WT = wall_thickness; //short-hand
PF = wall_adjustment; //short-hand; stands for Play Factor (Lego's term, I believe)

//OUTER WALLS

//gap factor and play factor remove from outer wall on BOTH SIDES of the part,
// so double them when accounting for wall lengths
long_wall_l = (l*SU)-(2*G)-(2*PF);
short_wall_l = (w*SU)-(2*G)-(2*PF);

//long walls

cube([long_wall_l,WT,h],0);

translate([0,short_wall_l-WT,0])
{
    cube([long_wall_l, WT,h],0);
};

//short walls

cube([WT, short_wall_l,h],0);

translate([(l*SU) - (2*G)-LU,0,0])
{
    cube([WT,short_wall_l,h],0);
}

//top

//TODO: Underside of the top wall needs to bridge over open area
//      and is often not very clean. That's fine for bricks and bases,
//      but for plates, it means not enough space for the studs from
//      the piece below. We need a way to allow an additional narrowing
//      of this section when rendering plates.
translate([0,0,h-WT])
{   
    cube([long_wall_l, short_wall_l, WT],0);  
};

//STUDS

stud_rad = (1.5*LU) - stud_radius_adjustment;

first_stud = (SU/2) - PF - G;

//default as "normal". If we don't understand the value, default to true
if (surface_type != "tile") 
{
    for(y=[0:w-1])
    {
        for(x=[0:l-1])
        {
            translate([first_stud+(x*SU),first_stud+(y*SU),h])
            {
                cylinder(stud_height,stud_rad, stud_rad, $fn=40);
            };
        }
    }
}

//INTERIOR RIDGES

// ridge depth should make up the space lost for interior wall adjusment + add .1mm (Lego play factor) to help it grip
//TODO: now that I have a good default, make an adjustment for this
ridge_d = PF + 0.1;
//  These ridges can challenge printers; make sure minimum length is 2*nozzle
ridge_w = LU/2<(2*nozzle_size)?(2*nozzle_size):LU/2;

// plates and bases do not have ridges
//TODO: test prints of plates are too loose compared to bricks. 
// Real lego does not use ridges for plates, but I might need to
if (block_type == "brick" && w > 1)
{
    //long edge
    for(x=[0:l-1])
    {  
        translate([first_stud+(x*SU)-(ridge_w/2), WT, 0])
        {
            cube([ridge_w, ridge_d, h],0);
        }
        translate([first_stud+(x*SU)-(ridge_w/2), short_wall_l-WT-ridge_d, 0]) 
        {
            cube([ridge_w, ridge_d, h],0);
        }
    }

    //short edge
    for(y=[0:w-1])
    {  
        //near side
        translate([WT,first_stud+(y*SU)-(ridge_w/2), 0])
        {
            cube([ridge_d, ridge_w, h],0);
        }
        //far side
        translate([long_wall_l-WT-ridge_d, first_stud+(y*SU)-(ridge_w/2),0]) 
        {
            cube([ridge_d, ridge_w, h],0);
        }
    }
}


//UNDER-SIDE CENTER SUPPORT POSTS

if (w==1 )
{
    //Nx1 posts (narrow solid, cross support on every post)
    
    /*Note on adjument factor for the post radius.
    
       Since these posts are 1LU, and studs are 3LU, 
       it's tempting to just use 1/3 that.
       However, I believe it's about area, rather than radius here.
       Thus, 1/9 is more appropriate (square of the sides).
       (LU-(stud_radius_adjustment/9)) 
      
       Of course, I could also be way off :)
       For now, I'm not doing either. Tests so far
       using un-adjusted posts, and 1xN bricks fit
       better than almost anything else I print. 
       I may put an adjustment back in the future if people ask for it.   
    */
    
    support_w = LU/4<nozzle_size?nozzle_size:LU/4;
    
    for(x=[1:l-1])
    {  
        translate([(SU*x)-PF-G,first_stud,0])
        {
            cylinder(h, LU, LU, $fn=32);
        }
        
        //cross supports
        if (include_cross_supports == "Y")
        {
            translate([x*SU-PF-G-(support_w/2),0,LU+PF])
            { 
                cube([support_w,short_wall_l, h-LU-PF],0);
            }        
        }
    }
}
else   
{
    // Nx2+ posts (wide hollow, cross support every other post)
    
    // Not sure how to handle cross support yet for non-standard (odd-length)
    // bricks with an even number of posts. 
    // Supports are there, but not aligned well.
    
    
    sup_w = LU/2<(2*nozzle_size)?(2*nozzle_size):LU/2;
    
    outer = ((((pow(2,0.5)*5)-3)/2) * LU)-support_post_radius_adjustment;
    inner = outer - sup_w;
    
    for(x=[1:l-1])
    {
        for(y=[1:w-1])
        {  
            difference()
            {
                translate([SU*x-PF-G,SU*y-PF-G, 0])
                {
                    cylinder(h, outer, outer, $fn=40);
                }
                translate([SU*x-PF-G,SU*y-PF-G, -0.1])
                {
                    cylinder((h-LU)+0.1, inner, inner, $fn=40);
                }
            }
            
            //partial cross supports
            if (include_cross_supports == "Y" && x%2==0)
            {          
                translate([(SU*x)-PF-G-(sup_w/2),((y*SU)+inner)-G-PF,LU+PF])
                { 
                    cube([sup_w,SU-(2*inner),h-LU-PF],0);
                }               
            }            
        }
        
        //remaining cross supports
        if (include_cross_supports == "Y")        
        { 
            sup_l = SU-inner-WT-G-PF;
           
            if (x%2 ==0)
            {
                translate([x*SU-PF-G-(sup_w/2),WT,LU+PF])
                { 
                    cube([sup_w,sup_l,h-LU-PF],0);
                }
                translate([x*SU-PF-G-(sup_w/2),short_wall_l-WT-sup_l,LU+PF])
                { 
                    cube([sup_w,sup_l,h-LU-PF],0);
                }
            }
        }
    }
}