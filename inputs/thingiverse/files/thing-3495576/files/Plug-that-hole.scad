
Overall_height=8;
Fill_hole_size=13.4; 
Lip_diameter=19.4;
Number_of_segments=5;
Gap_between_segments=1.8;
Diameter_overhang=1.9;
segment_thickness=2.9;
hole_diameter=0.;// hole in center 0= no hole
base_thickness=1.2;


cylinder(  base_thickness, d1=Lip_diameter,  d2=Lip_diameter  );

seg_depth=Overall_height-base_thickness;

module spring_cap (){
difference(){
cylinder(h=Overall_height, d1=Fill_hole_size, d2=Fill_hole_size+Diameter_overhang, center=false);
translate([0,0,Overall_height-seg_depth]) cylinder(h=Overall_height, d1=Fill_hole_size-segment_thickness, d2=Fill_hole_size-segment_thickness, center=false);
Number_of_segments=fill_angle/Number_of_segments;
for (a =[start_angle:Number_of_segments:fill_angle])
rotate([0,0,a])
translate([0,0,Overall_height-seg_depth])
translate([-Gap_between_segments/2,0,0]) cube([Gap_between_segments,Fill_hole_size,Overall_height],center=false);


difference(){
    translate([0,0,-Overall_height/3])
cylinder(h=Overall_height, d1=Fill_hole_size+Diameter_overhang, d2=Fill_hole_size+Diameter_overhang, center=false);
cylinder(h=Overall_height, d1=Fill_hole_size, d2=Fill_hole_size+Diameter_overhang/2, center=false);
}

translate([0,0,-0.1]) cylinder(h=Overall_height, d1=hole_diameter, d2=hole_diameter, center=false);

}
}

$fn=180;
fill_angle=360;
start_angle=0;

intersection(){
spring_cap ();
cylinder(h=Overall_height, d1=Fill_hole_size+5, d2=Fill_hole_size, center=false);
}


