# Godot 2D Camera Limiter

Working on a top-down or sidescroller game and sick of how much of that sweet
sweet camera real estate is outside the level? Fret no more!

This plugin lets you dynamically change the camera's built-in limits smoothly
depending on where your player is currently traveling. When the player enters
a camera-limiting-area, this plugin tweens the camera limits.

It does this by adding two custom nodes: one that you attach to your actual
camera object (composition ftw) that handles the actual tweening, and another
that extends Area2D that you use to configure areas that should have camera
limits in your game world.
