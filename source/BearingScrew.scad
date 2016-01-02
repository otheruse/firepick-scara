include <configuration.scad>
include <shapes.scad>

module BearingScrewBM(axis_dia = 8, bearing_od=13, bearing_id=4, bearing_h=5, lead = 3, tension_distance = 0.3) {
    height=nutHeight(bearing_id) + bearing_h + 3 + lead/4;
//    height=40;
    thread_angle = atan(lead/(8*pi));

    // bearing holes
    translate([0,(axis_dia + bearing_od)/2 - tension_distance, -bearing_h*1.5 ])cylinder(d=bearing_od + 2, h=2*bearing_h);
    // bearing
    %translate([0,(axis_dia + bearing_od)/2 - tension_distance, -bearing_h*0.5 ])cylinder(d=bearing_od, h=bearing_h);
    // bearing screw holes
    translate([0,(axis_dia + bearing_od)/2 - tension_distance, -boltDia(bearing_id) ])cylinder(d=boltDia(bearing_id), h=height*2);
    // bearing nut holes
    translate([0,(axis_dia + bearing_od)/2 - tension_distance, height-nutHeight(bearing_id)-1 ])rotate([0,0,-thread_angle])cylinder(d=nutDia(bearing_id), h=height, $fn=6);        
}

module BearingScrew(axis_dia = 8, bearing_od=13, bearing_id=4, bearing_h=5, lead = 3, tension_distance = 0.3, mount_screw = 4) {
    mount_dia = axis_dia + bearing_od*2+ 5;
    height=nutHeight(bearing_id) + bearing_h + 3 + lead/4;
    clamp_width = 20;
    clamp_length = mount_dia/2+7;
    clamp_split = 2;
    
    thread_angle = atan(lead/(8*pi));
    
//    %color([0,0.4,0,1])translate([0,0,-40])cylinder(d=axis_dia, h=80);
    
    translate([0,0,height])rotate([180,0,0]) {
            difference() {
            union() {
                // body
                cylinder(d=mount_dia, h=height);
                // clamp
                translate([-clamp_width/2,0,0])cube(size=[clamp_width, clamp_length, height]);
            }
            // Split
            translate([-clamp_split/2,0,-1])cube(size=[clamp_split, clamp_length, height+2]);
            // Space for axis
            cylinder(d=axis_dia + 4, h=height);
            translate([0,0,lead/16])for (a=[60:120:360]) {
                rotate([0,thread_angle,a]) {
                    BearingScrewBM(axis_dia, bearing_od, bearing_id, bearing_h, lead, tension_distance);
                }
                // Mount holes
                rotate([0,0,a-60])translate([0,mount_dia/2-mount_screw, -1])cylinder(d=boltDia(mount_screw), h=height+2);
            }
            // Larger mount hole in clamp
            for (d=[-clamp_split/2,clamp_split/2]) {
                translate([d,mount_dia/2-mount_screw, -1])cylinder(d=boltDia(bearing_id), h=height+2);
            }
            // clamp screw
            translate([-(clamp_width/2)-1,clamp_length - 5,height/2])rotate([0,90,0])cylinder(d=m3_dia, h=clamp_width+2);
            // screw head
            translate([-(clamp_width/2)-1,clamp_length - 5,height/2])rotate([0,90,0])cylinder(d=m3_nut_dia, h=m3_nut_height+1);
            // nut
            mirror(1,0,0)translate([-(clamp_width/2)-1,clamp_length - 5,height/2])rotate([0,90,0])cylinder(d=m3_nut_dia, h=m3_nut_height+1,$fn=6);

        }
        // print support
       translate([0,0,lead/16])for (a=[60:120:360]) {
            rotate([0,thread_angle,a]) {
                color([1,0,0,1])translate([0,(axis_dia + bearing_od)/2 - tension_distance, height-nutHeight(bearing_id) -1-print_layer_height ])rotate([0,0,-thread_angle])cylinder(d=boltDia(bearing_id)+1, h=print_layer_height);            
                %translate([0,(axis_dia + bearing_od)/2 - tension_distance, height-nutHeight(bearing_id) -1])rotate([0,0,-thread_angle])cylinder(d=nutDia(bearing_id), h=nutHeight(bearing_id));        
            }
         }
     }
}

module BearingScrewMount(axis_dia = 8, bearing_od=13, thickness=3,  base_width = 25) {
    mount_dia = axis_dia + bearing_od*2+5;

    
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
        translate([-(mount_dia/2-thickness),0,thickness])roundedCube([mount_dia-2*thickness, (mount_dia - axis_dia -4)/2+thickness+1, base_width], radius=2);
        // base
        translate([-(mount_dia/2-thickness),0,-base_width])roundedCube([mount_dia-2*thickness, (mount_dia - axis_dia -4)/2+thickness+1, base_width], radius=2);
        // axis hole
        translate([0, (mount_dia)/2+thickness+1,-2])cylinder(d=axis_dia+1, h=thickness+4);
        translate([0, (mount_dia)/2+thickness+1,0])for (a=[0:120:359]) {
            // Mount holes
            rotate([0,0,a+30])translate([0,mount_dia/2-4, -1])cylinder(d=m4_dia, h=thickness+2);
        }
        // Mount holes
        for (i=[1,-1]) {
            for (j=[1,-1]) {
                translate([i*(mount_dia-thickness)/4,1,j*(base_width+thickness)/4+thickness/2])rotate([90,0,0])cylinder(d=m4_dia, h=thickness+2);
            }
        }
    }
}

module BearingScrewAssembly() {
    axis_dia = 8;
    bearing_od = 13;
    bearing_id = 4;
    bearing_h = 5;
    mount_dia = axis_dia + bearing_od*2+5;
    mount_thickness = 4;
    translate([0,0,3])rotate([90,0,0])BearingScrewMount(axis_dia, bearing_od, mount_thickness, 25);
    translate([0,-((mount_dia)/2+2*mount_thickness+1),3])rotate([0,0,90])BearingScrew(axis_dia = axis_dia, bearing_od=bearing_od, bearing_id=bearing_id, bearing_h=bearing_h, lead = 3.2);
    translate([0,-((mount_dia)/2+2*mount_thickness+1),0])rotate([0,180,90])BearingScrew(axis_dia = axis_dia, bearing_od=bearing_od, bearing_id=bearing_id, bearing_h=bearing_h, lead = 3.2);
}

//BearingScrewMount();
//BearingScrewMount(axis_dia = 12, bearing_od=22, thickness = 5, base_width = 40);
$fs=0.3;
$fa=3;
//
//BearingScrewAssembly();
//%color([0,1,1,0.5])cylinder(d=8, h=40);
//
//// 623zz
//BearingScrew(axis_dia = 8, bearing_od=10, bearing_id=3, bearing_h=4, lead = 16, mount_screw = 3);
//
//// 624zz
//translate([40,0,0])BearingScrew(axis_dia = 8, bearing_od=13, bearing_id=4, bearing_h=5, lead = 8);
//
//// 608ZZ
//translate([100,0,0])BearingScrew(axis_dia = 12, bearing_od=22, bearing_id=8, bearing_h=7, lead = 3.2, mount_screw= 8);

