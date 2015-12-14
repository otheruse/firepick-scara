include <configuration.scad>
include <platform.scad>
include <motorMount.scad>
include <driveWheel.scad>
include <ZMount.scad>
include <pipeSupport.scad>
include <BedStabilizerBracket.scad>
include <BedArm.scad>

module assembly() {
    // base 
    render()linear_extrude(3)base();
    // motor mounts
    color([0.7,0,0,1])render()for (i=[1,-1]) {
        translate([i*(rodspacing/2-10),-60, 4])rotate([90+i*45,-90,0])MotorMount(Height=60+i*10);
    }
    // Zmount 
    color([0,0,0.5,1])render()translate([0,0,3])ZMountBottom(rodspacing = rodspacing, rodsize = rod_diameter, thickness = 3);
    color([0,0.5,0,1])render() {
        // drive wheel
        translate([0,0,60])rotate([0,180,0])beltWheelRod(75);
        // drive wheel
        translate([0,0,70])beltWheelTube(75);
    }
    color([0.7,0.7,0.7,1]) {
        // long support 
        translate([-150,0,3])render()pipeSupportLong();
        translate([150,0,3])rotate([0,0,90])render()pipeSupportLong();
        // short support
        translate([-140,160,3])rotate([0,0,180])render()pipeSupportShort();
        translate([140,160,3])rotate([0,0,180])render()pipeSupportShort();
    }
    // axes
    for (i=[1,-1]) {
        translate([i*rodspacing/2, 0, 6])cylinder(d=rod_diameter, h=platform_height-12);
    }
    // bed bracket
    translate([0,0,300]) {
        rotate([0,180,180])render()ZMountBracket(bearing_diameter = bearing_diameter, bearing_length = bearing_length);
        // Bed arms
        for (i=[1,-1]) {
            translate([i*rodspacing/2,0,0])rotate([0,180,180])render()BedArm(bearing_diameter = bearing_diameter, bearing_length = bearing_length);
        }
    }
}
$fs = 1;
$fa = 6;

assembly();