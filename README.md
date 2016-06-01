# jpgGoodies

Add GPS coordinates to the JPG file based on GPX files, which contains trackings from the trip:
======================================================================
`exiftool -v -geotag 'GPXFilesDir/*.gpx' '-geotime<${createdate}+<TimeZOneDiffToGMT>' <SourceJPGfilesDIR>`

List metadata information from a JPG file:
==========================================

 `exiftool -s <SourceJPGFile>`

Format GPX coordinates as floats:
=================================

 `exiftool -c "%+.6f"  <SourceJPGFile>`
 
Use Google Geocoding API to get Address information based on GPS coordinates:
=============================================================================

    1. create GeoCoding API credentials at google page:
          <https://developers.google.com/maps/documentation/geocoding/start>
		  Activate the Google Maps Geocoding API

	   To get you started we'll guide you through the Google Developers Console to do a few things first:

        * Create or choose a project
        * Activate the Google Maps Geocoding API
        * Create appropriate keys -> <KEY>
  
   2.  example of usage
	  `curl -X GET  https://maps.googleapis.com/maps/api/geocode/json?address=1600+Amphitheatre+Parkway,+Mountain+View,+CA&key=<KEY>`
	
		 ` "results" : [
		 {
			"address_components" : [
			   {
				  "long_name" : "1600",
				  "short_name" : "1600",
				  "types" : [ "street_number" ]
			   },
			   {
				  "long_name" : "Amphitheatre Parkway",
				  "short_name" : "Amphitheatre Pkwy",
				  "types" : [ "route" ]
			   },
			   {
				  "long_name" : "Mountain View",
				  "short_name" : "Mountain View",
				  "types" : [ "locality", "political" ]
			   },
			   {
				  "long_name" : "Santa Clara County",
				  "short_name" : "Santa Clara County",
				  "types" : [ "administrative_area_level_2", "political" ]
			   },
			   {
				  "long_name" : "California",
				  "short_name" : "CA",
				  "types" : [ "administrative_area_level_1", "political" ]
			   },
			   {
				  "long_name" : "United States",
				  "short_name" : "US",
				  "types" : [ "country", "political" ]
			   },
			   {
				  "long_name" : "94043",
				  "short_name" : "94043",
				  "types" : [ "postal_code" ]
			   }
			],
			"formatted_address" : "1600 Amphitheatre Pkwy, Mountain View, CA 94043, USA",
			"geometry" : {
			   "location" : {
				  "lat" : 37.4224277,
				  "lng" : -122.0843288
			   },
			   "location_type" : "ROOFTOP",
			   "viewport" : {
				  "northeast" : {
					 "lat" : 37.4237766802915,
					 "lng" : -122.0829798197085
				  },
				  "southwest" : {
					 "lat" : 37.4210787197085,
					 "lng" : -122.0856777802915
				  }
			   }
			},
			"place_id" : "ChIJ2eUgeAK6j4ARbn5u_wAGqWA",
			"types" : [ "street_address" ]
		 }
	  ],
	  "status" : "OK"
      }`

   3.  example of usage GPS coordinates to location info and store the
   result to "out.txt"
   
     `curl -vs -o "out.txt" https://maps.googleapis.com/maps/api/geocode/json?latlng=39.982218,116.388510&key=$KEY`
   
   
     `grep formatted_address out.txt|sed -n 1p`

   4. include Metadata information to <JPGFile>:
   
     `exiftool -UserComment="LocationInfo" -OwnerName=<OwnerName> -CopyRight=<CopyRight> -Artist=<Artist> -ImageDescription=<LocInfo> <JPGFile>`

   5. call addLocation script for all jpg file in the current
      directory:
	  
	 `for i in *.jpg; do ./addLocation.sh $i; done` 
   
