$fn=30;

//The variables hcoffre, lcoffrex,lcoffrey and llamey represent in the same order: 1) the height of the object 2) the lenght of the object 3) the width of the object 4) the thickness of the object. All values can be changed but it is recommended not to change the "llamey" value for the fonctionnality of the object.

hcoffre= 50;
lcoffrex= 130;
llamey= 5;
lcoffrey=70;



module base(){

//the first part represent the base of the object

cube([lcoffrex,lcoffrey,llamey]) ;

translate([0,lcoffrey/2+5,0])cylinder(h=llamey,r=lcoffrey/2+5) ;

translate([lcoffrex,lcoffrey/2+5,0])cylinder(h=llamey,r=lcoffrey/2+5) ;


//the second part represents the sides of the object

cube([lcoffrex,llamey,hcoffre]) ;

translate([0,lcoffrey,0])cube([lcoffrex,llamey,hcoffre]) ;

difference(){translate([0,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2+llamey/2);
translate([0,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2-llamey/2) ;translate([0,llamey,0])cube([lcoffrex/2,lcoffrey,hcoffre]); }

difference(){translate([lcoffrex,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2+llamey/2) ;
translate([lcoffrex,lcoffrey/2+llamey/2,0])cylinder(h=hcoffre,r=lcoffrey/2-llamey/2) ;translate([lcoffrex/2,llamey,0])cube([lcoffrex/2,lcoffrey,hcoffre]); }

//the next part represents the support of the pencil case

union() {translate([0,0,hcoffre])cube([10,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,hcoffre+5,0])cylinder(h=10,r=llamey/2) ;}

translate([lcoffrex/2-10,0,0])union() {translate([0,0,hcoffre])cube([10,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,hcoffre+5,0])cylinder(h=10,r=llamey/2) ;}

translate([lcoffrex-10,0,0])union() {translate([0,0,hcoffre])cube([10,llamey,5]) ;

rotate([90,0,90])translate([llamey/2,hcoffre+5,0])cylinder(h=10,r=llamey/2) ;}


translate([0,lcoffrey/2+llamey/2,0])cylinder(h=llamey,r=lcoffrey/2+10);

translate([lcoffrex,lcoffrey/2+llamey/2,0])cylinder(h=llamey,r=lcoffrey/2+10);

//the last part of the object represent the support for the rotation rod who will put together both parts of the pencil case

difference(){translate([0,lcoffrey/2+llamey/2,hcoffre-llamey])cylinder(h=llamey,r=lcoffrey/2+llamey);
translate([0,lcoffrey/2+5,hcoffre-10])cylinder(h=hcoffre,r=lcoffrey/2) ;translate([0,llamey,hcoffre-10])cube([lcoffrex/2,lcoffrey,hcoffre]); }

difference(){translate([lcoffrex,lcoffrey/2+llamey/2,hcoffre-llamey])cylinder(h=llamey,r=lcoffrey/2+llamey);
translate([lcoffrex,lcoffrey/2+5,hcoffre-10])cylinder(h=hcoffre,r=lcoffrey/2) ;translate([lcoffrex/2,llamey,hcoffre-10])cube([lcoffrex/2,lcoffrey,hcoffre]); }


}
base();

//the module key represent the rotation rod who will put together both parts of the pencil

module key(){
translate([0,llamey/2,hcoffre+5])rotate([90,0,90])cylinder(h=lcoffrex,r=llamey/4);
}
key();