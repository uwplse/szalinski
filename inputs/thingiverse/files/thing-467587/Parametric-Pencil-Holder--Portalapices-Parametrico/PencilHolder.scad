//--Portalápices Paramétrico de base poligonal

//--Unidades en mm.www.Bioplastic3d.es

//--Parametros


Numero_Lados=6;
Diametro_Inferior=50;
Diametro_Superior=90;
Altura=80;
Grosor=5;




//--Booleana

difference(){

//--Superficie Exterior
cylinder ( r1=Diametro_Inferior/2, r2=Diametro_Superior/2,h=Altura,$fn=Numero_Lados,center=true);

//--Superficie a Sustraer

translate([0,0,Grosor])
cylinder ( r1=Diametro_Inferior/2 - Grosor, r2=Diametro_Superior/2- Grosor,h=Altura,$fn=Numero_Lados,center=true);}