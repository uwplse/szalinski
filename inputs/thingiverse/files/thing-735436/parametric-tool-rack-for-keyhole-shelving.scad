//width of the shelf
shelf_width = 100;
//radius of the holes
shelf_hole_radius = 3;
//number of holes
num_holes = 8;


//diameter of the large round part of the key hole,make smaller then real (for clearaces)
key_big = 11;
//diameter of the small offshoot from the main key cylinder,make smaller then real (for clearaces)
key_small = 6;

//distance from one key hole to the same point in the next key hole, make slightly bigger then real (for clearaces)
key_spacing = 39;
//thickness of the material the key holes are kut out of, make slightly bigger then real (for clearaces)
key_thickness = 1.75;

//total hight if hook tip, hook width will = half this, hook should be smaller then poke
hook = 10;
//thickness of lugs and support bar
support_thickness = 4;


//calculated
spacer = ((shelf_width - (shelf_hole_radius * 2 * num_holes)) / num_holes) / 2;
poke = (shelf_hole_radius*2)+hook;
hookStart = support_thickness*2+key_thickness;
angle = atan ( hook / poke);
hype = poke + hook;
KBR = key_big/2;
KSR = key_small/2;

module wedge()  {
	translate([0,-key_small,0]) difference() {
		cube([poke,key_small,hook]);
		rotate(a=[0,-angle,0])translate([0,-1,0])cube([hype,key_small+2,hook]);
	}
}

module betterjoints() {
	intersection(){
		translate([0,-KSR,0])cube([key_spacing,key_small,support_thickness*2+key_thickness]);
		cylinder(h= support_thickness*2+key_thickness ,r1 = KBR , r2 = KBR,$fn=36);
	}
}

translate([-KBR- key_spacing/2,-KBR,0]) {		//to centre item on the build platform

  difference() {
    //shelf
    translate([KBR, KBR - (shelf_width/2), hookStart]) {
	    cube([hook/2, shelf_width, poke]);
    }

    //holes
    for ( i = [1 : num_holes ] ) {
      translate([
	      (KBR/2)-(hook/2), 
	      KBR - (shelf_width/2) + (shelf_hole_radius + spacer)*(i *2-1), 
	      hype-(poke/2)+(key_small/2)]) {
	
	      rotate([0, 90, 0]) {
		      #cylinder(h = hook*2, r = shelf_hole_radius);
	      }
      }  
    }
  }


  translate([KBR,KBR - KSR,hookStart]) {		//support bar making and wedge
    translate([poke,0,0])rotate(a=[0,0,180]) wedge();
    translate([0,0,-support_thickness]) cube([key_spacing,key_small,support_thickness]);
  }

  translate([KBR,KBR,0]) {								//post 1
	  cylinder(h= hookStart + poke, r1 = KSR ,r2 = KSR,$fn=36);
	  cylinder(h= support_thickness ,r1 = KBR , r2 = KBR,$fn=36);
	  betterjoints();
	  translate([key_spacing,0,0]){						//post 2
		  cylinder(h= hookStart, r1 = KSR ,r2 = KSR,$fn=36);
		  cylinder(h= support_thickness ,r1 = KBR , r2 = KBR,$fn=36);
		  betterjoints();
		  }
	  }
}
