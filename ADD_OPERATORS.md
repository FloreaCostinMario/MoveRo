# Adding operators

To add an new operator or update an existing one [open an issue](https://github.com/FloreaCostinMario/MoveRo/issues/new) and include the following:

- Name
- County
- App website link (if any)
- Link to PlayStore/AppleStore (if it has any such apps)

## Json structure

> ⚠️ If you are an programer you can easily add more operators by making an pull request with an modified operator list. The list is saved as an json and you can find it [here](https://github.com/FloreaCostinMario/MoveRo/blob/main/config/Operators.json)

```json
{
    "name": "Societatea de Transport Bucuresti", //Operator name
    "county": "Bucuresti - Ilfov", //County
    "zone": { //Zone boundries for geolocation
        "center": { //Center of the zone usually the city center
            "coordinates": [
                26.102778, //Latitude
                44.435408  //Longitude
            ]
        },
        "radius": 40.62 //Zone radius from the center in kilometers
    },
    "viewmode": "WebView", //Decides if the open website link opens in app or in an external browser, right now only WebView has been implemented
    "viewlink": "https://info.stb.ro/", //Link to online
    "packages": {
        //These are the packages names used to detect if the app is already installed and also to link to the respective stores you can find it in the Google Playstore URL for Android
        "android": "ro.stbsa", 
        "ios": null
    },
    "optional": {} //Optional parameters which can be used in future if needed
},
```