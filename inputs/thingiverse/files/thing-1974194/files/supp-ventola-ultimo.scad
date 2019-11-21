

mv=40; //misura ventola
rotate ([35,0,0])
union(){

//base vincolo a estrusore
difference(){
translate ([-(mv/2+0.5),18,-2])
rotate ([55,0,0])
cube ([mv+2,12,5]);
rotate ([55,0,0]){
translate ([-12,17,-18])    
cylinder(r=2,h=8,$fn=100); //foro vite
translate ([-12,17,-13.5])    
cylinder(r=3,h=3,$fn=100);}  // foro di svasatura vite  
rotate ([55,0,0]){
translate ([13,17,-18])    
cylinder(r=2,h=8,$fn=100); //foro vite
translate ([13,17,-13.5])    
cylinder(r=3,h=3,$fn=100);  // foro di svasatura vite
}
}

//base appoggio per ventola
difference(){
translate ([-(mv/2+0.5),-(mv/2+5.5),0])
cube ([mv+2,mv+3,5]);
translate ([-15.5,11.5,-1])
cylinder(r=1.5,h=7,$fn=100);
translate ([17.5,11.5,-1])
cylinder(r=1.5,h=7,$fn=100);
translate ([-15.5,-21.5,-1])
cylinder(r=1.5,h=7,$fn=100);
translate ([17.5,-21.5,-1])
cylinder(r=1.5,h=7,$fn=100);
translate ([0.3,-4.7,-1])
cylinder(r=18.5,h=7,$fn=100);    
}

//bocca di sfiato
difference (){
hull() {
translate ([-mv/3, mv/2.5, -29])
rotate([12, 0 ,0])
#cube ([mv/1.5, mv/4.5, 0.2]); //bocca d'uscita
translate ([-(mv/2+0.5),-(mv/2+5.5),0])
cube ([mv+2, mv+1.5*3, 0.2]);   
}
scale(v = [0.9, 0.9, 0.9]) {
//negativo da togliere per estrudere
hull() {
translate ([-mv/3, mv/1.8, -33.6])
rotate([12, 0 ,0]) 
cube ([mv/1.5, mv/8.5, 0.2]); //bocca d'uscita
translate ([-(mv/2+0.5),-(mv/2+5.5),0])
cube ([mv+2, mv+1.5, 0.2]); 
}
translate ([0.3,-4.7,-1])
cylinder(r=21,h=7,$fn=100);
}
}
}

