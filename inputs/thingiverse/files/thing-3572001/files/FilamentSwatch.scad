/* [Text] */
//Filament material
text_1 = "PETG";

//Filament brand
text_2 = "Devil Design";

//Filament color
text_3 = "Pacific blue";

//Hole diameter 
hole_diameter = 0;//[0,1,2,3,4]

/* [Hidden] */
Wight = 101.6;
Hight = 57.15;
Frame = 3.175;
DepthLow = 0.45;
DepthHi = 1.5;

thickX = 85.725;
thickY = 34.925;
thickWight = 12.7;
thickHight = 19.05;

TextX = 4.0;
TextSize = 8;
TextY1 = 24.0 + TextSize/2;
TextY2 = 14.0 + TextSize/2;
TextY3 = 4.0 + TextSize/2;

difference(){
    union(){
        cube([Wight,Hight,DepthLow]); //base plate
        translate([thickX,thickY,0])cube([thickWight,thickHight,DepthHi]); //Higher plate

        //Frame
        cube([Wight,Frame,DepthHi]); //bottom
        translate([0,Hight-Frame,0])cube([Wight,Frame,DepthHi]); //top
        cube([Frame,Hight,DepthHi]); //left
        translate([Wight-Frame,0,0])cube([Frame,Hight,DepthHi]); //right
        //Prizm
        polyhedron(
            points=[[thickWight + Frame, thickY, DepthLow],
                    [thickWight + Frame, thickY + thickHight, DepthLow],
                    [thickX, thickY + thickHight, DepthLow],
                    [thickX, thickY, DepthLow],                        
                    [thickX, thickY + thickHight, DepthHi],
                    [thickX, thickY , DepthHi]],
            faces=[ [0,1,2,3],[0,3,5,4],[4,5,2,1],[0,4,1],[3,2,5]]);

        //first row
        translate([TextX,TextY1,DepthLow])
        linear_extrude(height=DepthLow)
        text(text=text_1,halign="left",valign="center",size=TextSize,font="Helvetica:style=Bold");

        //second row
        translate([TextX,TextY2,DepthLow])
        linear_extrude(height=DepthLow)
        text(text=text_2,halign="left",valign="center",size=TextSize,font="Helvetica");

        //second row
        translate([TextX,TextY3,DepthLow])
        linear_extrude(height=DepthLow)
        text(text=text_3,halign="left",valign="center",size=TextSize,font="Helvetica");
    }
    translate([Wight-hole_diameter-1,Hight-hole_diameter-1,0])cylinder(DepthHi,d=hole_diameter,center=false, $fn = 50);
}