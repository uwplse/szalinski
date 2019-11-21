//Parametric Lab Condesor
//Nick Buday
//nkbuday@mtu.edu
//Creative Commons License

//Uses libraries developed by Rudolf Huttary
//  https://www.thingiverse.com/Parkinbot
//Link to library: 
//  https://www.thingiverse.com/thing:3252637

//The library does call upon another library made by Rudolf Huttary
//Link to other library:
//  https://www.thingiverse.com/thing:900137

//This program aims to construct a parametric compresssor for a suitable replacement of a commerical equivalant. Commerical equivalant: Graham Condenser, Borosilicate Glass, 24/40 Joint Size Price: $37.78 (usd) *(prices vary on length of condensor.

use <springs.scad>;
// spring with default values
//spring(r=5, R=40, windings=5, H=150, center = true,
//R1 = undef, start=false, end=false, 
//ends=undef, w = undef, h=undef)

//Resolution (switch to 100 when rendering and exporting)
$fn = 16;//[10:100]


//Height of Compressor (mm)
Height = 200; //[60:500]

//Windings of Tubing
Windings = 16;//[1:30]

//Radius of pipe (mm)
radius = 5;//[1:10]

//Wall Thickness of pipe (mm)
thickness = 2;//[1:9]

//Radius of helical piping
Radius = 10;//[1:40]
//Compressore

//Establishes geomtery to add 90 deg ends to the end of the "spring"
end_height = (Height/Windings)*Windings/2-radius-2.5;
end_angle = ((Height/Windings)/10*3.14*2);

//Couple Radius
Coupler_width = 24;//[5:103]
C_radius = Coupler_width/2;

//Couple Length
C_length = 40;//[12:60]

//Adapter diameter for side inlet and outlet (mm)
Tube_adapter_size = 10;//[2:15]
tube_adapter_size=Tube_adapter_size/2;

//The tube uses the spring libirary to create a helical pipe.
module tube(){
    union(){
        difference(){ 
            spring(r=radius,R=Radius,windings=Windings,H=Height-15);
            spring(r=radius-thickness,R=Radius,windings=Windings,H=Height-15);}
    }
}
//Makes the ends of the pipe
module end_1(){
    union(){
//90 degree bend
        difference(){
            rotate_extrude(angle= 90, convexity = 10)
            translate([radius, 0, 0])
            circle(r=radius);
            rotate_extrude(angle= 90, convexity = 10)
            translate([radius, 0, 0])
            circle(r=radius-thickness);}
//Vertical Section
        difference(){
            rotate([0,90,0])
            rotate([end_angle,0,0])
            translate([0,5,-5])
            cylinder(5,radius,radius);
            rotate([0,90,0])
            rotate([end_angle,0,0])
            translate([0,5,-5.2])
            cylinder(5.4,radius-thickness,radius-thickness);}
            
   }
}
module end_2(){
    union(){
//90 degree bend
        difference(){
            rotate_extrude(angle= 90, convexity = 10)
            translate([radius, 0, 0])
            circle(r=radius);
            rotate_extrude(angle= 90, convexity = 10)
            translate([radius, 0, 0])
            circle(r=radius-thickness);}
//Vertical section
        difference(){
            rotate([0,90,0])
            rotate([90-end_angle,0,0])
            translate([0,5,0])
            cylinder(5,radius,radius);
            rotate([0,90,0])
            rotate([90-end_angle,0,0])
            translate([0,5,-0.2])
            cylinder(5.4,radius-thickness,radius-thickness);}
    }
}
//Makes the "adapter" to go from pipe to the joint
module end_1_couple(){
            difference(){
                translate([0,0,end_height+7.25])
                cylinder(15,Radius+radius+10,C_radius);
                translate([0,0,2+end_height+7.25])
                cylinder(15,Radius+radius+2,C_radius-5);
                translate([Radius,3,5+end_height])
                cylinder(5,radius-1,radius-1);}
            difference(){
                translate([0,0,end_height+7.25+15])
                cylinder(C_length,C_radius,C_radius+0.1*C_radius);
                translate([0,0,2+end_height+7.25+15-3])
                cylinder(C_length+3,C_radius-2.75,C_radius-2.75+0.1*C_radius);}

        }
module end_2_couple(){
            union(){
                difference(){
                    translate([0,0,-end_height-17.25])
                    cylinder(15,C_radius,Radius+radius+10);
                    translate([0,0,-2-end_height-17.25])
                    cylinder(15,C_radius-5,Radius+radius+2);
                    translate([Radius,-3,-20-end_height+10])
                    cylinder(20,radius-1,radius-1);}
                difference(){
                    translate([0,0,-end_height-17.25-C_length])
                    cylinder(C_length,C_radius-0.1*C_radius,C_radius);
                    translate([0,0,-2-end_height-17.25-C_length])
                    cylinder(C_length+3,C_radius-2.75-0.1*C_radius,C_radius-2.75);}
                 

        }
}
//Outer casing of the condensor
module housing(){
//Creates outer shell for the condensor
    union(){
        difference(){
            translate([0,0,-Height/2+5])
            cylinder(Height-5,Radius+radius+10,Radius+radius+10);
            translate([0,0,-Height/2+4])
            cylinder(Height,Radius+radius+8,Radius+radius+8);
            translate([0,Radius+radius+36,Height/2-radius-tube_adapter_size])
            rotate([90,0,0])
            cylinder(34,tube_adapter_size,tube_adapter_size);
            translate([0,Radius+radius+36,-Height/2+2*radius+tube_adapter_size])
            rotate([90,0,0])
            cylinder(34,tube_adapter_size,tube_adapter_size);}
//Creates top tube adapter            
        difference(){
            union(){
                translate([0,Radius+radius+35,Height/2-radius-tube_adapter_size])
                rotate([90,0,0])
                cylinder(30,tube_adapter_size,tube_adapter_size);
//Creates multiple barbs for tube to be latched onto                
                translate([0,Radius+radius+35-15,Height/2-radius-tube_adapter_size])
                rotate([90,0,0])
                cylinder(5,tube_adapter_size,tube_adapter_size+2);
                translate([0,Radius+radius+35-10,Height/2-radius-tube_adapter_size])
                rotate([90,0,0])
                cylinder(5,tube_adapter_size,tube_adapter_size+2);
                translate([0,Radius+radius+35-5,Height/2-radius-tube_adapter_size])
                rotate([90,0,0])
                cylinder(5,tube_adapter_size,tube_adapter_size+2);
                translate([0,Radius+radius+35,Height/2-radius-tube_adapter_size])
                rotate([90,0,0])
                cylinder(5,tube_adapter_size,tube_adapter_size+2);}                
                 
            translate([0,Radius+radius+36,Height/2-radius-tube_adapter_size])
            rotate([90,0,0])
            cylinder(34,tube_adapter_size-2,tube_adapter_size-2);}
//Creates bottom tube adapter                       
        difference(){
            union(){
                translate([0,Radius+radius+35,-Height/2+2*radius+tube_adapter_size])
                rotate([90,0,0])
                cylinder(30,tube_adapter_size,tube_adapter_size);
//Creates multiple barbs for tube to be latched onto                
                translate([0,Radius+radius+35-15,-Height/2+2*radius+tube_adapter_size])
                rotate([90,0,0])
                cylinder(5,tube_adapter_size,tube_adapter_size+2);
                translate([0,Radius+radius+35-10,-Height/2+2*radius+tube_adapter_size])
                rotate([90,0,0])
                cylinder(5,tube_adapter_size,tube_adapter_size+2);
                 translate([0,Radius+radius+35-5,-Height/2+2*radius+tube_adapter_size])
                rotate([90,0,0])
                cylinder(5,tube_adapter_size,tube_adapter_size+2);
                translate([0,Radius+radius+35,-Height/2+2*radius+tube_adapter_size])
                rotate([90,0,0])
                cylinder(5,tube_adapter_size,tube_adapter_size+2);               
            }                
            translate([0,Radius+radius+36,-Height/2+2*radius+tube_adapter_size])
            rotate([90,0,0])
            cylinder(34,tube_adapter_size-2,tube_adapter_size-2);}
//Creates a top Chafer for 3d printing, reduces the span for extruder over no material
        difference(){
            translate([0,0,Height/2-10])
            cylinder(10,Radius+radius+10,Radius+radius+10);
            translate([0,0,-2+Height/2-10])
            cylinder(12,Radius+radius+10,Radius);
            translate([Radius,3,5+end_height])
            cylinder(5,radius-1,radius-1);}
//Creates a bottom Chafer for 3d printing, reduces the span for extruder over no material
        difference(){
            translate([0,0,-Height/2+5])
            cylinder(10,Radius+radius+10,Radius+radius+10);
            translate([0,0,-2-Height/2+5])
            cylinder(12,Radius,Radius+radius+10);
            translate([Radius,-3,-20-end_height])
            cylinder(30,radius-1,radius-1);}
  }
}


//Unites all of the pieces as one complete model
module assembly(){
    union(){
        housing();
        tube();
        translate([Radius,-2,end_height+4.5])
        rotate([0,90,0])
        rotate([0,0,end_angle])
        end_1();
        translate([Radius,2,-end_height-4.5])
        rotate([180,90,0])
        rotate([0,0,90-end_angle])
        end_2();
        end_1_couple();
        end_2_couple();
        
  }
}
assembly();