//Parameters
//Diameter spring
diameter=46;
//Number of layers
nlayers=13;
//Height of one layer
heightlayer = 2.2;
//Number vertical walls for each layer
nvertwall=12;
//Thickness vertical walls
thickwall = 0.8;
//Thickness rings
thickring =0.4;
//Width of the ring
widthring = 3.2;

//modules

module ring(hr)
{ translate([0,0,hr])
    difference()
    { cylinder(r=diameter/2,h=thickring);
      translate([0,0,-1])
      cylinder(r=diameter/2-widthring,h=thickring+2);  
    }
}

module vertwalls(rmin, hr)
{ translate([0,0,hr+(heightlayer/2+thickring/2)])
  { for(i=[1:nvertwall])
    { rotate([0,0,(360/nvertwall*i)-rmin])
      translate([0,diameter/2-widthring/2,0])
      cube(size=[thickwall,widthring, heightlayer],center=true);
    }
  }
}


//main
$fn=100;
union()
  {
  for(l=[0:nlayers])
    ring(l*heightlayer);
  for(l=[0:nlayers-1])
    vertwalls((round(l/2)-(l/2)) * (360/nvertwall), l*heightlayer);
  }