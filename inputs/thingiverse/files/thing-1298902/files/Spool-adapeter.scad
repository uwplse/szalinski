
External_Busing_Diameter = 40; //External Bushing Diam
Internal_Spool_Diameter = 30; //Internal Diam of Spool to support
Tube_Or_Support_Diameter = 19; //Spool support Diam
Lip_Diameter = 1.5;
e_diam = External_Busing_Diameter;
i_diam = Internal_Spool_Diameter;
t_diam = Tube_Or_Support_Diameter;
l_diam = Lip_Diameter;
 difference(){
union(){translate([0,0,0])
    linear_extrude (5,$fn=80)
        circle(d=e_diam);
  
    linear_extrude (10,$fn=80)   
        circle (d=i_diam);
    translate([0,0,10])
    linear_extrude (2,$fn=80)
        circle (d=i_diam+l_diam);
}
    translate([0,0,0])
        linear_extrude (12,$fn=80)
        circle (d=t_diam);
    }