$fn = 200;
//Parameters
Lip_Outer_Radius=30;
Lip_Height=4;
Carboy_Opening_Radius=23;
Bung_Length=36;
Your_Tubing_ID_Radius=6.5;
Tube_Connector_Height=20;
Wall_Thickness=2.4;
rotate([0,180,0]) { 
//Lip Ring
difference() {
    // This piece will be created:
    cylinder(r=Lip_Outer_Radius, h=Lip_Height, center=true);
 
    // Everything else listed will be taken away:
    
    cylinder(r=Carboy_Opening_Radius-Wall_Thickness, h=Lip_Height+.1, center=true);
}

//Bung Body
difference() {
    translate([0,0,Lip_Height/2])cylinder(h=Bung_Length, r1=Carboy_Opening_Radius+Wall_Thickness, r2=Carboy_Opening_Radius-2, center=false);
    translate([0,0,(Lip_Height/2)-.1])cylinder(h=Bung_Length+.2, r1=Carboy_Opening_Radius-Wall_Thickness, r2=(Carboy_Opening_Radius-2)-Wall_Thickness, center=false);
}

//Bung End
difference() {
    translate([0,0,(Lip_Height/2)+Bung_Length])
    cylinder(r=Carboy_Opening_Radius-2, h=Wall_Thickness, center=false);
    
    translate([0,0,((Lip_Height/2)+Bung_Length)-.1])
    cylinder(r=Your_Tubing_ID_Radius-Wall_Thickness, h=Wall_Thickness+.11, center=false);
}

//Tube Connector
difference() {
    translate([0,0,((Lip_Height/2)+Bung_Length)-Tube_Connector_Height])
    cylinder(r=Your_Tubing_ID_Radius, h=Tube_Connector_Height, center=false);
    
    translate([0,0,(((Lip_Height/2)+Bung_Length)-Tube_Connector_Height)-.1])
    cylinder(r=Your_Tubing_ID_Radius-Wall_Thickness, h=Tube_Connector_Height+.11, center=false);
}
}
