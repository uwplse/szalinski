use <maphershey.scad>;

engraving = "YOUR TEXT HERE - ";
innerDiameter = 37; // Inner ring diameter
height = 15; // Ring height (without bevel)
engravingDepth = 1.5; // Depth of engraved text
engravingDrillWidth = 2; // Text line width
fontSize = 8.6;
font = 11; // [0:cursive, 1:futural, 2:futuram, 3:gothgbt, 4:gothgrt, 5:gothiceng, 6:gothicger, 7:gothicita, 8:gothitt, 9:rowmand, 10:rowmans, 11:rowmant, 12:scriptc, 13:scripts, 14:timesi, 15:timesib, 16:timesr, 17:timesrb]
fonts=["cursive","futural","futuram","gothgbt","gothgrt","gothiceng","gothicger","gothicita","gothitt","rowmand","rowmans","rowmant","scriptc","scripts","timesi","timesib","timesr","timesrb"];

thickness = 6*1; // Ring thickness
radius = innerDiameter/2+thickness;
cylinderFragments = 60*1; // Modify for better resolution if you fancy
textTest = false && true; // Render only engraving

module engraving() {
  mapHershey(
    engraving,
    f="let(angle=-u*180/(PI*r),r1=r) [r1*cos(-angle),r1*sin(-angle),v]",
    size=fontSize,
    valign="center",
    font=fonts[font],
    extraParameters=[["r",radius-engravingDepth]]
  ) {
    cylinder(d=engravingDrillWidth,h=engravingDepth+1);
  }
}

if (textTest) {
  engraving();
} else {
  difference() {
    union() {
      ringCap();
      translate([0, 0, height]) ringCap();
      cylinder(d=radius*2, h=height, $fn=cylinderFragments);
    }
    translate([0, 0, height/2])
      engraving();
    translate([0, 0, -1])
      cylinder(d=(radius-thickness)*2, h=height+2, $fn=cylinderFragments);
    color("red") innerBevel();
  }
}

module innerBevelCutter() {
  rotate_extrude($fn=cylinderFragments)
    translate([innerDiameter/2, 0, 0])
      scale([2, 2, 1])
        polygon(points=[[0, 1], [1, 0], [0, -1]]);
}

module innerBevel() {
  translate([0, 0, thickness/2])
    hull() {
      innerBevelCutter();
      translate([0, 0, height-thickness])
        innerBevelCutter();
    }
}

module ringCap(r1, r2) {
  rotate_extrude($fn=cylinderFragments)
    translate([innerDiameter/2+thickness/2, 0, 0])
      scale([1, 0.66])
        circle(thickness/2, $fn=cylinderFragments/5);
}
