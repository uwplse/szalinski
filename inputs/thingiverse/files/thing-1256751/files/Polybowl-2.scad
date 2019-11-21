//poly Bowls


radius= 100;
sides=3;
thickness=3;
bodyheight1=60;    //from bottom to top
bodyheight2=50;
bodyheight3=70;
bodyheight4=60;
bodytwist1=20;      //from bottom to top
bodytwist2=25;
bodytwist3=25;
bodytwist4=20;
bodyflare=0.8;
baseheight=2;
slope=0.95;
numberslices=200;

/////RENDER


///body1
translate([0,0,baseheight])
linear_extrude(height= bodyheight1, twist=bodytwist1, scale=bodyflare, slices= numberslices)
    potatoe(solid="");

//rim1
translate([0,0,baseheight+bodyheight1])
linear_extrude(height=baseheight/2)
    scale(bodyflare)
    rotate([0,0,-bodytwist1])
    potatoe(solid="");
    
//body 2

    translate([0,0,baseheight*1.5+bodyheight2-((bodyheight1-bodyheight2)*(-1))])
linear_extrude(height=bodyheight2, twist=-bodytwist2, 
        scale=bodyflare/slope, slices= numberslices)
        rotate([0,0,-bodytwist1])
        scale(bodyflare)
        potatoe(solid="");

//rim2
translate([0,0,baseheight*1.5+bodyheight1+bodyheight2])
linear_extrude(height=baseheight/2)
    scale((bodyflare*bodyflare)/slope)
    rotate([0,0,-bodytwist1+bodytwist2])
   potatoe(solid="");

//body 3
    translate([0,0,baseheight*2+bodyheight1+bodyheight2])
linear_extrude(height=bodyheight3, twist=bodytwist3, scale=bodyflare/slope, slices= numberslices)
        scale((bodyflare*bodyflare)/slope)
        rotate([0,0,-bodytwist1+bodytwist2])
        potatoe(solid="");
        
//rim3
translate([0,0,baseheight*2+bodyheight1+bodyheight2+bodyheight3])
linear_extrude(height=baseheight/2)
    scale((bodyflare*bodyflare*bodyflare)/(slope*slope))
    rotate([0,0,-bodytwist1+bodytwist2-bodytwist3])
    potatoe(solid="");     
    
//body 4
    translate([0,0,baseheight*2.5+bodyheight1+bodyheight2+bodyheight3])
linear_extrude(height=bodyheight4, twist=-bodytwist4, scale=bodyflare/slope, slices= numberslices)
        rotate([0,0,-bodytwist1+bodytwist2-bodytwist3])
        scale((bodyflare*bodyflare*bodyflare)/(slope*slope))
        potatoe(solid="");

//rim4
translate([0,0,baseheight*2.5+bodyheight1+bodyheight2+bodyheight3+bodyheight4])
linear_extrude(height=baseheight/2)
    scale((bodyflare*bodyflare*bodyflare*bodyflare)/(slope*slope*slope))
    rotate([0,0,-bodytwist1+bodytwist2-bodytwist3+bodytwist4])
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