// Author: Mixo
// Auxetic unit cell
// v0 dd 14/10/2016
// v1 dd 06/05/2019: removed sphere(*,center=true) -obsolete parameter?-


// *  [ Main parameters] * /


triclinic_or_cubic = 4; // [3:triclinic,3.5:triclinic w/o offset, 4:cubic,99:test]
diam = 1; // tube diameter
cell_size = 10; // h1 default: 10
edgesize = 8; // h2. default 3/4*cell_size
structure_width =  3/4*cell_size; // Default 3/4*cell_size
angle = 79; // alfa. Default 79

n_cells_long = 1; // [1:4] below 5, else long calc
m_cells_wide = 1; // [1:4]
o_cells_tall = 1; // [1:4]

// *  [ Cubic_parameters only] * /
off_plane_skew = 1/2* structure_width; // Default 1/2* structure_width. Not used for triclinic
middle_node_skew = [1/2,-1/2,0]; // Default: off_plane_skew*[1/2,-1/2,0] Not used for triclinic
bottom_node_skew = [0,0,0]; // default: [1,0,0]*off_plane_skew; Not used for triclinic

$fn = 10; // 20-50 

if (triclinic_or_cubic ==4){
cubic_cell_dimensions = [cell_size,cell_size,cell_size];
cubic_lattice();
};


if (triclinic_or_cubic ==3.5){
triclinic_cell_dimensions = [structure_width,structure_width,cell_size-(cell_size-edgesize)/2];

triclinic_lattice_no_shift(triclinic_cell_dimensions);
};    



if (triclinic_or_cubic ==3){ // triclinic 

    stemsize = cell_size/2 + tan(angle-90)*structure_width/2;

triclinic_cell_dimensions = [structure_width,structure_width,cell_size-(cell_size-edgesize)/2-stemsize];
    
shift = [structure_width/2,0,-stemsize-tan(angle-90)*structure_width/2]; // highest density in YZ plane, lower in XZ plane.
    
triclinic_lattice_with_shift(triclinic_cell_dimensions,shift);
};    
module cubic_lattice(cubic_cell_dimensions){
translate(1/2*cubic_cell_dimensions){
for (n = [0:n_cells_long-1]){
for (m = [0:m_cells_wide-1]){
for (o = [0:o_cells_tall-1]){

translate([n*cubic_cell_dimensions.x,m*cubic_cell_dimensions.y,o*cubic_cell_dimensions.z])one_reference_cell();
};};};};
};


module cubic_lattice(cubic_cell_dimensions){
translate(1/2*cubic_cell_dimensions){
for (n = [0:n_cells_long-1]){
for (m = [0:m_cells_wide-1]){
for (o = [0:o_cells_tall-1]){
  echo((n)*(m_cells_wide*o_cells_tall)+(m)*o_cells_tall + o+1, "of",n_cells_long*m_cells_wide*o_cells_tall);// counter...
translate([n*cubic_cell_dimensions.x,m*cubic_cell_dimensions.y,o*cubic_cell_dimensions.z])one_reference_cell();
};};};};
};

module triclinic_lattice_no_shift(triclinic_cell_dimensions){
triclinic_cell_shift = []; //x and y shift at uneven rows.

translate([structure_width/2,structure_width/2,0]){ // shifted in pos quadrant
for (n = [0:n_cells_long-1]){
for (m = [0:m_cells_wide-1]){
for (o = [0:o_cells_tall-1]){
  pos = o-2*floor(o/2); // mod(o,2). Returns 0 on uneven rows, 1 on even.
    echo((n)*(m_cells_wide*o_cells_tall)+(m)*o_cells_tall + o+1, "of",n_cells_long*m_cells_wide*o_cells_tall);// counter...
translate([(n)*triclinic_cell_dimensions.x,m*triclinic_cell_dimensions.y,o*triclinic_cell_dimensions.z])union(){BowTie();
    rotate([0,0,90])BowTie();};
};};};};
};

module triclinic_lattice_with_shift(triclinic_cell_dimensions,shift=[0,0,0]){
triclinic_cell_shift = []; //x and y shift at uneven rows.

translate([structure_width/2,structure_width/2,0]){ // shifted in pos quadrant
for (n = [0:n_cells_long-1]){
for (m = [0:m_cells_wide-1]){
for (o = [0:o_cells_tall-1]){
  pos = o-2*floor(o/2); // mod(o,2). Returns 0 on uneven rows, 1 on even.
    echo((n)*(m_cells_wide*o_cells_tall)+(m)*o_cells_tall + o+1, "of",n_cells_long*m_cells_wide*o_cells_tall);// counter...
translate([(n)*triclinic_cell_dimensions.x+pos*shift.x,m*triclinic_cell_dimensions.y+pos*shift.y,o*triclinic_cell_dimensions.z+pos*shift.z])union(){BowTie();
    rotate([0,0,90])BowTie();};
};};};};
};

module BowTie(){
halfbowTie(cell_size, edgesize, structure_width, angle,diam,[0,0,0],[0,0,0],[0,0,0]);
rotate( [0,0,180])halfbowTie(cell_size, edgesize, structure_width, angle,diam,[0,0,0],[0,0,0],[0,0,0]);

};
//
module one_reference_cell(){
// One cubic direction:
    // Tailored 3D Mechanical Metamaterials Made by Dip-in Direct-Laser-Writing Optical Lithography by  Tiemo Buckmann et al.
    // build based on 
    

cubic_1D(cell_size, edgesize, structure_width, angle,diam,middle_node_skew ,bottom_node_skew);
mirror([1,0,0])cubic_1D(cell_size, edgesize, structure_width, angle,diam,middle_node_skew ,bottom_node_skew);

mirror([0,1,0])cubic_1D(cell_size, edgesize, structure_width, angle,diam,middle_node_skew ,bottom_node_skew);
mirror([0,0,1])cubic_1D(cell_size, edgesize, structure_width, angle,diam,middle_node_skew ,bottom_node_skew);
mirror([0,1,1])cubic_1D(cell_size, edgesize, structure_width, angle,diam,middle_node_skew ,bottom_node_skew);
mirror([1,0,1])cubic_1D(cell_size, edgesize, structure_width, angle,diam,middle_node_skew ,bottom_node_skew);
mirror([1,1,0])cubic_1D(cell_size, edgesize, structure_width, angle,diam,middle_node_skew ,bottom_node_skew);
};

//unit_cell_cubic(cell_size, edgesize,structure_width, angle,diam, middle_node_skew ,bottom_node_skew);
// test
// stemFR(PosFrom=[0,0,0],PosTo=[10,10,0], d=2);

//one_eight(cell_size,d ,startpos,edgepos);


// submodules
module unit_cell_triclinic(){
        
}


module cubic_1D(h_Tot, h_Edge, width, alfa,PipeDiam,middle_node_skew,bottom_node_skew){
// One cubic direction:
    // Tailored 3D Mechanical Metamaterials Made by Dip-in Direct-Laser-Writing Optical Lithography by  Tiemo Buckmann et al.

rotate([0,0,90])translate([0,0,-h_Tot/2])halfbowTie(h_Tot, h_Edge, width, alfa,PipeDiam, middle_node_skew,bottom_node_skew);        
//rotate([0,0,-90])translate([0,0,-h_Tot/2])halfbowTie(h_Tot, h_Edge, width, alfa,PipeDiam,off_plane_skew,off_plane_skew_bottom);
    
rotate([0,90,0]) translate([0,0,-h_Tot/2]) 
halfbowTie(h_Tot, h_Edge, width, alfa,PipeDiam, middle_node_skew,bottom_node_skew);
rotate([180,90,0]) translate([0,0,-h_Tot/2]) halfbowTie(h_Tot, h_Edge, width, alfa,PipeDiam, middle_node_skew,bottom_node_skew);;    

rotate([90,0,0])translate([0,0,-h_Tot/2])
halfbowTie(h_Tot, h_Edge, width, alfa,PipeDiam, middle_node_skew,bottom_node_skew);    
rotate([-90,0,0])translate([0,0,-h_Tot/2])halfbowTie(h_Tot, h_Edge, width, alfa,PipeDiam, middle_node_skew,bottom_node_skew);

}



module stemFR(PosFrom=[0,0,0],PosTo=[0,0,1], d=1)
{
    v = PosTo-PosFrom; // vector of direction.
    
fi = atan2(v.y,v.x); // angle between X and Z
psi =atan2(v.z, sqrt(v.y*v.y+v.x*v.x));
L= sqrt(v.x*v.x+v.y*v.y+v.z*v.z);
angles =   [-fi,psi,0];
// angles calculated based on http://electron9.phys.utk.edu/vectors/3dcoordinates.htm
 //   echo(angle);
translate(PosFrom)mirror([-1,0,1])rotate([-fi,0,0])rotate([0,psi,0]) rotate([0,0,0])cylinder(d=d/2,h=L,center=false);
    
//rotate()stem(PosFrom,angle,length,d);
};
    
module halfbowTie(h_Tot=20, h_Edge=10, width=10, alfa=45,PipeDiam=1, middle_node_delta=[1,0,0], bottom_node_delta = [1,0,1]){
   // Inventor: L. G. Gibson, M. Ashby, Mechanics of cellular solids, Pergamon Oxford, 1988
    // HALFvertical, in positive YZ plane.
    // middle_node_x  is in +X direction
    // top_node_x  is in +X direction
    
    h_stem = (h_Tot-h_Edge)/2 +( tan(-alfa+90)*width  ) ;
    
        
    bottom_node=[bottom_node_delta.x,width/2+bottom_node_delta.y,(h_Tot-h_Edge)/2+bottom_node_delta.z];
    top_node=[bottom_node_delta.x,width/2-bottom_node_delta.y,(h_Tot-h_Edge)/2+h_Edge-bottom_node_delta.z];
    bottom_crossing = [0 ,0,h_stem];
    top_crossing = [0 ,0,h_Tot-h_stem];
    middle_node = [middle_node_delta.x,width/2+middle_node_delta.y,h_Tot/2+middle_node_delta.z];

    // top and bottom connector.
    stemFR([0 ,0,0],bottom_crossing, PipeDiam); 
    stemFR([0 ,0,h_Tot],top_crossing, PipeDiam);  
    
    //diagonals
    stemFR(bottom_crossing,bottom_node, PipeDiam);
    stemFR(top_crossing,top_node, PipeDiam);
    
    // vertical 
   // stemFR(bottom_node,top_node, PipeDiam);
        translate(bottom_node)sphere(d=PipeDiam);
// spheres (to make connections).   
   translate(top_node)sphere(d=PipeDiam);
           translate(top_crossing)  sphere(d=PipeDiam);
           translate(bottom_crossing) sphere(d=PipeDiam);
    
              translate(middle_node)   sphere(d=PipeDiam);
   stemFR(bottom_node,middle_node
    , PipeDiam);
 

   stemFR(top_node,middle_node
, PipeDiam);
     stemFR(top_node,middle_node, PipeDiam); 
    
}


// other sub-programs
module one_arm(rx,ry,rz,d,l)
{

};

module one_hole(rx,ry,rz,d,l)
{
rotate([0,0,rz]) rotate([rx,0,0]) rotate([0,ry,0])cylinder(r=d/2,h=l,center=false);

};
