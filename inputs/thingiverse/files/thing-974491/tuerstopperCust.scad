// Breite
breit=40;
// Länge
lang=120;
// Höhe
hoch=25;

module klotz(breite,laenge,hoehe){
translate([0,laenge/8,0]){
    polyhedron
(points=[
         [breite,0,0],[0,0,0],[0,laenge,0],[breite,laenge,0],           [breite,0,hoehe],[0,0,hoehe] 
         ],
  faces=[
         [3,2,1,0],[0,1,5,4],[0,4,3],[1,2,5],[2,3,4,5]
         ]);}    
cube([breite,laenge/8,hoehe]);}

         
         *klotz(100,160,80);

*translate([70,57.5,5]){
    rotate([0,0,90]){
resize(newsize=[125,60,80]){
linear_extrude(10)
    text("Stopp!",font="arial");}}}
         


module tuerstopper(breite,laenge,hoehe){
difference(){
        klotz(breite,laenge,hoehe);
        #translate([breite*0.72,laenge*0.175,5])
            rotate([0,0,90])   
                resize(newsize=[laenge*0.75,breite*0.75,hoehe])
                    linear_extrude(10)
                        text("Stopp!",font="arial");
    }
}
       
tuerstopper(breit,lang,hoch);