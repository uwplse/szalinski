//customizable ruler by Stu121
//Updated by DrLex
//2017-04-21: v2: added inches option

/* [General] */
RulerLength=10;//[1:50]
Unit="centimeters";//[centimeters, inches]
WithHole="yes";//[yes, no]
ReverseDesign="no";//[yes, no]
ShrinkageCompensationFactor=1.0;

/* [Text] */
RulerText="iRuler";
FontSize=10;
BoldFont="no";//[yes, no]
NarrowFont="no";//[yes, no]
TextHeight=1;//[-2.6:.1:5]
TextX=3;
TextY=18;

/* [Numbers] */
NumberSize=7;//[1:15]
BoldNumbers="no";//[yes, no]
NumberHeight=.5;//[-2.6:.1:5]
NumberOffset=2;//[0:.5:4]

/* [Ruler lines] */
UnitsLineWidth=.5;//[.3:.05:.7]
SubdivisionsGapWidth=.3;//[.2:.05:.5]

/* [Hidden] */
UnitText = Unit == "inches" ? "IN" : "CM";
UnitSize = Unit == "inches" ? 25.4 : 10;
Font= NarrowFont == "no" ? "Roboto" : "Roboto Condensed";
Font2="Roboto Condensed";
Hole=(WithHole == "yes");
Inverted=(ReverseDesign == "yes");
TextFont = BoldFont == "no" ? Font : str(Font, ":style=Bold");
NumberFont = BoldNumbers == "no" ? Font2 : str(Font2, ":style=Bold");

module numbers() {
    Thickness=abs(NumberHeight) + (NumberHeight < 0 ? 0.1 : 0);
    ZPos=NumberHeight >= 0 ? 2.5 : 2.5+NumberHeight;
    Rot=Inverted ? [0,0,180] : [0,0,0];
    RotCenter=[RulerLength*UnitSize/2+5,5.5+NumberSize/2,0];
    translate(RotCenter) rotate(Rot) {
        for (i=[1:1:RulerLength]) {
            NumberOffsetActual=(i > 9) ? NumberOffset-2.5 : NumberOffset;
            translate([(i*UnitSize)+NumberOffsetActual,5.5,ZPos]-RotCenter) linear_extrude(Thickness)  text(str(i),NumberSize,font=NumberFont,$fn=24);
        }
        translate([1,5.5,ZPos]-RotCenter) linear_extrude(Thickness)  text(UnitText,5,font=NumberFont,$fn=24);
    }
}

module label() {
    Thickness=abs(TextHeight) + (TextHeight < 0 ? 0.1 : 0);
    ZPos=TextHeight >= 0 ? 2.5 : 2.5+TextHeight;
    Rot=Inverted ? [0,0,180] : [0,0,0];
    RotCenter=[RulerLength*UnitSize/2+5,TextY-1.5+FontSize/2,0];
    translate(RotCenter) rotate(Rot) {
        translate([TextX,TextY,ZPos]-RotCenter) linear_extrude(Thickness)  text(RulerText,FontSize,font=TextFont,$fn=24);
    }
}


scale(ShrinkageCompensationFactor) difference() {
    union() {
        hull() {
            translate([0,5,0]) cube([(RulerLength*UnitSize)+10,25,2.5]);
            translate([0,-5,0])  cube([(RulerLength*UnitSize)+10,1,1]);
        }

        for (i=[0:1:RulerLength]) {  //unit lines
            translate([i*UnitSize+5-UnitsLineWidth/2,-4.9,0.6]) rotate([8.5,0,0]) cube([UnitsLineWidth,10,.7]);
        }
        
        if(NumberHeight > 0) {
            numbers();
        }
        if (TextHeight > 0) {
            label();
        }
    }

    //Subdivision lines. These are recessed to improve printability with thicker nozzles.
    if(Unit == "centimeters") {
        for (i=[1:RulerLength*10]) {
            if(i % 10) {
                GapLength=(i % 5) ? 5 : 6.5;
                translate([i+5-SubdivisionsGapWidth/2,-4.95,0.5]) rotate([8.5,0,0]) cube([SubdivisionsGapWidth,GapLength,.7]);
            }
        }
    }
    else {
        for (i=[0:RulerLength-1]) {
            translate([(i+0.5)*UnitSize+5-SubdivisionsGapWidth/2,-4.95,0.5]) rotate([8.5,0,0]) cube([SubdivisionsGapWidth,8,.7]);
            for (j=[0:1]) {
                translate([(i+0.25+j*0.5)*UnitSize+5-SubdivisionsGapWidth/2,-4.95,0.5]) rotate([8.5,0,0]) cube([SubdivisionsGapWidth,6,.7]);
            }
            for (j=[0:3]) {
                translate([(i+0.125+j*0.25)*UnitSize+5-SubdivisionsGapWidth/2,-4.95,0.5]) rotate([8.5,0,0]) cube([SubdivisionsGapWidth,4.25,.7]);
            }
            for (j=[0:7]) {
                translate([(i+0.0625+j*0.125)*UnitSize+5-SubdivisionsGapWidth/2,-4.95,0.5]) rotate([8.5,0,0]) cube([SubdivisionsGapWidth,2.5,.7]);
            }
        }
    }
    if (TextHeight < 0) {
        label();
    }
    if (NumberHeight < 0) {
        numbers();
    }
    if (Hole) {
        HoleX = Inverted ? 10 : RulerLength*UnitSize;
        translate([HoleX,18,2])  cylinder(10, 2.5, 2.5, true);
    }
}
