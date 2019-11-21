use <write/Write.scad>


message_one = "Tom VC";
message_two = "Vertex Nano"; //[Velleman,Vertex,Vertex Nano,Vertex Micro,Vertex Delta]



main();

module main() {
font_one_scale = 2;
font_two_scale = 2;
text_height = 2;
Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]
build_plate_length = 70;
build_plate_width = 35;
height = 3;
cornerR = 10;
    
    
    
    
	plateLength = build_plate_length;
	plateWidth = build_plate_width;
	
	translate([-plateLength/2,-plateWidth/2,0])
	difference(){
        //Tekst
			union(){
				translate([plateLength/2,plateWidth-27,height])
					color([1,1,1])
						scale([font_one_scale,font_one_scale,text_height*2])
							write(message_two,space=1.05,center = true,font = Font);
			
				translate([plateLength/2,27,height])
					color([1,1,1])
						scale([font_two_scale,font_two_scale,text_height*2])
							write(message_one,space=1.05,center = true,font = Font);
			
            //plaatje
					translate([cornerR,0,0])
						cube([plateLength-cornerR*2,plateWidth,height]);
					translate([0,cornerR,0])
						cube([plateLength,plateWidth-cornerR*2,height]);
					translate([cornerR,cornerR,0])
						cylinder(h = height, r = cornerR);
					translate([cornerR+(plateLength-cornerR*2),cornerR,0])
						cylinder(h = height, r = cornerR);
					translate([cornerR,cornerR+(plateWidth-cornerR*2),0])
						cylinder(h = height, r = cornerR);
					translate([cornerR+(plateLength-cornerR*2),cornerR+(plateWidth-cornerR*2),0])
						cylinder(h = height, r = cornerR);
				
			}

					translate([plateLength/2,plateWidth/2,0])
						cylinder(h = height, r = 5);

	}
	
}