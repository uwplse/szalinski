//STENOPE 35MM PARAMETRIQUE
//(focale et format)
//OpenSCAD

////Paramètres et calculs :

    //// Which one would you like to see?
part = "both"; // [case:Case Only,back:Back Only, both:All parts]

    ////Paramètres Customizer
focale = 30; // [30:60]
format = 55; // [24:Square,36:Standard,43:Cinema,55:Panoramic]
perforations = 5; // [5:exposed, 0:hidden]

    ////Ajouter une image
//image = "foo.dat"; // [image_surface:50x50]

/* [Hidden] */
height = 1; // [1:50]
    ////Diamètre du cylindre de la chambre noire :
diamCylind = 2*((8*(55/2))/30);

    ////Diamètre intérieur de l'oburateur :
rShutter = ((5.2*(55/2))/30);
   
    ////Dimensions du boitier :
cubeX = format+72+2*perforations;
cubeY = 64;
cubeZ = focale+4.5;

    
print_part();
module print_part() {       ////Sélection du fichier :
	
    if (part == "case") {
		case();
	} else if (part == "back") {
		back();
    } else if (part == "both") {
		both();
	} else {
		both();
	}
}   

module case() {             ////Boitier :

difference(){

union(){
    ////Cube de base
cube([cubeX,cubeY,cubeZ],false);
    ////Viseur
translate([cubeX/2,-5+cubeY,cubeZ/2]) cube([16+(8/(24/format)),24,cubeZ],true);
}

    ////Arrondis :
difference(){
translate([2,2,cubeZ/2]) cube([4,4,cubeZ+5],true);
translate([4,4,-1]) cylinder(h=cubeZ+10, r=4, $fs=0.5);
}
difference(){
translate([cubeX-2,2,cubeZ/2]) cube([4,4,cubeZ+5],true);
translate([cubeX-4,4,-1]) cylinder(h=cubeZ+10, r=4, $fs=0.5);
}
difference(){
translate([2,cubeY-2,cubeZ/2]) cube([4,4,cubeZ+5],true);
translate([4,cubeY-4,-1]) cylinder(h=cubeZ+10, r=4, $fs=0.5);
}
difference(){
translate([cubeX-2,cubeY-2,cubeZ/2]) cube([4,4,cubeZ+5],true);
translate([cubeX-4,cubeY-4,-1]) cylinder(h=cubeZ+10, r=4, $fs=0.5);
}

    ////Arrondis viseur
difference(){
translate([(cubeX/2)+((16+(8/(24/format)))/2)-2,cubeY+5,cubeZ/2]) cube([4,4,cubeZ],true);
translate([(cubeX/2)+((16+(8/(24/format)))/2)-4,cubeY+3,0]) cylinder(h=cubeZ, r=4, $fs=0.5);
}
difference(){
translate([(cubeX/2)-((16+(8/(24/format)))/2)+2,cubeY+5,cubeZ/2]) cube([4,4,cubeZ],true);
translate([(cubeX/2)-((16+(8/(24/format)))/2)+4,cubeY+3,0]) cylinder(h=cubeZ, r=4, $fs=0.5);
}

difference(){
    ////Bords interieurs :
difference(){
translate([2.5,2.5,cubeZ-2.4]) cube([cubeX-5,cubeY-5,2.4],false);
translate([cubeX/2,-5+cubeY,cubeZ-1.2]) cube([5+(8/(24/format)),13,2.4],true);
}
    ////Arrondis bords :
difference(){
translate([3.25,3.25,cubeZ]) cube([1.5,1.5,cubeZ+5],true);
translate([4,4,cubeZ/2]) cylinder(h=cubeZ, r=1.5, $fs=0.5);
}
difference(){
translate([cubeX-3.25,3.25,cubeZ]) cube([1.5,1.5,cubeZ+5],true);
translate([cubeX-4,4,cubeZ/2]) cylinder(h=cubeZ+10, r=1.5, $fs=0.5);
}
difference(){
translate([3.25,cubeY-3.25,cubeZ]) cube([1.5,1.5,cubeZ+5],true);
translate([4,cubeY-4,cubeZ/2]) cylinder(h=cubeZ+10, r=1.5, $fs=0.5);
}
difference(){
translate([cubeX-3.25,cubeY-3.25,cubeZ]) cube([1.5,1.5,cubeZ+5],true);
translate([cubeX-4,cubeY-4,cubeZ/2]) cylinder(h=cubeZ+10, r=1.5, $fs=0.5);
}
}
    ////logement pellicule 35mm :
translate([18,cubeY,cubeZ-2.4])
union(){
translate([0,-1,-13]) rotate([90,0,0]) cylinder(h=10, r=4.2, $fs=0.5);
translate([0,0,-13]) rotate([90,0,0]) cylinder(h=1, r=5.2, $fs=0.5);
translate([0,-55,-13]) rotate([90,0,0]) cylinder(h=5, r=6, $fs=0.5);
translate([0,-11,-13]) rotate([90,0,0]) cylinder(h=44, r=13, $fs=0.5);
translate([0,-57.5,-6.5]) cube([12,5,13],true);
translate([0,-33,-6.5]) cube([26,44,13],true);
translate([0,-5.35,-13]) cube([18,1.3,26],true);
}

    ////Passage de la pellicule
translate([cubeX/2,31,focale+2])
cube([10+format+2*perforations,34,4],true);
   
    ////chambre noire :
CubePoints = [
  [ -diamCylind/2,  -diamCylind/2,  0 ],  //0
  [ diamCylind/2,  -diamCylind/2,  0 ],  //1
  [ diamCylind/2,  diamCylind/2,  0 ],  //2
  [  -diamCylind/2,  diamCylind/2,  0 ],  //3
  [  -(format/2)-perforations,  -12-perforations,  focale-8 ],  //4
  [ (format/2)+perforations,  -12-perforations,  focale-8 ],  //5
  [ (format/2)+perforations,  12+perforations,  focale-8 ],  //6
  [ -(format/2)-perforations,  12+perforations,  focale-8 ]]; //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left

translate([cubeX/2,31,8])
polyhedron(CubePoints,CubeFaces);

    ////cylindre chambre noir
translate([+cubeX/2,+31,-2]) cylinder(h=8+4, r=diamCylind/2, $fs=0.5);

    ////logement bobine receptrice :
translate([54+format+2*perforations,cubeY,cubeZ-2.4])
union(){
translate([0,-1,-13]) rotate([90,0,0]) cylinder(h=10, r=4.2, $fs=0.5);
translate([0,0,-13]) rotate([90,0,0]) cylinder(h=1, r=5.2, $fs=0.5);
translate([0,-11,-13]) rotate([90,0,0]) cylinder(h=44, r=13, $fs=0.5);
translate([0,-33,-6.5]) cube([26,44,13],true);
translate([0,-5.35,-13]) cube([18,1.3,26],true);
}

    ////cylindres languettes
translate([18,58,cubeZ+1]) rotate([90,0,0]) cylinder(h=5, r=6, $fs=0.5);
translate([54+format+2*perforations,58,cubeZ+1]) rotate([90,0,0]) cylinder(h=5, r=6, $fs=0.5);

    ////percements
translate([5.1,5.1,3.4]) cylinder(h=cubeZ, r=2, $fs=0.5);
translate([cubeX-5.1,5.1,3.4]) cylinder(h=cubeZ, r=2, $fs=0.5);
translate([5.1,cubeY-5.1,3.4]) cylinder(h=cubeZ, r=2, $fs=0.5);
translate([cubeX-5.1,cubeY-5.1,3.4]) cylinder(h=cubeZ, r=2, $fs=0.5);

    ////Emplacement têtes de vis :
translate([5.1,5.1,0]) rotate([0,0,90]) cylinder(3,4,4,$fn=6);
translate([cubeX-5.1,5.1,0]) rotate([0,0,90]) cylinder(3,4,4,$fn=6);
translate([5.1,cubeY-5.1,0]) rotate([0,0,90]) cylinder(3,4,4,$fn=6);
translate([cubeX-5.1,cubeY-5.1,0]) rotate([0,0,90]) cylinder(3,4,4,$fn=6);

    ////Polyhedre viseur :
CubePoints2 = [
  [ -4/(24/format)-3, -7,  0 ],  //0
  [  4/(24/format)+3, -7,  0 ],  //1
  [  4/(24/format)+3,  7,  0 ],  //2
  [ -4/(24/format)-3,  7,  0 ],  //3

  [ -4/(24/format), -4,  cubeZ ],  //4
  [  4/(24/format), -4,  cubeZ ],  //5
  [  4/(24/format),  4,  cubeZ ],  //6
  [ -4/(24/format),  4,  cubeZ ]]; //7
  
CubeFaces2 = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left

translate([cubeX/2,-5+cubeY,0])
polyhedron(CubePoints2,CubeFaces2);

}
}







module back() {             ////Dos :
rotate([0,180,0]) translate([-cubeX,-cubeY-20,48])  
difference(){
    ////Plaque :
union(){
translate([cubeX/2,-5+cubeY,-50]) cube([16+(8/(24/format)),24,4],true);
translate([cubeX/2,-32+cubeY,-50]) cube([cubeX,cubeY,4],true);
translate([cubeX/2,-32+cubeY,-52.4]) cube([cubeX-6.2,cubeY-6.2,4],true);

};
//difference(){
//translate([cubeX/2,27,-48.1]) rotate([0,0,0]) cube([49,49,2],true); 
//translate([cubeX/2,27,-49.1]) rotate([0,0,0]) scale([0.5,0.5,height]) surface(file=image, center=true, convexity=5);   
//}
//}
    ////Viseur :

translate([cubeX/2,-5+cubeY,-55]) cube([8/(24/format),8,20],true);
translate([cubeX/2,-5+cubeY,-54]) cube([6.2+(8/(24/format)),14.2,4],true);


    ////arrondis :
difference(){
translate([2,2,-55]) cube([4,4,20],true);
translate([4,4,-65]) cylinder(h=20, r=4, $fs=0.5);
}
difference(){
translate([cubeX-2,2,-55]) cube([4,4,20],true);
translate([cubeX-4,4,-65]) cylinder(h=20, r=4, $fs=0.5);
}
difference(){
translate([2,cubeY-2,-55]) cube([4,4,20],true);
translate([4,cubeY-4,-65]) cylinder(h=20, r=4, $fs=0.5);
}
difference(){
translate([cubeX-2,cubeY-2,-55]) cube([4,4,20],true);
translate([cubeX-4,cubeY-4,-65]) cylinder(h=20, r=4, $fs=0.5);
}
    ////arrondis viseur :
difference(){
translate([(cubeX/2)+((16+(8/(24/format)))/2)-2,cubeY+5,-55]) cube([4,4,20],true);
translate([(cubeX/2)+((16+(8/(24/format)))/2)-4,cubeY+3,-65]) cylinder(h=20, r=4, $fs=0.5);
}
difference(){
translate([(cubeX/2)-((16+(8/(24/format)))/2)+2,cubeY+5,-55]) cube([4,4,20],true);
translate([(cubeX/2)-((16+(8/(24/format)))/2)+4,cubeY+3,-65]) cylinder(h=20, r=4, $fs=0.5);
}

    ////percements :
translate([4.1,4.1,-50-3.2]) cube([2,2,2.4],true);
translate([6.1,4.1,-50-3.2]) cube([2,2,2.4],true);
translate([4.1,6.1,-50-3.2]) cube([2,2,2.4],true);
translate([5.1,5.1,-50-4.4]) cylinder(h=6.4, r=2, $fs=0.5);

translate([cubeX-4.1,4.1,-50-3.2]) cube([2,2,2.4],true);
translate([cubeX-6.1,4.1,-50-3.2]) cube([2,2,2.4],true);
translate([cubeX-4.1,6.1,-50-3.2]) cube([2,2,2.4],true);
translate([cubeX-5.1,5.1,-50-4.4]) cylinder(h=6.4, r=2, $fs=0.5);

translate([4.1,cubeY-4.1,-50-3.2]) cube([2,2,2.4],true);
translate([6.1,cubeY-4.1,-50-3.2]) cube([2,2,2.4],true);
translate([4.1,cubeY-6.1,-50-3.2]) cube([2,2,2.4],true);
translate([5.1,cubeY-5.1,-50-4.4]) cylinder(h=6.4, r=2, $fs=0.5);

translate([cubeX-4.1,cubeY-4.1,-50-3.2]) cube([2,2,2.4],true);
translate([cubeX-6.1,cubeY-4.1,-50-3.2]) cube([2,2,2.4],true);
translate([cubeX-4.1,cubeY-6.1,-50-3.2]) cube([2,2,2.4],true);
translate([cubeX-5.1,cubeY-5.1,-50-4.4]) cylinder(h=6.4, r=2, $fs=0.5);


}
}



module shutter() {    ////Obturateur :
rotate([180,0,0])
difference(){
translate([-100,0,0]) cylinder(h=3.2, r=9.5+rShutter, $fs=0.5);
translate([-100,0,0]) cylinder(h=3.2, r=1.6+rShutter, $fs=0.5);
translate([-100,0,1.4]) cube([4*rShutter+21.6,2*rShutter+3.2,2.8],true);
}
rotate([180,0,0])
difference(){
intersection(){
        union(){
translate([-100+2.6+(2*rShutter),25,0.4]) cylinder(h=3.2, r=9.5+rShutter, $fs=0.5);
translate([-100,25,0.4]) cylinder(h=3.2, r=9.5+rShutter, $fs=0.5);
}
translate([-100+1.3+rShutter,25,1.4+0.4]) cube([(4*rShutter)+21.6,(2*rShutter)+3.2,2.8],true);
}
translate([-100,25,0.4]) cylinder(h=3.2, r=rShutter, $fs=0.5);
}

translate([-70,0,-1.2])rotate([180,0,90])
difference(){
    
cylinder(h=2, r=9.5+rShutter, $fs=0.5);
cylinder(h=2, r=rShutter+1.6, $fs=0.5);
    
translate ([rShutter+3.2,rShutter+1.7,0]) cylinder(h=0.4, r=1, $fs=0.5);
translate ([-rShutter-3.2,-rShutter-1.7,0]) cylinder(h=0.4, r=1, $fs=0.5);
translate ([rShutter+3.2,-rShutter-1.7,0]) cylinder(h=0.4, r=1, $fs=0.5);
translate ([-rShutter-3.2,rShutter+1.7,0]) cylinder(h=0.4, r=1, $fs=0.5);
}

}
module both() {             ////Toutes les pièces :
//translate ([40,0,3.2]) shutter();
back();
case();
}
    
