/* [RaspberryPI holder] */
// Y dimension of the case i.e. SD side (HDMI+jack side is fixed to 56)
case_dimY = 63;
// Z dimension of the case
case_dimZ = 33;
// wall thickness
sp_raspPI = 3;

/* [Vesa base dimensions] */
// Vesa base thickness
sp_Vesa = 3;
// Vesa base diameter
dia_Vesa = 122;
// screw diameter
dia_viti = 5;
// X distance between screw
posX_viti = 75;
// Y distance between screw
posY_viti = 75;

/* [Other] */
// Hdmi & Jack lenght side
pareti_dimX = 56;
// External Y dimension
pareti_dimY = case_dimY + 2*sp_raspPI;
// External Z dimension
pareti_dimZ = case_dimZ + sp_raspPI;

module raspPI(){ // disegno pareti con alette superiori (box for raspberryPI - two L walls)
    difference(){
    cube([pareti_dimX,pareti_dimY,pareti_dimZ]);  // dimensioni esterne (external dimensions)  
    translate([0,sp_raspPI,0])cube([pareti_dimX,pareti_dimY-sp_raspPI*2,pareti_dimZ-sp_raspPI]); // vuoto per raspPI (hole for raspberryPI case)
    translate([0,sp_raspPI*2,0])cube([pareti_dimX,pareti_dimY-sp_raspPI*4,pareti_dimZ]); // vuoto per alette superiori (hole for raspberryPI case)
        }     
     }

module fori_porte(){ // dimensioni fori per porte HDMI e Jack (positioning and hole for hdmi and jack)
    union(){
        translate([7,0,8])cube([18,sp_raspPI,9]);
        translate([7+18+7,0,8])cube([10,sp_raspPI,9]);
        }
    
    }

module vite(){ // singola vite (one screw)
    cylinder(sp_Vesa, dia_viti/2, dia_viti/2);     
    }
    
module viti_Vesa(){ // fori per fissaggio Vesa (four holes for Vesa screw)
    translate([posX_viti/2,posY_viti/2,0])vite();
    mirror([0,1,0])translate([posX_viti/2,posY_viti/2,0])vite();
    mirror([1,0,0])union(){
    translate([posX_viti/2,posY_viti/2,0])vite();
    mirror([0,1,0])translate([posX_viti/2,posY_viti/2,0])vite();
    }
    }

module cuneo(){ //smusso (chamfer)
rotate([90,0,90])
linear_extrude(pareti_dimX)
polygon(points=[[0,0],[-5,0],[0,5]]);
}


module vuotopiastra(){ //vuoto rettangolare (hole in the middle of the base)
    cube([pareti_dimX+10,pareti_dimY-20,sp_Vesa],true);
    
    }

// MAIN

difference(){ // pareti forate (walls for raspberryPI with holes)
    raspPI();
    color("red")fori_porte();
    }
    

difference(){ //piastra Vesa forata (Vesa base with screw holes)
    translate([pareti_dimX/2,pareti_dimY/2,-sp_Vesa/2])cylinder(sp_Vesa,dia_Vesa/2,dia_Vesa/2); //piatto Vesa
    translate([pareti_dimX/2,pareti_dimY/2,-sp_Vesa/2])viti_Vesa();
    translate([pareti_dimX/2,pareti_dimY/2,0])vuotopiastra();
}

cuneo(); //rinforzo alla base (positioning chamfer)
translate([0,pareti_dimY,0])mirror([0,1,0])cuneo();
