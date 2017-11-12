# iPhone User Performance Tests

Do iPhones really get slower over time, or is it just our imagination? This repository aims to keep records of iPhone performance for various models over time to objectively answer this question.


## Overview

When my iPhone 6+ started getting really slow, I wondered how much of it was real and how much was false nostalgia. I couldn't answer this without seeing how it worked when it was new. I can't go back in time to see that, but I can do the next best thing: record my devices now, and keep a record for the future.

The goal of this test is to be easy to perform while still giving a sense of the speed of some basic tasks. Some important points about its design:

1. It is meant to be performed on a working device, not something freshly wiped just for a test.
2. To that end, apps which might display private info (e.g. Mail, Messages) are avoided.
3. Network access is mostly avoided, since it can differ for reasons beyond the device. The one exception to this is Siri.
4. Times are really approximate. Don't read anything into minor differences.


## I Want to Time My Device!

Here's how to do your own timing with my methodology! If you think your results might be useful to add to the list here, feel free to submit a pull request.

1. Set up a camera that can record your device while you use it. This could be a MacBook camera, another iOS device, or something else. To make things easiest on yourself, suspend the camera above a table somehow, and point it down at the phone sitting on the table.
2. If the table surface is dark, put something light-colored under the device's camera. Part of the test involves the camera, and it's hard to figure out when things happen if the camera picture is pure black.
3. Open [test-plan.txt](test-plan.txt) and read through it so you know what you'll be doing. Follow the preparation steps described at the top.
4. Start recording video.
5. Go through the test plan.
6. Stop recording video.
7. If you want to make the test public, trim out the part where you enter the password, then upload the remainder of the video.
8. `cd` into a local clone of this repository, and run `./record.swift make somefilename.json`.
9. Put in your information, then the time of each event as prompted.
10. The result will be written to the JSON file you specified.
11. To generate Markdown from that file, run `./record.swift read somefilename.json`.


## Results

Here are the recorded measurements:

**Device**: iPhone X running iOS 11.1.1  
**Recording date**: 2017-11-12  
**Video URL**: https://www.youtube.com/watch?v=jAzIGsu-ORs  
**Comment**: The phone was five days old at the time of recording. It was restored from a backup of my old phone.  

| Description | Time Taken |
| :-- | --: |
| **From**: Pressing power button<br/>**To**: Passcode/lock screen appears | 25s |
| **From**: Pressing enter to accept passcode<br/>**To**: Springboard appears | 1s |
| **From**: Settings tapped<br/>**To**: Settings finishes launching | 1s |
| **From**: Home pressed in Settings<br/>**To**: Springboard appears | 0s |
| **From**: Safari tapped<br/>**To**: Safari finishes launching | 1s |
| **From**: Address bar tapped<br/>**To**: The keyboard appears | 1s |
| **From**: Home pressed in Safari<br/>**To**: Springboard appears | 0s |
| **From**: Siri button pressed<br/>**To**: Siri begins listening | 1s |
| **From**: Siri begins processing<br/>**To**: Siri displays the response | 1s |
| **From**: Siri displays the response<br/>**To**: Siri begins speaking the response | 0s |
| **From**: Home button pressed in Siri<br/>**To**: Springboard appears | 0s |
| **From**: Control Center summoned<br/>**To**: Control Center appears | 0s |
| **From**: Camera button tapped<br/>**To**: Camera UI appears | 1s |
| **From**: Camera UI appears<br/>**To**: Camera image appears | 0s |
| **From**: Camera button pressed<br/>**To**: Photo is taken | 1s |
| **From**: New picture tapped<br/>**To**: New picture appears fullscreen | 1s |
| **From**: Home button pressed in Camera<br/>**To**: Springboard appears | 0s |
| **From**: Swipe down on Springboard<br/>**To**: Search appears | 0s |
| **From**: Search appears<br/>**To**: Keyboard appears | 1s |
| **From**: Swipe up on Springboard<br/>**To**: Springboard appears | 0s |

**Device**: iPhone 6+ running iOS 11.1  
**Recording date**: 2017-11-12  
**Video URL**: https://www.youtube.com/watch?v=G5UbM4JP8B0  

| Description | Time Taken |
| :-- | --: |
| **From**: Pressing power button<br/>**To**: Passcode/lock screen appears | 60s |
| **From**: Pressing enter to accept passcode<br/>**To**: Springboard appears | 7s |
| **From**: Settings tapped<br/>**To**: Settings finishes launching | 4s |
| **From**: Home pressed in Settings<br/>**To**: Springboard appears | 4s |
| **From**: Safari tapped<br/>**To**: Safari finishes launching | 4s |
| **From**: Address bar tapped<br/>**To**: The keyboard appears | 3s |
| **From**: Home pressed in Safari<br/>**To**: Springboard appears | 0s |
| **From**: Siri button pressed<br/>**To**: Siri begins listening | 5s |
| **From**: Siri begins processing<br/>**To**: Siri displays the response | 4s |
| **From**: Siri displays the response<br/>**To**: Siri begins speaking the response | 0s |
| **From**: Home button pressed in Siri<br/>**To**: Springboard appears | 0s |
| **From**: Control Center summoned<br/>**To**: Control Center appears | 1s |
| **From**: Camera button tapped<br/>**To**: Camera UI appears | 1s |
| **From**: Camera UI appears<br/>**To**: Camera image appears | 0s |
| **From**: Camera button pressed<br/>**To**: Photo is taken | 1s |
| **From**: New picture tapped<br/>**To**: New picture appears fullscreen | 2s |
| **From**: Home button pressed in Camera<br/>**To**: Springboard appears | 1s |
| **From**: Swipe down on Springboard<br/>**To**: Search appears | 1s |
| **From**: Search appears<br/>**To**: Keyboard appears | 0s |
| **From**: Swipe up on Springboard<br/>**To**: Springboard appears | 0s |

