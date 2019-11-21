//Fill in your dimensions --> 

D_out = 30; // Outer Diameter
D_i = 15; // Inner Diameter
Wall = 4; // Thickness of spoolwalls
Bore = 14; // Diameter of the bore( mustnot larger as the inner diameter ^^)
Spl_lenght = 30; // inner Lenght of the spool

rotate_extrude($fn=200) polygon( points=[
[Bore/2,0], //1
[D_out/2,0], //2
[D_out/2,Wall], //3
[D_i/2,Wall], //4
[D_i/2,(Wall + Spl_lenght)], //5
[D_out/2,(Wall + Spl_lenght)],  //6
[D_out/2,(2*Wall + Spl_lenght)],  //7
[Bore/2,(2*Wall + Spl_lenght)]]); //8


