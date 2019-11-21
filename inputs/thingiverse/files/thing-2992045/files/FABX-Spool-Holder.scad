$fn=200;
spool_length=65;
sheet_thickness=3.5;
spool_saver=5;
cylinder_dia=30;
bottom_projection=50;
top_projection=15;
inner_projection=20;
offset=5;
tightener=0.3;

translate([0,-cylinder_dia/2+offset,cylinder_dia/2-inner_projection+offset])
    cube([spool_saver,cylinder_dia-offset*2,inner_projection]);

translate([spool_saver,-cylinder_dia/2+offset,cylinder_dia/2-inner_projection+offset])
    cube([tightener,cylinder_dia-offset*2,tightener*sheet_thickness*2]);

translate([0,-cylinder_dia/2+offset,+cylinder_dia/2])
    cube([sheet_thickness+spool_saver*2,cylinder_dia-offset*2,offset]);

translate([sheet_thickness+spool_saver,-cylinder_dia/2+offset,top_projection-bottom_projection+cylinder_dia/2])
    cube([spool_saver,cylinder_dia-offset*2,bottom_projection]);

difference()
{
translate([spool_saver+sheet_thickness+spool_saver,0,0])
rotate([0,90,0])
{
    cylinder(h=spool_saver, r=spool_saver+cylinder_dia/2);
    translate([0,0,spool_saver])
    cylinder(h=spool_length,r=cylinder_dia/2);
    translate([0,0,spool_length+spool_saver])
    cylinder(h=spool_saver, r=spool_saver+cylinder_dia/2);
}

translate([spool_saver+sheet_thickness+spool_saver,-cylinder_dia,-cylinder_dia+offset])
    cube([spool_length+spool_saver*2+offset,cylinder_dia*2, cylinder_dia]);

translate([spool_saver+sheet_thickness+spool_saver-offset/2,cylinder_dia/2-offset,-cylinder_dia])
    cube([spool_length+spool_saver*2+offset,cylinder_dia, cylinder_dia*2]);

translate([spool_saver+sheet_thickness+spool_saver-offset/2,-cylinder_dia-cylinder_dia/2+offset,-cylinder_dia])
    cube([spool_length+spool_saver*2+offset,cylinder_dia, cylinder_dia*2]);
}