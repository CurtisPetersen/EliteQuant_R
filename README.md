# EliteQuant_R
R quantitative trading and investment platform

* [Platform Introduction](#platform-introduction)
* [Project Summary](#project-summary)
* [Participation](#participation)
* [Installation](#installation)
* [Development Environment](#development-environment)
* [Architecture Diagram](#architecture-diagram)
* [Todo List](#todo-list)

---

## Platform Introduction

EliteQuant is an open source forever free unified quant trading platform built by quant traders, for quant traders. It is dual listed on both [github](https://github.com/EliteQuant) and [gitee](https://gitee.com/EliteQuant).

The word unified carries two features.
- First it’s unified across backtesting and live trading. Just switch the data source to play with real money.
- Second it’s consistent across platforms written in their native langugages. It becomes easy to communicate with peer traders on strategies, ideas, and replicate performances, sparing language details.

Related projects include
- [A list of online resources on quantitative modeling, trading, and investment](https://github.com/EliteQuant/EliteQuant)
- [C++](https://github.com/EliteQuant/EliteQuant_Cpp)
- [Python](https://github.com/EliteQuant/EliteQuant_Python)
- [Matlab](https://github.com/EliteQuant/EliteQuant_Matlab)
- [R](https://github.com/EliteQuant/EliteQuant_R)
- [C#](https://github.com/EliteQuant/EliteQuant_CSharp)
- [Excel](https://github.com/EliteQuant/EliteQuant_Excel)
- [Java](https://github.com/EliteQuant/EliteQuant_Java)
- [Scala](https://github.com/EliteQuant/EliteQuant_Scala)
- [Kotlin](https://github.com/EliteQuant/EliteQuant_Kotlin)
- [Go](https://github.com/EliteQuant/EliteQuant_Go)
- [Julia](https://github.com/EliteQuant/EliteQuant_Julia)

## Project Summary

EliteQuant_R is R based multi-threading, concurrent high-frequency trading platform that provides consistent backtest and live trading solutions. It follows modern design patterns such as event-driven, server/client architect, and loosely-coupled robust distributed system. It follows the same structure and performance metrix as other EliteQuant product line, which makes it easier to share with traders using other languages.

## Participation

Please feel free to report issues, fork the branch, and create pull requests. Any kind of contributions are welcomed and appreciated. Through shared code architecture, it also helps traders using other languges.

To contribute,
1. clone source files
2. from RStudio menu, File/Open Project source\EliteQuantR\EliteQuantR.Rproj
3. Make changes
4. from RStudio menu, Build/Build and Reload the project library
5. Make pull request to merge the changes on github

## Installation

1. clone or download the project.
2. open RStudio, install some third-party libraries
    ```R
    install.packages("R6")
    install.packages("Quandl")
    install.packages("tcltk2")
    install.packages("yaml")
    install.packages("rzmq")
    install.packages("PerformanceAnalytics")
    ```
3. from RStudio menu Tools/Install Packages/Install from dropdown menu, choose Package Archive File, and browse to source/EliteQuantR_0.1.0.tar.gz

### Backtest

Configure config_backtest.yaml in the strategy directory 

* ticker: ticker names that are of interest to you
* datasource: historical data source
* hist_dir: local history data directory
* output_dir: output test results directory

Currently it supports data source from

* Quandl
* Local CSV

More data sources will be added later on. To run sample backtest, enter the following in RStudio

```R
library(EliteQuantR)
setwd('D:/Workspace/EliteQuant_R/strategy')      # where you downloaded the project
source('moving.average.cross.strategy.R')
mystrat <- MovingAverageCrossStrategy$new('AMZN')
engine <- BacktestEngine$new(mystrat)
engine$Run()
```

### Live Trading

 Go to server folder, configure config.yaml
 
1. If you want to use interactive broker, open IB trader workstation (TWS), go to its menu File/Global Configuration/API/Settings, check "Enable ActiveX and Socket Client", uncheck "Read-Only API"
2. In the config file, change the account id to yours; IB account id usually can be found on the top right of the TWS window.
3. If you use CTP, change your brokerage account information and ctp addresses accordingly.
4. create folder for log_dir and data_dir respectively. The former records runtime logs, while the later saves tick data.
5. run eqserver.exe

After that, in RStudio enter the following

```R
setwd('D:/Workspace/EliteQuant_R/server')   # where you downloaded the project 
LiveEngine()
```

![Live Demo](/resource/ib_demo.gif?raw=true "Live Demo")

**Interactive Brokers**
is the most popular broker among retail traders. A lot of retail trading platform such as quantopian, quantconnect are built to support IB. If you don't have IB account but want to try it out, they provide demo account edemo with password demouser. Just download TWS trader workstation and log in with this demo account. Note that accound id changes everytime you log on to TWS with demo account so you have to change EliteQuant config file accordingly.

**CTP**
is the de-facto brokerage for Chinese futures market, including commodity futures and financial futures. They also offer free demo account [SimNow](http://simnow.com.cn/). After registration, you will get account, password, brokerid, along with market data and trading broker address. Replace them in EliteQuant config file accordingly.


## Development Environment

Below is the environment we are using
* Windows 10
* R v3.4.1
* RStudio v1.0.153

## Architecture Diagram

Backtest

![Backtest](/resource/Backtest_Diagram.PNG?raw=true "Backtest")

Live Trading

![Live Trading](/resource/Live_Trading_Diagram.PNG?raw=true "Live Trading")

Code Structure

![Code Structure](/resource/code_structure_en.PNG?raw=true "Code Structure")

## Todo List

[Post](http://www.elitequant.com/2017/10/10/elitequant-matlab-one/)