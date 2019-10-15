//Nom: Cabrespines, Darné et Lemonche
//Prénom: Lena, Laia et Andrea
//Classe: 2de5
//Lycée Français de Barcelone
//Projet: Section d'un cube par un plan
//Licence: CC BY-NC-SA


//Sections du cube et trous pour les dentelles
  difference(){     
      difference(){ 
       difference(){
difference(){
    
difference(){
 cube(10,center=false);
 translate([-5,-0.5,7])rotate([0,30,0])cube([5,11,8]);
    };
    translate([8.5,-2.0,6])rotate([0,-35,-40])cube([5,7,6]);
}
translate([1.50,2,8])sphere(0.5,$fn=100,center=false);
    
}
translate([1.50,8,8])sphere(0.5,$fn=100,center=false);
}
translate([9.2,1.3,8.5])sphere(0.5,$fn=100,center=false);
}
//Figures avec les dentelles
//Figure de la première section avec les dentelles:
translate([0,0,10])rotate([-90,0,0])
union(){
union(){
    translate([12,0,0])intersection(){
   cube(10,center=false);
  translate([-5,-0.5,7])rotate([0,30,0])cube([5,11,8]);
    }
    translate([13.5,2,8])sphere(0.5,$fn=100,center=false);
}
translate([13.5,8,8])sphere(0.5,$fn=100,center=false);
}
//Figure de la deuxième section avec les dentelles:
translate([11,0,22])rotate([0,90,0])
 union(){translate([12,0,0])intersection(){
   cube(10,center=false);
translate([8.5,-2.0,6])rotate([0,-35,-40])cube([5,7,6]);}
translate([21.2,1.3,8.5])sphere(0.5,$fn=100,center=false);}