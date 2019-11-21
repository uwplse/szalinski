//parameters

cuts_outs=1;//1=cutouts 0=no cutouts
pivots=0;//1=with pivots 0=no pivoits


$fn=100;
hole_dia=12;
blend_rad=30;//default 30
link_width=11;
hole_center=100;
link_thickness=8;
bonerad=12;
//

width=link_width+(blend_rad*2);
bonerad2=bonerad+blend_rad;
hole_rad=hole_dia/2;


module link () {
union(){
cube([hole_center,width,1],center=true);
translate([-hole_center/2,0,-2.5]) cylinder(  5, bonerad2, bonerad2,false);
translate([hole_center/2,0,-2.5]) cylinder(  5, bonerad2, bonerad2,false);
}
}

module dlink () {
offset(r=-blend_rad) projection(cut = false) link ();
}
difference(){
        linear_extrude(0,0,link_thickness) dlink ();
        translate([-hole_center/2,0,-5])cylinder(link_thickness+10,hole_rad,hole_rad,false);
        translate([hole_center/2,0,-5])cylinder(link_thickness+10,hole_rad,hole_rad,false);
            
        if (cuts_outs==1) translate([hole_center/2,0,link_thickness/2])cylinder((link_thickness/2)+1,bonerad+5,bonerad+17,false);
        if (cuts_outs==1) translate([-hole_center/2,0,link_thickness/2])cylinder((link_thickness/2)+1,bonerad+5,bonerad+17,false);
 }


if (pivots==1) translate([-hole_center/2,0,0])cylinder(link_thickness,hole_rad,hole_rad,false);
if (pivots==1) translate([hole_center/2,0,0])cylinder(link_thickness,hole_rad,hole_rad,false);
