
// by: Scorch
// http://www.scorchworks.com/Blog/openscad-modules-for-automatic-fillets-and-radii/
// www.scorchworks.com
// 12/29/2015

// PARAMETERS

sample_R    = 1;      // Radius of the fillet/round to be added

sample_OB   = 1000;   // Outer boundary (should be larger than model outer boundary)

sample_axis = "xyz";  // ["xyz":"xyz",x:x,y:y,z:z]
                      // axes to round choose one (x,y,z, or xyz)

sample_fn   = 6;      // number of facets on radius (per 360 degrees)

MAKE_EXAMPLE = 1;    // [0:Generate sample base part,1: Add fillets to base part,2: Add rounds to base part,3: Add fillets and rounds to base part,4: Add local fillets to base part,5: Add local rounds to base part,6: Add local fillets and local rounds to base part, 7: Show transparent local area selection box on base part]

//-1: Do not make example part
// 0: Generate sample base part
// 1: Add fillets to base part 
// 2: Add rounds to base part 
// 3: Add fillets and rounds to base part 
// 4: Add local fillets to base part 
// 5: Add local rounds to base part 
// 6: Add local fillets and local rounds to base part 
// 7: Show transparent local area selection box on base part 
//

//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////

// The add_fillets module will either auto fillet the whole model or
// a section of the model depending on if ther are one or two children.
// 1 child:       Fillet the whole model
// Two children:  Fillet the first child in the area that is
//                 intersected by the second child 
module add_fillets(R=1,OB=1000,axis="xyz",fn=10)
{
    fn_even = ceil(fn/2)*2;
    if ($children==1)
    {
        minkowski_fillets(R=R,OB=OB,axis=axis,fn=fn_even)
        {
            children(0);
        }
    }
    if ($children==2)
    {
        union()
        {
            minkowski_fillets(R=R,OB=OB,axis=axis,fn=fn_even)
            {
                intersection()
                {
                    children(0);
                    children(1);
                }
            }
            difference()
            {
                children(0);
                children(1);
            }
        }
    }
}


// The add_rounds module will either auto round the whole model or
// a section of the model depending on if ther are one or two children.
// 1 child:       Round the whole model
// Two children:  Round the first child in the area that is
//                  intersected by the second child 
module add_rounds(R=1,OB=1000,axis="xyz",fn=10)
{
    fn_even = ceil(fn/2)*2;
    if ($children==1)
    {
        minkowski_rounds(R=R,OB=OB,axis=axis,fn=fn_even)
        {
            children(0);
        }
    }
    if ($children==2)
    {
        union()
        {
            minkowski_rounds(R=R,OB=OB,axis=axis,fn=fn_even)
            {
                intersection()
                {
                    children(0);
                    minkowski()
                    {
                        children(1);
                        if (axis=="x")   rotate([0 ,90,0]) cylinder(r=R,$fn=fn_even,center=true);
                        if (axis=="y")   rotate([90,0 ,0]) cylinder(r=R,$fn=fn_even,center=true);
                        if (axis=="z")   rotate([0 ,0 ,0]) cylinder(r=R,$fn=fn_even,center=true);
                        if (axis=="xyz") sphere(r=R,$fn=fn_even);
                    }
                }
            }
            difference()
            {
                children(0);
                children(1);
            }
        }
    }
}




module minkowski_fillets(R=1,OB=1000,axis="xyz",fn=10)
{
    OBplus=OB+4*R;
    fn_even = ceil(fn/2)*2;
    echo(fn_even);
    difference()
    {
        cube([OB,OB,OB],center=true);
        minkowski()
        {   
            difference()
            {
                cube([OBplus,OBplus,OBplus],center=true);
                minkowski()
                {
                    children(0);
                    if (axis=="x")   rotate([0 ,90,0]) cylinder(r=R,$fn=fn_even,center=true);
                    if (axis=="y")   rotate([90,0 ,0]) cylinder(r=R,$fn=fn_even,center=true);
                    if (axis=="z")   rotate([0 ,0 ,0]) cylinder(r=R,$fn=fn_even,center=true);
                    if (axis=="xyz") sphere(r=R,$fn=fn);
                }
            }
            if (axis=="x")   rotate([0 ,90,0]) cylinder(r=R,$fn=fn_even,center=true);
            if (axis=="y")   rotate([90,0 ,0]) cylinder(r=R,$fn=fn_even,center=true);
            if (axis=="z")   rotate([0 ,0 ,0]) cylinder(r=R,$fn=fn_even,center=true);
            if (axis=="xyz") sphere(r=R,$fn=fn_even);
        }
    }
}


module minkowski_rounds(R=1,OB=1000,axis="xyz",fn=10)
{
    OBplus=OB+4*R;
    fn_even = ceil(fn/2)*2;
    minkowski()
    {  
        difference()
        {
            cube([OB,OB,OB],center=true);
            minkowski()
            {
                difference()
                {
                    cube([OBplus,OBplus,OBplus],center=true);
                    children(0);
                }
                if (axis=="x")   rotate([0 ,90,0]) cylinder(r=R,$fn=fn_even,center=true);
                if (axis=="y")   rotate([90,0 ,0]) cylinder(r=R,$fn=fn_even,center=true);
                if (axis=="z")   rotate([0 ,0 ,0]) cylinder(r=R,$fn=fn_even,center=true);
                if (axis=="xyz") sphere(r=R,$fn=fn_even);
            }
        }
        if (axis=="x")   rotate([0 ,90,0]) cylinder(r=R,$fn=fn,center=true);
        if (axis=="y")   rotate([90,0 ,0]) cylinder(r=R,$fn=fn,center=true);
        if (axis=="z")   rotate([0 ,0 ,0]) cylinder(r=R,$fn=fn,center=true);
        if (axis=="xyz") sphere(r=R,$fn=fn_even);      
    }
}

//////////////////////////////////////////////////////////
//The remainder of this file contains the Sample models //
//////////////////////////////////////////////////////////
// ------------------------------   
// Base sample object
// ------------------------------
if (MAKE_EXAMPLE==0)
    fillets_and_rounds_sample_object();

// ------------------------------   
// Sample add fillets
// ------------------------------
if (MAKE_EXAMPLE==1)
    render()
        add_fillets(R=sample_R,OB=sample_OB,axis=sample_axis,fn=sample_fn)
            fillets_and_rounds_sample_object();

// ------------------------------   
// Sample add rounds
// ------------------------------
if (MAKE_EXAMPLE==2)
    render()
        add_rounds(R=sample_R,OB=sample_OB,axis=sample_axis,fn=sample_fn)
            fillets_and_rounds_sample_object();
   
// ------------------------------   
// Sample add rounds and fillets
// ------------------------------
if (MAKE_EXAMPLE==3)
{
    render()
        add_fillets(R=sample_R,OB=sample_OB,axis=sample_axis,fn=sample_fn)
            add_rounds(R=sample_R,OB=sample_OB,axis=sample_axis,fn=sample_fn)
                fillets_and_rounds_sample_object();
}       

// ------------------------------   
// Sample add local fillets
// ------------------------------
if (MAKE_EXAMPLE==4)
{
    render()
        add_fillets(R=sample_R,OB=sample_OB,axis=sample_axis,fn=sample_fn)
        {
            fillets_and_rounds_sample_object();
            translate([10,10,0])cube([10,10,50],center=true);
        }
}

// ------------------------------   
// Sample add local rounds
// ------------------------------
if (MAKE_EXAMPLE==5)
{
    render()
        add_rounds(R=sample_R,OB=sample_OB,axis=sample_axis,fn=sample_fn)
        {
            fillets_and_rounds_sample_object();
            translate([10,10,0])cube([10,10,50],center=true);
        }
}

// ------------------------------   
// Sample add rounds and fillets
// ------------------------------
if (MAKE_EXAMPLE==6)
{
    render()
        add_fillets(R=sample_R,OB=sample_OB,axis=sample_axis,fn=sample_fn)
        {
            add_rounds(R=sample_R,OB=sample_OB,axis=sample_axis,fn=sample_fn)
            {
                fillets_and_rounds_sample_object();
                translate([10,10,0])cube([10,10,50],center=true);
            }
            translate([10,10,0])cube([10,10,50],center=true);
        }
}


// ------------------------------   
// Sample Show Intersecting Box
// ------------------------------
if (MAKE_EXAMPLE==7)
{
    fillets_and_rounds_sample_object();
    %translate([10,10,0])cube([10,10,50],center=true);

}

// -------------------
// Sample Object module
// -------------------
module fillets_and_rounds_sample_object()
{
    cube([10,20,10]);
    cube([20,10,10]);
    cube([10,10,20]);
}

// END
