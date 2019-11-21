// Square tubing corner connector
// David O'Connor  david@lizardstation.com
// 14 August 2018

// Copyright Creative Commons Attribution Unported 3.0 (CC-BY-3.0)
//   (https://creativecommons.org/licenses/by/3.0/)

// Inside dimension
insideDim = 9.4; // [6:0.1:30]
// Outside dimension
outsideDim = 12.7;// [6:0.1:30]
// Protrusion length
protrusionLength = 15;// [6:0.2:60]
// Roundoff radius
roundoffRadius = 1;// [1.0:0.1:4.0]
// Connector type
fittingType = 0;// [0:Fit_Check, 1:Plug, 2:L, 3:Union, 4:T, 5:Corner, 6:Cross, 7:Mid_Edge, 8:Mid_Face, 9:Interior]

bracket(id=insideDim, od=outsideDim, l=protrusionLength, r=roundoffRadius, type=fittingType, fa=5, $fs=0.5);

module bracket(id=6, od=8, l=8, r=1, type=3) {
    m = l/2+od/2;
    textScaling = od*0.032;
    
    // This part provides five protrusions in increments of 0.1 mm to help you find the optimum size
    if (type == 0) {
        union() {
            dw = 0.1;
            cube([od, 5*od, od], center=true);
            for (i = [-2:2]) {
                translate([m, od*i, 0]) {
                    rotate([0, 90, 0]) {
                        protrusion(id-dw*i, l, r);
                    }
                    translate([-od*1.1, 0, od/2])
                        scale([textScaling, textScaling, 1.5*textScaling])
                        if (i == 0) 
                            numtex(id, 1, false);
                        else
                            numtex(dw*i, 1, true);
                }
            }           
        }
    }
    else {
    union() { 
        
        // The Center Cube
        cube([od, od, od], center=true);

        
        // All the parts have at lease one protrusion
        translate([0, 0, m])
            protrusion(id, l, r);

        // The rest depend on the type selected
        if ((type==3) || (type==4) || (type==6) || (type==7) || (type==8) || (type==9)) 
            translate([0, 0, -m])
                protrusion(id, l, r);
        
        if ((type==2) || (type==4) || (type==5) || (type==6) || (type==7) || (type==8) || (type==9)) 
            translate([m, 0, 0])
                rotate([0, 90, 0])
                    protrusion(id, l, r);
        
        if ((type==6) || (type==8) || (type==9))
            translate([-m, 0, 0])
                rotate([0, 90, 0])
                    protrusion(id, l, r);
            
        if ((type==5) || (type==7) || (type==8) || (type==9))
            translate([0, m, 0])
                rotate([90, 0, 0])
                    protrusion(id, l, r);
        
        if(type==9)
            translate([0, -m, 0])
                rotate([90, 0, 0])
                    protrusion(id, l, r);           
    }
}
}

// Create the protrusion, with rounded corners
// t = thickness, l = length, r = radius
module protrusion(t, l, r) {
    minkowski() {
    cube([t-2*r, t-2*r, l], center=true);  
        sphere(r=r);
    }
}  

// Convert a floating point number into a 2D text element
// x:   The floating point number
// dec: Number of digits past the decimal point to print
// plus:  true to show the + for positive numbers
module numtex(x = 3.14159, dec = 1, plus=false) {
    rounded = round(x * pow(10, dec)) * pow(10, -dec); 
    //print_string = str(rounded); 
    //linear_extrude(1)
    //text(print_string, font = "Liberation Sans:style=Bold Italic", halign="center", valign="center");
    linear_extrude(1)
        if ((x <=0) || (plus==false)) {
            text(str(rounded), font = "Liberation Sans:style=Bold Italic", halign="center", valign="center");
        } else {
            text(str("+", rounded), font = "Liberation Sans:style=Bold Italic", halign="center", valign="center");
        }
               

}


