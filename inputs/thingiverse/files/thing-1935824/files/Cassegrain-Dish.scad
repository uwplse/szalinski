//Cassegrain Dish
//Ari M Diacou
//December 2016

/***************Source***************\
Peter Hannan, "Microwave antennas derived from the cassegrain telescope," in IRE Transactions on Antennas and Propagation, vol. 9, no. 2, pp. 140-153, March 1961.

URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=1144976&isnumber=25737 

http://ieeexplore.ieee.org/document/1144976/
https://sci-hub.cc/10.1109/TAP.1961.1144976
DOI: 10.1109/TAP.1961.1144976 
\************************************/
/*///////////////////////// Instructions //////////////////////////////
This thing creates a customizable Cassegrain Reflector dish. It was created using the equations from the paper by Peter Hannan, "Microwave antennas derived from the cassegrain telescope," in IRE Transactions on Antennas and Propagation, vol. 9, no. 2, pp. 140-153, March 1961.

If you are using customizer, playing with values, use the "mockup" mode. If you want to print it straight (which you should only use if you are using a resin printer or Shapeways or another fused dust printer), then use "solid". "For printing" should be used on a FFF printer (most of you). If using an FFF printer, the pieces are arranged so that they can be printed best on a flat bed. Feel free to rearrange the pieces on your slicer. The STLs provided will work if scaled all by the same amount, but the physics will not work out if you have different scaling for x,y,z.

If printing on an FFF printer, use supports for the dish. Infill doesnt matter as long as there are no holes in your pieces. Once all the pieces are printed, the waveguide gets glueed (I recommend a clear superglue, like cyanoacrylate) to the back of the main reflector. The struts get glued to the main reflector and the secondary reflector. The bulge on the scondary reflector is supposed to point towards the concave part of the main reflector. The spike looking thing is a ruler. You stick the thin end in the hole of the main reflector, and the secondary reflector sits on top of the ruler, so that you know how far apart they are supposed to be. The thin part of the ruler measuers the distance between the reflecting face of the main reflector, and where the focus/sensor/microphone/speaker/lightbulb is supposed to be. Check "mockup" mode if you are unsure how the pieces are supposed to be arranged. The ruler is not to be glued to any pieces. Remove the ruler (I guess by cutting it in half) once you have assembled the struts and secondary reflector.

Theory
Cassegrain reflectors are used in radio telescopes, and are based off of the optical Cassegrain Telescopes. While Cassegrain reflectors will work theoretically with any wave, the physics assumptions that they are designed with assume that the distance between the main and secondary reflectors is more than 3 wavelengths. This can present problems if you are using this for Radio or Sound waves. But, if you know enough physics to want to use a cassegrain reflector as a tool, you can figure out how to calculate the wavelength of the signal you are using (Hint: λ=v/f).

Suggestions for use as a tool:
    ►Stick the waveguide in you ear, see what you can hear.
    ►Glue aluminum foil to the main and secondary reflectors, and use it as a flashlight by putting an LED in the waveguide.
    ►Glue aluminum foil to the main and secondary reflectors, stick a coil of wire in the waveguide, and use it as a radio receiver.
    ►Glue aluminum foil to the main and secondary reflectors, stick an IR photodiode in the waveguide, and use it in photo-communications projects. Bonus points if you mod one of your home entertainment systems to use this!    */

//////////////////////////// Parameters ///////////////////////////////
//is the focal lenth of the main reflector.
focal_main=20;
//is the diameter of the main refector.
diameter_main=30;
//is the distance below the bottom of the reflector that you want the electronics to be (the collector point, or the real focus of the whole system).
x_e=2;
//is the diameter of the secondary reflector.
diameter_secondary=5;
//How do you want your parts arranged?
display_type=2;//[1:Mockup,2:Solid,3:For Printing]
//that support the secondary reflector from the main reflector
number_of_struts=3;//[0,1,2,3,4]
//is the number of segments make up a circle. Higher is smoother, but with larger file size, and longer rendering time. Customizer will fail silently if there are too many facets.
$fn=20;
/*[Hidden]*/
//////////////////////// Derived Parameters ///////////////////////////
//Suggested filename
echo(str("Suggested filename: Cassegrain Dish ",type_string,"-Fm=",focal_main,"Dm=",diameter_main,"Xe=",x_e,"Ds=",diameter_secondary,"Ns=",number_of_struts));
type_string=(display_type==1)?"mockup":((display_type==2)?"solid":"printable");
//epsilon, a small value used to ensure mainfold-ness
ep=0+0.05;
//The thickness of the main reflector, and the added thickness of the secondary reflector
thickness=0.05*diameter_main;
//The angle that the edges of the mirrors make with the virtual focus (
focal_collector=focal_main+x_e+thickness;
phi_v=2*atan(diameter_main/focal_main/4); //Hannan, Eq. 1
//The angle between the boresight axis (z), the real focal point (C, which is x_e behind the main reflector), and the edge of the secondary reflector
phi_r=atan(1/(2*(focal_collector)/diameter_secondary-1/tan(phi_v))); //Hannan, Eq. 2
//The eccentricty of a hyperbola (http://mathworld.wolfram.com/Hyperbola.html, Eq. 9)
e=sin((phi_v+phi_r)/2)/sin((phi_v-phi_r)/2); //Hannan, Eq. 5.e
//In the canonical form of a hyperbola (x/a)^2-(y/b)^2=1, these are the cononical denominators (http://mathworld.wolfram.com/Hyperbola.html, Eq. 7)
a=(focal_collector)/e/2; //Hannan, Eq. 5.a
b=a*sqrt(e*e-1); //Hannan, Eq. 5.b
l_v=(focal_collector)*(1-1/e)/2; //Hannan, Eq. 3
//The highest point on the edge of the secondary dish
x_s_max=x_secondary(diameter_secondary/2);
//The highest point on the edge of the main dish
x_m_max=x_main(diameter_main/2);
//The number of radial steps that make the curve of the main dish,smaller steps means more facets
step_main=focal_main*tan(360/$fn/3);
//The number of radial steps that make the curve of the main dish,smaller steps means more facets
step_secondary=l_v*tan(360/$fn/2);
//echo(str("$fn=",$fn,", phi_v=",phi_v," step_main=",step_main));
//echo(str("$fn=",$fn,", phi_v=",phi_v," step_secondary=",step_secondary));
//The diameter of the hole in the main reflector
hole_diameter=1+1.03*(focal_collector-focal_main)*diameter_secondary/(focal_collector-l_v)/2;
ms_dimensions=[hole_diameter*1.25,min(2,thickness),focal_main-l_v-x_main(hole_diameter*1.25/2)];
mc_dimensions=[hole_diameter/2,min(2,thickness,hole_diameter/2),thickness+x_e+ep];
strut_thickness=thickness;
////////////////////////////// Main() /////////////////////////////////
if(display_type==1){
    color("slategrey") translate([0,0,-focal_main-thickness-ep]) main_mirror();
    color("slategrey") translate([0,0,-l_v+ep]) secondary_mirror();
    #translate([0,0,-l_v]) 
        ruler();
    color("grey") translate([0,0,-focal_main-x_e-thickness-2*ep]) waveguide();
    for(j=[0:number_of_struts-1])
        rotate([90,0,j*360/number_of_struts])
            strut();
    }
else if(display_type==2){
    color("slategrey") 
        translate([0,0,-focal_main-thickness+1*ep])
            main_mirror();
    color("slategrey") 
        translate([0,0,-l_v-1*ep]) 
            secondary_mirror();
    color("grey") 
        translate([0,0,-focal_main-x_e-thickness+2*ep]) 
            waveguide();
    for(j=[0:number_of_struts-1])
        rotate([90,0,j*360/number_of_struts])
            translate([-ep-0.02*diameter_secondary,0,0])
                strut();
    }    
else{
    color("slategrey") 
        translate([0,0,0])
            main_mirror();
    color("slategrey") 
        translate([0,.5*diameter_main+2*strut_thickness+diameter_secondary,thickness]) 
            mirror([0,0,1]) secondary_mirror();
    color("grey") 
        translate(diameter_main*[-.4,.6,0]) 
            waveguide();
    for(j=[0:number_of_struts-1])
        translate([.6*diameter_main+strut_thickness,(2*j+0)*strut_thickness+.7*(focal_main+l_v),0])
            rotate([0,0,-phi_v])
                translate([(3*j+1)*strut_thickness,0,0])
                    strut();
    translate([-.8*diameter_main,-.5*focal_main,0])
        rotate([90,0,0]) 
            ruler();
    }
//////////////////////////// Functions ////////////////////////////////
module strut(){
    A=[diameter_secondary/2,-l_v+x_s_max];
    B=A+[strut_thickness,0];
    C=B+[0,thickness];
    H=[.49*diameter_main,-focal_main+x_m_max];
    D=H+[2*strut_thickness,0];
    E=D+[0,-thickness];
    F=E+[-strut_thickness,0];
    G=(H+D)/2;
    
    strut_points=[A,B,C,D,E,F,G,H]; 
    //echo(struct_points);
    //*for(i=[0:len(struct_points)-1])
    //    translate(struct_points[i])
    //        #text(chr(65+i),size=.6*strut_thickness);
    translate([0,0,-strut_thickness/2])
        linear_extrude(strut_thickness)
            polygon(strut_points);
    }
    
module waveguide(){
    if(x_e>thickness){
        linear_extrude(x_e-0*thickness){
            difference(){
                circle(d=hole_diameter+thickness);
                circle(d=hole_diameter);
                }
            }
        }
    }
module ruler(){
    translate([0,0,-ms_dimensions[2]/2-0*l_v])
        cube(ms_dimensions,center=true);
    translate([0,0,-ms_dimensions[2]-mc_dimensions[2]/2+ep]) 
        cube(mc_dimensions,center=true);
    }
module main_mirror(){
    main_points=concat(
        [for(i=[0:step_main:diameter_main/2])
            [x_main(i),i]
            ]
        ,[[x_m_max,diameter_main/2]]
        ,[for(i=[diameter_main/2:-step_main:0])
            [x_main(i)+thickness,i]
            ]
        ,[[thickness,0]]
        );
    //echo(main_points);
    difference(){
        rotate_extrude()
            rotate(90) 
                polygon(main_points);   
        cylinder(h=thickness*1.1, d=hole_diameter);
        }
    for(i=[0:number_of_struts-1])
        rotate([0,0,i*360/number_of_struts])
            translate([0.49*diameter_main+strut_thickness/2,0,x_m_max+thickness/2])
                cube([strut_thickness,strut_thickness,thickness],center=true);
    }
module secondary_mirror(){
    secondary_points=concat(
        [for(i=[0:step_secondary:diameter_secondary/2])
            [x_secondary(i),i]
            ]
        ,[[x_s_max,diameter_secondary/2],[x_s_max+thickness,diameter_secondary/2],[x_s_max+thickness,0]]
        );
    
    rotate_extrude()
        rotate(90) 
            polygon(secondary_points);
    for(i=[0:number_of_struts-1])
        rotate([0,0,i*360/number_of_struts])
            translate([0.45*diameter_secondary+strut_thickness/2,0,x_s_max+thickness/2])
                cube([0.05*diameter_secondary+strut_thickness,strut_thickness,thickness],center=true);
    }
//height (x) as a function of the radial distance from the center of the main reflector (a parabola). Eq. 4
function x_main(y_main)=y_main*y_main/focal_main/4;
//height (x) as a function of the radial distance from the center of the secondary reflector (a hyperbola). Eq. 5
function x_secondary(y_secondary)=a*(-1+sqrt(1+pow(y_secondary/b,2)));