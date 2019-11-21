//Customizable Obelisk
//Created by Ari M. Diacou, June 2016
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

//////////////////////////// Parameters ////////////////////////////
//of your Obelisk
height=100;

//How many "tips" high is the base of the Obelisk
base_units=7;
my_string="ԴռԽենոծիդե";
my_font="DejaVu Sans";
style=3;//[1:Cartoosh with Raised Inscription,2:Carved Inscription,3:Carved Inscription with Cartoosh]

                           /* [Hidden] */
//////////////////////// Derived Parameters ////////////////////////
h=height;
//A way to adjust the distance between the cartoosh and the sides of the obelisk
tolerance=0.4+0;
//Shorthand for the square root of 2
s2=sqrt(2)+0;
//Epsilon, a small number (used for avoiding coplanar errors and artifacts)
ep=0.05+0;
//The height of the base of the obelisk
base_height=h*(base_units/(base_units+1));
//The height of the tip of the obelisk
tip_height=h/(base_units+1);
//The width of the base of the obelisk
base1=tip_height*1.5*s2;
//The width of the tip of the obelisk
base2=tip_height*0.9*s2;
//The radius of the bottom arc of the cartoosh
r1=tolerance*base1/s2;
//The radius of the top arc of the cartoosh
r2=tolerance*base2/s2;
//The distance between the centers of the two arcs of the cartoosh is 2*z
z=base_height/2-(r1+r2)*(1-tolerance);
//The size of the font is chosen so that it will fit in the cartoosh
my_size=min(1.5*z/len(my_string), 2*r1,2*r2);
//The angle that the sides of the obelisk make from vertical
adjustment_angle=atan((base1-base2)/(2*base_units*tip_height*s2));



echo(str("my size =", my_size));
echo(str("Suggested Filename: Obelisk-",my_string,"-",my_font,"-bu",base_units,"s",style));

////////////////////////////// Main() //////////////////////////////
if (style==1){
    difference(){
        stone();
        cartoosh();
        }
    inscription();
    }
else if (style==2){
    difference(){
        stone();
        inscription();
        }    
    }
else{
    difference(){
        stone();
        inscription();
        cartoosh2();
        }    
    }
//////////////////////////// Functions ////////////////////////////    
module stone(){
    //Creates the obelisk blank by creating a 4-sided cone (cylinder). The use of s2 throughout the program is because OpenSCAD makes the vertices, not the sides radius r away from the center.
    rotate([0,0,45]){
        cylinder(d1=base1, d2=base2, h=base_height, $fn=4);
        translate([0,0,base_height]) cylinder(d1=base2, d2=0, h=tip_height, $fn=4);
        }
    }

module cartoosh(d=.1*tip_height){
    //The cartoosh is created by wrapping a hull around two circles. That object is then extruded to height d, rotated to lie flush with the sides of the obelisk, moved up to the sides of the obelisk, and then repeated on all 4 faces.
    //d is the depth of the relief
    for(i=[0:3])
        rotate([0,0,i*90])
            translate([0,-.5*base2+d*s2,z+2*r1*(1-tolerance)])
                rotate([90-adjustment_angle,0,0]){
                    color("red")
                        linear_extrude(height=d)
                            hull(){
                                translate([0,-z]) circle(r=r1);
                                translate([0,+z]) circle(r=r2);
                                }
                          
                    }
                            
    }

module cartoosh2(d=.1*tip_height,t=0.9){
    //The cartoosh is created by wrapping a hull around two circles - then taking the difference with a slightly smaller one. That object is then extruded to height d, rotated to lie flush with the sides of the obelisk, moved up to the sides of the obelisk, and then repeated on all 4 faces.
    //d is the depth of the relief
    //t is the thickness ratio of the cartoosh
    for(i=[0:3])
        rotate([0,0,i*90])
            translate([0,-.5*base2+d*s2,z+2*r1*(1-tolerance)])
                rotate([90-adjustment_angle,0,0]){
                    color("red")
                        linear_extrude(height=d)
                            difference(){
                            hull(){
                                translate([0,-z]) circle(r=r1);
                                translate([0,+z]) circle(r=r2);
                                }
                            hull(){
                                translate([0,-z]) circle(r=t*r1);
                                translate([0,+z]) circle(r=t*r2);
                                }
                            }
                          
                    }
                            
    }

module inscription(d=.1*tip_height){ 
    //The inscription simply a string of text that is written TopToBottom ("ttb"). That object is then extruded to height d, rotated to lie flush with the sides of the obelisk, moved up to the sides of the obelisk, and then repeated on all 4 faces.
    //d is the depth of the relief
    for(i=[0:3])
        rotate([0,0,i*90])
            translate([0,-.5*base2+d*s2,z+2*r1*(1-tolerance)])
                rotate([90-adjustment_angle,0,0]){
                    color("blue") 
                        linear_extrude(height=d+ep) 
                            text(my_string,size=my_size,font=my_font, direction="ttb",valign="center");
                          
                    }
                            
    }