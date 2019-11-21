// Parts gap
gap=0.4;

// Cube radius
cube_radius=1.5;

// Cube size
cube_size=15;

// Cube distance
cube_distance=0.6;

// Link width
link_width=6.0;

// Link thiskness
link_thickness=7.5;

// Link tab len
link_tab_len=4.5;

// Link tab radius
link_tab_radius=1.75;

// ----------------------------------------------------------------------------------

/* [Hidden] */

$fn = 30;

module line(l=10, r=1) {
  sphere(r=r);
  linear_extrude(height=l, center=false, convexity=0, twist=0) {
    circle(r=r);
  }
}

module frame(l=10, r=1) {
    line(l,r);
    translate([0,0,l]) {
        rotate(90,[1,0,0]) {
            line(l,r);
            translate([0,0,l]) {
                rotate(90,[1,0,0]) {
                    line(l,r);
                    translate([0,0,l]) {
                        rotate(90,[1,0,0]) {
                            line(l,r);
                        }
                    }
                }
            }
        }
    }
}

module ccube(l=10, r=1) {
    translate([-l/2,l/2,-l/2]) {
        frame(l=l,r=r);
        translate([l,0,0]) {
            frame(l=l,r=r);
            rotate(90,[0,-1,0]) {
                linear_extrude(height=l, center=false, convexity=20, twist=0) {
                    circle(r=r);
                }
                translate([l,0,0]) {
                    linear_extrude(height=l, center=false, convexity=20, twist=0) {
                        circle(r=r);
                    }
                }
                translate([0,-l,0]) {
                    linear_extrude(height=l, center=false, convexity=20, twist=0) {
                        circle(r=r);
                    }
                }
                translate([l,-l,0]) {
                    linear_extrude(height=l, center=false, convexity=20, twist=0) {
                        circle(r=r);
                    }
                }
            }
        }
        translate([-r, -l, 0]) {
            cube([l+2*r, l, l]);
        }
        translate([0, -l-r, 0]) {
            cube([l, l+2*r, l]);
        }
        translate([0, -l, -r]) {
            cube([l, l, l+2*r]);
        }
    }
}

module link(l=8,r=2,cl=10,cr=1,cd=0.5,tl=1,tr=1) {
    translate([-cl/2-(cr-r),-r+cr+cl/2+(r-tr),-l/2]) {
        linear_extrude(height=l, center=false, convexity=0, twist=0) {
            circle(r=r);
        }
        translate([0,cd+r*2-2*(r-tr),0]) {
            linear_extrude(height=l, center=false, convexity=0, twist=0) {
                circle(r=r);
            }
        }
        translate([-r,0,0]) {
            cube([2*r,cd+r*2-2*(r-tr),l]);
        }
    }
    translate([-cl/2-(cr-r),-r+cr+cl/2,-l/2-tl]) {
        linear_extrude(height=l+tl*2, center=false, convexity=0, twist=0) {
            circle(r=tr);
        }
        translate([0,cd+r*2,0]) {
            linear_extrude(height=l+tl*2, center=false, convexity=0, twist=0) {
                circle(r=tr);
            }
        }
    }
}

module linkhole(l=8,r=2,cl=10,cr=1,cd=0.5,tl=1,tr=1,g=0.3) {
    difference() {
        translate([-g/2-cl/2-(cr-r),-r+cr+cl/2+g/2,-(cl+2*cr)/2-g]) {
            translate([-r,0,0]) {
                translate([-r,0,0]) {
                    cube([2*r,cd+r*2-g,cl+2*cr+2*g]);
                };
            };
        };
        translate([-g/2-cl/2-(cr-r),-r+cr+cl/2+g/2,-(cl+2*cr)/2-2*g]) {
            linear_extrude(height=cl+2*cr+4*g, center=false, convexity=0, twist=0) {
                circle(r=r-g/2);
            }
            translate([0,cd+2*r-g,0]) {
                linear_extrude(height=cl+2*cr+4*g, center=false, convexity=0, twist=0) {
                    circle(r=r-g/2);
                }
            }
         }
    }
    translate([-g/2-cl/2-(cr-r),-r+cr+cl/2+g/2,-l/2]) {
        linear_extrude(height=l, center=false, convexity=0, twist=0) {
            circle(r=r);
        }
        translate([0,cd+2*r-g,0]) {
            linear_extrude(height=l, center=false, convexity=0, twist=0) {
                circle(r=r);
            }
        }
        translate([-r,0,0]) {
            cube([2*r,cd+2*r,l]);
            translate([-r,-r,0]) {
                cube([2*r,cd+r*4-g,l]);
            }
        }
    }
    translate([-cl/2-(cr-r)-g/2,-r+cr+cl/2+g/2,-l/2-tl]) {
        linear_extrude(height=l+tl*2, center=false, convexity=0, twist=0) {
            circle(r=tr);
        }
        translate([0,cd+r*2-g,0]) {
            linear_extrude(height=l+tl*2, center=false, convexity=0, twist=0) {
                circle(r=tr);
            }
        }
    }
}

module row(l=10,r=1,d=0.5,g=0.3) {
    ccube(l,r);
    translate([l+2*r+d,0,0]) {
        ccube(l,r);
        translate([l+2*r+d,0,0]) {
            ccube(l,r);
            translate([l+2*r+d,0,0]) {
                ccube(l,r);
            }
        }
    }
}

module battery(l=10,r=1,d=0.5,g=0.2) {
    rotate(90,[0,0,1]) {
        row(l,r,d);
        translate([0,-(l+2*r+d),0]) {
            row(l,r,d);
        };
    };
}

cl=cube_size-cube_radius*2;
cd=cube_distance;
cr=cube_radius;
l=link_width;
r=link_thickness/2.0;
g=gap;
tl=link_tab_len;
tr=link_tab_radius;

if (true) {
difference() {
    battery(cl,cr,cd);
    {
        rotate(90,[0,1,0]) {
            linkhole(l=l+2*g,r=r+g/2,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr+g,g=g);
            translate([0,0,(cl+cr*2+cd)]) {
                linkhole(l=l+2*g,r=r+g/2,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr+g,g=g);
            };
            translate([0,2*(cl+cr*2+cd)],0) {
                linkhole(l=l+2*g,r=r+g/2,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr+g,g=g);
                translate([0,0,(cl+cr*2+cd)]) {
                    linkhole(l=l+2*g,r=r+g/2,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr+g,g=g);
                };
            };
        };
        rotate(90,[0,-1,0]) {
            rotate(90,[-1,0,0]) {
                linkhole(l=l+2*g,r=r+g/2,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr+g,g=g);
                translate([0,0,3*(cl+cr*2+cd)]) {
                    linkhole(l=l+2*g,r=r+g/2,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr+g,g=g);
                };
            };
        };
        translate([0,cl+cr*2+cd,0]) {
            linkhole(l=l+2*g,r=r+g/2,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr+g,g=g);
            rotate(180,[0,1,0]) {
                translate([-(cl+cr*2+cd),0,0]) {
                    linkhole(l=l+2*g,r=r+g/2,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr+g,g=g);
                };
            };
        };
    };
};
{
    rotate(90,[0,1,0]) {
        link(l=l,r=r,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr);
        translate([0,0,(cl+cr*2+cd)]) {
            link(l=l,r=r,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr);
        };
        translate([0,2*(cl+cr*2+cd)],0) {
            link(l=l,r=r,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr);
            translate([0,0,(cl+cr*2+cd)]) {
                link(l=l,r=r,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr);
            };
        };
    };
    rotate(90,[0,-1,0]) {
        rotate(90,[-1,0,0]) {
            link(l=l,r=r,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr);
            translate([0,0,3*(cl+cr*2+cd)]) {
                link(l=l,r=r,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr);
            };
        };
    };
    translate([0,cl+cr*2+cd,0]) {
        link(l=l,r=r,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr);
        rotate(180,[0,1,0]) {
            translate([-(cl+cr*2+cd),0,0]) {
                link(l=l,r=r,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr);
            };
        };
    };
};
};

//linkhole(l=l+2*g,r=r+g/2,cl=cl,cd=cd,cr=cr,tl=tl,tr=tr+g,g=g);
