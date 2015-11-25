include <configuration.scad>
include <shapes.scad>
axis_dia = 8;
bearing_od=13;
bearing_id=4;
bearing_h=5;

lead = 3;

pi = 3.1415926536;
mount_dia = axis_dia + bearing_od*2+4;

module BearingScrew() {
    height=13;
    clamp_width = 20;
    clamp_length = 26;
    clamp_split = 1.5;
    tension_distance = 1;
    
    thread_angle = atan(lead/(8*pi));
    
    translate([0,0,height])rotate([0,180,0])difference() {
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
                // screw holes
                translate([0,(axis_dia + bearing_od)/2 - tension_distance, -m4_dia ])cylinder(d=m4_dia, h=height*2);
                // nut holes
                translate([0,(axis_dia + bearing_od)/2 - tension_distance, 6 ])rotate([0,0,-thread_angle])cylinder(d=m4_nut_dia, h=height, $fn=6);        
            }
            // Mount holes
            rotate([0,0,a-60])translate([0,mount_dia/2-4, 0])cylinder(d=m4_dia, h=height);
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
}

module BearingScrewMount(thickness=3) {
    base_width = 25;
    
    difference() {
        union() {
            // plate
            hull() {
                translate([0, (mount_dia)/2+thickness+1,0])cylinder(d=mount_dia, h=thickness);
                translate([-mount_dia/2,0,0])cube([mount_dia, thickness, thickness]);
            }
            // bump around axis
            translate([0, (mount_dia)/2+thickness+1,-2])roundedCylinder(d=axis_dia+4, h=thickness+4, rr=2);
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
            rotate([0,0,a])translate([0,mount_dia/2-4, 0])cylinder(d=m4_dia, h=thickness);
        }
        // TODO mount holes
        
    }
}
$fs=0.3;
$fa=3;
//BearingScrew();
BearingScrewMount();
    base_width = 25;
