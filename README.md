# Pause and Breathe: A Relaxation App

Pause and Breathe is a relaxtion app that guides the User through deep breathing exercises to promote calmness. 

Note: Referenced https://www.makeareadme.com/ when writing this README.

##  Features

* Animated circle that expands and contracts with instructions on when to inhale and exhale
* Sliders that allow the User to adjust the length of the inhale and exhale in seconds (minimum 2 seconds, maximum 12 seconds), so long as the exhale is one second longer than the inhale
* Optional soothing background sounds (ocean waves or rain) that cannot play simultaneously
* Optional stopwatch to keep track of how long the User has been breathing for

##  Installation

As of now, Pause and Breathe is not available on the App Store. The only way to run the App is to download the source code and execute it through a simulator in Xcode. Download the Xcode project and unzip the file, if necessary. Then open the file, Pause and Breathe.xcodeproj, in Xcode. Ensure that the version of Xcode is no lower than 10.2 since the App was written with Swift 5. Go to `Product` -> `Destination` and select  `iPhone 11 Pro Max` as the simulator. If this version of the iPhone is not available, older versions should suffice. However, note that a distorted layout is a possibility with older versions of the iPhone. Then, click the play button on the top left corner of the IDE to run the app in a simulator. If the app takes more than 30 seconds to launch and load, quitting Xcode and reopening the project is recommended. 

##  Usage

Upon launch of the App, the animations for the breathing circle and instructions to breathe in or out should begin and will continue until the app is closed. The default inhale length is 4 seconds, and the default exhale length is 6 seconds. The stopwatch should display `00:00:00`, and no audio should be playing. 

The User can manipulate the length of the inhale and exhale with the sliders, but note that the exhale must be at least 3 seconds long if the inhale is 2 seconds long, and the inhale can only be at most 11 seconds long if the exhale is 12 seconds long. The lower limit was set to 2 seconds since a breath for relaxation purposes should not too quick, and the upper limit was set to 12 seconds because it is difficult for most to exhale that slowly. 

If the length of the inhale or exhale is changed, the rate at which the breathing circle expands or contracts should change accordingly. That is, if the inhale is 3 seconds long and the exhale is 6 seconds long, the circle should take 3 seconds to expand fully and 6 seconds to contract fully. If desired, the timer could be used as a rough gauge for the performance of the animated breathing circle. 

Upon pressing either the `Ocean Waves` or `Raindrops` buttons, the appropriate sound should play (i.e., waves crashing onto shore or rain falling outside). The sounds should not be playing simultaneously, and the volume of the sound cannot be adjusted by the volume buttons on the simulator. However, if louder or quieter audio is desired, the volume can be adjusted through the computer itself. 

The stopwatch can be initialized by pressing the `Start` button. The stopwatch can be paused with the `Stop` button that should replace the   `Start` button once pressed. The stopwatch can be reset to `00:00:00` at any time, counting or not. Furthermore, if the User finds the stopwatch too distracting, they can press the `Hide` button to hide the stopwatch. The stopwatch will continue counting when hidden. To show the stopwatch once more, the User can press the same button, which should read `Show`.

##  Support

Feel free to email me (Helen Cho) at hcho@college.harvard.edu if there are any questions, comments, concerns, or recommendations.

##  Roadmap

Future features include
* Countdown timer
* Sound effects specific to the inhale and exhale
* System to send deep breathing reminders throughout the day

##  Acknowledgements

I'd like to thank Brian Yu for advising the creation of the App, Ron Mileikowsky for providing inspiration for this App through his app BioBreathing, which is sadly no longer available in the App Store, and John Sanchez for recommending new features.
