include <configuration.scad>
include <shapes.scad>

module HeatbedMount(xdist = 209, ydist=209) {
    support_dia = 16;
    translate([-xdist/2-support_dia/2-2,0])difference() {
        union() {
            hull() {
                translate([xdist/2, ydist/2])circle(d=support_dia);
                translate(-[xdist/2, ydist/2])circle(d=support_dia);
            }
            hull() {
                translate([-xdist/2, ydist/2])circle(d=support_dia);
                translate([xdist/2, -ydist/2])circle(d=support_dia);
            }
            hull() {
                translate([-xdist/2, 0])circle(d=support_dia);
                translate([xdist/2, 0])circle(d=support_dia);
            }
            hull() {
                translate([0, ydist/2])circle(d=support_dia);
                translate([0, -ydist/2])circle(d=support_dia);
            }
//            difference() {
                translate([-xdist/2, -rodspacing/2-20])square([xdist, rodspacing+40]);
//                for (a=[0:90:359]) {
//                    rotate(a)translate([-xdist/2, -rodspacing/2-20])rotate(45)square([40,80], center=true);
//                }
//            }
        }
        // bed mount holes
        for (i = [-1,1]) {
            for (j = [-1,1]) {
                translate([i*xdist/2, j*ydist/2])circle(d=m3_dia);
            }
        }
        for (i = [-1,1]) {
            translate([i*xdist/2, 0])circle(d=m3_dia);
        }
        for (j = [-1,1]) {
            translate([0, j*ydist/2])circle(d=m3_dia);
        }
        // Arm mount holes
        for (j = [-1,1]) {
            translate([xdist/2, j*rodspacing/2])for (i=[-1,1]) {
                translate([-10, i*10])circle(d=m3_dia);
                translate([-120, i*10])circle(d=m3_dia);
            }
        }
        
        // remove some material
        translate([15, -rodspacing/2 + 15])square([xdist/2-40, rodspacing-30]);
        translate([-xdist/2+25, -rodspacing/2 + 15])square([xdist/2-40, rodspacing-30]);
//        polygon([[0,0], [10,0], [10,10]]);
            
    }
}

HeatbedMount();