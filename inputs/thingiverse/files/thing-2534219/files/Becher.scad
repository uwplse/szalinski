/* [Top Part Dimensions] */
// height
top_height = 75;
// radius
top_radius = 39;
// number of edges
top_edges = 8;
// number of floors
top_levels = 6;

/* [Bottom Part Dimensions] */
// height
bottom_height = 22;
// radius
bottom_radius = 26.5;
//thickness of the
bottom_thickness = 5;

/* [Wall Dimensions] */
// thickness
wall_thickness = 3;

difference() {
  union() {
    translate([0, 0, bottom_height]) {
      top();
    }
    translate([0,0,bottom_height/2])
      cylinder(r=bottom_radius, h=bottom_height, center=true, $fn=360);
  }
  translate([0, 0, bottom_height+bottom_thickness]) {
    cylinder(r=bottom_radius-wall_thickness, h=bottom_height*2, center=true);
  }
}


module top() {
  faceshilfsarray=[for(i=[0:(top_edges-1)]) i];
  faces1=[
  for (i=[0:(top_levels-1)])
  for (ii=[0:top_edges-1])
  [faceshilfsarray[ii%top_edges]+(i)*top_edges,
  faceshilfsarray[(ii+1)%top_edges]+(i)*top_edges,
  (i+1)*top_edges+faceshilfsarray[(ii%top_edges+((i+1)%2))%top_edges]]
  ];
  faces2=[
  for (i=[0:(top_levels-1)])
  for (ii=[0:top_edges-1])
  [faceshilfsarray[(ii+1)%top_edges]+(i+1)*top_edges,
  faceshilfsarray[ii%top_edges]+(i+1)*top_edges,
  (i)*top_edges+faceshilfsarray[(ii%top_edges+((i)%2))%top_edges]]
  ];
  face_bottom=[for(i=[(top_edges-1):-1:0]) i];
  face_top=[for(i=[top_levels*top_edges:(top_levels+1)*top_edges]) i];

  faces=concat(faces1,faces2,[face_bottom],[face_top]);

  coords=[for(ii=[0:top_levels]) for (i=[1:top_edges]) [top_radius*sin((1-(ii%2)*0.5)*360/top_edges+i*360/top_edges),top_radius*cos((1-(ii%2)*0.5)*360/top_edges+i*360/top_edges),top_height/top_levels*ii]];

  difference() {
    scale([1, 1, 1]) {
      polyhedron(coords,faces,convexity=5);
    }
    difference(){
      translate([0,0,0.001])
      {
        scale([(top_radius-wall_thickness)/top_radius, (top_radius-wall_thickness)/top_radius, 1]) {
          polyhedron(coords,faces,convexity=5);
        }
      }
      translate([0,0,wall_thickness/2])
      {
        cube(size=[top_radius*2, top_radius*2, wall_thickness], center=true);
      }
    }
  }
}
