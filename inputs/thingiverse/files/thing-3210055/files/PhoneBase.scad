/*   Customizable Phone Stand v 0.7
     by John Ulvr, 2018
*/

// phone width in mm
phone_width = 77.0;
// phone height in mm
phone_height = 150;
// phone thickness in mm
phone_thickness = 11.1;
// distance from front of phone to center of usb charger
charger_depth = 5.9;
// distance of charger from center of phone width (positive is to right)
// use 0 if centered
charger_offset = 0;

// basetype (0 or 1 -- 1 does not work with older openscad)
base_type = 1;

//back screw hole diameter in mm (keep to 3mm for M4 or 6-32 screws)
hole_diameter=3;

//optional text for front -- leave blank if acetone smoothing!
front_text = "";

// printer tollerance: the distance in mm that your printer overprints
overprint=0.1;

//play: amount of play -- smaller play means a tighter fit.
play = 0.5;

module unused() {}

//thickness of walls in mm (default to 2mm)
wallThickness = 2;

/*
This software is licenced under the BSD 2.0 License:

Copyright (c) 2018 John Ulvr
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies,
either expressed or implied, of the PhoneBase project.
*/


module check(c,msg) {
    if (c == false) 
        translate([0,-30,0]) linear_extrude(4) color("red") 
            text(msg, 
                 font = "Liberation Sans:style=Bold Italic", 
                         size=10,
                         valign="center", halign="center");
}


check(phone_thickness >= 8.5, msg="Phone to thin");
check(phone_thickness <= 25, message="Phone to thick");
check(phone_width > 55, message="Phone to narrow (55mm <= width <= 90mm)");
check(phone_width <= 90, message="Phone to wide (55mm <= width <= 90mm)");
check(charger_depth+3.5 < phone_thickness, message="Bad Charger Depth");
check(charger_depth-3.5 > 0, message="Bad Charger Depth");
check(abs(charger_offset) < 3, message="Bad Charger Depth");
check(base_type == 0 || base_type == 1, message = "Bad Base Type");
check(overprint >= 0, message = "Overprint cannot be negative");
check(overprint < 0.4, message = "No printer has an overprint that large!");

phone_sx = phone_width+play*2+overprint*2;
phone_sy = phone_height+play*2+overprint*2;
phone_sz = phone_thickness+play*1.4 +overprint*2;




// some convinience variables:
Ex = phone_sx/2;   // edge X

function dist(p1,p2) = 
    sqrt( (p1[0]-p2[0]) * (p1[0]-p2[0]) +
          (p1[1]-p2[1]) * (p1[1]-p2[1]) );
          
/* phone_sx, phone_sy, phone_sz: size of phone
    where Sy > Sx > Sz
*/          

module generate_backplane(
    depth=phone_sz/2, 
    height=Ex,
    radius=10 ) {
// Generate backplate:
    // for now, R2 must be R1...
    R1 = radius;
    R2 = R1;

    SIDEX=phone_sx/2;
        
    P1=[R1/2,R1+4];
    P2=[SIDEX,height-radius];

    // calculate points:
    distP1P2=dist(P2,P1);
    angleY=atan((P2[1]-P1[1])/(P2[0]-P1[0]));
    angleX=acos(R1/(dist(P2,P1)/2));
    angleT=angleX-angleY;
    echo("angles: Y=",angleY); //OK
    echo("angles: X=",angleX); //OK
    echo("angles: T=",angleT); //OK
    P1T = [P1[0]+R1*cos(angleT),P1[1]-R1*sin(angleT)];
    P2T = [P2[0]-R2*cos(angleT),P2[1]+R2*sin(angleT)];
    nP1T = [-P1T[0],P1T[1]];
    nP2T = [-P2T[0],P2T[1]];
    nP1 = [-P1[0],P1[1]];
    nP2 = [-P2[0],P2[1]];
    P1B = [P1[0],P1[1]-R1];
    nP1B = [-P1[0],P1[1]-R1];
    //Ex = P2[0];  // Edge X
    translate([0,0,-depth-wallThickness]) {
        linear_extrude (height=wallThickness) {
            difference() {
                union(){
                    polygon(points=[ P2T,P2,[SIDEX,0],
                                 [-SIDEX,0],nP2,nP2T,
                                 nP1T, nP1B, P1B, P1T ]);
                    translate( [P2[0],P2[1]] ) {
                        intersection() {
                            circle(R2,$fn=90);
                            translate( [-R1,0] ) {
                                square(R1);
                            };
                        }
                    };
                    translate( [-P2[0],P2[1]] ) {
                        intersection() {
                            circle(R2,$fn=90);
                            translate( [0,0] ) {
                                square(R1);
                            };
                        }
                    };
                };
                translate( [P1[0],P1[1]] ) {
                    circle(R1,$fn=90);
                }
                translate( [-P1[0],P1[1]] ) {
                    circle(R1,$fn=90);
                }
            }
        }
    }
}

module generate_sideplane(
    depth=phone_sz, 
    radius=phone_sz/2,
    height=Ex,
    side="left") 
{
    scale=side=="left"?-1:1;
    back=-depth/2-wallThickness;
    front=-back;
    bottom = -20;
    
    _depth = depth + wallThickness*2;
    
    translate ( [scale*(phone_sx+wallThickness)/2, 0] ) {
        rotate([0,-90,0]) {
            /*intersection()*/ {
                linear_extrude(height=wallThickness,center=true) {
                    union() {
                        polygon(
                            points=[[back,bottom],
                                    [back,height],
                                    [front-radius,height],
                                    [front-radius,height-radius],
                                    [front,height-radius],
                                    [front,bottom]]);
                        translate([front-radius,height-radius]) {
                            intersection() {
                                circle(radius,$fn=60);
                                square(radius);
                            };
                        };
                    };
                }; //linear_extrude 
                /* doesn't look good...
                translate([0,(height+bottom)/2,0])
                translate([-_depth/2,0,0]) union() {
                    translate([0,0,scale*wallThickness/2])
                    cube(size=[_depth*2,height-bottom,wallThickness], center=true);
                    rotate([90,0,0]) scale([1,.75*wallThickness/depth,1])
                        cylinder(height-bottom, _depth,_depth, center = true, $fn=30);
                    
                }  
                */
            }          
        }; //rotate
        
        /* do not round bottom corners
        r2=3;
        translate([-scale*r2,r2,0]) difference() 
        {
            translate([scale * r2/2,-r2/2,0])
                cube(size=[r2,r2,phone_sz], center=true);
            cylinder(phone_sz+1,r2,r2,center=true, $fn=60);
        };
        */
    }; //translate
}

module generate_frontplane(
    depth=phone_sz, 
    height=Ex,
    side="left") 
{
    left=-phone_sx/2;
    right=phone_sx/2;
    radius = height/5;
    
    bradius=radius*3;
    translate([0,0,depth/2+wallThickness/2])
    linear_extrude(height=wallThickness,center=true) {
        union() {
             difference() {
                union() {
                    translate([left,height-radius]) scale([1,1]) 
                        circle(radius,$fn=30);
                    polygon(
                        points=[[left,0],
                                [left,height-radius],
                                [left+radius,height-radius],
                                [left+radius,bradius],
                                [left+radius+bradius,bradius],
                                [left+radius+bradius,0]]
                        );
                    translate([right,height-radius]) scale([1,1]) 
                        circle(radius,$fn=30);
                    polygon(
                        points=[[right,0],
                                [right,height-radius],
                                [right-radius,height-radius],
                                [right-radius,bradius],
                                [right-radius-bradius,bradius],
                                [right-radius-bradius,0]]
                        );
                };
                translate([left+radius+bradius,bradius]) 
                    circle(bradius, $fn=60);
                translate([right-radius-bradius,bradius]) 
                    circle(bradius, $fn=60);
                polygon( points=[[left,0],
                         [left,height],
                         [left-radius,height],
                         [left-radius,0]]);
                polygon( points=[[right,0],
                         [right,height],
                         [right+radius,height],
                         [right+radius,0]]);
            }
               
            
        }
    }
}

module draw_micord() {
    // micord USB C 90 degree connector -- for reference purposes
    color("grey") translate([0,4,0]) cube([8.3,6.8,2.4],center=true);
    color("blue") translate([0,0,0]) cube([10.7,3.3,5.4],center=true);
    color("blue") translate([-2.3,-6.6,0]) cube([15.3,10,7],center=true);
    color("blue") translate([-14,-6.6,0]) rotate([0,90,0]) cylinder(8,3,3,center=true);
}

//use <path_extrude.scad>;

module generate_plugcutout (height=12) {

    // just to complicate things, the top of the cutout has to be rounded 
    // to allow for no-support printing...
    
    pt=0.2; // printer tolerance in mm
    top=-1.5;
    width=7;
    //widthend=6;  //width of cord protector...
    //lengthend=6; //length of cord protector
    width2=6;
    r2=width2/2;
    top2=top-r2;//this is the height of the cylinders
    echo(top=top,top2=top2);
    height2=height+top2;
    
    mid=top-height/2;
    mid2=top2-height2/2;
    
    bwallThickness=1.5;
    bwall=width/2;
    
    total_width=50;

    translate([-charger_offset,0,-phone_sz/2+charger_depth]) union() {
        // main cutout (micord usb c::
         translate([0,0,0]) cube([10.7+pt,4,5.4+pt],center=true);
         translate([0,mid,0]) cube([20,height,width+pt],center=true);
         //translate([0,mid,0]) cube([20+lengthend*2,height,widthend+pt],center=true);
        
             
        /* not working....
         myPoints = [   [0,top],
                        [width/2,top-width/2],
                        [width/2,-height*2],
                        [-width/2,-height*2],
                        [-width/2,top-width/2]
         ];
                        
         tw=total_width;
         myPath = [[0,0,0],[tw/2,0,0], [tw/2,10,0],[tw/2,30,0] ];
         path_extrude(exShape=myPoints, exPath=myPath);
         */
         
         //front
         translate([0,mid2,0]) cube([total_width ,height2,width2],center=true);
         translate([0,top2,0]) rotate([0,90,0]) 
                 cylinder(total_width,r2,r2,center=true, $fn=30);

         //left
         translate([-total_width/2,mid2,10]) 
            cube([width2,height2,20],center=true);
         translate([-total_width/2,top2,10]) rotate([0,0,0])
            cylinder(20,r2,r2,center=true, $fn=30);

         //right
         translate([total_width/2,mid2,10]) 
            cube([width2,height2,20],center=true);
         translate([total_width/2,top2,10]) rotate([0,0,0])
            cylinder(20,r2,r2,center=true, $fn=30);

         // round corners
         translate([-total_width/2,mid2,0]) rotate([90,0,0]) 
            cylinder(height2,r2,r2,center=true, $fn=30);
         translate([-total_width/2,top2,0]) 
            sphere(r2,center=true, $fn=30);
         translate([-total_width/2+r2,mid2,r2]) rotate([90,0,0]) 
            cylinder(height2,r2/2,r2/2,center=true, $fn=30);
        
         translate([total_width/2,mid2,0]) rotate([90,0,0])
            cylinder(height2,r2,r2,center=true, $fn=30);
         translate([total_width/2,top2,0]) 
            sphere(r2,center=true, $fn=30);
         translate([total_width/2-r2,mid2,r2]) rotate([90,0,0]) 
            cylinder(height2,r2/2,r2/2,center=true, $fn=30);
         
         //Slot
         translate([0,mid,7/2+bwallThickness+.5]) 
            cube([total_width/2,height,1],center=true);
         translate([0,top-1,7/2+2.2]) 
            cube([total_width/2,1,4],center=true);

         //screw hole:
         hradius=hole_diameter/2;  //hole radius..   
         //TBD: translate of 10 is just a guess here...
         translate([0,top-hradius-3,10]) rotate([0,0,90])
             cylinder(10,1.5,1.5,center=true, $fn=30);
     
     }

}

// this is the bottom of the husk -- not the base
module generate_bottom(
    depth=phone_sz, 
    height=12,
    side="left") 
{
    rotate([0,180,0]) {
        front = -phone_sz/2-wallThickness;
        back  = -front;
        left  = -phone_sx/2-wallThickness;
        right = -left;
        
        difference() {
            translate([0,-height/2,0]) {
                union() {
                    cube([right-left,height,back-front],center=true);
                    translate([0,height/10+2,back+1]) 
                       cylinder(2,6,4,center=true);
                    translate([-charger_offset,0,-phone_sz/2+charger_depth+height/2-3])
                        color("red") cube(size=[30,19,2],center=true);
                }
            }
            generate_plugcutout(height=height);
            if (front_text != "") {
                color("red") rotate([0,180,0]) translate([0,-5.5,-.3+phone_sz/2+wallThickness])
                    linear_extrude(height = .4)
                         text(front_text, 
                              font = "Liberation Sans:style=Bold Italic", 
                              size=5,
                              valign="center", halign="center");
            }
        }
        //draw_micord();
    }   
}

module _square(pt1=[0,0],pt2=[1,1]) {
    polygon(points=[ [pt1[0],pt1[1]],
                     [pt1[0],pt2[1]],
                     [pt2[0],pt2[1]],
                     [pt2[0],pt1[1]]]);
}

module generate_base() {
    width=17;
    bigd=phone_sx+wallThickness*2+20;
    bigr=bigd/2;
    height=3;
    
    trans_back=10;
    trans_front=2;
    scale_front=0.35;
    
    backCutoutAngle=30;
    
    circleMidy = height/2;
    ovalPts=[for(t=[0:9:359])
                [width/2*cos(t)+bigr-width/2,height*sin(t)]];
    
    if(base_type==1) {
        
        difference() {
            translate([0,circleMidy,0]) {
                
                // drawing back:
                // requires openscad 2016 or later...
                translate([0,0,-trans_back]) {
                    /*
                    rotate([90,90-backCutoutAngle,0])
                        rotate_extrude(angle=90-backCutoutAngle, convexity=2,$fn = 90)
                            polygon(points=ovalPts);
                    rotate([90,180,0])
                        rotate_extrude(angle=90-backCutoutAngle, convexity=2,$fn = 90)
                            polygon(points=ovalPts);
                    */
                    difference() {
                        rotate([90,90-backCutoutAngle,0])
                            rotate_extrude(convexity=2,$fn = 90)
                                polygon(points=ovalPts);
                        translate([0,0,bigr/2])
                            cube(size=[bigd,10,bigr], center=true);
                        color("red") rotate([90,0,0]) linear_extrude(10, center=true) 
                            polygon( [[0,0],
                                      [-sin(backCutoutAngle)*bigd,-cos(backCutoutAngle)*bigd],
                                      [sin(backCutoutAngle)*bigd,-cos(backCutoutAngle)*bigd]
                                        ]);
                    }
                    
                    rotate([90,90-backCutoutAngle,0]) 
                        translate([bigr-width/2,0,0]) 
                            scale([1,1,height*2/width])
                                sphere(width/2);
                    rotate([90,90+backCutoutAngle,0]) 
                        translate([bigr-width/2,0,0]) 
                            scale([1,1,height*2/width])
                                sphere(width/2);
                }
                //drawing front
                 
                translate([0,0,trans_front]) scale([1,1,scale_front]) rotate([90,0,0]) {
                    difference() {
                        rotate_extrude(convexity=2,$fn = 90)
                            polygon(points=ovalPts);
                     color("red") translate([0,-bigr/2,0])
                            cube(size=[bigd,bigr,bigr], center=true);
                   }
                    difference() {
                        cylinder(height*2,bigr-width/2,bigr-width/2,center=true);
                        cube(size=[phone_sx,phone_sz*1.5,height*2+1],center=true);
                        translate([0,-bigr/2,0]) 
                            cube(size=[bigd,bigr,height*2+1],center=true);
                    }
                }
                // drawing sides:
                translate([0,0,(trans_front-trans_back)]/2) {
                    linear_extrude(trans_back+trans_front, center=true) {
                        polygon(points=ovalPts);
                        rotate([0,180,0]) polygon(points=ovalPts);
                        
                    }
                    
                }
            };
            translate([0,-bigr/2,0])
                cube(size=[bigd,bigr,bigd*2], center=true);
            // adding holes for cushions:
            /* Holes don't work
            rotate([90,0,0]) { // [x,z,y]
                hole_radius=5.5;
                hole_depth=1.2;
                translate([0,12,0]) 
                    cylinder(hole_depth*2,hole_radius,hole_radius, center=true);
                translate([bigr-hole_radius-3,0,0]) 
                    cylinder(hole_depth*2,hole_radius,hole_radius, center=true);
                translate([-bigr+hole_radius+3,0,0]) 
                    cylinder(hole_depth*2,hole_radius,hole_radius, center=true);
                
                translate([0,-trans_back,0]) {
                    rotate([0,0,90-backCutoutAngle])
                        translate([-bigr+width/2,0,0]) 
                            cylinder(hole_depth*2,hole_radius,hole_radius, center=true);
                    rotate([0,0,-90+backCutoutAngle])
                        translate([bigr-width/2,0,0]) 
                            cylinder(hole_depth*2,hole_radius,hole_radius, center=true);
                }
               
            }
            */
        }
        
    }
    else {
        //base_type is 0
        translate([0,height/2,0]) rotate([90,0,0]) 
            linear_extrude(height=height,center=true) {
                // drawing back
                translate([0,-trans_back]) {
                    difference() {
                        circle(bigr,center=true, $fn=90);
                        circle(bigr-width,center=true, $fn=90);
                        _square([-bigr,0],[bigr,bigr]);
                        polygon(   [[0,0],
                                    [-sin(backCutoutAngle)*bigd,-cos(backCutoutAngle)*bigd],
                                    [sin(backCutoutAngle)*bigd,-cos(backCutoutAngle)*bigd]
                                    ]);
                        //rotate(backCutoutAngle) 
                        //    _square([0,0],[-width*2,-bigr]);
                        //rotate(-backCutoutAngle) 
                        //    _square([0,0],[width*2,-bigr]);
                    }
                    rotate(backCutoutAngle) 
                        translate([0,-bigr+width/2])
                            circle(width/2,center=true, $fn=30);
                    rotate(-backCutoutAngle) 
                        translate([0,-bigr+width/2])
                            circle(width/2,center=true, $fn=30);
                }
            //drawing front...
            translate([0,trans_front]) {
                difference() {
                    scale([1,.4]) circle(bigr,center=true, $fn=120);
                    scale([1,.1]) circle(bigr-width,center=true, $fn=30);
                    _square([-bigr,0],[bigr,-bigr]);
                }
            }
            //drawing sides:
            _square([bigr,trans_front],[bigr-width,-trans_back]);
            _square([-bigr,trans_front],[-bigr+width,-trans_back]);
        }
    }
}


module generate_main() {
    
    difference() {
        union() {
            generate_base();
            rotate([-10,0,0]) translate([0,13,0])
            {
                generate_backplane(height=Ex, radius=12);
                generate_sideplane(side="left",height=Ex, radius=12);
                generate_sideplane(side="right",height=Ex, radius=12);                
                difference() {
                    generate_frontplane(height=Ex-12, radius=6);
                     translate([0,Ex-12,phone_sz/2-wallThickness/3])
                        rotate([15,0,0])
                            cube(size=[phone_sx, 12*2, wallThickness*2], center=true);
                }
                generate_bottom(height=20);
                //generate_plugcutout(height=20);
            }
        };
        translate([0,-50,0]) cube([100,100,100], center=true);
        // need gap for holes
        /* holes don't work...
        translate([phone_sx/2+1,0,0]) cube(size=[6,3,25], center=true);
        translate([-phone_sx/2-1,0,0]) cube(size=[6,3,25], center=true);
        translate([0,0,18]) cube(size=[15,3,25], center=true);
        */
        // screw holes for bottom:
        
         translate([phone_sx/2-5,0,-4])
            rotate([90,0,0])
                cylinder(20,hole_diameter/2,hole_diameter, center=true);
         translate([-phone_sx/2+5,0,-4])
            rotate([90,0,0])
                cylinder(20,hole_diameter/2,hole_diameter, center=true);
         //translate([0,0,8]) rotate([90,0,0]) scale([.31,.31,.5])
         //   text("www.thingiverse.com/thing:3210055", valign="center", halign="center");

        
    }
    
}


//generate_plugcutout();
rotate([-90,180,180]) generate_main();



