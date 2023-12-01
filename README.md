# Caravel User Project

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)



## Convolution Accelerator ###

This project gives a implementation of a opensource convolution accelerator
The design has two sub designs
A convolution engine and a distributed control memory controller
The engine is intended to be a small in size low in power and performance optimized. 
The project also contains a memory controller that works on distributed pipelined memory control.
The two sub systems combine to form a complete convolution controller 

