diametre = 17; // Diameter of the space in mm
rayon = (diametre-3)/2;
ecart = 37.5; //Space between the holes in mm

difference () { //soustraction cube cylindre
    translate ([0,rayon,14.5]) { //cylindre gauche
    rotate([0,70,0]) {
    cylinder (h=80, r=rayon, $fn=90);
}
};
union () //collage des deux cubes
{
    translate ([0,0,-2.2]) { //découpe du cylindre gauche
    rotate([0,-20,0]) //rotation du cube vers le haut
    cube ([90,rayon*2,16]); //découpe longue du tube
    translate ([-10,0,15]) //placement du cube à l'arrière
    cube ([10,rayon*2,10]); //découpe arrière du tube
    }
}
}
difference () { //soustraction cube cylindre
    translate ([0,rayon+ecart,14.5]) { //cylindre droit
    rotate([0,70,0]) {
        cylinder (h=80, r=rayon, $fn=90);
}
}
union () //collage des deux tubes
{
    translate ([0,ecart,-2.2]) { //translation + découpe du cylindre droit
    rotate([0,-20,0]) //rotation du cube vers le haut
    cube ([90,rayon*2,16]); //découpe longue du tube
    translate ([-10,0,15]) //placement du cube à l'arrière
    cube ([10,rayon*2,10]); //découpe arrière du tube
    }
}
}
difference () { //soustraction de l'union bloc+renforts et emplacement vis
union () // union du cube de fixation et des supports tubes
{
cube ([5,ecart+(rayon*2),16.7]); //bloc fixation
CubePoints = [ //renfort sous le tube
[ 5, 0, 10 ],
[ 30, 0, 25.7 ],
[ 30, rayon*2, 25.7 ],
[ 5, rayon*2, 10 ],
[ 5, 0, 16.8 ],
[ 30, 0, 25.8 ],
[ 30, rayon*2, 25.8 ],
[ 5, rayon*2, 16.8 ]];

CubeFaces = [
[0,1,2,3],
[4,5,1,0],
[7,6,5,4],
[5,6,2,1],
[6,7,3,2],
[7,4,0,3]];

polyhedron( CubePoints, CubeFaces );

translate ([0,ecart,0]) { //copie et translation du renfort
    CubePoints = [ //renfort sous le tube
[ 5, 0, 10 ],
[ 30, 0, 25.7 ],
[ 30, rayon*2, 25.7 ],
[ 5, rayon*2, 10 ],
[ 5, 0, 16.8 ],
[ 30, 0, 25.8 ],
[ 30, rayon*2, 25.8 ],
[ 5, rayon*2, 16.8 ]];

CubeFaces = [
[0,1,2,3],
[4,5,1,0],
[7,6,5,4],
[5,6,2,1],
[6,7,3,2],
[7,4,0,3]];

polyhedron( CubePoints, CubeFaces );
}
}
union () //emplacement des vis
{
//translate ([-0.1,rayon,8]) {
//rotate([0,90,0])
//cylinder (h=5, r=1.875, $fn=90); //petit diamètre
//}
translate ([-0.05,rayon,8]) {
rotate([0,90,0])
cylinder (h=5.1, r1=1.875, r2=4, $fn=90); //cône
}
translate ([5,rayon,8]) {
rotate([0,90,0])
cylinder (h=5, r1=4, r2=4, $fn=90); //gros diamètre
}
}

union () //emplacement des vis
{
    translate ([0,ecart,0]){
//translate ([-0.1,rayon,8]) {
//rotate([0,90,0])
//cylinder (h=5, r=1.875, $fn=90); //petit diamètre
//}
translate ([-0.05,rayon,8]) {
rotate([0,90,0])
cylinder (h=5.1, r1=1.875, r2=4, $fn=90); //cône
}
translate ([5,rayon,8]) {
rotate([0,90,0])
cylinder (h=5, r1=4, r2=4, $fn=90); //gros diamètre
}
}
}
}
