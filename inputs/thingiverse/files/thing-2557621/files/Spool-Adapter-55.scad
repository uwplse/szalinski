// Adapter ring for spool holder bearing
//   https://www.thingiverse.com/thing:454808

DI=52.6;          // Inner diameter = bearing outer diam.
DI2 =DI - 0.2;  // cone for 'perfect fit' - set DI2 = DI for perfect ring
    // better measure your printed (!) bearing with a sliding caliper
DA=56.0;      // Outer Diam. - my spools are often more than 55mm
DA2=DA - 0.8;   // cone for perfect fit, see above
h= 12;
Res = 100;    // resolution (openScad default is quite coarse)

difference() {
  cylinder (h, DA/2, DA2/2, center=true, $fn=Res );
  cylinder (h+1, DI/2, DI2/2, center=true, $fn=Res );  
        // h+1 avoids approximation artefacts @cone
}