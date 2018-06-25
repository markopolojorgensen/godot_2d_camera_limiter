# Fancy Godot Addons

Hopefully the mods approve this submission to the asset library. There's
features that I've got that work as addons, and I want an easy and fast way to
get them into new projects I start up for game jams. It also makes me feel
better about the organization of my code, it's nice to break something out
into a library. It also makes me feel like I'm giving back to the community,
even it the addons are garbage and I'm the only one who uses them :P

#### Camera Limiter

Working on a top-down or sidescroller game and sick of how much of that sweet
sweet camera real estate is outside the level? Fret no more!

This plugin lets you dynamically change the camera's built-in limits smoothly
depending on where your player is currently traveling. When the player enters
a camera-limiting-area, this plugin tweens the camera limits.

It does this by adding two custom nodes: one that you attach to your actual
camera object (composition ftw) that handles the actual tweening, and another
that extends Area2D that you use to configure areas that should have camera
limits in your game world.

