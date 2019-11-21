

letter_size = 17;
letter_height = 3;


difference(){
hull(){
translate([-7,-7,-3])cylinder(d=3, h=12,$fn =38, center = true);
translate([30,-7,-3])cylinder(d=3, h=12,$fn =38, center = true);
translate([5,36,-3])cylinder(d=3, h=12,$fn =38, center = true);
translate([18,36,-3])cylinder(d=3, h=12,$fn =38, center = true);}
    hull(){
    sphere(d = 10,$fn = 60);
translate([23,0,0])sphere(d = 10,$fn = 60);
translate([11,28,0])sphere(d = 10,$fn = 60);
translate([12,28,0])sphere(d = 10,$fn = 60);
}
hull(){
translate([2,6,0])rotate([90,0,0])cylinder(d=4.8, h=16,$fn =38);
translate([2,6,10])rotate([90,0,0])
    cylinder(d=4.8, h=16,$fn =38);}
 hull(){   
translate([21,6,0])rotate([90,0,0])cylinder(d=4.8, h=16,$fn =38);
translate([21,6,10])rotate([90,0,0])cylinder(d=4.8, h=16,$fn =38);}     
    hull(){     
translate([23/2,40,0])rotate([90,0,0])cylinder(d=4.8, h=16,$fn =38);
        
translate([23/2,40,10])rotate([90,0,0])cylinder(d=4.8, h=16,$fn =38);}        
}
translate([12.5,10,-7])rotate([0,0,180])linear_extrude(height=letter_height, convexity=4)
      text("\u263A", size=letter_size,font="Liberation Sans",$fn = 65,
  halign="center", valign="center");

