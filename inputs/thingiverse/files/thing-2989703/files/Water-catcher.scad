Tube_radius=10;
Tube_inner_radius=8;
Joint_length=40;
Hose_inner_radius=2.65;

$fn=36;

difference()
    {
    union()
        {
        difference()
            {
                union()
                    {
        //Corpo
                    cylinder(r=Tube_radius+2,h=Joint_length,center=true);
        //Tubo uscita acqua
                    translate([Tube_radius/1.5,0,-Hose_inner_radius/2+5+Hose_inner_radius])
                    rotate([0,135,0])
                    cylinder(r=Hose_inner_radius,h=Joint_length*2);
                    }

        //Foro centrale corpo
                cylinder(r=Tube_radius,h=Joint_length*2,center=true);


            }
//Paratia centrale conica
        translate([0,0,-Hose_inner_radius/2])
        rotate([0,180,0])
        cylinder(r2=Tube_inner_radius/1.5,r1=Tube_radius,h=10);
//Rialzo centrale raccolta acqua
        translate([0,0,-Joint_length/3])
        rotate([0,0,0])
        cylinder(r=Tube_inner_radius/1.4,h=Joint_length,center=true);

//Rialzini per non bloccare foro uscita acqua        
    difference()
        {
         union()
            {
            rotate([0,0,45])
            cube([Tube_radius*2,2,Hose_inner_radius*2],center=true);
             rotate([0,0,-45])
            cube([Tube_radius*2,2,Hose_inner_radius*2],center=true);
            }
        cylinder(r=Tube_inner_radius,h=Joint_length,center=true);
        }

        }


        //Foro tubo uscita acqua
                translate([Tube_radius/1.5,0,-Hose_inner_radius/2+5+Hose_inner_radius])
                rotate([0,135,0])
                cylinder(r=Hose_inner_radius-1.5,h=Joint_length*2+5);

        translate([0,0,0])
        rotate([0,0,0])
        cylinder(r=Tube_inner_radius/1.4-2,h=Joint_length*2,center=true);

        //Rimozione eccessi sopra e sotto
                translate([0,0,50+Joint_length/2])
                cube([Tube_radius*25,Tube_radius*25,100],center=true);
                translate([0,0,-50-Joint_length/2])
                cube([Tube_radius*25,Tube_radius*25,100],center=true);
    }