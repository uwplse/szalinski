//Customizable Dog Name Tag by ficacador!

/* [Plate Dimensions] */

//Choose the lenght of the plate, in mm
lenght=60; // [40:10:80]

//Choose the height of the plate, in mm
height=30; // [20:5:40]

/* [Key Chain Ring size] */

//Choose the diameter of the key ring you want to use, in mm
ring_diameter=20; // [15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

//Choose the thickness of the key ring hole, in mm
ring_thickness=3; // [3,4]

/* [Name] */

//Type your dog's name
name="Buddy";

//Choose one of these cool fonts
name_font="Knewave"; // [Black Ops One,Chewy,Creepster,Emblema One,Faster One,Freckle Face,Knewave,Lobster,Pacifico,Permanent Marker,Plaster,Press Start 2P,Ranchers,Shojumaru,ZCOOL KuaiLe]

//Resize the name to best fit the plate
name_size=14; // [10:25]

/* [Text on the back] */

//Text on the first line, for ex. your phone number
line_1="123456789";

//Resize the first line to best fit the plate
line_1_size=7; // [5:10]

//Text on the second line, for ex. your town
line_2="San Junipero";

//Resize the first line to best fit the plate
line_2_size=5; // [5:10]

/* [Colors] */

//Choose a color for the plate
plate_color="Brown"; // [White,Yellow,Orange,Red,HotPink,Purple,Blue,Cyan,Lime,Green,Brown,Gold,Silver,Black]

//Chose a color for the name
name_color="Lime"; // [White,Yellow,Orange,Red,HotPink,Purple,Blue,Cyan,Lime,Green,Brown,Gold,Silver,Black]

/* [Hidden] */

thickness=ring_thickness+2;
name_height=1;
line_1_font="Comfortaa:style=Bold";
line_2_font="Comfortaa:style=Bold";
lines_depht=0.4;



/////////////////////////////////////////////////////////////////////////////


//Plate
color(plate_color){
    difference(){
        difference(){
            minkowski(){
                linear_extrude(thickness-2){
                    translate([-(lenght/2-height/2),0,0])
                        circle(d=height-4,$fn = 80);
                    translate([(lenght/2-height/2),0,0])
                        circle(d=height-4,$fn = 80);
                    square([(lenght-height),height-4],center=true);
                }
//Chamfer
                {
                cylinder(1,0,1,center=true,$fn = 20);
                translate([0,0,1])
                cylinder(1,1,0,center=true,$fn = 20);
                }
            }
        }
//Hole
        translate([0,height/2,thickness/2]){
            rotate_extrude()
                translate([ring_diameter/2,0,0])
                    circle(d=ring_thickness,$fn = 20);
        }
    
//Text
        linear_extrude(lines_depht){
            translate([0,height/5,0])
                rotate([180,0,180])
                    text(line_1,line_1_size,line_1_font,halign="center",valign="center");
            translate([0,-height/5,0])
                rotate([180,0,180])
                    text(line_2,line_2_size,line_2_font,halign="center",valign="center");
        }
    }
}
//Name
color(name_color){
    translate([0,0,thickness])
        linear_extrude(name_height)
            text(name,name_size,name_font,halign="center",valign="center");
}


