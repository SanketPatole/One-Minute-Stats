# One-Minute-Stats


## Introduction

This repository contains the codebase, which I used to generate visualisation videos in portrait mode.
The videos were meant to be uploaded on a YouTube channel called "One Minute Stats" as 1 minute long YouTube shorts.
70% of the code is written in Processing.js and the rest of the 30% of code is written in Python.

YouTube channel: https://www.youtube.com/channel/UCbXj_IJCurIuUZkGN5Sn_YQ

The Python part of the code is used for data processing and the Processing.js part of the code is used for generating  visualisation video frames from the processed data.


## Prerequisites

### Python requirements

* You need to install Python with version 3.0 or more. You can find the latest version of Python at https://www.python.org/downloads/

* You need to have following Python libraries to be installed.
```sh
pip install numpy
pip install pandas
```

### Processing.js requirements

* You need to install latest version of Processing.js from https://processing.org/download

### Quicktime Movie Maker

* The Quicktime Movie Maker comes free with Processing.js IDE. So, make sure that you select Quicktime Movie Maker while installing the Processing.js IDE.


## How to run the code

* You need to clone the repository to your local system. Open command line/terminal or git bash and run following command.
```sh
git clone https://github.com/SanketPatole/One-Minute-Stats.git
```

* Open command line/terminal and go inside any video folder you want to generate video for. For example: "1. Covid Cases"
```sh
cd "1. Covid Cases"
```

* The datafile.csv file contains the raw data to be processed. Run following command to execute Python script for data processing.
```sh
python "Parse_Input.py"
```

Once the raw data is processed, two new files will get generated, values.csv and ranks.csv

* Now open Processing IDE, go inside the sketch folder and open the file with .pde extension. For example: "./Covid_Cases_Ranking/Covid_Cases_Ranking.pde". Note that sketch folder name and pde file name should be exactly same.
```sh
cd "Covid_Cases_Ranking"
```

* Run the sketch by clicking play button in toolbar at top. A window will pop up displaying live status of the exection. Once the execution gets completed, it creates multiple video frmes in "movie" folder.

* Now open Processing.js IDE, click on Tools and select movie Maker. A window will open.

* Browse and select the "movie" folder and click on "Create Movie" button to generate the video from video frames.
