dia=60;
a_lower=42; //  [40:0.5:42]
a_upper=37; // [31:0.5:37]
plate=0.6;  // [0.56:0.02:0.66]0.56-0.66
offset=0;   // [0:0.2:2]

simple();

module simple()
{
    translate([0,0,dia/2*(1-plate)*tan(a_upper)+offset]) cylinder(d1=dia, d2=0.1, h=dia/2*tan(a_lower), $fn=8);
    translate([0,0,dia/2*(1-plate)*tan(a_upper)])cylinder(d1=dia, d2=dia, h=offset, $fn=8);
    cylinder(r1=dia/2*plate, r2=dia/2, h=dia/2*(1-plate)*tan(a_upper), $fn=8);
}
