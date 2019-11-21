//Insert the diameter of your handle bars in millimeters.
handle_mm = 22;// [20:25]
//Insert the lenght of your grip in millimeters.
handle_lenght = 130; // [50:200]
//Insert the inscription that you would like to use as a grip.
Inscription = "Insert words here";//

/* [Hidden] */
thickness = 10;
grip= handle_mm+ thickness;
$fn=50;


module topround(){
difference (){
    translate ([-0,0,0])
    sphere(d=grip+40);
    translate ([-0,0,0])
    sphere(d=grip+19);
     translate ([0,0,-40])
    cube ([50*2,50*2,80],center = true);
}}


difference (){
cylinder (handle_lenght, d=grip, d=grip);
cylinder (handle_lenght-10, d=handle_mm, d=handle_mm);
translate ([0,0,handle_lenght-handle_mm])topround();    
    }
module name (){
translate ([20,0,20]) rotate ([0,90,0])
linear_extrude( height =4){text (Inscription, size = 10);}}


 for(i=[0:45:360]) {

  rotate([0,0,i])   
translate([handle_mm-29,-6,handle_lenght-27])
    
name();
}

   