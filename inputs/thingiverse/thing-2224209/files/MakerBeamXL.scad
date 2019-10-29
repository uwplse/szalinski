//This is a MakerBeamXL library based off the MakerBeamXL specificatioion at:
//https://www.makerbeam.com/blogs/makerbeam/specifications-makerbeam-and-openbeam/
//By: Curtis Jones
//Licensed CC0 or public domain

//ToDo Set beautify to 0 after compleation.

Beam_Lenght = 100;

function MBXL_Width() = 15;        // Overall width
function MBXL_BigHoleID() = 2.55;  // Screw hole
function MBXL_SmallHoleID() = 0.8; // Tap grove - This is guesswork
function MBXL_EdgeOR() = 0.25;     // Radius of smooth edge
function MBXL_HoleDist() = 10;     // Outer screw hole distance


module MakerBeamXL(Lenght, beautify= 0.1 , $fn = 50)
{
    difference()
    {
        translate([ 0 , 0 , Lenght / 2 ])
        {
            cube([ MBXL_Width() , MBXL_Width() , Lenght ], center = true);
        };
        union()
        {
            MBXL_ScrewHole(Lenght,beautify,$fn);
            for(Count = [0:3])
            {
                rotate (a= [0 ,0 ,90 * Count])
                {
                    translate([ (MBXL_HoleDist() / 2) , (MBXL_HoleDist() / 2) , 0])
                    {
                        MBXL_ScrewHole(Lenght,beautify,$fn);
                    };
                    
                    translate([ (MBXL_Width() / 2) , (MBXL_Width() / 2) , 0 - beautify ])
                    {
                        MBXL_RoundedEdgeNegitive(Lenght + (beautify *2),MBXL_EdgeOR(),beautify,$fn);
                    };
                    
                    translate([ (MBXL_Width() / 2) , (-1.5) , 0 - beautify ])
                    {
                        MakerBeamXL_TSlot(Lenght + (beautify *2),beautify,$fn);
                    };
                };
            };
        };
    };   
};

module MBXL_ScrewHole(Lenght, beautify = 0.1 , $fn = 50 )
{
    $fn = 50;
    union()
    {
        translate([ 0 , 0 , ( 0 - beautify ) ] )
        {
            cylinder( d = MBXL_BigHoleID() , h = Lenght + ( beautify * 2 ) , $fn = 50 );
        };
        
        rotate(a = [0,0,45])
        {
            for(Count = [0:3])
            {
                rotate(a = [0,0,90 * Count])
                {
                    //More Guesswork
                    translate([ ((MBXL_BigHoleID() / 2 ) - MBXL_SmallHoleID() / 4  ) , 0 , ( 0 - beautify ) ] ) 
                    {
                        cylinder( d = MBXL_SmallHoleID() , h = Lenght + ( beautify * 2 ) , $fn = 50 );
                    };
                };
            };
        };    
    };
};

module MBXL_RoundedEdgeNegitive(Lenght , CSize , beautify= 0.1 , $fn = 50)
{
    translate([ 0 - CSize , 0 - CSize , 0 ])
    {
        
            difference()
            {
                
                cube([ CSize + beautify , CSize+ beautify , Lenght ]);
                
                translate([ 0 , 0 , 0 - beautify])
                {
                    cylinder(r = CSize, h = Lenght +(2 * beautify) , $fn = 50 );
                };
            };
    }
};

module MakerBeamXL_TSlot_MainChanel(Lenght, beautify = 0.1 , $fn = 50)
{
    translate([ 0 , 0 - beautify , 0 ])
    {
        difference()
        {
            union()
            {
                rotate(a=[0,0,270])
                {
                    MBXL_RoundedEdgeNegitive(Lenght,0.25,beautify,$fn);
                };
                cube([3,5 + beautify,Lenght]);
                
                translate([3,0,0])
                {
                    rotate(a=[0,0,180])
                    {
                        MBXL_RoundedEdgeNegitive(Lenght,0.25,beautify,$fn);
                    };
                };
            };
            union()
            {
                translate([0,5,0 - beautify])
                {
                    rotate(a=[0,0,90])
                    {
                        MBXL_RoundedEdgeNegitive(Lenght + ( beautify * 2 ),0.5,beautify,$fn);
                    };
                    translate([3,0,0])
                    {
                        MBXL_RoundedEdgeNegitive(Lenght + ( beautify * 2 ),0.5,beautify,$fn);
                    };
                };
            };
        };
    };
};

module MakerBeamXL_TSlot_CrossChanel(Lenght, beautify = 0.1 , $fn = 50)
{
    difference()
    {
        union()
        {
            cube([5.7,2.5,Lenght], center = true );
            for(count = [0:3])
            {
                rotate(a=[ 0 , 0 , 90 * count])
                {
                    if(count % 2 == 0)
                    {
                        translate([ (-1.5) , (-1.25) , 0 - (Lenght/2)])
                        {
                            MBXL_RoundedEdgeNegitive(Lenght ,0.3,beautify,$fn);
                        };
                    }else{
                        translate([ (-1.25) , (-1.5) , 0 - (Lenght/2) ])
                        {
                            MBXL_RoundedEdgeNegitive(Lenght ,0.3,beautify,$fn);
                        };
                    };
                };
            };
        };

        union()
        {
            for(count = [0:3])
            {
                rotate(a=[ 0 , 0 , 90 * count])
                {
                    if(count % 2 == 0)
                    {
                        translate([ 2.85 , 1.25 , 0 - (Lenght/2) - beautify])
                        {
                            MBXL_RoundedEdgeNegitive(Lenght + ( beautify * 2 ),0.5,beautify,$fn);
                        };
                    }else{
                        translate([ 1.25 , 2.85 , 0 - (Lenght/2) - beautify])
                        {
                            MBXL_RoundedEdgeNegitive(Lenght + ( beautify * 2 ),0.5,beautify,$fn);
                        };
                    };
                };
            };
        };
    };
};

module MakerBeamXL_TSlot(Lenght, beautify= 0.1 , $fn = 50)
{
    rotate(a= [0,0,90])
    union()
    {
        MakerBeamXL_TSlot_MainChanel(Lenght , beautify , $fn );
        translate([ 1.5 , 2.35 ,Lenght/2])
        {
            MakerBeamXL_TSlot_CrossChanel(Lenght , beautify , $fn );
        }
    };
};



rotate (a= [ 0, 90  ,90 ])
{
    MakerBeamXL(Beam_Lenght);
}


echo("Remeber to 'use' not 'include'");