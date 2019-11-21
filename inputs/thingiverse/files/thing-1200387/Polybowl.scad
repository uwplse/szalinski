//poly Bowls


radius= 50;
sides=8;
thickness=3;
bodyheight=45;
bodytwist=60;
bodyflare=1.1;
baseheight=5;
slope=0.9;
numberslices=60;

/////RENDER


///body1
translate([0,0,baseheight])
linear_extrude(height= bodyheight, twist=bodytwist, scale=bodyflare, slices= numberslices)
    potatoe(solid="");

//rim1
translate([0,0,baseheight+bodyheight])
linear_extrude(height=baseheight/2)
    scale(bodyflare)
    rotate([0,0,-bodytwist])
    potatoe(solid="");
    
//body 2

    translate([0,0,baseheight*1.5+bodyheight])
linear_extrude(height=bodyheight, twist=-bodytwist, 
        scale=bodyflare/slope, slices= numberslices)
        rotate([0,0,-bodytwist])
        scale(bodyflare)
        potatoe(solid="");

//rim2
translate([0,0,baseheight*1.5+2*bodyheight])
linear_extrude(height=baseheight/2)
    scale((bodyflare*bodyflare)/slope)
    rotate([0,0,0])
   potatoe(solid="");

//body 3
    translate([0,0,baseheight*2+bodyheight*2])
linear_extrude(height=bodyheight, twist=bodytwist, scale=bodyflare/slope, slices= numberslices)
        scale((bodyflare*bodyflare)/slope)
        potatoe(solid="");
        
//rim3
translate([0,0,baseheight*2+3*bodyheight])
linear_extrude(height=baseheight/2)
    scale((bodyflare*bodyflare*bodyflare)/(slope*slope))
    rotate([0,0,-bodytwist])
    potatoe(solid="");        
//body 4
    translate([0,0,baseheight*2.5+bodyheight*3])
linear_extrude(height=bodyheight, twist=-bodytwist, scale=bodyflare/slope, slices= numberslices)
        rotate([0,0,-bodytwist])
        scale((bodyflare*bodyflare*bodyflare)/(slope*slope))
        potatoe(solid="");

//rim4
translate([0,0,baseheight*2.5+4*bodyheight])
linear_extrude(height=baseheight/2)
    scale((bodyflare*bodyflare*bodyflare*bodyflare)/(slope*slope*slope))
    rotate([0,0,0])
    potatoe(solid="");        

//base
linear_extrude(height=baseheight)
    potatoe(solid="");    

/////MODULE

module potatoe(solid){
difference(){
   //outside
    offset( r=5, $fn=40)
        circle(r=radius, $fn=sides);
    // hollow
    if (solid=="no"){    
    //inside
    offset( r=5-thickness, $fn=40)
       circle(r=radius, $fn= sides);
        }
    }
}