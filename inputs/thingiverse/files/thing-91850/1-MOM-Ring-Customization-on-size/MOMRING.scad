use <write/Write.scad>

// Version 6. March 11, 2013
// Fixed a problem with not properly handling the case when there is no text but we are generating the "inscription" part

//preview[view:west,tilt:top]

//CUSTOMIZER VARIABLES

// Sizing for the finger

// Chart taken from http://www.thingiverse.com/thing:40704
//(US Ring Sizes)
ring_size = 15.09;//[11.63:0,11.84:0.25,12.04:0.5,12.24:0.75,12.45:1,12.65:1.25,12.85:1.5,13.06:1.75,13.26:2,13.46:2.25,13.67:2.5,13.87:2.75,14.07:3,14.27:3.25,14.48:3.5,14.68:3.75,14.88:4,15.09:4.25,15.29:4.5,15.49:4.75,2215.9:5.25,16.1:5.5,16.31:5.75,16.51:6,16.71:6.25,16.92:6.5,17.12:6.75,17.32:7,17.53:7.25,17.73:7.5,17.93:7.75,18.14:8,18.34:8.25,18.54:8.5,18.75:8.75,18.95:9,19.15:9.25,19.35:9.5,19.56:9.75,19.76:10,19.96:10.25,20.17:10.5,20.37:10.75,20.57:11,20.78:11.25,20.98:11.5,21.18:11.75,21.39:12,21.59:12.25,21.79:12.5,22:12.75,22.2:13,22.4:13.25,22.61:13.5,22.81:13.75,23.01:14,23.22:14.25,23.42:14.5,23.62:14.75,23.83:15,24.03:15.25,24.23:15.5,24.43:15.75,24.64:16]

c_r=ring_size/2;

// Thickness of the ring
thick=2;//[2:4]
// Up and down width at the back of the ring
ring_width=5;//[5:7]
// Angle from back to front. 0 is uniform width
ring_angle=15;//[0:20]

// Text on the face
//text_face="#1 MOM";
// Text size on the face
text_size_face = 4; // [3:9]
// Text spacing on the face
space_size_face=1.0*1;

// Text of the interior inscription
text= "LOVE YOU";
// Text Size on interior inscription
text_size_interior =  3;  // [3:5]
// Text spacing on the interior
space_size =1.0*1;

// Which one would you like to see?
part = "ring"; // [ring:Ring,inscription:Inscription]

s_r=c_r+2*thick;
x_offset=-thick;
y_b=ring_width/2;
x_b=sqrt(s_r*s_r-y_b*y_b);

angle=ring_angle;

translate([c_r+thick,0,0])
rotate([0,angle,0])
translate([-x_b,0,y_b])
{
  if(part=="ring")
  difference() {
    difference() {
      difference() { 
        translate([0,0,0]) sphere(s_r,$fn=100,center=true);
        union() {
          translate([-x_offset,0,0]) cylinder(60,c_r,c_r,$fn=100,center=true); 
          translate([+x_b,0,y_b]) rotate([0,angle,0]) translate([-x_b-s_r,-s_r,0]) cube([2*s_r,s_r*2,s_r]);
          translate([+x_b,0,-y_b]) rotate([0,-angle,0]) translate([-x_b-s_r,-s_r,-s_r]) cube([2*s_r,s_r*2,s_r]);
        }
      }
      translate([-s_r-c_r,-s_r,-s_r]) cube([s_r,2*s_r,2*s_r]);
    }
    translate([-x_offset,0,0]) mirror([ 0, 1, 0 ]) writesphere(text,[0,0,0],c_r,east=90,t=thick,h=text_size_interior,font="write/Letters.dxf", space=space_size,center=true);
      translate([-c_r,0,0]) rotate([90,0,-90]) write("#1 MOM",h=text_size_face,t=thick,font="write/Letters.dxf",space=space_size_face,center=true);
  }

  if(part=="inscription") {

    if(len(text))
    color("red")
    intersection() {
      difference() {
        translate([-x_offset,0,0]) cylinder(10,c_r+thick,c_r+thick,$fn=100,center=true); 
        translate([-x_offset,0,0]) cylinder(10,c_r,c_r,$fn=100,center=true); 
      }
      translate([-x_offset,0,0]) mirror([ 0, 1, 0 ]) writesphere(text,[0,0,0],c_r,east=90,t=thick,h=text_size_interior,font="write/Letters.dxf", space=space_size,center=true);
    } // End of intersection() for the interior text

    if(len(text_face))
    color("red")
    intersection() {
      translate([-c_r,-s_r,-s_r]) cube([thick,2*s_r,2*s_r]);
      translate([-c_r,0,0]) rotate([90,0,-90]) write(text_face,h=text_size_face,t=thick,font="write/Letters.dxf",space=space_size_face,center=true);
    } // End of intersection() for the text on the face

  } // End of part=="inscription"
}


