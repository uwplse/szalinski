// Bait Station Model
// David O'Connor    28 July 2018    david@lizardstation.com
// Creative Commons CC BY 3.0 License applies (https://creativecommons.org/licenses/by/3.0/)

// 12 August 2018 Fixed to work with Thingiverse Customizer

// Overall Diameter
OverallDiameter = 67;

// Diameter of outside upper rim
OutsideUpperRimDia = 30.6;

// Overall height
OverallHeight = 24;

// Thickness of the outer rim
OuterRimThickness = 3;

bait_station(D=OverallDiameter, Do=OutsideUpperRimDia, h=OverallHeight, h1=OuterRimThickness, $fa=3, $fs=0.5);

module bait_station(D=80, Do=40, h=20, h1=4, print_vol=true) {
    Dh = Do - 2 * h1;
    zscale = (h-h1)/((D-Do)/2);
    
    difference() {
        difference() {
            difference() {
                translate([0, 0, -h/2]) {
                    cylinder(h=h, r=D/2, center=true);
                }
                scale([1, 1, zscale]) {
                    torus(r=(D-Do)/2, R=D/2);
                }
            }
            cylinder(r=Dh/2, 2*(h-h1), center=true);
        }
    
        volume_ml = 3.1416 * pow(Dh/2, 2) * (h-h1) * 0.001;
        echo (str("Volume = ", volume_ml, " ml"));
        if (print_vol == true) {
        translate([0, 0, -h-h1*.75]) {
            linear_extrude(h1) {
                rotate([180, 0, 0]) {    
                    scale(D*0.022) 
                        numtex(volume_ml);
                    }
                }
            }    
        }
    }
}

// Generate a torus
// r = minor radius; R = major radius
module torus(r=1, R=3) {
	rotate_extrude() {
		translate([R, 0, 0]) {
			circle(r);
		}
	}
}

// Convert a floating point number into a 2D text element
// x:   The floating point number
// dec: Number of digits past the decimal point to print
module numtex(x = 3.14159, dec = 1) {
    rounded = round(x * pow(10, dec)) * pow(10, -dec); 
    print_string = str(rounded, " ml");
    text(print_string, font = "Liberation Sans:style=Bold Italic", halign="center", valign="center");
}

