

mv=73; //misura ventola

union(){

//base vincolo a estrusore
translate ([-0,mv/2+7,9]) {    
rotate([90, 0 ,0])
difference(){
cube ([40+2,12,5],center = true); 
translate ([-12,0,-3]) cylinder(r=2,h=8,$fn=50); //foro vite
translate ([-12,0,0]) cylinder(r=3,h=3,$fn=50);  //foro di svasatura vite  
translate ([13,0,-3]) cylinder(r=2,h=8,$fn=50); //foro vite
translate ([13,0,0]) cylinder(r=3,h=3,$fn=50);  //foro di svasatura vite
}

//raccordo base vincolo--base ventola
hull(){
rotate([90,0,0])
translate ([0,-6,0]) cube ([40+2,1,5],center = true);
translate ([0,-5,-9]) cube ([mv+4,1,5],center = true);;
}
}

//base appoggio per ventola
difference(){
cube ([mv+4,mv+4,5],center = true);
    translate ([-30,30,-3]) cylinder(r=1.5,h=7,$fn=50);//foro vite alto SX
    translate ([30,30.5,-3]) cylinder(r=1.5,h=7,$fn=50);//foro vite falto DX
    translate ([-30,-30.5,-3])cylinder(r=1.5,h=7,$fn=50);//foro vite basso SX
    translate ([30,-30,-3])cylinder(r=1.5,h=7,$fn=50);//foro vite basso DX
    translate ([0,0,-3])cylinder(r=34,h=7,$fn=50); //foro ventola   
}
// base per interuttore
translate([mv/2,-13,-2.5]) {
difference(){
cube ([12,25,5]);
    translate([3,7,-1]) cube ([6,11,7]);
    translate([6,(7-2.5),-1]) cylinder(r=1, h=7, $fn=50);
    translate([6,20.5,-1]) cylinder(r=1, h=7, $fn=50);
    
}
//raccordo inferiore base per interruttore con base ventola
hull(){
translate([2,0,0]) cube([10,0.5,5]);
translate([2,-25.5,0]) cube([0.5,25.5,5]);
}
//raccordo superiore base per interruttore con base ventola
difference(){
hull(){
translate([2,25,0]) cube([10,0.5,5]);
translate([2,26.5,0]) cube([0.5,25.5,5]);   
}
translate([6,28,-1]) cylinder(r=2, h=7, $fn=50);//foro passaggio cavi
}
}

/*
//estrusore stampante
translate ([-22,(46+28),(2.5-31+7)])
color("Blue",0.7) cube([22,18,12]);
translate ([-4,(46+33),(2.5-31)])
color("Blue",0.7) cylinder(r1=0.5, r2=4, h=7,$fn=50);
*/
// bocca d'uscita e raccordo
difference(){
hull(){
translate ([-25,(46+15),(2.5-28)])
rotate([-20,0,0])cube([44,1,8.5]); //bocca uscita
translate ([0,0,-2.5])cube ([mv+4,mv+4,0.5],center = true);//raccordo vnt
}
hull(){ //negativo bocca d'uscita
translate ([-23,(46+15),(2.5-26.5)])
rotate([-20,0,0])cube([40,2,5.5]); //bocca uscita
translate ([0,0,-2.3])cube ([mv+1,mv-1,0.5],center = true);//raccordo vnt   
}
}
}


