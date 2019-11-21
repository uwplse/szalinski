//Customizable square by Trinner. Downloaded from Thingiverse.
//Version 0.9

// Open this file with OpenScad software (free and open-source)
// http://www.openscad.org/downloads.html
// Choose your parameters in the SETTINGS section
// Press F5 to compile and see the resulting hook
// Check your square in the preview window
// If OK, press F6 to render
// Go to : File => Export => Export as STL : choose filename and location
// Save the STL file of your customized square

//SETTINGS

//Dimensions
w = 20;
l = 50;
h = 25;

//Screw Diameter spacing
Dw=8; //Head Diameter w side. 0 to remove screws
dw=4; //Thread diameter w side. 0 to remove screws
Dh=6; //Head Diameter h side. 0 to remove screws
dh=3; //Head Diameter h side. 0 to remove screws

//Thickness from screw head to thing end
a=2;

//Color
color("YELLOW")

//Perfil
difference() {

$fn=20;

difference(){cube ([l,w,h]);
rotate ([atan(h/w),0,0])
cube ([l,sqrt((h*h)+(w*w)),h]);
};

//Screws xy (width)
translate ([l*(1/3),w*0.5, 0])
tornillo(Dw,dw);
translate ([l*(2/3),w*0.5, 0])
tornillo(Dw,dw);
//Screws xz (heigth)
rotate ([90,0,0])
translate ([l*(1/6),h*0.5, -w])
tornillo(Dh, dh);
rotate ([90,0,0])
translate ([l*(5/6),h*0.5, -w])
tornillo(Dh, dh);
}

module tornillo (D,d){
//Rosca
cylinder (h=h,r1=d/2, r2=d/2, $fn=30);
//Cabeza
translate ([0,0,a])
cylinder (h=h,r1=D/2, r2=D/2, $fn=30);
}

//Warning messages

if (a<0.4)
    echo (" WARNING : Thickness under the screw head seems too low. Your printer may not probably be able to print this ");