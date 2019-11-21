// quick and simple nozzle distance and adhesion test.
// prints a test pattern
// 2016sep02, ls  v0.0.1 initial version
// 2016oct19, ls  v0.0.2 changed for thingiverse customiser

// determines width of traces
extrusion = 0.5;	// [0.1:0.1:3]

// specifies test pattern height
layer = 0.5;		// [0.1:0.1:5]

// dimensions. Set smaller than actual bed size because of skirt.
bed = 160;		// [80:10:300]

linear_extrude(layer)  {
   bed45 = bed*sqrt(2);

   difference()  {
      square(bed, center=true);
      square(bed-2*extrusion, center=true);
   }

   rotate([0, 0, 45])  {
      for (a=[0, 90])
      rotate([0, 0, a])
      square([extrusion, bed45-extrusion], center=true);

      difference()  {
         square(bed45/2, center=true);
         square(bed45/2-2*extrusion, center=true);
      }
   }
}
