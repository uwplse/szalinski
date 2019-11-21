$fn=30;

hcoffre= 50;
lcoffrex= 130;
llamey= 5;
lcoffrey=70;



module base(){


cube([lcoffrex,lcoffrey,llamey]) ;

translate([0,lcoffrey/2+5,0])cylinder(h=llamey,r=lcoffrey/2+5) ;

translate([lcoffrex,lcoffrey/2+5,0])cylinder(h=llamey,r=lcoffrey/2+5) ;



cube([lcoffrex,llamey,hcoffre]) ;

translate([0,lcoffrey,0])cube([lcoffrex,llamey,hcoffre]) ;



difference(){translate([0,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2+llamey/2);
translate([0,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2-llamey/2) ;translate([0,llamey,0])cube([lcoffrex/2,lcoffrey,hcoffre]); }

difference(){translate([lcoffrex,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2+llamey/2) ;
translate([lcoffrex,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2-llamey/2) ;translate([lcoffrex/2,llamey,0])cube([lcoffrex/2,lcoffrey,hcoffre]); }


union() {translate([0,0,hcoffre])cube([10,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,hcoffre+5,0])cylinder(h=10,r=llamey/2) ;}


translate([lcoffrex/2-10,0,0])union() {translate([0,0,hcoffre])cube([10,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,hcoffre+5,0])cylinder(h=10,r=llamey/2) ;}


translate([lcoffrex-10,0,0])union() {translate([0,0,hcoffre])cube([10,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,hcoffre+5,0])cylinder(h=10,r=llamey/2) ;}


translate([0,lcoffrey/2+llamey/2,0])cylinder(h=llamey,r=lcoffrey/2+10);

translate([lcoffrex,lcoffrey/2+llamey/2,0])cylinder(h=llamey,r=lcoffrey/2+10);

difference(){translate([0,lcoffrey/2+llamey/2,hcoffre-llamey])cylinder(h=llamey,r=lcoffrey/2+llamey);
translate([0,lcoffrey/2+5,hcoffre-10])cylinder(h=hcoffre,r=lcoffrey/2) ;translate([0,llamey,hcoffre-10])cube([lcoffrex/2,lcoffrey,hcoffre]); }

difference(){translate([lcoffrex,lcoffrey/2+llamey/2,hcoffre-llamey])cylinder(h=llamey,r=lcoffrey/2+llamey);
translate([lcoffrex,lcoffrey/2+5,hcoffre-10])cylinder(h=hcoffre,r=lcoffrey/2) ;translate([lcoffrex/2,llamey,hcoffre-10])cube([lcoffrex/2,lcoffrey,hcoffre]); }


}
base();

module llave(){
translate([0,llamey/2,hcoffre+5])rotate([90,0,90])cylinder(h=lcoffrex,r=llamey/4);
}
llave();