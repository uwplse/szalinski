$fn=90;

plug_d1=7;                  //plug diameter of the neck
plug_d2=7.6;                //plug diameter of the head
plug_h1=3;                  //plug height of the neck
plug_h2=3;                  //plug height of the head

plug_groove_width=.6;       //slot width in the head
plug_groove_height=4;       //slot height in the head
plug_bottom_d=plug_d2 + 3;  //diameter of plug's base
plug_bottom_h=2;            //height of plug's base

socket_d = plug_d2 + 3;     //socket wall thickness 
socket_h = 5;               //socket height
socket_bottom=1;            //thickness of socket's bottom
socket_offset=.3;           //socket's offset to the plug

show_plug=1;                // 1 shows the plug
show_socket=1;              // 1 shows the socket
show_socket_cut=1;          // 1 shows the cross section

module plug(d1,d2,h1,h2,groove_width,groove_height){
    
    difference(){
        union(){
            cylinder(d=d1,h=h1);
            translate([0,0,h1])
            cylinder(d1=d1,d2=d2,h=h2*.25);
            translate([0,0,h1+h2*.25])
            cylinder(d1=d2,d2=d1*.9,h=h2*.75);
        }
        translate([0,0,h1+h2-groove_height])
        union(){
            translate([-d2,groove_width/-2,0])
            cube([2*d2,groove_width,2*groove_height]);
            rotate([0,0,90])
            translate([-d2,groove_width/-2,0])
            cube([2*d2,groove_width,2*groove_height]);
        }
    }

}

module socket(s_d,s_h,p_d1,p_d2,p_h1,p_h2){
    difference(){
        cylinder(d=s_d,h=s_h);
        rotate([180,0,0])
        translate([0,0,-socket_bottom-p_h1-p_h2])
        plug(p_d1,p_d2,p_h1,p_h2,0,0);
    }
}


if (show_socket==1){
    socket(socket_d,socket_h,plug_d1 + socket_offset,plug_d2 + socket_offset, plug_h1, plug_h2);
    
}
 
if (show_plug==1){ 
    translate([0,plug_d2+5,0])
    union(){ 
        cylinder(d=plug_bottom_d,h=plug_bottom_h);
        plug(plug_d1,plug_d2,plug_h1,plug_h2,plug_groove_width,plug_groove_height);
    }
}

if (show_socket_cut==1){
    translate([0,-plug_d2-5,0])
    difference(){
        union(){            
            socket(socket_d,socket_h,plug_d1 + socket_offset,plug_d2 + socket_offset, plug_h1, plug_h2);            
            translate([0,0,plug_h1+plug_h2+socket_bottom+(socket_offset/2)])
            rotate([0,180,0])
            union(){ 
                cylinder(d=plug_bottom_d,h=plug_bottom_h);
                plug(plug_d1,plug_d2,plug_h1,plug_h2,plug_groove_width,plug_groove_height);
            }
        }
        translate([0,-plug_d2,-socket_h/2])
        cube([1*plug_d2,2*plug_d2,2*(socket_h + plug_h2)]);       
    }
}