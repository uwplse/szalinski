texto="MXC = = = =";
//medidas caixa principal
anchox=110;
fondoy=30;
altoz=50;
marxen=3;

//medidas enchufe 
banchox=33;
bfondoy=50;
baltoz=19;

//medidas interruptor
ianchox=32;
ifondoy=50;
ialtoz=12;




rotate([90,0,0])
{

difference() {
			difference() {
						difference() {
									difference() {
									difference() {
						 						//cuadrado principal
						 						cube([anchox+(marxen*2),fondoy+marxen,altoz+marxen]);
						 						translate([marxen,marxen,0]){
						 							color("blue") 
													cube([anchox,fondoy,altoz]);
													}
												}
											translate([7,0,0]){
													cube([anchox-10,fondoy-0,altoz-20]);							
													}		
																	
											}	

									//cuadrado interruptor
									
									rotate([90,0,0]){
									   				 translate([10,10,-20])
									  				 color("red") cube([ianchox,ifondoy+0,ialtoz]);
													}
									
					    				}
						//cuadrado enchufe
						rotate([90,0,0]){
							color("green")
							translate([70,10,-25])
							cube([banchox,bfondoy,baltoz]);
								}	
						}
						// texto
						//rotate([0,0,90]){	
						translate([5,23,0]){
												//rotate([0,0,0])
												color("brown")
												linear_extrude(height = 110)
												text(texto, size=8);
												}
						}
			}
//}