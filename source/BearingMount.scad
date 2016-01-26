include <configuration.scad>
include <shapes.scad>


module screwMount(thickness = 7, hex=true) {
    difference() {
            hull() {
            translate([-thickness,-(m3_nut_dia)/2-1.5,0])rotate([0,90,0])cylinder(d=m3_nut_dia+3, h=thickness);
            translate([-thickness/2,-0.5,0])cube(size=[thickness,1, m3_nut_dia+12], center=true);
        }
        // screw
        translate([-thickness,-(m3_nut_dia)/2-1.5,0])rotate([0,90,0])cylinder(d=m3_dia, h=thickness);
        //nut
        translate([-thickness-1,-(m3_nut_dia)/2-1.5,0])rotate([0,90,0]) {
            if (hex) {
                cylinder(d=m3_nut_dia, h=3, $fn=6);
            }
            else {
                cylinder(d=m3_nut_dia, h=3, $fn=6);
            }
        }
    }
}

module BearingTube(bearing_od = 15, bearing_h=24, bearing_count=3, wall_thickness = 3) {
    ring_h = 2;
    mount_height = (bearing_h+ring_h)*bearing_count+ring_h;
    module lockRing(h=2){
        rotate_extrude()translate([bearing_od/2-1,1])trapezoid(top=h, base=0.5, h=1);
    }

    difference() {
        union() {
           // tube
            difference() {
                cylinder(d=bearing_od + 2*wall_thickness, h=mount_height);
                cylinder(d=bearing_od, h=mount_height);
                
            }
            // separators for bearings
            for (i=[0:1:bearing_count]) {
                translate([0,0,i*(bearing_h+ring_h)])lockRing(ring_h);
            }
            difference() {
                cylinder(d=bearing_od, h=1);
                cylinder(d=bearing_od-2, h=1);
                
            }
        }
        // slice half off
        translate([0,-bearing_od/2 - wall_thickness,-1])cube([bearing_od+2*wall_thickness, bearing_od+2*wall_thickness, mount_height+2]);
 
    }
    
}

module BearingMount(bearing_od = 15, bearing_h=24, bearing_count=3, hex = true) {
    wall_thickness = 3;
    mount_height = (bearing_h+2)*bearing_count+2;
    
    
    BearingTube(bearing_od = bearing_od, bearing_h = bearing_h, bearing_count = bearing_count, wall_thickness = wall_thickness);
    translate([0,-bearing_od/2,15])screwMount();
    translate([0,-bearing_od/2,mount_height-15])screwMount();
    translate([0,bearing_od/2,15])mirror([0,1,0])screwMount();
    translate([0,bearing_od/2,mount_height-15])mirror([0,1,0])screwMount();
}

