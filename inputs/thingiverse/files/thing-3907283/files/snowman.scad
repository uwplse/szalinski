//Size of bottom?
size=1;

//How big is his tummy
tummy=1;

// How big is his head
head=1;



module snow(){
    

sphere(size, center=true);
bite=size/1.25;

rig=tummy/1.25;
translate([0,0,bite+rig]) 
   sphere(tummy);

hw=head;
translate([0,0,1.5*tummy+bite+hw]) 
   sphere(head);
}

module finalprint(){difference(){
    snow();
      translate([0,0,-60]){cube(100,center=true);
      };
    
 
    }
}


finalprint();

    