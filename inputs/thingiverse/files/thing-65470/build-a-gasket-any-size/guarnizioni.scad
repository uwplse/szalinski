
						//DICHIARAZIONI:                     		// DECLARATIONS:

r1=16.5;    //diametro interno guarnizione					// inner diameter seal
r2=20 ;   //diametro esterno guarnizione					// ??outer diameter seal
s=2.5;      //spessore guarnizione						// thickness seal

						//IMPOSTAZIONI FUNZIONI					// FUNCTION SETTINGS

rs1=r1-5; //diametro interno supporto						// inner diameter support
rs2=r2+5; //diametro esterno supporto						// outer diameter support
ss=s+2;      //spessore supporto							// thickness support

						//GUARNIZIONE									// SEAL

difference()
{
cylinder(h=ss,r=rs2,center=true);
cylinder(h=ss+2,r=rs1,center=true);
difference()
{
cylinder(h=s,r=r2,center=true+1);
cylinder(h=s,r=r1,center=true+1);
}
}



