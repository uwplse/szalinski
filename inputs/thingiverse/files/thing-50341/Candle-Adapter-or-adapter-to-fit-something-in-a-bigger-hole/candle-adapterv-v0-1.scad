// Candle adapter
//(c) 2013 Wouter Robers


OuterDiameterTop=25;
OuterDiameterBottom=20;
InnerDiameterTop=20;
InnerDiameterBottom=18;
Height=17;


// Some 3D printers print a little thicker. This parameter compensates for that.
Margin=0.2;

difference(){
union(){
// All the objects
cylinder(r1=OuterDiameterBottom/2-Margin,r2=OuterDiameterTop/2-Margin,h=Height);
}
//All the cut-outs
translate([0,0,-0.01]) cylinder(r1=InnerDiameterBottom/2+Margin,r2=InnerDiameterTop/2+Margin,h=Height+0.02);

}