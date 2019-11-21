//Flow Pen-The customizable Bic case

use <write/Write.scad>

/* [Parameters] */
//The model of pen you want to print. Choose the name among all of the options.
Type_of_pen="Twisted hexagon"; //[Classic, Cylinder, Twisted hexagon]

//e.g. Peter
Write_here_your_name="FLOW";

//Font of your text. Choose the name among all of the options.
Font="orbitron.dxf"; //[Letters.dxf, orbitron.dxf, BlackRose.dxf, knewave.dxf, braille.dxf]

//Name size
Name_size=5; //[2:0.5:7]

//Thickness of the word´s letters
Font_thickness=1.9; //[1:0.1:3]

//The distance between the first letter and the floor. Recommended value for left handed: 10. Recomended value for right handed: it depends of how many letters has your name.
Distance_to_bottom=10;

//The space in mm between the left side of each letter
Spacing=1.2; //[0.9:0.1:1.5]

//Now, you can modify your Flow depending on if you´re right or left handed. This feature flips 180º the name so that you can read it while you are writing. PD: if you choose the right handed option, you´ll have to increase the value of the "Distance to bottom" tool.
Left_or_right_handed="Left handed"; //[Left handed, Right handed]

//Logo
translate ([0,3.6,20])
rotate([90,0,0])
resize ([5,5,1])
union() {
    translate ([0,-15,0])
    rotate ([0,0,-30])
    difference () {
        cylinder (h=1, r=30, $fn=3, center=true);
        cylinder (h=2, r=15, $fn=3, center=true);
    }

    translate ([0,15,0])
    rotate ([0,0,30])
    difference () {
        cylinder (h=1, r=30, $fn=3,     center=true);
        cylinder (h=2, r=15, $fn=3,     center=true);
    }
}

//Classic model
if (Type_of_pen=="Classic") {
difference() {
union() {
    difference() {
        cylinder (r=4, h=124, $fn=6);
        translate ([0,0,2])
        cylinder (r=2.2, h=125, $fn=50);
        }
    
    translate ([0,0,124])
    difference() {
        cylinder (r1=4, r2=3.2, h=9, $fn=6);
        translate ([0,0,-0.5])
        cylinder (r=2.2, h=140,$fn=50);
        }
    }
    //Little hole
    translate ([0,4,60])
    rotate ([90,0,0])
    cylinder (r=0.5, h=3, $fn=20);
}
if (Left_or_right_handed=="Left handed") {
    translate ([Name_size/2,-3.4,Distance_to_bottom])
    rotate([90,-90,0])
    write(Write_here_your_name, t=Font_thickness, h=Name_size, font=Font, space=Spacing);
}
else {
    translate ([-Name_size/2,-3.4,Distance_to_bottom])
    rotate([90,90,0])
    write(Write_here_your_name, t=Font_thickness, h=Name_size, font=Font, space=Spacing);
}
}
    
//Cylinder model
if (Type_of_pen=="Cylinder") {
difference() {
union() {
    difference() {
        cylinder (r=4, h=124, $fn=100);
        translate ([0,0,2])
        cylinder (r=2.2, h=125, $fn=50);
        }
    
    translate ([0,0,124])
    difference() {
        cylinder (r1=4, r2=3.2, h=9, $fn=100);
        translate ([0,0,-0.5])
        cylinder (r=2.2, h=140,$fn=50);
        }
    }
    //Little hole
    translate ([0,4,60])
    rotate ([90,0,0])
    cylinder (r=0.5, h=3, $fn=20);
}
if (Left_or_right_handed=="Left handed") {
    translate ([Name_size/2,-3.4,Distance_to_bottom])
    rotate([90,-90,0])
    write(Write_here_your_name, t=Font_thickness, h=Name_size, font=Font, space=Spacing);
}
else {
    translate ([-Name_size/2,-3.4,Distance_to_bottom])
    rotate([90,90,0])
    write(Write_here_your_name, t=Font_thickness, h=Name_size, font=Font, space=Spacing);
}
}
    
//Twisted hexagon model
if (Type_of_pen=="Twisted hexagon") {
difference() {
union() {
    difference() {
        linear_extrude (height=124, twist=248, slices=300)
        circle (r=4, $fn=6);
        translate ([0,0,2])
        cylinder (r=2.2, h=125, $fn=50);
        }
    
    translate ([0,0,124])
    difference() {
        linear_extrude(height=9, twist=18, slices=100, scale=0.8)
        rotate ([0,0,-8])
        circle(r=4,$fn=6,scale=0.8);
        translate ([0,0,-0.5])
        cylinder (r=2.2, h=140,$fn=50);
        }
    }
    //Little hole
    translate ([0,4,60])
    rotate ([90,0,0])
    cylinder (r=0.5, h=3, $fn=20);
}

if (Left_or_right_handed=="Left handed") {
    translate ([Name_size/2,-3.4,Distance_to_bottom])
    rotate([90,-90,0])
    write(Write_here_your_name, t=Font_thickness, h=Name_size, font=Font, space=Spacing);
}
else {
    translate ([-Name_size/2,-3.4,Distance_to_bottom])
    rotate([90,90,0])
    write(Write_here_your_name, t=Font_thickness, h=Name_size, font=Font, space=Spacing);
}
}