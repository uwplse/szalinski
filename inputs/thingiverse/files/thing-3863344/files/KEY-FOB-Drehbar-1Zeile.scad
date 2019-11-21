text1 = "Merry XMas"; //Textline 1 on front side
scale1 = 0.5; //Textsize for front side
name = "Happy New Year"; //Text for backside
scale2 = 0.4; //Textsize for backside
tolerance=1; //gap to be included between border and inlay - depends on material/temperature/...
length=80; //length of keyfob without keyring
width=30; //width of keyfob
thickness=4; //thickness of keyfob
border=4; //border width


module key_fob(length, width, thickness, border, tolerance, text1a, text1b, text2, scale1, scale2) {
    inlay(length-2*border-tolerance,width-2*border-2.2*tolerance,thickness,tolerance,text1a,text1b,text2,scale1,scale2);
    border(length,width,thickness,border,tolerance);
}

module rounded_cylinder(radius,height,rounding){
    $fn=30;
    cylinder(d=radius*2, h=height-2*rounding, center=true);
    cylinder(d=radius*2-2*rounding, h=height, center=true);
    translate([0,0,height/2-rounding]) rotate_extrude(convexity = 30) translate([radius-rounding,0,height]) circle(r=rounding, $fn=10);
    translate([0,0,-(height/2-rounding)]) rotate_extrude(convexity = 30) translate([radius-rounding,0,height]) circle(r=rounding, $fn=10);
}

module border(length, width, thickness, border, tolerance) {
     
    difference(){
        //outer plate
         union(){
            cube([length-width,width, thickness-2], center=true);
            cube([length-width,width-2, thickness], center=true);
            translate([0,width/2-1,(thickness)/2-1]) rotate(90,[0,1,0]) cylinder(length-width,1,center=true, $fn=10);
            translate([0,-(width/2-1),(thickness)/2-1]) rotate(90,[0,1,0]) cylinder(length-width,1,center=true, $fn=10);
            translate([0,width/2-1,-((thickness)/2-1)]) rotate(90,[0,1,0]) cylinder(length-width,1,center=true, $fn=10);
            translate([0,-(width/2-1),-((thickness)/2-1)]) rotate(90,[0,1,0]) cylinder(length-width,1,center=true, $fn=10);
            translate([(length-width)/2,0,0]){
                rounded_cylinder(width/2,thickness,1);
            }
            translate([-(length-width)/2,0,0]){
                rounded_cylinder(width/2,thickness,1);
            }
            //thorus
            $fn=30;
            translate([length/2+thickness/2,0,0]) rotate_extrude(convexity = 30) translate([thickness, 0, 0]) circle(r = thickness/2);
        }
        //cut out
        union(){
            cube([(length-width), width-2*border, thickness], center=true);
            translate([(length-width)/2,0,0]){
                cylinder(d=width-2*border, h=thickness, center=true);
            }
            translate([-((length-width)/2),0,0]){
                cylinder(d=width-2*border, h=thickness, center=true);
            }
            //lager
            $fn=50;
            translate([length/2-border-tolerance,0,0]) rotate(90,[0,1,0]) cylinder(d1=thickness,h=thickness,d2=0);
            translate([-(length/2-border-tolerance),0,0]) rotate(-90,[0,1,0]) cylinder(d1=thickness,h=thickness,d2=0);
        }
    }
}


module inlay(length, width, thickness, tolerance, text1a, text1b, text2, scale1, scale2){
    difference(){
        union(){
            //solid
            ///cube
            cube([length-width,width,thickness], center=true);
            ///cylinders
            translate([(length-width)/2,0,0]) cylinder(d=width, h=thickness, center=true);
            translate([-(length-width)/2,0,0]) cylinder(d=width, h=thickness, center=true);
            ///axes
            $fn=20;
            translate([(length)/2-1,0,0]) rotate(90, [0,1,0]) cylinder(d1=thickness, d2=0, h=thickness);
            translate([-(length)/2+1,0,0]) rotate(-90, [0,1,0]) cylinder(d1=thickness, d2=0, h=thickness);
        }
        //Text 1
        translate([0,0,0.5]) linear_extrude(thickness/2-0.5) rotate(180, [0,0,1]) text(text=text1a, size=width*0.7*scale1, font="Montserrat:style=ExtraBold", halign="center", valign="center");
        //Name
        translate([0,0,-thickness/2]) linear_extrude(thickness/2-0.5) rotate(180, [0,1,0]) text(text=text2, size=width*0.7*scale2, font="Montserrat:style=ExtraBold", halign="center", valign="center");
    }
}

key_fob(length,width,thickness,border,tolerance,text1,text2,name, scale1, scale2);

//rounded_cylinder(10,5,1);

