# SwiftReverseGeoCode

Offline GeoCoding class based on [GeoNames data](https://www.geonames.org).
This package provide a fast and efficient way for translating GPS Coordinate in textual location.

Adapted from [Lucas Spiller](https://github.com/lucaspiller) [offline-geocoder](https://github.com/lucaspiller/offline-geocoder) project. Thanks to him for the clean documentation and explanations. 

## Data

As explain Lucas Spiller, 
" This uses data from the [GeoNames project](http://www.geonames.org/), which is
free to use under the [Creative Commons Attribution 3.0 license](http://creativecommons.org/licenses/by/3.0/).
To enable this to work offline, the data is imported into a SQLite database
which is roughly 12 MB, so easily embeddable within an application. "

## Database Setup

First you should build a sqlite database that contains all the relevant point of interest.

```sh
cd Data
../Script/generate_geonames.sh
```

This script download data on geonames web site, and fill the sql database. In comment you can choose to get only important cities or a full coverage of worldwide location. It's easy to adapt the script to download only one country.

## Usage

The librairy is available within swift package manager. 
the url of the package is
```swift
.package(url: "https://github.com/hlemai/SwiftReverseGeoCode.git", from : "1.0.0"),
```
The name of the librairy is `SwiftReverseGeoCode`.

The result are provided in a LocationDescription Struct. The nearest point of interest in the database is returned.
```swift
let reverseService = ReverseGeoCodeService(database: "path/to/geocitydb.sqlite")

let location = try reverseService.ReverseGeoCode(latitude: 37.78772166666667, longitude: -122.40679166666666)

// location.countryCode == "US"
// location.name == "Chinatown"
```

## License

This library is licensed under **the MIT license**.

You don't need to give this library attribution, but you must do so for
GeoNames if you use their data!
