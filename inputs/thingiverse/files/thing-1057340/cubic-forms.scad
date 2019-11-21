/*
  
   cubic system forms
   
   see http://kitwallace.tumblr.com/tagged/crystal 
   
   Kit Wallace October 2015
   
   doesnt work in Thiniverse customiser - preview is very small 
   
*/

form=5; // [0:cube,1:rhombic dodecahedron,2:tetrahexahedron,3:pentagonal dodecahedron,4:octahedron,5:tetrahedron,6:icositetrahedron,7:triakis tetrahedron,8:triakis octahedron,9:deltoid dodecahedron,10:hexakis octahedron,11:diakisdodecahedron,12:hexatetrahedron,13:pentagonal icositetrahedron,14:tetrahedral pentagonal dodecaheron]



/* [orientation] */
//experimentation needed since size varies with form
size=20; // [1:40] 

// basic functions

function flatten(l) = [ for (a = l) for (b = a) b ] ;

function vcontains(val,list) =
     search([val],list)[0] != [];
       
function distinct(list,dlist=[],i=0) =  // return only distinct items of list
      i==len(list)
         ? dlist
         : vcontains(list[i],dlist)
             ? distinct(list,dlist,i+1)
             : distinct(list,concat(dlist,[list[i]]),i+1)
      ;

function sum(list,i=0) =  
      i < len(list)
        ?  list[i] + sum(list,i+1)
        :  0;

// solid construction
  
module orient_to(centre, normal) {   
      translate(centre)
      rotate([0, 0, atan2(normal.y, normal.x)]) //rotation
      rotate([0, atan2(sqrt(pow(normal.x, 2)+pow(normal.y, 2)),normal.z), 0])
      children();
}

module face(normal, d=1, size=20) {
   orient_to([0,0,0],normal)
       translate([0,0, d + size/2])
            cube([10*size,10*size,size],center=true);
} 

module solid(faces,d=1,color="lightblue",size=5) {
 /* faces is a list of normals (Miller indices)
    d is either a scaler, the distance of each face from the origin or a list of distances, one for each face
 */  
 color(color)
    difference() {
     sphere(size,center=true);
     for(i = [0:len(faces)-1])  {
       face = faces[i];
       fd = len(d) == undef ? d : d[i];
       face(face,d=fd,size=size);
     }
 }
}

// functions to expand a form into faces using eg perms and combs

function perm3(l) =
// lazy until I code general perms with duplicates
 distinct(
   [[l[0],l[1],l[2]],
   [l[0],l[2],l[1]],
   [l[1],l[0],l[2]],
   [l[1],l[2],l[0]],
   [l[2],l[0],l[1]],
   [l[2],l[1],l[0]]
]);
        
function combs(list,n=0) =
   n < len(list)-1
   ? [for (j=list[n])
       for (sl= combs(list,n+1))
           concat(j,sl)
     ]
   : list[n] ;
 
       
function expand(list) =   
// needs a better name
  [for (x= list)
      x== 0 ? 0 : [x,-x]
  ];

// face generators
  
function shift(face,k=1) = [face[k%3],face[(k+1)%3],face[(k+2)%3]];
       
function cycle(face) =
    [face,shift(face,1),shift(face,2)];

function full_symmetry(form) =
   distinct(flatten([for (comb = combs(expand(form))) perm3(comb)]));
  
function tetra_symmetry(form) =
   distinct(flatten([for (face = [form,[form[1],form[0],form[2]]]) combs(expand(face))]));

function gyroid_symmetry(form,even=true) =
    concat(parity_filter(distinct(flatten([for (face = cycle(form)) combs(expand(face))])),even),
           parity_filter(distinct(flatten([for (face = cycle([form[0],form[2],-form[1]])) combs(expand(face))])), ! even)
    );

function opposite(face) =
   [for (a=face) 
       a==0 ? 0 : - a];

function mirror(face) =  [ face,opposite(face)];   

function switch(face) = [face[1],face[0],face[2]];

function trapezohedral_symmetry(form) =
 concat(
    parity_filter(combs(expand(form)),form),
    parity_filter(combs(expand(switch(form))),mirror(form))
    );

// bit of a hack - sb a filter
function rotate_z(form) = [-form[1],form[0],form[2]]; 
   
function rotate_z4(form) = 
   let (mform=[form[0],form[1],-form[2]])
   [form,
    rotate_z(form),
    rotate_z(rotate_z(form)),
    rotate_z(rotate_z(rotate_z(form))),
    mform,
    rotate_z(mform),
    rotate_z(rotate_z(mform)),
    rotate_z(rotate_z(rotate_z(mform))) 
   ];
   
 // filters
           
function parity(face) =
    let(parity = sum( [for (i=face) i > 0 ? 1 : 0]))
    parity % 2 == 0 ;
 
function parity_filter(faces,form) =
    [for (face=faces) if (parity(face) == parity(form) ) face]; 

function unsigned(face) = [abs(face[0]),abs(face[1]),abs(face[2])];

function same_order(form,face) = 
    form == face || form==shift(face) || form==shift(shift(face));

function order_filter(faces,form) =
    [for (face=faces) 
        if (same_order(unsigned(form),unsigned(face))) face
    ];

function hemi_filter(faces,axis,form) =
     let(asign=sign(form[axis]))
     [for (face=faces) 
          if(sign(face[abs(axis)])==asign) face
     ];
          
// face construction      
function filter_faces(form,faces,modifiers,i=0) =
    i < len(modifiers)
       ? let(filter=modifiers[i])
         let(filtered_faces =
             filter=="order"
             ? order_filter(faces,form)
             : filter=="parity" 
             ? parity_filter(faces,form)
             : filter=="hemiz"
             ? hemi_filter(faces,2,form)
             : faces)
         filter_faces(form,filtered_faces,modifiers,i+1)
       : faces;
          
function form_faces(form,base,modifiers) =
    let(base_faces = 
         base=="full" 
       ? full_symmetry(form)
       : base=="tetra" 
       ? tetra_symmetry(form)
       : base=="gyroid"
       ? gyroid_symmetry(form)
       : base=="trapezoid" 
       ? trapezohedral_symmetry(form)
       : base=="mirror"
       ? mirror(form)
       : base=="pedion"
       ? [form]
       : base=="rotate_z4"
       ? rotate_z4(form)
       : [form])
     let(faces = filter_faces(form,base_faces,modifiers) )
     faces;

// crystal rendering
COLORS=["lightpink","lime","aquamarine","khaki","silver","lightsalmon","lightgreen","orange","cadetblue","tan","chartreuse","violet"];

module c_render(crystal) {
    forms=crystal[1];
    intersection_for (i=[0:len(forms)-1]) 
       c_render_part(crystal,i);
}


module c_render_selected(crystal,ds) {
    forms=crystal[1];
    intersection_for (i=[0:len(forms)-1]) {
       if (ds[i] != 0) c_render_part(crystal,i,ds[i]);
           }
}

module c_render_part(crystal,k,ds,label=false) {
    data=crystal[0];
    forms=crystal[1];
    scale(data[1])  
      {
         form_spec=forms[k];     
         form=form_spec[0];
         d = ds==undef ? form_spec[1] : ds;
         base = form_spec[2] == "" || form_spec[2] == undef  ?  data[2] : form_spec[2];
         modifiers=form_spec[3] == undef ? [] : form_spec[3] ;  
         name = form_spec[4] == undef ? "" :   form_spec[4];     
         ci= k % len(COLORS);
         color = COLORS[ci]== undef ? "green" : COLORS[ci];
         faces=form_faces(form,base,modifiers);  
  //       echo(form_spec);
         if(label) color("black") {
             translate([0,0,-3.5]) rotate([45,0,25]) scale(0.05) text(name,halign="center",font="Georgia:style=Regular"   );
             translate([0,0,-4.5]) rotate([45,0,25]) scale(0.05) text(str(form),halign="center",font="Georgia:style=Regular"   );
         }
         echo(name,color,form,d,base,modifiers, len(faces),faces);
         solid(faces,d,color);      
      }  
}

// data
/*
   the data structure has the format:
       [header [form]*]
   header = [name,scale,default_base symmetry,class]
   form =[miller indices, d, base ("" = default_base), [modifiers], name]
   
*/
// Cubic system

cubic_system = [
    ["cubic system",[1,1,1], "full"],
    [
      [[1,0,0],1,"",[],"cube"],
      [[1,1,0],1,"",[],"rhombic dodecahedron"],
      [[1,2,0],1,"",[],"tetrahexahedron"],
      [[1,2,0],1,"",["order"],"pentagonal dodecahedron"],  
      [[1,1,1],1,"",[],"octahedron"],
      [[1,1,1],1,"",["parity"],"tetrahedron"],
      [[2,1,1],1,"",[],"icositetrahedron"],
      [[2,1,1],1,"",["parity"],"triakis tetrahedron"],
      [[2,2,1],1,"",[],"triakis octahedron"],
      [[2,2,1],1,"",["parity"],"deltoid dodecahedron"],
      [[3,2,1],1,"",[],"hexakis octahedron"],
      [[3,2,1],1,"",["order"],"diakisdodecahedron"],
      [[3,2,1],1,"",["parity"], "hexatetrahedron"],
      [[3,2,1],1,"gyroid",[], "pentagonal icositetrahedron"],
      [[3,2,1],1,"",["parity","order"],"tetrahedral pentagonal dodecaheron"]
    ]
];

scale(size)  c_render_part(cubic_system,form);

