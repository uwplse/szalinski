// will cut 1/4 of the bearing to look at the internals
look_inside=true;

// Number of rings to generate
num_rings=4;

// inner diameter
inner_diameter=12;
// gap between rings
zgap=0.35;
// connector gap
gap=0.2;
$fn=300;

// thinest part of connector
connector_thin = 1.2;
// thinest part of wall with largest connector hole
wall_thin = 0.8;
// how much connector grip on the upper ring
connector_grip = 0.8;
overhang=45;

// top offset from connector hole
ztop=0.8;

r_connector_inner = connector_thin / 2 + gap/cos(overhang) + zgap*tan(overhang) + connector_grip;
r_connector_outer = r_connector_inner + gap / cos(overhang);
// half wall width
rwall = r_connector_outer + wall_thin;
connector_zoffset = (r_connector_inner - connector_thin/2) / tan(overhang);
zwall = connector_zoffset + r_connector_outer / tan(overhang) + ztop;
dring = inner_diameter + rwall; 


echo("rwall", rwall);
echo(tan(60));

echo("wall size", rwall * 2);

module connector(r) {
  echo("r", r);
  translate([0,0,zwall+connector_zoffset])
  scale([1,1,1/tan(overhang)])
  rotate_extrude(convexity = 10)
  translate([dring/2, 0, 0])
  circle(r = r, $fn=4);
}

module ring(connector,connector_hole) {
difference() {
// add
union() {
  cylinder(d=dring+2*rwall, h=zwall);
  if (connector) {
    connector(r_connector_inner);
  }
};
// remove
union() {
  translate([0,0,-0.05])
  cylinder(d=dring-2*rwall, h=zwall+0.1);
  translate([0,0,-zwall - zgap])
  if (connector_hole) {
    connector(r_connector_outer);
  }
}
}
}


difference() {
union() {
  for (n=[0:1:num_rings-1]) {
      translate([0,0,n * (zwall+zgap)])
      ring(n != num_rings-1, n != 0);
  }  
}
union() {
  if (look_inside) {
    translate([0,-30,-1])
    cube([30,30,30]);
  }
}
}

