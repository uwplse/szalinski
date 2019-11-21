
// Generated from inkscape drawing I made.
// Designed to be pressed into the Sand at the beach
//  - to annoy and intrigue others...
// Author Neon22 Dec 2015

use<scad-utils/morphology.scad>;

// Added customizer so user can get better prints for narrow edge

/* [Escher Birds] */
// Nose to Tail length (mm).
Length = 200;
// Top width of the walls.
Maximum_wall_width = 3;
// Bottom width of internal walls.
Minimum_wall_width = 1; 
// Height of the walls.
Wall_height = 20;
// Thickness of Base.
Base = 2.0;

/* [Cookie Mode] */
// Set to yes for different internal wall height. Ideal for impressing into cookies.
Cookie_mode = "yes"; // [yes, no]
// Inner wall height(from Base).
Inner_height = 10;

/* [Demo] */
// Show a sample tesselation (not for printing)
show_tesselated = "no"; // [yes, no]


/* [Hidden] */
Delta = 0.1;
profile_scale = 25.4/90; //made in inkscape in mm
s = Length / 11; // 11 is length of actual in mm
echo(s);
min_width = Minimum_wall_width / profile_scale / s /2; // div by 2 because cyl uses radius
max_width = Maximum_wall_width / profile_scale / s /2;
base_thick = Base;  // no scale in Z
wall = Wall_height; // no scale in Z
inner_walls = (Cookie_mode == "yes") ? Inner_height : wall;


profile_scale = 25.4/90; //made in inkscape in mm


//---------------------------
// curves

path563071936_0_points = [[-11.966994,-13.357745],[-4.893721,-12.437685]];

module poly_path563071936(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563071936_0_points)-2]) {
      hull() {
        translate(path563071936_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563071936_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563071447005_0_points = [[-6.888285,-14.933905],[-7.800735,-14.818826],[-8.106392,-14.620120],[-7.921491,-14.364461],[-7.362266,-14.078528],[-5.585783,-13.522539],[-3.706819,-13.165565]];

module poly_path563071447005(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563071447005_0_points)-2]) {
      hull() {
        translate(path563071447005_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563071447005_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630719070_0_points = [[10.234063,1.397965],[7.269069,1.931852],[3.889725,2.425765]];

module poly_path5630719070(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630719070_0_points)-2]) {
      hull() {
        translate(path5630719070_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630719070_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307144706379_0_points = [[2.827733,-0.234265],[3.819386,-0.052616],[4.369996,0.181427],[4.541457,0.448080],[4.395659,0.727556],[3.399860,1.245840],[1.877732,1.577995]];

module poly_path56307144706379(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307144706379_0_points)-2]) {
      hull() {
        translate(path56307144706379_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307144706379_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630714470338565_0_points = [[-0.909071,7.217745],[0.698420,7.449223],[1.609772,7.721487],[1.953734,8.008856],[1.859052,8.285651],[0.868749,8.704805],[-0.331153,8.773515]];

module poly_path5630714470338565(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714470338565_0_points)-2]) {
      hull() {
        translate(path5630714470338565_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714470338565_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563071447065_0_points = [[-10.791004,-16.687795],[-11.004780,-16.422102],[-10.913503,-16.160587],[-10.018325,-15.668060],[-8.510556,-15.246152],[-6.795276,-14.930805]];

module poly_path563071447065(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563071447065_0_points)-2]) {
      hull() {
        translate(path563071447065_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563071447065_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630714470335826_0_points = [[-3.735781,0.003505],[-5.919082,0.205828],[-7.393506,0.485999],[-8.230941,0.801999],[-8.503277,1.111809],[-8.282403,1.373410],[-7.640208,1.544785],[-6.648582,1.583912],[-5.379413,1.448775]];

module poly_path5630714470335826(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714470335826_0_points)-2]) {
      hull() {
        translate(path5630714470335826_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714470335826_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630714470335267_0_points = [[-0.237837,8.781805],[2.211423,9.149646],[2.801675,9.398341],[3.026001,9.659249],[2.927148,9.909143],[2.547862,10.124795],[1.118972,10.360465]];

module poly_path5630714470335267(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714470335267_0_points)-2]) {
      hull() {
        translate(path5630714470335267_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714470335267_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563043_0_points = [[-7.751998,-5.075615],[-5.679447,-5.779350],[-3.729846,-6.141638],[-2.060314,-6.220767],[-0.827971,-6.075025]];

module poly_path563043(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563043_0_points)-2]) {
      hull() {
        translate(path563043_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563043_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5626316_0_points = [[9.653944,10.631575],[9.189020,9.949097],[8.825818,9.070020],[8.261920,7.221965],[7.911815,6.401837],[7.404387,5.639770],[6.763635,4.996203],[6.013556,4.531575],[5.171661,4.281687],[4.355254,4.193460],[3.493690,4.210365]];

module poly_path5626316(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5626316_0_points)-2]) {
      hull() {
        translate(path5626316_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5626316_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5833790_0_points = [[-13.050059,4.576755],[-12.947743,4.818409],[-12.700725,4.918505],[-12.453708,4.818408],[-12.351395,4.576755],[-12.453712,4.335108],[-12.700725,4.235015],[-12.947740,4.335107],[-13.050059,4.576755],[-13.050059,4.576755]];

module poly_path5833790(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5833790_0_points)-2]) {
      hull() {
        translate(path5833790_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5833790_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307625_0_points = [[-15.931854,1.996345],[-13.411497,1.116530],[-11.037823,0.466758],[-8.752934,0.031068],[-6.498931,-0.206495]];

module poly_path56307625(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307625_0_points)-2]) {
      hull() {
        translate(path56307625_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307625_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307971_0_points = [[8.882524,9.230045],[6.830743,8.806527],[4.904745,8.686164],[3.211327,8.783374],[1.857285,9.012575]];

module poly_path56307971(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307971_0_points)-2]) {
      hull() {
        translate(path56307971_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307971_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307144703371_0_points = [[0.940917,-5.786545],[-0.278876,-5.549134],[-0.927941,-5.294315],[-1.115363,-5.036876],[-0.950223,-4.791603],[0.001404,-4.396706],[1.054271,-4.227925]];

module poly_path56307144703371(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307144703371_0_points)-2]) {
      hull() {
        translate(path56307144703371_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307144703371_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path562609_0_points = [[-9.565688,-3.044685],[-9.054406,-3.337758],[-8.637145,-3.676730],[-8.309330,-4.119665],[-7.586699,-5.345309],[-6.609021,-6.613455],[-5.918580,-7.178431],[-5.257282,-7.524051],[-3.916865,-7.832015],[-3.070253,-7.850612],[-2.478687,-7.725746],[-2.018186,-7.491955]];

module poly_path562609(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path562609_0_points)-2]) {
      hull() {
        translate(path562609_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path562609_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630760494_0_points = [[14.345773,14.979815],[11.496805,14.067003],[9.873226,13.773809],[8.044415,13.640415]];

module poly_path5630760494(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630760494_0_points)-2]) {
      hull() {
        translate(path5630760494_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630760494_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630714250_0_points = [[11.881869,-0.592325],[7.793949,0.284740],[3.784425,1.095415]];

module poly_path5630714250(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714250_0_points)-2]) {
      hull() {
        translate(path5630714250_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714250_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307144703693_0_points = [[1.805880,1.589715],[3.120947,1.706221],[3.426061,1.867095],[3.531790,2.068530],[3.251784,2.509529],[2.494304,2.862105]];

module poly_path56307144703693(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307144703693_0_points)-2]) {
      hull() {
        translate(path56307144703693_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307144703693_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630714242_0_points = [[-10.606747,-12.054185],[-8.815957,-11.781268],[-7.152541,-11.412570],[-4.032218,-10.807285]];

module poly_path5630714242(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714242_0_points)-2]) {
      hull() {
        translate(path5630714242_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714242_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630714470335601_0_points = [[12.694868,-7.742335],[13.261843,-6.923614],[13.266050,-6.616365],[13.144639,-6.368657],[12.706669,-6.026277],[12.311342,-5.845285],[13.674293,-5.392659],[15.632635,-5.176785]];

module poly_path5630714470335601(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714470335601_0_points)-2]) {
      hull() {
        translate(path5630714470335601_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714470335601_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563070191_0_points = [[9.924926,11.026585],[7.373892,10.301503],[5.452875,10.144045],[4.010369,10.292137],[2.894867,10.483705]];

module poly_path563070191(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563070191_0_points)-2]) {
      hull() {
        translate(path563070191_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563070191_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307144703353137_0_points = [[1.242369,10.347535],[2.715732,10.520162],[3.766657,10.776872],[4.412292,11.078438],[4.669780,11.385634],[4.556268,11.659233],[4.088901,11.860009],[3.284825,11.948735],[2.161184,11.886185]];

module poly_path56307144703353137(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307144703353137_0_points)-2]) {
      hull() {
        translate(path56307144703353137_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307144703353137_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630210_0_points = [[-9.143661,-3.263015],[-6.952445,-4.053832],[-4.741778,-4.607702],[-2.811179,-4.878414],[-1.460169,-4.819755]];

module poly_path5630210(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630210_0_points)-2]) {
      hull() {
        translate(path5630210_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630210_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5628690_0_points = [[9.337450,2.957325],[7.715923,2.693643],[5.680267,2.595780],[3.377200,2.738352],[0.953440,3.195975]];

module poly_path5628690(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5628690_0_points)-2]) {
      hull() {
        translate(path5628690_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5628690_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307516_0_points = [[-15.763705,-16.055275],[-13.096846,-15.983741],[-10.211270,-15.735995]];

module poly_path56307516(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307516_0_points)-2]) {
      hull() {
        translate(path56307516_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307516_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307144703667_0_points = [[4.869563,-2.054575],[5.805809,-1.741533],[5.916431,-1.536655],[5.758107,-1.299265],[4.542790,-0.726130],[1.976190,-0.020485]];

module poly_path56307144703667(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307144703667_0_points)-2]) {
      hull() {
        translate(path56307144703667_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307144703667_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}



path5630714450_0_points = [[-10.748440,3.163585],[-10.902939,2.835351],[-10.869611,2.550480],[-10.326452,2.094263],[-9.292909,1.761798],[-7.942931,1.519955]];

module poly_path5630714450(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714450_0_points)-2]) {
      hull() {
        translate(path5630714450_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714450_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563075853_0_points = [[15.542853,-4.104605],[13.503363,-3.674225],[11.692787,-3.526036],[9.921461,-3.423967],[7.999720,-3.131945]];

module poly_path563075853(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563075853_0_points)-2]) {
      hull() {
        translate(path563075853_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563075853_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307144841_0_points = [[9.338424,15.046255],[9.612096,14.606127],[9.556343,14.263136],[9.231654,14.001166],[8.698518,13.804099],[5.691303,13.342505]];

module poly_path56307144841(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307144841_0_points)-2]) {
      hull() {
        translate(path56307144841_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307144841_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563071447033507_0_points = [[-0.190302,-3.000665],[-2.648955,-2.635955],[-3.248834,-2.390470],[-3.484197,-2.133241],[-3.396381,-1.887027],[-3.026723,-1.674584],[-1.607227,-1.442045]];

module poly_path563071447033507(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563071447033507_0_points)-2]) {
      hull() {
        translate(path563071447033507_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563071447033507_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563071447033812_0_points = [[0.801546,-4.304235],[-0.818861,-4.084811],[-1.764263,-3.844326],[-2.156364,-3.601886],[-2.116865,-3.376594],[-1.229885,-3.053872],[-0.076948,-3.028995]];

module poly_path563071447033812(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563071447033812_0_points)-2]) {
      hull() {
        translate(path563071447033812_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563071447033812_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path583305_0_points = [[12.185353,-6.925185],[12.096460,-6.680504],[11.881840,-6.579155],[11.667223,-6.680506],[11.578330,-6.925185],[11.667226,-7.169858],[11.881840,-7.271205],[12.096457,-7.169859],[12.185353,-6.925185],[12.185353,-6.925185]];

module poly_path583305(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path583305_0_points)-2]) {
      hull() {
        translate(path583305_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path583305_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307144703358922_0_points = [[3.450536,11.958765],[5.450641,12.111943],[6.680159,12.339743],[7.239690,12.607485],[7.229832,12.880485],[6.751185,13.124063],[5.904349,13.303537],[3.508506,13.331445]];

module poly_path56307144703358922(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307144703358922_0_points)-2]) {
      hull() {
        translate(path56307144703358922_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307144703358922_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630746_0_points = [[-11.790487,-1.753525],[-9.462744,-2.432461],[-6.907084,-2.982489],[-4.392388,-3.344999],[-2.187534,-3.461385]];

module poly_path5630746(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630746_0_points)-2]) {
      hull() {
        translate(path5630746_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630746_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563076195_0_points = [[11.563719,12.759495],[9.210779,12.260566],[5.830331,11.956705]];

module poly_path563076195(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563076195_0_points)-2]) {
      hull() {
        translate(path563076195_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563076195_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630922_0_points = [[7.827118,6.258455],[6.659760,5.874797],[5.509678,5.658287],[3.350449,5.609506],[1.527646,5.877700],[0.219487,6.228455]];

module poly_path5630922(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630922_0_points)-2]) {
      hull() {
        translate(path5630922_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630922_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630760449_0_points = [[-17.594387,4.136845],[-15.888908,3.290976],[-13.941342,2.528851],[-11.790319,1.895796],[-9.474470,1.437135]];

module poly_path5630760449(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630760449_0_points)-2]) {
      hull() {
        translate(path5630760449_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630760449_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path4303_0_points = [[-18.686609,5.872895],[-17.348725,5.596487],[-15.755608,5.138565],[-13.256920,4.038301],[-11.446259,3.275065],[-10.249588,3.208429],[-9.161636,3.372666],[-7.136912,3.857395],[-5.845427,3.885952],[-4.244393,3.717399],[-1.685617,3.187995],[-1.088633,2.290011],[-0.230847,0.649148],[0.736965,-1.198172],[1.664028,-2.715525],[4.190734,-3.101697],[6.229737,-3.794590],[7.910589,-4.507920],[9.362844,-4.955405],[11.451079,-5.072737],[13.568822,-5.050282],[15.784947,-5.199882],[16.951426,-5.436651],[18.168328,-5.833375]];

module poly_path4303(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path4303_0_points)-2]) {
      hull() {
        translate(path4303_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path4303_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path562483_0_points = [[1.694154,-2.731085],[2.186536,-3.754812],[2.782087,-4.631978],[3.592833,-5.394905]];

module poly_path562483(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path562483_0_points)-2]) {
      hull() {
        translate(path562483_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path562483_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563071447033936_0_points = [[-0.948251,6.176275],[0.939394,6.590230],[1.146071,6.767438],[1.003007,6.920738],[0.092716,7.143429],[-0.941351,7.233935]];

module poly_path563071447033936(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563071447033936_0_points)-2]) {
      hull() {
        translate(path563071447033936_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563071447033936_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563071210_0_points = [[13.672292,-2.502415],[11.916573,-2.105792],[9.900200,-1.798784],[5.530834,-1.149085]];

module poly_path563071210(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563071210_0_points)-2]) {
      hull() {
        translate(path563071210_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563071210_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563071447818_0_points = [[7.557497,-4.364285],[8.305531,-4.509092],[8.836704,-4.440624],[9.070498,-4.195208],[8.926393,-3.809170],[8.323872,-3.318837],[7.182415,-2.760536],[5.421504,-2.170593],[2.960620,-1.585335]];

module poly_path563071447818(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563071447818_0_points)-2]) {
      hull() {
        translate(path563071447818_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563071447818_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630714470335342_0_points = [[-1.610394,-1.470085],[-4.256790,-1.050912],[-5.027585,-0.759764],[-5.428552,-0.464511],[-5.458517,-0.202855],[-5.116312,-0.012497],[-4.400764,0.068860],[-3.310704,0.003515]];

module poly_path5630714470335342(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714470335342_0_points)-2]) {
      hull() {
        translate(path5630714470335342_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714470335342_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630714470324_0_points = [[-1.851315,-11.512655],[-2.996365,-11.578784],[-3.284731,-11.465063],[-3.402878,-11.290647],[-3.186170,-10.871219],[-2.461561,-10.543475]];

module poly_path5630714470324(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714470324_0_points)-2]) {
      hull() {
        translate(path5630714470324_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714470324_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path563071202_0_points = [[-13.526873,-14.630795],[-10.298199,-14.450632],[-7.764724,-14.264275]];

module poly_path563071202(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path563071202_0_points)-2]) {
      hull() {
        translate(path563071202_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path563071202_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path562892_0_points = [[-9.660141,-10.471255],[-5.381894,-10.620914],[-3.430991,-10.428481],[-1.281386,-9.929065]];

module poly_path562892(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path562892_0_points)-2]) {
      hull() {
        translate(path562892_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path562892_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5624129_0_points = [[-1.801681,9.031355],[-2.359186,7.929975],[-3.109408,6.952929],[-4.221356,6.046915]];

module poly_path5624129(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5624129_0_points)-2]) {
      hull() {
        translate(path5624129_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5624129_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307144703356440_0_points = [[-14.082223,4.398535],[-14.208196,4.729256],[-14.190913,5.023493],[-14.058596,5.280076],[-13.839469,5.497834],[-13.253678,5.812197],[-12.659328,5.957225],[-14.043082,6.117716],[-15.344692,6.186355],[-17.633552,6.223815]];

module poly_path56307144703356440(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307144703356440_0_points)-2]) {
      hull() {
        translate(path56307144703356440_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307144703356440_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56307033_0_points = [[-13.819695,-0.134705],[-10.930203,-1.041384],[-8.172899,-1.613384],[-5.664917,-1.917407],[-3.523388,-2.020155]];

module poly_path56307033(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56307033_0_points)-2]) {
      hull() {
        translate(path56307033_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56307033_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path56302392_0_points = [[8.494777,8.088795],[8.041445,7.707626],[7.286116,7.436030],[5.205183,7.179861],[2.923398,7.236910],[1.112184,7.523795]];

module poly_path56302392(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path56302392_0_points)-2]) {
      hull() {
        translate(path56302392_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path56302392_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

path5630714470619_0_points = [[-3.736792,-13.178965],[-4.642538,-13.043616],[-5.053937,-12.844367],[-5.052841,-12.602645],[-4.721102,-12.339880],[-3.393104,-11.836938],[-1.724759,-11.506975]];

module poly_path5630714470619(h, res=4)  {
  scale([profile_scale, -profile_scale, 1])
  union()  {
    for (t = [0: len(path5630714470619_0_points)-2]) {
      hull() {
        translate(path5630714470619_0_points[t]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
        translate(path5630714470619_0_points[t + 1]) 
          cylinder(h=h, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}

// The outline
path54002100430_0_points = [[13.206317,-2.004865],[11.020408,0.411180],[9.971924,1.772325],[9.580512,2.402231],[9.324022,2.964475],[10.530342,3.530334],[11.866703,4.271712],[13.263524,5.148960],[14.651222,6.122429],[15.960218,7.152469],[17.120929,8.199433],[18.063776,9.223671],[18.719177,10.185535],[16.224163,10.553695],[14.020688,10.687661],[11.885608,10.667624],[9.595781,10.573775],[10.563543,11.743839],[11.601739,12.795421],[12.694965,13.745397],[13.827816,14.610645],[16.150785,16.154467],[18.447416,17.561905],[16.952484,17.269671],[15.462092,16.891581],[13.841148,16.280034],[11.954564,15.287425],[11.059130,15.100452],[10.246256,15.034018],[9.501531,15.059823],[8.810547,15.149567],[7.532163,15.407673],[6.295832,15.581935],[4.698086,15.593155],[3.532353,15.459174],[2.531811,15.187461],[1.429641,14.785485],[0.737070,13.578310],[-0.048960,12.047189],[-0.909996,10.444058],[-1.827586,9.020855],[-3.348927,8.793386],[-4.591543,8.540884],[-6.477111,7.991081],[-7.957297,7.432055],[-9.505111,6.924415],[-11.980593,6.713804],[-14.299064,6.641694],[-16.524075,6.453295],[-17.621393,6.235864],[-18.719177,5.893815],[-17.936908,4.609346],[-17.018768,3.312806],[-15.979518,2.033642],[-14.833918,0.801302],[-13.596727,-0.354765],[-12.282707,-1.405112],[-10.906616,-2.320291],[-9.483215,-3.070855],[-10.661097,-3.545486],[-11.894003,-4.218351],[-13.146128,-5.042210],[-14.381669,-5.969825],[-16.659778,-7.947364],[-18.441898,-9.773055],[-16.374394,-9.750047],[-14.037657,-9.828241],[-11.705237,-10.050715],[-10.626131,-10.229518],[-9.650686,-10.460545],[-9.881640,-10.980456],[-10.207112,-11.497260],[-11.066533,-12.503266],[-12.078797,-13.441999],[-13.093751,-14.276895],[-14.374385,-15.200013],[-15.672811,-15.984995],[-18.515644,-17.561905],[-17.295493,-17.162584],[-16.120455,-16.918968],[-14.983689,-16.793492],[-13.878358,-16.748593],[-11.734644,-16.750271],[-10.682584,-16.721722],[-9.634605,-16.623495],[-8.928955,-16.450876],[-8.182350,-16.176010],[-6.501498,-15.462680],[-5.534862,-15.095786],[-4.462495,-14.769788],[-3.268202,-14.520469],[-1.935789,-14.383615],[-1.008725,-12.866262],[-0.040913,-11.018943],[0.816873,-9.378079],[1.157388,-8.802701],[1.413855,-8.480095],[2.455034,-8.216596],[3.972633,-7.950691],[5.573667,-7.782138],[6.865150,-7.810695],[7.866898,-8.034405],[8.889875,-8.295424],[9.977827,-8.459661],[10.559839,-8.463583],[11.174498,-8.393025],[11.851123,-8.141334],[12.985159,-7.629781],[15.483845,-6.529525],[16.964469,-6.082836],[18.213010,-5.850295],[16.758399,-4.964085],[15.445231,-4.030083],[14.264279,-3.044829],[13.206317,-2.004865],[13.206317,-2.004865]];

module poly_path54002100430(h, res=4)  {
	height = h+base_thick;
  scale([profile_scale, -profile_scale, 1])
  union()  {
	translate([0,0,h-Delta]) {
		linear_extrude(height=base_thick+Delta)
			polygon(path54002100430_0_points);
		}
    for (t = [0: len(path54002100430_0_points)-2]) {
      hull() {
        translate(path54002100430_0_points[t]) 
          cylinder(h=height, r1=min_width, r2=max_width, $fn=res);
        translate(path54002100430_0_points[t + 1]) 
          cylinder(h=height, r1=min_width, r2=max_width, $fn=res);
      }
    }
  }
}



// The shapes
module birds() {
	union() {
		z_offset = (Cookie_mode == "yes") ? wall - Inner_height : 0;
		translate([0,0,z_offset]) {
			poly_path563071936(inner_walls);
			poly_path563071447005(inner_walls);
			poly_path5630719070(inner_walls);
			poly_path56307144706379(inner_walls);
			poly_path5630714470338565(inner_walls);
			poly_path563071447065(inner_walls);
			poly_path5630714470335826(inner_walls);
			poly_path5630714470335267(inner_walls);
			poly_path563043(inner_walls);
			poly_path5626316(inner_walls);
			poly_path5833790(inner_walls);
			poly_path56307625(inner_walls);
			poly_path56307971(inner_walls);
			poly_path56307144703371(inner_walls);
			poly_path562609(inner_walls);
			poly_path5630760494(inner_walls);
			poly_path5630714250(inner_walls);
			poly_path56307144703693(inner_walls);
			poly_path5630714242(inner_walls);
			poly_path5630714470335601(inner_walls);
			poly_path563070191(inner_walls);
			poly_path56307144703353137(inner_walls);
			poly_path5630210(inner_walls);
			poly_path5628690(inner_walls);
			poly_path56307516(inner_walls);
			poly_path56307144703667(inner_walls);
			poly_path5630714450(inner_walls);
			poly_path563075853(inner_walls);
			poly_path56307144841(inner_walls);
			poly_path563071447033507(inner_walls);
			poly_path563071447033812(inner_walls);
			poly_path583305(inner_walls);
			poly_path56307144703358922(inner_walls);
			poly_path5630746(inner_walls);
			poly_path563076195(inner_walls);
			poly_path5630922(inner_walls);
			poly_path5630760449(inner_walls);
			poly_path562483(inner_walls);
			poly_path563071447033936(inner_walls);
			poly_path563071210(inner_walls);
			poly_path563071447818(inner_walls);
			poly_path5630714470335342(inner_walls);
			poly_path5630714470324(inner_walls);
			poly_path563071202(inner_walls);
			poly_path562892(inner_walls);
			poly_path5624129(inner_walls);
			poly_path56307144703356440(inner_walls);
			poly_path56307033(inner_walls);
			poly_path56302392(inner_walls);
			poly_path5630714470619(inner_walls);
		}
	poly_path54002100430(wall);
	poly_path4303(wall);
	}
}

if (show_tesselated == "no") {
	scale([s,s,1])
	rotate([180,0,0])
	translate([0,0,-wall-base_thick])
		birds();
} else {
	// tessellate example
	col = [[1,0,0], [1,1,0], [0,1,1], [1,0,1] ];
	move = [[3,-4.3,0],
			[-5,1.5,0],
			[-5,-5.15,0],
			[3,-11,0]
			];
	translate([0, -Length/3, 0])
	rotate([180,0,0])
	scale([s,s,1])
	for (i=[1:len(move)]) {
		translate(move[i-1])
		// rotate([0,0,i*120])
		color(col[i-1])
		birds();
	}
}