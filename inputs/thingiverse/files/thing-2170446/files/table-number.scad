
// Number to preview
part=34; // [1:"1",2:"2",3:"3",4:"4",5:"5",6:"6",7:"7",8:"8",9:"9",10:"10",11:"11",12:"12",13:"13",14:"14",15:"15",16:"16",17:"17",18:"18",19:"19",20:"20",21:"21",22:"22",23:"23",24:"24",25:"25",26:"26",27:"27",28:"28",29:"29",30:"30",31:"31",32:"32",33:"33",34:"34",35:"35",36:"36",37:"37",38:"38",39:"39",40:"40",41:"41",42:"42",43:"43",44:"44",45:"45",46:"46",47:"47",48:"48",49:"49",50:"50"]

/* [Body] */

// Height of the body section (mm)
body_height=50;
// Angle of the body section (degrees)
body_angle=50;
// Thickness of the body section (mm)
body_thickness=13;

/* [Font] */

// The font to write the name in.
font = 2; // [0:Google (give name below), 1:Helvetica, 2:Times, 3:Arial, 4:Courier]

// the name of the font to get from https://www.google.com/fonts/
google_font = "Arial Unicode MS";

// The Font Style. Not all styles work with all fonts.
style = 2; // [0:None, 1:Regular, 2:Bold, 3:Italic, 4:Bold Italic]

/* [Middle] */

// Opening in the front or the back
front_opening=1; // [1:"Front", 0:"Back"]

// Thickness of the ring (mm)
middle_height=5;
// Outer diameter of the top ring (mm)
middle_radius=35;
// Thickness of the bottom rod (mm)
middle_rod_thickness=7.5;

/* [Hidden] */
$fn=50;

font_list = [undef,
             "Helvetica",
             "Times",
             "Arial Unicode MS",
             "Courier",
             "Symbola",
             "Apple Color Emoji",
             "serif",
             "Code2001"];
             
style_list = [undef, 
              "Regular", 
              "Bold", 
              "Italic", 
              "Bold Italic"];

fn = (font == 0) ? google_font : font_list[font];
sn = (style_list[style] != undef) ? str(":style=",style_list[style]) : "";
f = str(fn,sn);

print_part();

module body(h=5, a=45, t=2) {
    union() {
        for(n = [-a/2:0.5:a/2]) {
            rotate(a=n,v=[0,0,1])
                hull() {
                    translate([0, h, 0])
                        cylinder(r=(h*0.05), h=t);
                    translate([0, 2*h, 0])
                        cylinder(r=(h*0.05), h=t);
                }
        }
    }
}

module middle(h, r, t) {
    union() {
        translate([0,0, -1])
            cylinder(r = r/2, h = body_thickness / 2);
        hull()
            rotate_extrude(convexity = 10, $fn = 100)
                translate([r * 0.6, body_thickness/2, 0])
                    circle(r = h/2, $fn = 100);
        
        rotate(a=90 ,v=[1,0,0])
            hull() {
                translate([0, body_thickness/2, 0])
                    cylinder(r=t/2, h=body_height);
                translate([0, body_thickness/-2, 0])
                    cylinder(r=t/2, h=body_height);
            }
    }
}

module print_part() {
    difference() {
        union() {
            translate([0, body_height * 1.9, 0])
                linear_extrude(body_thickness + 3)
                    text(str(part), size=50, font=f, halign="center", valign="bottom");
            body(body_height, body_angle, body_thickness);
        }
        translate([0, body_height + 24, 0])
        if (front_opening==1) {
            rotate(a=180, v=[0,1,0])
            translate([0,0,-body_thickness])
            middle(middle_height, middle_radius, middle_rod_thickness);
        } else {
            middle(middle_height, middle_radius, middle_rod_thickness);
        }
    }
}
