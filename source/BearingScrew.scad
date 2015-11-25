include <configuration.scad>
include <shapes.scad>


pi = 3.1415926536;

module BearingScrew(axis_dia = 8, bearing_od=13, bearing_id=4, bearing_h=5, lead = 3) {
    mount_dia = axis_dia + bearing_od*2+4;
    height=13;
    clamp_width = 20;
    clamp_length = 26;
    clamp_split = 1.5;
    tension_distance = 0.3;
    
    thread_angle = atan(lead/(8*pi));
    
    translate([0,0,height])rotate([180,0,0]) {
            difference() {
            union() {
                // body
                cylinder(d=mount_dia, h=height);
                // clamp
                translate([-clamp_width/2,0,0])cube(size=[clamp_width, clamp_length, height]);
            }
            // Split
            translate([-clamp_split/2,0,0])cube(size=[clamp_split, clamp_length, height]);
            // Space for axis
            cylinder(d=axis_dia + 4, h=height);
            for (a=[60:120:360]) {
                rotate([0,thread_angle,a]) {
                    // bearing holes
                    translate([0,(axis_dia + bearing_od)/2 - tension_distance, -bearing_h+1 ])cylinder(d=bearing_od + 2, h=bearing_h);
                    %translate([0,(axis_dia + bearing_od)/2 - tension_distance, -bearing_h+1 ])cylinder(d=bearing_od, h=bearing_h);
                    // bearing screw holes
                    translate([0,(axis_dia + bearing_od)/2 - tension_distance, -m4_dia ])cylinder(d=m4_dia, h=height*2);
                    // bearing nut holes
                    translate([0,(axis_dia + bearing_od)/2 - tension_distance, height-4 ])rotate([0,0,-thread_angle])cylinder(d=m4_nut_dia, h=height, $fn=6);        
                }
                // Mount holes
                rotate([0,0,a-60])translate([0,mount_dia/2-4, -1])cylinder(d=m4_dia, h=height+2);
            }
            // Larger mount hole in clamp
            for (d=[-clamp_split/2,clamp_split/2]) {
                translate([d,mount_dia/2-4, 0])cylinder(d=m4_dia, h=height);
            }
            // clamp screw
            translate([-(clamp_width/2)-1,clamp_length - 5,height/2])rotate([0,90,0])cylinder(d=m3_dia, h=clamp_width+2);
            // screw head
            translate([-(clamp_width/2)-1,clamp_length - 5,height/2])rotate([0,90,0])cylinder(d=m3_nut_dia, h=m3_nut_height+1);
            // nut
            mirror(1,0,0)translate([-(clamp_width/2)-1,clamp_length - 5,height/2])rotate([0,90,0])cylinder(d=m3_nut_dia, h=m3_nut_height+1,$fn=6);

        }
        // print support
       for (a=[60:120:360]) {
            color([1,0,0,1])rotate([0,thread_angle,a]) {
                 // bearing nut holes
                translate([0,(axis_dia + bearing_od)/2 - tension_distance, height-4-print_layer_height ])rotate([0,0,-thread_angle])cylinder(d=m4_dia+1, h=print_layer_height);        
            }
         }
     }
}

module BearingScrewMount(axis_dia = 8, bearing_od=13, thickness=3) {
    mount_dia = axis_dia + bearing_od*2+4;

    base_width = 25;
    
    translate([0,0,thickness])rotate([90,0,0])difference() {
        union() {
            // plate
            hull() {
                translate([0, (mount_dia)/2+thickness+1,0])cylinder(d=mount_dia, h=thickness);
                translate([-mount_dia/2,0,0])cube([mount_dia, thickness, thickness]);
            }
            // bump around axis
            translate([0, (mount_dia)/2+thickness+1,-2])roundedCylinder(d=axis_dia+4, h=thickness+4, rr=3);
            // mount plate
            rotate([90,0,0])translate([-mount_dia/2,-(base_width-thickness)/2,0])roundedBox([mount_dia, base_width, thickness], radius=2);
            // base
            translate([0,-5, thickness/2])intersection() {
                rotate([90,0,0])translate([-mount_dia/2,-(base_width)/2,-base_width-5+thickness])roundedBox([mount_dia, base_width, base_width], radius=2);
                rotate([45,0,0])translate([-mount_dia/2,-(base_width)/2,-(base_width)/2])roundedCube([mount_dia, base_width, base_width], radius=2);
            }
        }
        // base
        translate([-(base_width/2+thickness),0,thickness])roundedCube([mount_dia-2*thickness, base_width/2+1, base_width], radius=2);
        // base
        translate([-(base_width/2+thickness),0,-base_width])roundedCube([mount_dia-2*thickness, base_width/2+1, base_width], radius=2);
        // axis hole
        translate([0, (mount_dia)/2+thickness+1,-2])cylinder(d=axis_dia+1, h=thickness+4);
        translate([0, (mount_dia)/2+thickness+1,0])for (a=[0:120:359]) {
            // Mount holes
            rotate([0,0,a+30])translate([0,mount_dia/2-4, -1])cylinder(d=m4_dia, h=thickness+2);
        }
        // Mount holes
        for (i=[1,-1]) {
            for (j=[1,-1]) {
                translate([i*10,1,j*8+thickness/2])rotate([90,0,0])cylinder(d=m4_dia, h=thickness+2);
            }
        }
    }
}

module BearingScrewAssembly() {
    mount_dia = 38;
    translate([0,0,3])rotate([90,0,0])BearingScrewMount();
    translate([0,-mount_dia/2-7,3])rotate([0,0,90])BearingScrew();
    translate([0,-mount_dia/2-7,0])rotate([0,180,90])BearingScrew();
}

//$fs=1;
//$fa=6;
//BearingScrew();
//color([0,1,1,1])cylinder(d=8, h=40);
//BearingScrew(axis_dia = 8, bearing_od=13, bearing_id=4, bearing_h=5, lead = 4);