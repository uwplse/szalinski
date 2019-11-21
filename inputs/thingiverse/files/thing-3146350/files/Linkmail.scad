/* Linkmail: Seamless, modular, parametric, semi-print-in-place, linkable plated chain and scale fabric

I found many remixes of NASA style chainmail but found its creative potential to be lacking since all of them save for one square one, were limited to a small patch that was incapable of being disassembled and linked to another securely. I printed the one square one that could be assemblable, it seemed too XY for my taste. I wanted more tesselation and more degrees of freedom. This does that. Linkmail is a modular parametric mesh system that any size patch of caps and chains can be printed and easily popped together to tightly seal links without the need for certain parts to look different, a seam of sorts, with more flexability in all directions and best of all DESIGNED TO BE PRINTABLE ON ANY FDM 3D PRINTER! However those using Slic3r / Slic3r Prusa Edition are at more of an advantage as some of the parts take advantage of the modifier meshes that the slicer has. It should be possible to even link parts that used different parameters if they are tweaked just slightly enough to provide a seamless gradient. Go nuts and get creative with this stuff because I made it to fill the void in Thingiverse that was a reliable extendable triangluar linking fabric that was easy to put together and difficult to accidentally pull apart. Believe it or not this is my first true from scratch project in OpenSCAD and it took 11 tries just to get the caps to mate with the chains at all. As such be careful when tweaking parameters because there are lots of them that do lots of things. Most could be calculated but I am not the greatest at mathematics with a slightly cumbersome programming language with no runtime like OpenSCAD — yet. Have fun and share your results because this one can get tricky really fast, you might just find some flaws in your slicing settings, and it will probably take a few tries.

These default presets were designed for succesful printing on:
    Origional Prusa i3 MK3,
    Priline PETG, (cheap-ish mid quality PETG)
        From my experiences may want to print a few degrees cooler than normal on at least the chains as I have experienced monsterous and debilitating stringing that severely hinders the function of the parts and makes assembly a pain in the rear, and even more of a pain in the fingers as it will take some force if there is so much stringing.
        Slow and steady wins the edges of the triangles that don't curl up and potentially grab onto the nozzle pulling the whole thing off of the bed EVEN WItH A RAFT and turn the whole print into a horrible mess of a blob half way through. Support material can stop this too but could cause other postprocessing headaches.
        other slicer settings I used while designing this I will eventually put in another git repo since with PETG printing something this complex and structural proved a very daunting task.
    Raft on tops and chains but the tops would probably benefit from the decrease in potential debris that would come from no raft and some brim.
    Support material on chains. If the tops are printed with supports it will probably put a bunch in the peg hole. (Slic3r especially)
    This was designed with the special features of slic3r in mind. The skirt option is designed specifically to be used as a modified part that prints at the same speed as slic3r PE's default "sacrificial skirt" or around that number.
The default presets could potentially work with other materials that have comparable durability and resistance to shearing and twisting forces that does not warp signifficantly. Maybe PLA could work too but may end up incredibly fragile but could have less need for beveling.
    »» WORD OF WARNING! ««
A lot of these parameters available in this configurable section are more intermediate parameters that are used in the calculation of various aspects of the form and structure of the parts and as a result, changing some parameters can potentially have unexpected or undesirable effects on the arrangement of the many shapes that create the assembly. if you discover a stable set of parameters that works for your printer, filament, environment, etc. I would love to know and i'm sure many others would too because from scratch it took me 11 tries to get the caps to go on the chains, excluding getting them to stay on firmly until they are intentionally seperated. You ahve been warned.
*/

// Configurables
//  Did I mention some of these may have unexpected or unwanted results.

// General
nx = 3; // Number of copies of the part in the x direction
ny = 2; // Number of copies of the part in the y direction
capSize=6; // Size of the caps at their thickest point. (before beveling)
spacing=1.5; // Space between copies of the part. if parameters that effect the links are modified this value will likely need adjustment as this value plays hand in hand with the calculation of the flareAngle on the link rings. It tries its best to make it fit.

// Connector pin: USE WITH CAUTION BECAUSE IF THEY ARE SLIGHTLY OFF THE CAPS PROBABLY WON'T GO ON THE CHAINS OR MAY FALL OFF OF THEM OR COULD BREAK THE RIVET INSIDE THE CAP, BREAK THE PIN OFF THE CHAIN, OR BREAK OR SEVERELY WEAKEN THE STRENGTH OF THE LINK RINGS IF THEIR SETTINGS ARE TOO LOW!
pinHeight=2.4; // How high the core cylinder (shaft) of the pin should be. NOTE: shouldn't be greater than the height of the cap assembly minus one (if your feelin' lucky and confident with your filament) or two times your layer height settings you will use in your slicer.
pinLipHeight=1.5; // how high should the lip of the pin be, play with this as with the correlating geometries of the pin core and pin bulb can sometimes be a bit odd with the wrong pinLipScale
pinRadius=.8; // The radius of the pin core
pinBulbRadius=0.925; // The radius of the sphere at the top of the pin
pinTolerance=.05; // How much extra space to add to the dimensions of the pin inside the cap to allow it to easily be popped on. it is possible for other parameters to make this setting be ineffective at allowing the pin to seat correctly
pinLipScale=.5; // Scale of the pin lip, this is what makes the pin lip geometry tricky
pinRivetScale=1; // scale of the expandable rivet inside of the pin that locks it in place. May be useful in different ways with different settings
pinLipRadius=1.3; // radius of the pin lip
pinRivetGap=0.2; // how big is the gap in the rivet

// Caps
capHeight=1; // How thick the cap should be, use it wisely as it will effect some aspects of the links. FIXME: changing this may have too much of an effect to be set to a purely aesthetic or extreme value.
capScale=.5; // Scale of the top part of the cap. By default this value is .5 for 2 reasons, it looks cooler (in my opinion) and more streamlined compared to everyone elses flat topped ones, and it also helps prevent the thickness of the caps limiting the flexability of the mesh. NOTE: the flexability increase can be bruitally murdered if capSpacerHeight is set too high.
connectorHeight=2; // How high is the connector plate. DRAMATICALLY EFFECTS THE ENTIRE ASSEMBLY! Especially the way the rings meet the caps.
connectorScale=.75; // scale to curve the connector plate from top to bottom, (scale at top = 1, scale at bottom = connectorScale)
capBevel=0.5; // How much should the cap be beveled. If you have issues with the edges of the caps warping/curling upwards this is the best way to fight it! Plus it looks kind of cool. :)
capBevelRes=9; // How many edges should the bevel use ($fn=capBevelRes) for beveling the caps.
capSpacerHeight=.3; // how large should the cap spacer be. This is most useful for combating warping of the edges of the caps but if set too thick may compromise the flexability when it is bent concave

protrusion=0.0; // how much should the rings allow the caps to protrude from the point they meet. POC: for now don't use because it doesn't work quite as expected/desired

// Chains
hubHeight=1.5; // height of the small part at the core of the chains that holds the assembly stable. It is relatively safe to edit this parameter
hubScale=.75; // scale of the hub peice from bottom to top
hubSize=3;// size of the central gap of the chains
spineHeight=4.5; // height of the major assembly of links and the height of the spine support
spineScale=.4; // scale of the spine support
spineBase=1; // radius of the spine support at the base
hubCapSize=2; // size of the central hub part
linkDiameter=.8; // diameter of the circle that gets extruded into the link rings
donutDiameter=.85; // diameter of the base donut
donutSize=linkDiameter*(2*PI/3); // advised not to change this unless you know what would provide better lateral support and space for future fittings
donutOffset=0; // offset of the donut. not very useful

// Support material

// Generally relevant
contractZDistance=0.2; // for spine support beam, same as it is in Slic3r

// Top relevant
generateSkirts=false; // generate small mini skirts around each of the tops in an effort to prevent warping at the tips. TIP: to avoid getting this stupid wrong and not having them show up enable Detect thin walls setting in the slicer
skirtWidth=0.6; // try to set this as close to the width of the skirt generated by the slicer
skirtHeight=0; // height of the enclosure skirt, set to 0 to use the height of the entire top
skirtDistance=.5; // seperation between cap and skirt

// Chain relevant
generateSpine=false; // Generate a support spine so that the hub can be printed on FDM printers hassle (slic3r overcompensating even if the threshold is set to 90°)


// Assembly

topOnly=false; // if assembled and printCapAndChain are both false this value controls if the stl it will create is for the caps or for the chains
    // true = caps
    // false = chains
    // ONLY IF assembled & printCapAndChain ARE FALSE!
modifiersOnly=false; // only render the support structure, convenient for slic3r modifier meshes so they can be printed to emulate support material
printCapAndChain=false; // POC: does weird things
assemble=true; // FOR DISPLAY PURPOSES ONLY!! NOT ACTUALLY DESIGNED TO BE COMPLETELY PRINT IN PLACE

for(y=[0:1:ny-1]){
    for(x=[0:1:nx-1]){
         
        dx=x*(spacing+capSize)*cos(30);
        y1=pow(-1,y)*pow(-1,x)*sin(30)/2;        
        dy=(capSize+spacing)*(y1+y*1.5);
         
        translate([dx,dy,0]) {
            rotate([0,0,30*pow(-1,x)*pow(-1,y)]) {
                if (assemble==true) {
                    make_chain();
                    translate([0,0,spineHeight])              make_cap();
                } else if (printCapAndChain==true && assemble==false) {
                    translate([dx*nx*-.5,dy*ny*-.5,0]) make_chain();
                    translate([dx*nx*.5,dy*ny*.5,0]) make_cap();
                };
                if (topOnly==true && printCapAndChain==false && assemble == false) {
                    make_cap();
                } else if (topOnly==false && printCapAndChain==false && assemble==false) {
                    make_chain();
                };
            }
        };
    }
}

module bevel(r) {
    offset(r=r) {
        offset(delta=-r) {
            children();
        }
    }
}

module plate() {
    render() linear_extrude(height=capHeight,scale=capScale) bevel(r=capBevel,$fn=capBevelRes) circle(r=capSize,$fn=3);
};

module spacer_plate() {
    render() linear_extrude(height=capSpacerHeight) bevel(r=capBevel,$fn=capBevelRes) circle(r=capSize,$fn=3);
};

module popper() {
    linear_extrude(height=.25,scale=.5);
};

module rivet_gap() {
    linear_extrude(height=pinLipHeight) square([(pinLipRadius)*2,0.3],center=true);
}

module pop_rivet_gaps() {
    rivet_gap();
    rotate(60) rivet_gap();
    rotate(120) rivet_gap();
}

module pop_rivet() {
    difference() {
        linear_extrude(height=pinLipHeight,scale=pinRivetScale)
        circle(r=pinLipRadius+(pinRivetGap),$fn=6);
        linear_extrude(height=pinLipHeight,scale=pinRivetScale) circle(r=pinLipRadius,$fn=6);
    };
}

module pop_pin(withSpace=false) {
    if (withSpace == false) {
        render() union() {
            linear_extrude(height=pinHeight) circle(r=pinRadius,$fn=6);
            linear_extrude(height=pinLipHeight,scale=pinLipScale) circle(r=pinLipRadius,$fn=6);
            translate([0,0,pinHeight-(pinBulbRadius*1/2)]) sphere(r=pinBulbRadius,$fn=6);
        }
    } else {
        render() union() {
            linear_extrude(height=pinHeight+pinTolerance) circle(r=pinRadius+pinTolerance,$fn=6);
            linear_extrude(height=pinLipHeight+pinTolerance,scale=pinLipScale) circle(r=pinLipRadius+pinTolerance,$fn=6);
            translate([0,0,pinHeight-(pinBulbRadius*1/2)+pinTolerance]) sphere(r=pinBulbRadius+pinTolerance,$fn=6);
        }
    }
};

module connector_plate() {
    mirror([0,0,1]) linear_extrude(height=connectorHeight,scale=connectorScale,$fn=3) bevel(r=capBevel,$fn=capBevelRes) circle(r=capSize,$fn=3);
    
};


module make_cap(skirtOption=true) {
    if (modifiersOnly == false) {
       difference() { union() {
    translate([0,0,connectorHeight]) connector_plate();
    translate([0,0,connectorHeight]) spacer_plate();
    translate([0,0,connectorHeight+capSpacerHeight]) plate();};if (skirtOption==true) translate([0,0,2*(pinHeight-pinBulbRadius)/3]) pop_rivet();
    
    if (skirtOption==true) {
        pop_pin(withSpace=true);
    } 
    if (skirtOption==true) {
        translate([0,0,2*(pinHeight-pinBulbRadius)/3]) pop_rivet_gaps();
    }
    };};
    if (generateSkirts==true && skirtOption==true && assemble==false) {
        render() difference() {
            linear_extrude(height=capHeight+capSpacerHeight+connectorHeight) bevel(r=capBevel,$fn=capBevelRes) circle(r=capSize+skirtDistance+skirtWidth,$fn=3);
            linear_extrude(height=capHeight+capSpacerHeight+connectorHeight) bevel(r=capBevel,$fn=capBevelRes) circle(r=capSize+skirtDistance,$fn=3);
        }
    }
};

module spine() {
    linear_extrude(height=spineHeight-hubHeight-contractZDistance,scale=spineScale) circle(r=spineBase,$fn=3);
};

module rings(a) {
 render()
 rotate_extrude(angle=360,$fn=30) translate([((connectorHeight+spineHeight)/2)-(linkDiameter/2)+(donutDiameter/2),0]) circle(linkDiameter,$fn=9);
}

module donut() {
      render()
      rotate_extrude(angle=360,$fn=16) translate([donutSize,0]) circle(r=donutDiameter,$fn=8);
}

module hub() {
    union() {
    linear_extrude(height=hubHeight,scale=hubScale) circle(r=hubCapSize,$fn=3);
    translate([0,0,hubHeight]) pop_pin();
    };
}

function cot(x) = 1/tan(x); // Cotangent: looks a little better in the function plus I wanted to figura out openSCAD functions

module make_rings() {
    protrusionCap = protrusion != 0 ? abs(cot( (capSize - (capSize*connectorScale)) / (protrusion*2))) : capSize;// if anyone comes up with the correct way to do this, don't hesitate to tell me or make a pull request with a more functional function.
    echo(protrusionCap);
    ha = capHeight+capSpacerHeight+connectorHeight+spineHeight-protrusion;
    hs = protrusionCap+(spacing/2);//+hubSize;
    flareAngle=atan(ha/hs);
    echo(flareAngle);
    for (r=[60:60:180]) {
        color([60/r,60/r,60/r,1])
        rotate([0,0,r*2])  
        translate([-hubSize/(2*PI/3),0,(connectorHeight+spineHeight)/2])
        rotate([flareAngle,00,0]) 
        rings();
    };
};


module make_chain() {
    if (generateSpine==true) {
        color([1,.5,0,1]) spine();
    };
    color([1,0,0,1]) translate([0,0,donutDiameter+donutOffset])donut();
    color([0,0,1,1]) translate([0,0,spineHeight-hubHeight]) hub();
    
    
    difference() {
        make_rings();
        translate([0,0,spineHeight]) color([0,1,0,.5])make_cap(skirtOption=false);
    };
    //translate([0,0,-8]) pop_pin();
    //spine();
};