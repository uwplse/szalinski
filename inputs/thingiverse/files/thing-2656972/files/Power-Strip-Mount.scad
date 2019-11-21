/* [Hidden] */
$fs=0.1;

/* [Global] */
// The width of your socket
socket_width=50; 

// The height of your socket
socket_height=41;

// How far should your socket be covered in total?
overlay=20;


/* [Cable holder] */
// Cableholder on the left ?
cable_holder_right = true;

// Cable holder on th eright?
cable_holder_left = true;

// Thickness of the Cable holder
cable_holder_thickness = 6;

// Distance to cable holder
cable_holder_width = 10;


/* [Plug cuts] */
// Offset from the end of the socket to the beginning of the round cut
outlet_cut_round_offset=9; 

// Diameter of the round cut (0=disabled) (Schuko=41)
outlet_cut_diameter=40; 


// Offset from the end of the socket to the beginning of the rectangular cut
switch_cut_rect_offset=0; 

// Diameter of the rectangular cut (0=disabled)
switch_cut_rect_width=0; 


/* [Cable outlet cuts] */

// Distance from the bottom of the socket to the top of the cable
cable_top_offset=32;

// Diameter of the cable cut
cable_diameter=22; 


/* [Other] */
// Wall thickness
thickness=3; 

// Diameter of the screw holde
screw_diameter = 4; 


outerwidth=socket_width+2*thickness;
outerheight=socket_height+thickness;
outerdepth=overlay+thickness;

cableholderheight = outerheight-cable_holder_width-thickness;



render () {
difference () {
    cube([outerdepth,outerwidth,outerheight]);
    translate([thickness,thickness,0])
        cube([overlay,socket_width,socket_height]);

    // cable outlet
    hull()
    {
        translate ([0,outerwidth/2,cable_top_offset-cable_diameter/2])
            rotate ([0,90,0])
                cylinder (h=thickness*2,r=cable_diameter/2,center=false);

        translate ([0,thickness+cable_diameter/2,0])
            rotate ([0,90,0])
                cylinder (h=thickness*2,r=cable_diameter/2,center=false);

        translate ([0,outerwidth-(thickness+cable_diameter/2),0])
            rotate ([0,90,0])
                cylinder (h=thickness*2,r=cable_diameter/2);
    
    }
    
    // socketcut round
    translate ([outlet_cut_round_offset+thickness+outlet_cut_diameter/2,outerwidth/2,outerheight-thickness])
        cylinder (h=thickness*2,r=outlet_cut_diameter/2);
    
    
    // socketcut rectangular
    translate ([switch_cut_rect_offset+thickness,(outerwidth-switch_cut_rect_width)/2,outerheight-thickness])
        cube ([overlay,switch_cut_rect_width,thickness*2]);
}


//srewfix right
translate([0,outerwidth],0)
    screwfix(outerdepth,thickness,screw_diameter);

//screwfix left
mirror([0,1,0])
    screwfix(outerdepth,thickness,screw_diameter);


//cableholder right
if (cable_holder_right)
{
translate([0,outerwidth,outerheight])
    cableholder(cable_holder_width,cable_holder_thickness,
    cableholderheight,
    outerdepth,
    screw_diameter*2.5);    // change this factor to adjust the screw driver width
}

//cableholder left
if (cable_holder_left)
{
    translate([0,0,outerheight])
        mirror([0,1,0])
        cableholder(cable_holder_width,cable_holder_thickness,
        cableholderheight,
        outerdepth,
        screw_diameter*2.5);    // change this factor to adjust the screw driver width
}
}


module cableholder (
    width,
    cthickness,
    height,
    depth,
    dia)
{
    outerradius = width/2+cthickness; 

    // Point zero at top left corner
    difference(){
        union() {
            // top cylinder
            translate ([0,width/2,(width/2+cthickness)*-1])
                rotate ([0,90,0])
                    cylinder (h=depth,r=outerradius);
           
            // fill corner on cylinder
            translate ([0,0,(width/2+cthickness)*-1])
                cube ([depth,width/2,outerradius]);
            
            // main bar
            translate ([0,0,cthickness/2-height])
                cube ([depth,width+cthickness,height-outerradius-cthickness/2]);
            
            // main bar lower rounding
            translate ([0,width+cthickness/2,cthickness/2-height])
                rotate ([0,90,0])
                    cylinder (h=depth,r=cthickness/2);
            
            // corner out main bar rounding
            translate([0,width,height*-1])
                cube([depth,cthickness/2,cthickness/2]);
        }

        //top inner rounding
        translate ([0,width/2,(width/2+cthickness)*-1])
            rotate ([0,90,0])
                cylinder (h=depth*2,r=width/2);
        // main inner space
        translate ([0,0,(height+width)*-1])
            cube ([depth,width,height+width/2-cthickness]);
        
        // screwslot
        translate ([(depth)/2, max(width/2,dia/2),height*-1])
                cylinder (h=height,r=dia/2);   
        
        // remove overhanging cylinder  
        translate([0,outerradius*-1,outerradius*-2])
            cube ([depth,outerradius,outerradius*2]); 
    }
}
    


module screwfix(width,height,diameter) {
    length=3*diameter;
    radius=min(length,width/2);
    difference(){
        hull() {
            cube([width,length-radius,height]);
            
            translate ([width-radius,length-radius,0]) 
                cylinder (h=height,r=radius);
            translate ([radius,length-radius,0]) 
                cylinder (h=height,r=radius);
       };
       // screwholes
       translate ([(width)/2,length/2,0]) 
            cylinder(h=height,r=diameter/2);
       
       // remove leftover from rounding
       translate ([0,radius*-1,0])
            cube([width,radius,height]);
    }
}

