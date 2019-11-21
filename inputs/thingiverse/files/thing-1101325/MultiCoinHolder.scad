
CoinDiameter=24.6; // US Quarter Dollar
CoinThickness=3.7/2; // US Quarter Dollar
CoinQty=4;
HangerHoleDiameter=4;
ApertureDiameter=CoinDiameter-1;
SideMount=0;
LogoSize=10;
$fn=20;

CoinHeight=CoinThickness*CoinQty;

module CC_Tag(Size=10,Thickness=1, Center=true, DoBorder=true){
 linear_extrude(height=Thickness,center=Center)
 scale([2.54/90*Size/10, -2.54/90*Size/10, 1]) union() {
  polygon([[-0.006525,-53.156145],[-141.738804,17.709995],[-141.738804,88.576135],[-0.006525,17.709995],[141.725765,88.576135],[141.725765,17.709995]]); // Chevron
  polygon([[-0.006525,45.577248],[12.137625,82.011868],[50.541755,82.302728],[19.643125,105.111418],[31.234025,141.725798],[-0.006535,119.387728],[-31.247095,141.725798],[-19.656185,105.111418],[-50.554815,82.302728],[-12.150685,82.011868]]); //Bottom star
 polygon([[91.200672,-141.742850],[103.344822,-105.308230],[141.748952,-105.017370],[110.850322,-82.208680],[122.441222,-45.594300],[91.200662,-67.932370],[59.960102,-45.594300],[71.551012,-82.208680],[40.652382,-105.017370],[79.056512,-105.308230]]);
 polygon([[-91.078056,-141.883062],[-78.933906,-105.448442],[-40.529776,-105.157582],[-71.428406,-82.348892],[-59.837506,-45.734512],[-91.078066,-68.072582],[-122.318626,-45.734512],[-110.727716,-82.348892],[-141.626346,-105.157582],[-103.222216,-105.448442]]);
 if (DoBorder)
 difference(){
  polygon([[-177.171875,-177.171875],[-177.171875,177.171875],[177.171875,177.171875],[177.171875,-177.171875],[-177.171875,-177.171875]]);
  polygon([[-159.453125,-159.453125],[159.453125,-159.453125],[159.453125,159.453125],[-159.453125,159.453125],[-159.453125,-159.453125]]);
  }
 }
}

rotate([0,180,0])
difference(){
 union() {
  hull(){
   cylinder(r=(CoinDiameter/2)+2,h=CoinHeight+2,center=true);
   translate([0,CoinDiameter,1.5*(1-SideMount)]) rotate([0,90*SideMount,0]) cylinder(r=(HangerHoleDiameter/2)+1,h=CoinHeight-1,center=true);
  }
  translate([0,CoinDiameter,1*(1-SideMount)]) rotate([0,90*SideMount,0]) cylinder(r=(HangerHoleDiameter/2)+1,h=CoinHeight,center=true);
 }

 translate([0,0,0])
 union(){
  color("red") cylinder(r=ApertureDiameter/2,h=CoinHeight+10, center=true);
  color("red") translate([0,0,CoinHeight/2-0.5]) cylinder(r1=CoinDiameter/2,r2=ApertureDiameter/2,h=0.5);
  color("red") translate([0,0,-CoinHeight/2]) cylinder(r2=CoinDiameter/2,r1=ApertureDiameter/2,h=0.5);
  color("red") cylinder(r=CoinDiameter/2, h=CoinHeight-1, center=true);
 }
 color("red") translate([0,CoinDiameter,0]) rotate([0,90*SideMount,0]) cylinder(r=HangerHoleDiameter/2,h=CoinHeight+10,center=true);
 translate([0,-CoinDiameter/2-0.5,0])
 difference(){
  color("red") cube([4,3,CoinHeight+10],center=true);
  color("blue") translate([2,0,0]) cylinder(r=1.5,h=CoinHeight+11,center=true);
  color("blue") translate([-2,0,0]) cylinder(r=1.5,h=CoinHeight+11,center=true);
 }

translate([0,CoinDiameter/2+LogoSize/2,CoinHeight/2+1]) CC_Tag(Size=LogoSize,center=true,DoBorder=false);
}
