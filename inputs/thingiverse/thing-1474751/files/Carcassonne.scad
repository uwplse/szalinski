/* [Basic Settings] */
//Number of Tiles for this section
number_of_tiles=72;
//Enable Tile Divider(true=1,false=0)
Divider=0;//[0,1]
//Enable Meeple Compartment(true=1,false=0)
Meeple=0;//[0,1]

/* [Thickness/Tolerance settings] */
//Adjust tile width to printer tolerance or looser fit. 45.2 fits snugly for me
tile_width=45.2;
//Thicker walls use more filament and print time but makes it stronger
wall_width=1.0;
//Modify it if you have a different average thickness of tiles
tile_thickness=2.1;
//Adds excess space for easier removal of tiles and to compensate for printer tolerance
tile_excess_space=0.6;

/* [Customisation] */
//Height of the box
height=20;

/* [Divider] */
//Number of dividers, CHANGE ONLY IF YOU ARE USING IT[Currently supporting up to 5 per row]
no_of_divider=0;//[5]
//Width of the divider
divider_width=1;//in mm
//Divider 1 location(as an integer in terms of tiles)
div1=0;
//Divider 2 location(as an integer in terms of tiles)
div2=0;
//Divider 3 location(as an integer in terms of tiles)
div3=0;
//Divider 4 location(as an integer in terms of tiles)
div4=0;
//Divider 5 location(as an integer in terms of tiles)
div5=0;

/* [Meeple Compartment] */
//Number of meeple compartments
mcom=0;
//Position of first meeple compartment 
mpos=0;//(as an integer in terms of tiles)
//Spacing of meeple compartments ( 22 is used in my other project but you might want to use a wider value)
mspace=22;//in mm
//Height of meeple compartments
mheight=40;//in mm
//Width of meeple compartments
mwidth=1;//in mm
//Resolution of circle
$fn=50;
//Ciurcular cutout
circle_radius =10;//in mm

/**
CODE
**/

//generate box
difference(){
    
    cube([number_of_tiles*tile_thickness+tile_excess_space+no_of_divider*divider_width+wall_width*2,tile_width+wall_width*2 ,height+wall_width]);

    translate([wall_width,wall_width,wall_width+0.1]){  
   cube([number_of_tiles*tile_thickness+tile_excess_space+no_of_divider*divider_width,tile_width,height]);
  }

}

//generate divider
if(Divider==1&&no_of_divider>0&&no_of_divider<6){
translate([div1*tile_thickness+tile_excess_space,wall_width,wall_width])
cube([divider_width,tile_width,height]);
     if(no_of_divider>1){
translate([div2*tile_thickness+tile_excess_space,wall_width,wall_width])
cube([divider_width,tile_width,height]);
     }
     if(no_of_divider>2){
translate([div3*tile_thickness+tile_excess_space,wall_width,wall_width])
cube([divider_width,tile_width,height]);
     }
     if(no_of_divider>3){
translate([div4*tile_thickness+tile_excess_space,wall_width,wall_width])
cube([divider_width,tile_width,height]);
     }
     if(no_of_divider>4){
translate([div5*tile_thickness+tile_excess_space,wall_width,wall_width])
cube([divider_width,tile_width,height]);
     }
}

//generate Meeple Compartment
if(Meeple==1&&mcom>0){
    for(i=[0:1:mcom]){
    translate([i*mspace,0,0]){
    difference(){
        translate([mpos*tile_thickness,wall_width,0])
        cube([mwidth,tile_width+wall_width,mheight]);
        
        translate([-1,(tile_width+wall_width*2)/2,mheight])
        rotate([0,90,0]){
        cylinder(h=mwidth*5,r=circle_radius);
        };
    }
    }
    }
    translate([mpos*tile_thickness,0,0])
    cube([mcom*mspace+mwidth,wall_width,mheight]);
        
    for(i=[0:1:1]){
    translate([mpos*tile_thickness,wall_width+tile_width,0]){
    cube([mcom*mspace+mwidth,wall_width,mheight]);
    }
}
}
