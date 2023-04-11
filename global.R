# for fullPage, first install remotes package
# then using remotes, install fullPage from github
# > install.packages("remotes")
# > remotes::install_github("RinteRface/fullPage")
library(fullPage)
library(highcharter)
library(leaflet)
library(scales)
library(shiny)
library(shinyWidgets)
library(tidyverse)

abb <- read_csv('data/abb.csv')
sbux <- read_csv('data/sbux.csv')
usa <- read_csv('data/usa.csv')
mos <- read_csv('data/mos.csv')

bootColors <- c('success', 'primary', 'warning', 'danger', 'royal')