lupenbreite=15;//inkl. Spalt
lupend=90;
text="Lupe";
w=1.5;
$fn=10;

$fn=200;


difference(){
hull(){//Grundständer
cube([50,30,1],center=true);
translate([0,0,20]) cube([20,lupenbreite+2*w,2],center=true);
}

translate([0,lupenbreite/2+w,lupend/2+w]) rotate([90,0,0])cylinder(d=lupend+w,h=lupenbreite+2*w);//Ausenrundung

}



difference(){
translate([0,lupenbreite/2+w,lupend/2+w]) rotate([90,0,0])cylinder(d=lupend+w,h=lupenbreite+2*w);//Ausenrundung
translate([0,lupenbreite/2,lupend/2+w]) rotate([90,0,0])cylinder(d=lupend,h=lupenbreite);//Ausenrundung


translate([0,lupenbreite/2,lupend/2+w+10]) rotate([90,0,0])cylinder(d=lupend,h=lupenbreite);//Ausenrundung
  translate([-50,-lupenbreite/2,45]) cube([100,lupenbreite,100]);  
}


//

translate([-28,-lupenbreite/2-w,lupend/2])
rotate([90,0,0])
scale([1.9,3,3])
linear_extrude(height=0.7,size = 90) text(text);