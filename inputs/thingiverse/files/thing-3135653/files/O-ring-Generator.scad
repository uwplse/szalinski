//3D printable O-ring Customizer Project MY4777
//Aubrey Woern 10-3-2018

OD = 10; //Outer Diameter in mm 

ID = 9	; // Inner Diameter in mm

Height = 0.5; // Height of O-ring in mm

$fn=50;

difference(){ cylinder (d=OD,h=Height); //ring OD
              
					cylinder(d=ID,h=Height+20,center=true);
}

