dikte =18.5;
lengte = 590;
hoogte = 330;
diepte = 200;
aantalSteunVerticaal = 5;
aantalSteunHorizontaal = 3;

diepteInfrezing = 8;
hoogteSteun = 50;

//explode();
rolluikkasten();
//horizontaalSteun();
//verticaalSteun();

module explode(){
    translate([0,hoogte*2,0]){
difference(){
  square ([lengte,hoogte],center = false);
projection(cut=true) rolluikkastenExplode();
}
translate([0, (-diepte) -50,0]){
 
projection(cut=true) onderplaat();

  
}
}
  
//horizontaal   
for ( i = [0 :hoogteSteun +20: hoogteSteun *aantalSteunHorizontaal ] )
{
    translate([0,-i,0]){
        projection (cut=true) horizontaalSteun();
}
}

//verticaal
for ( i = [0 :hoogte+50:  (hoogte +50)* aantalSteunVerticaal ] )
{
translate([hoogte + i, 100, 0]){
rotate([0,0,90]){
projection (cut= true) verticaalSteun();
}
}
}
}
 module rolluikkasten(){
        
// difference(){
cube([lengte,hoogte,dikte], center=false);
translate([0,0,dikte]){
cube([lengte,dikte,diepte-dikte], center=false);
}

for ( i = [0 :  (lengte-dikte)/aantalSteunVerticaal: lengte] )
{
    translate([i,dikte,dikte-diepteInfrezing]){
cube([dikte,hoogte-dikte,hoogteSteun], center=false);
}
}
for ( i = [0 :  (hoogte-dikte)/aantalSteunHorizontaal: hoogte] )
{

 translate([0,i,dikte-diepteInfrezing]){
cube([lengte,dikte,hoogteSteun], center=false);
}
}

{   
//}
}
}

module rolluikkastenExplode(){

 difference(){
cube([lengte,hoogte,dikte], center=false);
translate([0,0,dikte]){
cube([lengte,dikte,diepte-dikte], center=false);
}

for ( i = [0 :  (lengte-dikte)/aantalSteunVerticaal: lengte] )
{
    translate([i,0,0]){
cube([dikte,hoogte,hoogteSteun], center=false);
}
}
for ( i = [0 :  (hoogte-dikte)/aantalSteunHorizontaal: hoogte] )
{

 translate([0,i,0]){
cube([lengte,dikte,hoogteSteun], center=false);
}
}

{   
}
}
}
module horizontaalSteun(){

   
 difference(){
        
 translate([0,0,0]){
cube([lengte,hoogteSteun,dikte], center=false);

} 

for ( i = [0 :  (lengte-dikte)/aantalSteunVerticaal: lengte] )
{
    translate([i,0,0]){
cube([dikte,hoogteSteun/2,hoogte-dikte,], center=false);

}

}
}
}

module verticaalSteun(){

   
 difference(){
translate([0,diepteInfrezing,0]){
cube([hoogteSteun,hoogte-diepteInfrezing,dikte], center=false);
}
for ( i = [0 :  (hoogte-dikte)/aantalSteunHorizontaal: hoogte] )
{

 translate([0,i,0]){
cube([hoogteSteun/2,dikte,dikte*2], center=false);
     
}
}


}
}

module onderplaat(){

   
 difference(){
        
 translate([0,0,0]){
cube([lengte,diepte,dikte], center=false);

} 

for ( i = [0 :  (lengte-dikte)/aantalSteunVerticaal: lengte] )
{
    translate([i,0,0]){
cube([dikte,hoogteSteun/2,hoogte-dikte], center=false);

}

}
}
}


