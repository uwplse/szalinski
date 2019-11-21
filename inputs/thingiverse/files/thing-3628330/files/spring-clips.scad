/********* BEST VIEWED IN 80 COLUMNS ** BEST VIEWED IN 80 COLUMNS **************
*
* Spring Clip Screwdriver Holder
* Benjamen Johnson <workshop.electronsmith.com>
* 20190509
* Version 1
* openSCAD Version: 2015.03-2 
*******************************************************************************/
// number of mounting holes
mounting_hole_num = 2; // [0,1,2]

// mounting hole diameter
mount_hole_dia = 4;

// Countersunk mounting hole?
countersink = 1; //[0:false, 1:true]

//Countersink angle
countersink_angle = 82;

//Countersink depth
countersink_depth = 3;

// How high is the entire spring clip holder
holder_height = 20;

// the distance between the springs
spring_distance = 0.2;

// the size of the notch
notch_radius = 3;

// type of notch
notch_type = 4; // [4:Diamond, 5:Hex, 50:Semicircle]

// How thick are the two springs
wall_thickness = 3;

// width of the ellipse that makes the spring
spring_width = 16;

//height of the ellipse that makes the spring
spring_height = 40;

x=tan(countersink_angle/2)*countersink_depth/2;

difference(){
    
    union(){
        holder();
        mirror([1,0,0])holder();
        
        //join the two sides
        translate([0,-spring_height/2+wall_thickness/2,0])cube([spring_width+spring_distance,wall_thickness,holder_height],center=true);
    } // end union
    
    //cut the inside of the spring
    translate([0,-spring_height/2+3*wall_thickness/2,0])cube([spring_width,wall_thickness,holder_height],center=true);
   
    //cut the mounting hole
    if (mounting_hole_num == 1){    
        translate([0,-spring_height/2+wall_thickness/2,0])rotate([90,0,0])cylinder(d=mount_hole_dia,h=wall_thickness, center=true,$fn=50);
        if (countersink){
            translate([0,-spring_height/2+wall_thickness/2+(wall_thickness-countersink_depth)/2,0])rotate([90,0,0])cylinder(d2=mount_hole_dia, d1=mount_hole_dia+2*x, h=countersink_depth,center=true,$fn=50);
        } //end if countersink
    } //end if 1 mounting hole
    else if (mounting_hole_num == 2){
        translate([0,-spring_height/2+wall_thickness/2,-holder_height/4])rotate([90,0,0])cylinder(d=mount_hole_dia,h=wall_thickness, center=true,$fn=50);
        translate([0,-spring_height/2+wall_thickness/2,holder_height/4])rotate([90,0,0])cylinder(d=mount_hole_dia,h=wall_thickness, center=true,$fn=50);
        if (countersink){
            translate([0,-spring_height/2+wall_thickness/2+(wall_thickness-countersink_depth)/2,-holder_height/4])rotate([90,0,0])cylinder(d2=mount_hole_dia, d1=mount_hole_dia+2*x, h=countersink_depth,center=true,$fn=50);
            translate([0,-spring_height/2+wall_thickness/2+(wall_thickness-countersink_depth)/2,holder_height/4])rotate([90,0,0])cylinder(d2=mount_hole_dia, d1=mount_hole_dia+2*x, h=countersink_depth,center=true,$fn=50);
        } // end if countersink
    } //end if 2 mounting holes
} //end difference


/*******************************************************************************
* Function to make the spring three dimensional and have thickness
*******************************************************************************/
module holder()
{
    translate([0,0,-holder_height/2])
    linear_extrude(height=holder_height){
        difference(){
            spring();
            offset(r=-wall_thickness)spring();
        }// end difference
    } // end linear_extrude
}

/*******************************************************************************
* Function to make the outline of one side of the spring
*******************************************************************************/
module spring()
{
    difference(){
        translate([-(spring_width/2+spring_distance/2),0,0])ellipse(spring_width/2,spring_height/2,200);
        circle(r=notch_radius,center=true,$fn=notch_type);
        }// end difference      
}// end module

/*******************************************************************************
* Simple function to make an ellipse
* a: semi-minor axis
* b: semi-major axis
* res: smoothness -- render with how many sides ($fn)
*******************************************************************************/
module ellipse(a,b,res){
    scale([a,b,1])circle(r=1,$fn=res,center=true);
}// end module