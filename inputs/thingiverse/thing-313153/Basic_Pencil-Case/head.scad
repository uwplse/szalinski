$fn=18.5;
hcoffre= 25;
lcoffrex= 130;
llamey= 5;
lcoffrey=70;


module head(coffrex,coffrey,coffrez){

	difference(){union(){difference(){cube([coffrex,llamey,coffrez]) ;
union(){union() {translate([0,0,0])cube([10,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,llamey,0])cylinder(h=12,r=llamey/2) ;}


translate([lcoffrex/2-10,0,0])union() {translate([0,0,0])cube([12,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,llamey,0])cylinder(h=12,r=llamey/2) ;}


translate([lcoffrex-10,0,0])union() {translate([0,0,0])cube([12,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,llamey,0])cylinder(h=12,r=llamey/2) ;}}}}translate([0,llamey/2,4])rotate([90,0,90])cylinder(h=lcoffrex,r=llamey/4+0.5);translate([0,1.5,0])cube([lcoffrex,2.5,3]);}


translate([0,lcoffrey,0])cube([coffrex,llamey,coffrez]) ;

difference(){	union(){difference(){translate([0,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2+llamey/2);
translate([0,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2-llamey/2) ;translate([0,llamey,0])cube([lcoffrex/2-15,lcoffrey-llamey,hcoffre]); }}union() {translate([0,0,0])cube([12,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,llamey,0])cylinder(h=12,r=llamey/2) ;}}

difference(){	union(){difference(){translate([lcoffrex,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2+llamey/2) ;
translate([lcoffrex,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2-llamey/2) ;translate([lcoffrex/2,llamey,0])cube([lcoffrex/2,lcoffrey-llamey,hcoffre]); }}union(){translate([lcoffrex-10,0,0])union() {translate([0,0,0])cube([12,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,llamey,0])cylinder(h=12,r=llamey/2) ;}}}

translate([0,lcoffrey/2+llamey/2,hcoffre])rotate([0,90,0])difference(){cylinder(h=lcoffrex,r=lcoffrey/2+llamey/2);cylinder(h=lcoffrex,r=lcoffrey/2-llamey/2);translate([0,-lcoffrey/2+llamey/2,0])cube([lcoffrey/2+5,lcoffrey-llamey,lcoffrex]);}

translate([llamey/2,0,hcoffre])translate([0,lcoffrey+llamey])rotate([0,0,180])translate([-lcoffrey/2,0,-lcoffrey])difference(){translate([lcoffrey/2+llamey/2,lcoffrey/2+llamey/2,lcoffrey])sphere(d=lcoffrey+llamey);cube([lcoffrey+llamey,lcoffrey+llamey,lcoffrey]);cube([lcoffrey/2,lcoffrey+llamey,lcoffrey+lcoffrey/2+llamey]);translate([lcoffrey/2+llamey/2,lcoffrey/2+llamey/2,lcoffrey])sphere(d=lcoffrey-llamey);}

translate([lcoffrex-llamey/2,0,hcoffre])translate([-lcoffrey/2,0,-lcoffrey])difference(){translate([lcoffrey/2+llamey/2,lcoffrey/2+llamey/2,lcoffrey])sphere(d=lcoffrey+llamey);cube([lcoffrey+llamey,lcoffrey+llamey,lcoffrey]);cube([lcoffrey/2,lcoffrey+llamey,lcoffrey+lcoffrey/2+llamey]);translate([lcoffrey/2+llamey/2,lcoffrey/2+llamey/2,lcoffrey])sphere(d=lcoffrey-llamey);}

intersection(){translate([lcoffrex/2-hcoffre/4,lcoffrey+llamey,0])cube([hcoffre/2,llamey,hcoffre]);
translate([lcoffrex/2,lcoffrey+llamey+llamey,hcoffre/2])rotate([90,0,0])cylinder(h=llamey,r=hcoffre/2);}
}

translate([0,0,0])head(lcoffrex,lcoffrey,hcoffre);


