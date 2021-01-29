# All Roads Lead to Traffic
### Where are Tennessee's Roads Being Hit Hardest by Population Growth?

#### MOTIVATION
I’ve had a lifelong passion for the built environment, and how humans have made the Earth more suitable for them. A canyon vista is beautiful - but so, to me, is a city streetscape that echoes the artistic, intellectual, and social DNA of a diverse group of people whose lives have led them to live in close proximity.

It is easy to identify the problems of a growing population and the strains we are putting on the natural world, but it is much more difficult to find solutions for these problems. It is my goal to help build a tool that will allow us to grow efficiently and spending resources unnecessarily. Now, I will be the first to tell you that building roads is not the best solution to that problem. However, we live in the reality that roads are what we’ve got to work with in the state of Tennessee - so until we are able to better diversify our methods of transportation, it is my goal to minimize our waste as much as possible.

#### QUESTIONS GOING IN
When I began this project, I had two goals - 1) Determine whether the state of Tennessee is appropriating funding to areas most likely to see their roads being strained, and 2) Make projections of future commute times for residents (hopefully, to point them in the direction of developing more transit options and transit-friendly developments).

Honestly, I didn’t succeed with either of those goals. I was unable to gather comprehensive data of road construction projects in Tennessee, and ultimately determined that the number of factors that go into projecting commute times were too extensive for me to incorporate into this project. I would rather be honest about what my research can do than overstate its value.

#### DATA COLLECTION AND CLEANING
I started my data collection directly from TDOT and the TN ArcGIS library. Tennessee has an incredibly comprehensive tracking system of daily traffic counts across more than 12,000 locations in the state. Fortunately, this data required little cleaning. I also imported census data of population and commute times, by county.

#### NARROWING DOWN MY SCOPE
Ultimately, I have created an app that will give a user a high-level view of traffic patterns in the state, and also with the ability to zoom in and investigate what is going on at a local level. The goal is for state planners and engineers to identify trends, and use this as one tool in the process of identifying and executing future projects.

#### USER EXPERIENCE
Upon opening the app and reading the homepage, there are three tabs for the user to experience. The first consists of data at the state level, where the user can inspect various factors that lead to and are affected by traffic growth, such as population and commute times. The second tab gives the user the ability to inspect all of the traffic counts within a chosen county. The final tab allows the user to select the roads with the highest levels of increase in traffic growth, and identify regions in the state that are most likely experiencing a high impact by traffic growth.

#### FURTHER STUDY
**Road Capacity and Condition** - Two major influences on the need for road construction are a road’s capacity limits for traffic, as well as the condition of the road. Employees at TDOT were remarkably kind and helpful in providing extremely thorough details of every road segment in the state. I would love to revisit and incorporate this data to give more accurate diagnoses.

**Transit Solutions** - A problem of most Tennessee cities, especially Nashville and its surrounding areas, is that they experienced their highest growth after the advent of cars. Because of this, we do not have existing infrastructure to allow for easily implemented mass transit. Notably, many residential streets in Nashville do not even have sidewalks. I am interested in solving the “last-mile” problem in Nashville - how can we create a comfortable experience for transit users to travel that final segment from the transit station to their front door?

#### LINK TO COMPLETED APP
https://matttparker.shinyapps.io/TnTraffic/
