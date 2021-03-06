# Project Dragonfly

The Project Dragonfly Investigative App is an iOS application used by children to conduct basic scientific experiments. The users  use various tools to collect data. These collections of data are organized into investigations which are further organized into investigation categories. Each investigation can can use a single "type" of tool (currently a counter, stopwatch, and timed counter). Data within an investigation can be visualized into charts. Investigations can be shared via email, text, twitter, etc. This project was written in Swift 3 and developed in XCode 8.0. 

## Getting Started

For future maintenance and development, clone the repo with the link above. Our Project utilizes public iOS projects from Cocoapods. To properly import these into the project, you must first have an up-to-date version of Cocoapods. 

```
$ git clone https://github.com/kochrt/ProjectDragonfly.git
$ gem install cocoapods
$ cd ProjectDragonfly/ 
$ pod install
```

### Prerequisites

\>= XCode 8.0

\>= Swift 3

\>= Cocoapods 1.1.1

## Deployment

#### TestFlight Deployment

## Style and Practices

Style within the app follows https://dragonflyworkshops.org/about/styleguide#

## Built With

Charts https://cocoapods.org/pods/Charts
DZNEmptyDataSet https://cocoapods.org/pods/DZNEmptyDataSet
Eureka https://cocoapods.org/pods/Eureka
FontAwesome https://cocoapods.org/pods/FontAwesome.swift

## Archive and Submit
In order to export as an archive for Testflight testing or App Store submission, make sure you have `Generic iOS Device` selected and that you increment the build and version numbers
![](images/buildtype.png)
![](images/buildversion.png)

Select `Product` -> `Archive`
![](images/archive.png)

Assuming there are no errors, the app will be archived and can then be uploaded to the app store for submission or testing via iTunes Connect. This screen can also be accessed from `Window` -> `Organizer`.
![](images/archives.png)

## Authors

Rob Koch  
Marian Willard  
Zach Eldemire  
Gage Laufenberg  

## License

## Acknowledgments

Pods on Cocoapods
* Martin Barreto and Mathias Claassen -- Eureka
* dzenbot, https://github.com/dzenbot -- DZNEmptyDataSet
* Thi Doan -- FontAwesome.swift
* Daniel Cohen Gindi and Philipp Jahoda, Charts
* etc
