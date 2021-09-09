# SwiftReverseGeoCode

Offline GeoCoding class based on [GeoNames data](https://www.geonames.org).
This package provide a fast and efficient way for translating GPS Coordinate in textual location.

Adapted from [Lucas Spiller](https://github.com/lucaspiller) [offline-geocoder](https://github.com/lucaspiller/offline-geocoder) project. Thanks to him for the clean documentation and explanations. 

## Database Setup

First you should build a sqlite database that contains all the relevant point of interest.

```sh
cd Data
../Script/generate_geonames.sh
```
This script download data on geonames web site, and fill the sql database. In comment you can choose to get only important cities or a full coverage of worldwide location. It's easy to adapt the script to download only one country.

## Usage


