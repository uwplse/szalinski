material="PETG";
x=80;
y=20;

cube([x, y, 1]);
translate([5, y/2, 1]) linear_extrude(height=1) text(material, size=8, valign="center");
