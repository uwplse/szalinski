//corner radius(mm)make half as lenth to get a round sieve//
radius=50;
lengthx=100;
lengthy=100;
higth=100;
//overhang of the brim//
overhang=2;
//wall thikness//
wall=1.2;

// - honeycomb height
hc_height = 1.2;
// - hexagon hole diameter
hexagon_diameter = 3.8                                                                             ;
// - hexagon frame thickness
hexagon_thickness = 0.8;

r=radius/1;
b=lengthx-r;
l=lengthy-r;
h=higth/1;
u=overhang/1;
w=1.2/1;

//Backside//

back1_h=0/1;
back1_b=0/1;
back1p_l=(l+r)/2-13/1;
back1p_b=-30.5/1;
back2_h=0/1;
back2_b=0/1;
back2p_l=(l+r)/2-46/1;
back2p_b=0/1;



//knopfe top//

k1=22.5/1;

//knopfe seite//

k2=16/1;

k3=26/1;

//jack//
j1=34/1;


difference  (){
union(){
difference(){
    union(){
    minkowski(){
       union(){
            cylinder(h-u-u+w+w,r+w,r+w, center=true);
            translate([0,0,(h/2)-u/2+w])
            cylinder(u,r+w,r,center=true);
            translate([0,0,-(h/2)+u/2-w])
            cylinder(u,r,r+w,center=true);
           

           
        }
            cube([b-r,l-r,1],center=true);
               }
               
               ///////////////knopfe bobbel///////////

//translate([(b+r)/2-k1,(l+r)/2,-0.5])    
  //  rotate (a=90, v=[0,0,1])           
//scale([1,2,1])
//sphere(3);
               
//translate([(b+r)/2,(l+r)/2-k2,-0.5])               
//scale([1,2,1])
//sphere(3);
 
//translate([(b+r)/2,(l+r)/2-k3,-0.5])               
//scale([1,2,1])
//sphere(3);              
           }
               
               
                minkowski(){
        union(){
            cylinder(h-u-u,r,r, center=true);
            translate([0,0,(h/2)-u/2])
            cylinder(u,r,r-w,center=true);
            translate([0,0,-(h/2)+u/2])
            cylinder(u,r-w,r,center=true);
        }
            cube([b-r,l-r,1],center=true);
               }
               
               minkowski(){
            cylinder(h+w+w+w,r-u,r-u, center=true);
                   cube([b-r,l-r,1],center=true);
               }
           
///////////////////////////////           
/////////////zubehör///////////
///////////////////////////////

////////////jack//////////////
               
       //    translate([(b+r)/2-j1,(l+r+w)/2,-1.5])
         //  rotate(a=90, v=[1,0,0])
          // cylinder(w+0.1,4.5,3, center=true);   
           
            //   translate([(b+r)/2-j1,(l+r+w)/2-w,-1.5])
         //  rotate(a=90, v=[1,0,0])
           //cylinder(w+0.1,3,3, center=true); 
////////////mic////////////////
               
     //       translate([(b+r)/2-28.5,-(l+r+w)/2,2])
       //    rotate(a=90, v=[1,0,0])
         //  cylinder(w+h,1,1, center=true);      
               
               
               
               
////////////microUSB////////////
       //        translate([0,-(l+r+w)/2,0])
         
       //  rotate(a=90, v=[1,0,0])
         //  cube([10.5,7,w+h], center=true);   
    
///////////speakr//////////////         
 //translate([20,-(l+r+w)/2,0])
   //        rotate(a=90, v=[1,0,0])
     //      cube([14,2.5,w+h], center=true); 
       //    
         //  translate([-20,-(l+r+w)/2,0])
           //rotate(a=90, v=[1,0,0])
             //cube([14,2.5,w+h], center=true);   
           
           
           
////////////knopfe space//////////////////
          // rotate(a=90, v=[0,0,1])
                                                                                                                             //  translate([(l+r)/2,-(b)/2-2*u+w-0.4+k1,-0.5])                                                                                                                         rotate(a=90,v=[0,0,1])                                                                                                                          cube ([12,0.6,4],center=true);
           
         //   rotate(a=90, v=[0,0,1])
           //translate([(l+r)/2-((k2+k3)/2),-(b)/2-2*u+w-0.4,-0.5])
    //       cube ([22,0.6,4],center=true);
           
       }
       
       //---------------------------------------------------------------
//-- CUSTOMIZER PARAMETERS
//---------------------------------------------------------------

// - honeycomb length
hc_length = l+r;
// - honeycomb width
hc_width = b+r;



/* [HIDDEN] */

box = [hc_width, hc_length, hc_height];
       
       
intersection(){
    union(){
       
    
    
    difference(){
    hexagonal_grid(box, hexagon_diameter, hexagon_thickness);
            translate([back1p_b,back1p_l,    -(h+2*w)/2])
    
     cube([back1_h+2*hexagon_thickness,back1_b+2*hexagon_thickness,w],center=true);
                   translate([back2p_b,back2p_l,    -(h+2*w)/2])
    
     cube([back2_h+2*hexagon_thickness,back2_b+2*hexagon_thickness,w],center=true);
    }
    translate([back1p_b,back1p_l,    -(h+2*w)/2])
    difference(){
     cube([back1_h+2*hexagon_thickness,back1_b+2*hexagon_thickness,w],center=true);
     cube([back1_h,back1_b,w],center=true);   
    }
 //  translate([back2p_b,back2p_l,    -(h+2*w)/2])
  //   difference(){
 //    cube([back2_h+2*hexagon_thickness,back2_b+2*hexagon_thickness,w],center=true);
   //  cube([back2_h,back2_b,w],center=true);   
  //  }
    }
        
    
   
    
   
   
    minkowski(){
       union(){
            cylinder(h-u-u+w+w,r+w,r+w, center=true);
            translate([0,0,(h/2)-u/2+w])
            cylinder(u,r+w,r,center=true);
            translate([0,0,-(h/2)+u/2-w])
            cylinder(u,r,r+w,center=true);
           

           
        }
            cube([b-r,l-r,1],center=true);
               }
           }
//    hexagonal_grid([25, 25, 5], 5, 1);
       }
////////////jack//////////////
               
        //   translate([(b+r)/2-j1,(l+r+w)/2,-1.5])
          // rotate(a=90, v=[1,0,0])
           //cylinder(w+0.1,4.5,3, center=true);   
           
          //     translate([(b+r)/2-j1,(l+r+w)/2-w,-1.5])
          // rotate(a=90, v=[1,0,0])
           //cylinder(w+0.1,3,3, center=true); 
   }

//---------------------------------------------------------------
//-- MODULES
//---------------------------------------------------------------



// * HONEYCOMB

module hexagonal_grid(box, hexagon_diameter, hexagon_thickness){
// first arg is vector that defines the bounding box, length, width, height
// second arg in the 'diameter' of the holes. In OpenScad, this refers to the corner-to-corner diameter, not flat-to-flat
// this diameter is 2/sqrt(3) times larger than flat to flat
// third arg is wall thickness.  This also is measured that the corners, not the flats. 

// example 
//    hexagonal_grid([25, 25, 5], 5, 1);

translate([0,0,-(h+2*w)/2])
    difference(){
        cube(box, center = true);
        hexgrid(box, hexagon_diameter, hexagon_thickness);
        
        
        
    }
}


module hex_hole(hexdiameter, height){
        translate([0, 0, 0]) rotate([0, 0, 0]) cylinder(d = hexdiameter, h = height, center = true, $fn = 6);
}


module hexgrid(box, hexagon_diameter, hexagon_thickness) {
    cos60 = cos(60);
    sin60 = sin(60);
    d = hexagon_diameter + hexagon_thickness;
    a = d*sin60;

    moduloX = (box[0] % (2*a*sin60));
//    numX = (box[0] - moduloX) / a;
    numX =  floor(box[0] / (2*a*sin60));
    oddX = numX % 2;
    numberX = numX;

    moduloY = (box[1] % a);
//    numY = (box[1] - moduloY) / a;
    numY =  floor(box[1]/a);
    oddY = numY % 2;
    numberY = numY;

// Center the central hexagon on the origin of coordinates
    deltaY = oddY == 1 ? a/2 : 0;

    x0 = (numberX + 2) * 2*a*sin60;
    y0 = (numberY + 2) * a/2 + deltaY;

    for(x = [ -x0: 2*a*sin60 : x0]) {
        for(y = [ -y0 : a : y0]) {
            translate([x, y, 0]) hex_hole(hexdiameter = hexagon_diameter, height = box[2] + 0.001);
           translate([x + a*sin60, y + a*cos60 , 0]) hex_hole(hexdiameter = hexagon_diameter, height = box[2] + 0.001);
// echo ([x, y]);
// echo ([x + a*sin60, y + a*cos60]);
            
         } //fo
    } //fo
} //mo

// * END OF HONEYCOMB



//---------------------------------------------------------------
//-- RENDERS
//---------------------------------------------------------------
