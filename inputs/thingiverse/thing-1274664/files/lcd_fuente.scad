Length=64.14; // largo [mm]
Height=13.5; // alto [mm]
Wall_thickness=3; //Grosor [mm]
Clearing=0; //extra clearing on both directions [mm]
Border_Length= 73.1; //Largo borde [mm]
Border_Height = 26.6; //Alto Borde [mm]
largonegro=Border_Length+Clearing; 
anchonegro=Border_Height+Clearing; 
espesor=Wall_thickness;
Sphere_faces=50;
rotate([180,0,0]){
    difference(){
        union(){
            translate([Wall_thickness,Wall_thickness,0]) cube([largonegro,anchonegro,espesor]);
            translate([ Wall_thickness,Wall_thickness, -Wall_thickness ])sphere(r=Wall_thickness*2,$fn=Sphere_faces);
            translate([ Wall_thickness+largonegro,Wall_thickness, -Wall_thickness ])sphere(r=Wall_thickness*2,$fn=Sphere_faces);
            translate([ Wall_thickness+largonegro,Wall_thickness+anchonegro, -Wall_thickness ])sphere(r=Wall_thickness*2,$fn=Sphere_faces);
            translate([ Wall_thickness,Wall_thickness+anchonegro, -Wall_thickness ])sphere(r=Wall_thickness*2,$fn=Sphere_faces);
            translate([ Wall_thickness,Wall_thickness,-Wall_thickness ])rotate([0,90,0])cylinder(r=Wall_thickness*2,h=largonegro,$fn=Sphere_faces);
            translate([ Wall_thickness,Wall_thickness+anchonegro,-Wall_thickness  ])rotate([0,90,0])cylinder(r=Wall_thickness*2,h=largonegro,$fn=Sphere_faces);
            translate([ Wall_thickness,Wall_thickness+anchonegro, -Wall_thickness ])rotate([90,90,0])cylinder(r=Wall_thickness*2,h=anchonegro,$fn=Sphere_faces);
            translate([ Wall_thickness+largonegro,Wall_thickness+anchonegro, -Wall_thickness ])rotate([90,90,0])cylinder(r=Wall_thickness*2,h=anchonegro,$fn=Sphere_faces);
        }
        translate([ Wall_thickness+(largonegro-Length)/2,Wall_thickness+(anchonegro-Height)/2, -0.01 ])cube([Length,Height,espesor+0.1]);
        translate([Wall_thickness,Wall_thickness,-espesor-Wall_thickness])cube([ largonegro,anchonegro,espesor+Wall_thickness ]);
            translate([-2*Wall_thickness,-2*Wall_thickness,-espesor-3*Wall_thickness])cube([ 5*Wall_thickness+largonegro,5*Wall_thickness+anchonegro,espesor+2*Wall_thickness ]);
    }   
}