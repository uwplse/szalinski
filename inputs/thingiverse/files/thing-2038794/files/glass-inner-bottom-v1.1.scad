/**
 * Glass Inner bottom (Ikea glass)
 * @Author Wilfried Loche
 * @Created Jan 11, 2017
 */

/* Plater radius */
radius = 28; /*27*/
/* Nb of feet */
nbFeet = 10;
/* Feet radius */
feetRadius = 2;
/* Feet height */
feetHeight = 8;
/* Inner feet gap */
feetInnerGap = 1;


cylinder(h=2, r=radius, center=true, $fn=90);

for (n = [ 0 : nbFeet - 1 ])
    translate([
        (radius-feetRadius - feetInnerGap) * cos(360 * n / nbFeet),
        (radius-feetRadius - feetInnerGap) * sin(360 * n / nbFeet),
        feetHeight/2+1
    ])
    cylinder(h=feetHeight, r=feetRadius, center=true, $fn=60)
;
