# Noise Statistics Estimation based on adaptive filtering

This repository contains all MATLAB scripts and files related to our work on estimating noise statistics in a room to increase intelligibility of speech in the presence of non-fluctuating noise, fluctuating noise, speech shaped noise, and competing speaker noise. The work is available at [TU Delft Repository](http://resolver.tudelft.nl/uuid:9011b256-576e-48e1-85db-e8bb9eeb6b88) with accompanying information for referencing this document.

![MC0%2C10%2C72](https://user-images.githubusercontent.com/25173878/115594876-8d2a6900-a2d6-11eb-92a6-e4527ebf146f.png)
> **Figure 4.4:**: A Monte Carlo simulation of the normalized LMS with \mu = 0.1 and M = 33 and traditional LMS filter \mu = 0.72 and M = 33. The
upper graph plots the squared error against iterations of the algorithm. The lower graph plots the deviation of the error signal from the
real noise signal, against iterations.



## Abstract

At virtually every public venue, announcements for visitors are made via a public addressing system. It is important that announcements transmitted by means of a public addressing system are not only audible, but also well understood by the general public. This thesis covers one of three subsystems required to make a product that is capable of improving intelligibility of speech based on noise statistics in a room. Moreover, these statistics allow for an automatic volume control in order for listeners to experience an improved audio level. Therefore, this thesis aims at estimating the noise statistics in real time, while prior knowledge on the distorting announcement signal is available. Consequently, the concept of adaptive filtering deems suiting and is extensively studied. In order to meet the real time processing constraint, members of least mean squares algorithms are examined. Therefore, the method of steepest decent is covered, leading to the expounding of the traditional least mean squares (LMS) algorithm and the normalized LMS (NLMS) algorithm. By assessment of the algorithms regarding different step sizes and filter lengths, the NLMS algorithm is shown to be superior in terms of faster convergence speed and better stability characteristics considering similar conditions for both algorithms. Subsequently, the results show that the NLMS is able to estimate the noise in noise-to-signal ratio’s higher than -15dB. Also, its low complexity allows it to be suitable for real time applications, hence meeting the requirements.
