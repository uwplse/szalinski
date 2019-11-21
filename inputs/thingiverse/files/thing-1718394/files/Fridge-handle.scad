use <MCAD/boxes.scad>;


// Fridge handle project

dep = 5;
handleW = 165;
handleD = 30;
handleH = 20;

screwsDim = 4;
screwsW   = 15;
screwsD    = handleD + 10;

module cylinderIn(h, dim, c = false)
{
   cylinder(h= h, r1=dim/2, r2=dim/2, center=c);
}

module screwsHolder()
{
    translate([screwsDim/2, screwsD, 0])
     rotate([90,0,0])
      union()
        {
            translate([0, screwsDim/2, 0])
             cylinderIn(screwsD , screwsDim);
    
            cube([screwsW, screwsDim, screwsD], false);
    
            translate([screwsW, screwsDim/2, 0])
             cylinderIn(screwsD , screwsDim);
            
            // Par 2
            
            translate([0, -screwsDim/2, -dep])
             cube([screwsW, screwsDim*2, screwsD], false);
            
            translate([0, screwsDim/2, -dep])
             cylinderIn(screwsD , screwsDim*2);
            
            translate([screwsW, screwsDim/2, -dep])
             cylinderIn(screwsD , screwsDim*2);
            
        }
}

module grip(gh, gr)
{
    translate([gr, gr, gr])
     sphere(r = gr, $fn = 20);
}

module handle()
{
    difference() {
        // External
        translate([handleW/2, handleD/2, handleH/2])
         roundedBox([handleW,handleD,handleH], 2.5, sidesonly = false);
    
        // Handle
        dimCil = handleD - (dep *2);
        translate([dep,dimCil/2 + dep, dimCil/2 + handleH/2])
         rotate([0,90,0])
          #cylinderIn(handleW - (dep *2) , dimCil);

        // Screws holder
        translate([dep, -0.5, dep + 2])
         #screwsHolder();
    
        translate([dep + 135, -0.5, dep+2])
         #screwsHolder();
    }
}

//handle();
//screwsHolder();

rotate([90,0,0])
union()
{
    gripH = 3;
    gripR = 4;
    
    translate([0, 0, gripH])
        handle();

    translate([2.5, 3, 0])
    {
        for(posd = [0 : gripR*2 : handleD-10])
         for(posw = [0 : gripR*2 : handleW - 10])
            translate([posw, posd, 0])
             grip(gripH, gripR);
    }
}

