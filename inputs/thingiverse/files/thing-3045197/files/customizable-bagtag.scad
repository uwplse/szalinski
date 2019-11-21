// customizable bagtag - scruss, 2018-08

//CUSTOMIZER VARIABLES
// Uppercase is best
Your_Tag_Text="SCR";
//CUSTOMIZER VARIABLES END

module bbox_2d() {
    /*
    simple unified bounding box for 2D paths, inspired by  https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Commented_Example_Projects#Bounding_Box 
    */
    intersection() {
        projection(cut=false)rotate([90,0,0])linear_extrude(center=true, height=1000, convexity=10)hull()children(0);
        projection(cut=false)rotate([0,90,0])linear_extrude(center=true, height=1000, convexity=10)hull()children(0);
    }
}

$fn=16;

module txt() {
    text(Your_Tag_Text, font="Roboto:style=Black", spacing=1.05, size=12, $fn=32);
}

module outl() {
    hull() {
        offset(r=4)bbox_2d()txt();
        translate([-6,6])circle(d=8, center=true);
    }
}
    

difference() {
    union() {
        linear_extrude(height=3)txt();
        linear_extrude(height=2)outl();
        linear_extrude(height=3) {
            difference() {
                outl();
                offset(r=-2)outl();
            }
            translate([-6,6])circle(d=8, center=true);
        }
    }
    linear_extrude(height=8, center=true)translate([-6,6])circle(d=4, center=true);
}