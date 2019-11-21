//bowl

radius= 35;
sides=4;
thickness=2;
bodyheight=35;
bodytwist=60;
bodyflare=1.2;
baseheight=5;
slope=1.5;
numberslices=60;
stickout=0.48;


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






//module
module potatoe(solid){
difference(){
union(){
offset( r=5, $fn=48)
     circle( r=radius, $fn=sides);
  translate([-radius+(stickout)*radius,-radius+(stickout)*radius,0]) offset( r=5, $fn=48)
     circle( r=radius/6, $fn=sides);
  translate([-radius+(stickout)*radius,radius-(stickout)*radius,0]) offset( r=5, $fn=48)
     circle( r=radius/6, $fn=sides);             
  translate([radius-(stickout)*radius,-radius+(stickout)*radius,0]) offset( r=5, $fn=48)
     circle( r=radius/6, $fn=sides);     
  translate([radius-(stickout)*radius,radius-(stickout)*radius,0]) offset( r=5, $fn=48)
     circle( r=radius/6, $fn=sides);     
}
if (solid=="no"){

union(){
offset( r=5-thickness, $fn=48)
     circle( r=radius, $fn=sides);
  translate([-radius+(stickout)*radius,-radius+(stickout)*radius,0]) offset( r=5-thickness, $fn=48)
     circle( r=radius/6, $fn=sides);
  translate([-radius+(stickout)*radius,radius-(stickout)*radius,0]) offset( r=5-thickness, $fn=48)
     circle( r=radius/6, $fn=sides);             
  translate([radius-(stickout)*radius,-radius+(stickout)*radius,0]) offset( r=5-thickness, $fn=48)
     circle( r=radius/6, $fn=sides);     
  translate([radius-(stickout)*radius,radius-(stickout)*radius,0]) offset( r=5-thickness, $fn=48)
     circle( r=radius/6, $fn=sides);  
           

            }
        }
    }
} 