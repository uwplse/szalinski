slots = 10;

thickness = 3.5;
width = 20.0;
spacer = 1.5;
length = ((thickness + spacer) * slots) + spacer;
font = min(length/8, 10);

difference()
{
cube([25,length,15]);
   
   for(i=[0:(slots-1)])
   { 
        translate([2.5,spacer+(i*(thickness + spacer)),1])
        cube([width,thickness,15]);
       //20190101 P. de Graaff: remix start - Bohrung zum Rausdrücken
        translate([12.5,spacer+(i*(thickness + spacer))+1.8,-1])
        cylinder(d=2,h=10,$fn=50);
       //remix end
   }
   
   translate([12.5, 0, 15])
   rotate([-90,0,0])
   cylinder(length+5, 8, 8, $fn = 50);

   translate([24.6,5,3])
   rotate([90,0,90])
   linear_extrude(height = 1) 
   {
        text("CR 2032",font);
   }
}

translate([2.25,0,14.45])
rotate([-90,0,0])
cylinder(length,0.5,0.5,$fn = 30);

