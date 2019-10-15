
//Length of the cube:
laenge=50; // [10:100]
//heigth of the cube:
hoehe=60; // [10:100]
//heigth of the cube:
breite=50; // [10:100]
//diameter of the glass
glas=25; //[10:60]

toleranz=0.25;  
//cut (front):
auschnitt=15; //[8:100]

//miko="N";

//Basis-Rechteck
difference(){
    
//if(miko="N"){
  
cube([laenge,breite,hoehe]);
//}   
//else{    
//$fn=50;
//minkowski()
//{
//  cube([laenge,breite,hoehe]);
//  cylinder(r=2,h=1);
//}
//}
    
    
    
union(){
translate([laenge/2,breite/2,hoehe/3])
cylinder(h = hoehe, d1 = glas+toleranz, d2 = glas+toleranz, $fn=96) ;
translate([laenge/2,breite/2,hoehe/3])
sphere(d = glas+toleranz, $fn=96);

translate([laenge/2-auschnitt/2,-10,hoehe/2.5])
cube([auschnitt,breite/2,hoehe]);


translate([laenge/2,breite/2,hoehe/2.5])
rotate([90,0,0])
cylinder(h = hoehe, d1 = auschnitt, d2 = auschnitt, $fn=96) ;
}
}