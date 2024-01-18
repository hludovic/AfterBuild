#!/bin/zsh
# rebdatabase.sh

if [ "$1" = "-t" ];
then
    open https://icloud.developer.apple.com/dashboard/home
	xcrun cktool save-token
	exit
fi

echo "Clear database ..."
xcrun cktool reset-schema \
--team-id  W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild

echo "Rebuild model database ..."
xcrun cktool import-schema \
--team-id  W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--file cloudkit-development.ckdb

echo "Writing the database ..."
echo -ne ' Progress: |██------------------|  10% Complete\r'
xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type SpotLocation \
--fields-json '{
  "websiteURL": {
    "value": "https://www.osf.com/location/san-jose-ca/",
    "type": "stringType"
  },
  "address": {
    "type": "stringType",
    "value": "51 N San Pedro St"
  },
  "name": {
    "value": "The Old Spaghetti Factory",
    "type": "stringType"
  },
  "description": {
    "type": "stringType",
    "value": "The Old Spaghetti Factory has been proudly serving delicious 3 course meals since 1969. Family owned and operated, we’re committed to exceptional service."
  },
  "bannerAsset": {
    "type": "assetType",
    "value": "SPAGHETTI_BANNER_ASSET"
  },
  "phoneNumber": {
    "value": "408-288-7488",
    "type": "stringType"
  },
  "squareAsset": {
    "type": "assetType",
    "value": "SPAGHETTI_SQUARE_ASSET"
  },
  "location": {
    "value": {
      "latitude": 37.335905,
      "longitude": -121.893981
    },
    "type": "locationType"
  }
}' \
--asset-files SPAGHETTI_BANNER_ASSET=location-images/spaghetti-banner.jpg SPAGHETTI_SQUARE_ASSET=location-images/spaghetti-square.jpg \
> /dev/null 2

echo -ne ' Progress: |████----------------|  20% Complete\r'
xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type SpotLocation \
--fields-json '{
  "squareAsset": {
    "type": "assetType",
    "value": "CHIPOTLE_SQUARE_ASSET"
  },
  "websiteURL": {
    "value": "https://locations.chipotle.com/ca/san-jose/1-s-market-st",
    "type": "stringType"
  },
  "description": {
    "type": "stringType",
    "value": "It'\''s Chipotle. Enough said."
  },
  "address": {
    "value": "1 S Market St Ste 40",
    "type": "stringType"
  },
  "name": {
    "value": "Chipotle",
    "type": "stringType"
  },
  "bannerAsset": {
    "value": "CHIPOTLE_BANNER_ASSET",
    "type": "assetType"
  },
  "phoneNumber": {
    "type": "stringType",
    "value": "408-938-0919"
  },
  "location": {
    "type": "locationType",
    "value": {
      "latitude": 37.334967,
      "longitude": -121.892566
    }
  }
}' \
--asset-files CHIPOTLE_BANNER_ASSET=location-images/chipotle-banner.jpg CHIPOTLE_SQUARE_ASSET=location-images/chipotle-square.jpg \
> /dev/null 2

echo -ne ' Progress: |██████--------------|  30% Complete\r'
xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type SpotLocation \
--fields-json '{
  "bannerAsset": {
    "value": "ACLOUNGE_BANNER_ASSET",
    "type": "assetType"
  },
  "phoneNumber": {
    "value": "408-924-0900",
    "type": "stringType"
  },
  "squareAsset": {
    "type": "assetType",
    "value": "ACLOUNGE_SQUARE_ASSET"
  },
  "websiteURL": {
    "value": "https://www.marriott.com/hotels/hotel-information/restaurant/sjcac-ac-hotel-san-jose-downtown/",
    "type": "stringType"
  },
  "description": {
    "value": "Thrill your palate with diverse and delectable dining for breakfast and dinner at AC Kitchen & Lounge.",
    "type": "stringType"
  },
  "location": {
    "type": "locationType",
    "value": {
      "longitude": -121.895999,
      "latitude": 37.333311
    }
  },
  "name": {
    "type": "stringType",
    "value": "AC Kitchen & Lounge"
  },
  "address": {
    "type": "stringType",
    "value": "350 W Santa Clara St"
  }
}' \
--asset-files ACLOUNGE_BANNER_ASSET=location-images/ac-lounge-banner.jpg ACLOUNGE_SQUARE_ASSET=location-images/ac-lounge-square.jpg \
> /dev/null 2

echo -ne ' Progress: |████████------------|  40% Complete\r'
xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type SpotLocation \
--fields-json '{
  "phoneNumber": {
    "value": "408-283-9595",
    "type": "stringType"
  },
  "location": {
    "value": {
      "latitude": 37.334233,
      "longitude": -121.889657
    },
    "type": "locationType"
  },
  "websiteURL": {
    "value": "https://mezcalrestaurantsj.com/",
    "type": "stringType"
  },
  "address": {
    "value": "25 W San Fernando St",
    "type": "stringType"
  },
  "squareAsset": {
    "value": "MEZCAL_SQUARE_ASSET",
    "type": "assetType"
  },
  "bannerAsset": {
    "type": "assetType",
    "value": "MEZCAL_BANNER_ASSET"
  },
  "name": {
    "value": "Mezcal Restaurant",
    "type": "stringType"
  },
  "description": {
    "type": "stringType",
    "value": "Mezcal Restaurant specializes in three Oaxacan sauces – Estofado, Coloradito and Mole Negro – all family recipes that have been passed down generations."
  }
}' \
--asset-files MEZCAL_BANNER_ASSET=location-images/mezcal-banner.jpg MEZCAL_SQUARE_ASSET=location-images/mezcal-square.jpg \
> /dev/null 2

echo -ne ' Progress: |██████████----------|  50% Complete\r'
xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type SpotLocation \
--fields-json '{
  "address": {
    "type": "stringType",
    "value": "200 S 1st St #10"
  },
  "websiteURL": {
    "type": "stringType",
    "value": "https://www.scottsseafoodsj.com/"
  },
  "bannerAsset": {
    "type": "assetType",
    "value": "SCOTTS_BANNER_ASSET"
  },
  "phoneNumber": {
    "type": "stringType",
    "value": "408-971-1700"
  },
  "description": {
    "type": "stringType",
    "value": "Scott'\''s Seafood has been a Bay Area Tradition since 1976. Scott'\''s Seafood is known for some of the best and freshest seafood on the West Coast."
  },
  "name": {
    "type": "stringType",
    "value": "Scott'\''s Seafood"
  },
  "squareAsset": {
    "value": "SCOTTS_SQUARE_ASSET",
    "type": "assetType"
  },
  "location": {
    "type": "locationType",
    "value": {
      "longitude": -121.887956,
      "latitude": 37.332856
    }
  }
}' \
--asset-files SCOTTS_BANNER_ASSET=location-images/scotts-banner.jpg SCOTTS_SQUARE_ASSET=location-images/scotts-square.jpg \
> /dev/null 2

echo -ne ' Progress: |████████████--------|  60% Complete\r'
xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type SpotLocation \
--fields-json '{
  "location": {
    "value": {
      "longitude": -121.891437,
      "latitude": 37.328625
    },
    "type": "locationType"
  },
  "phoneNumber": {
    "value": "408-795-1200",
    "type": "stringType"
  },
  "squareAsset": {
    "type": "assetType",
    "value": "GRACE_SQUARE_ASSET"
  },
  "websiteURL": {
    "value": "https://grace303.com/",
    "type": "stringType"
  },
  "bannerAsset": {
    "value": "GRACE_BANNER_ASSET",
    "type": "assetType"
  },
  "name": {
    "value": "Grace Deli & Cafe",
    "type": "stringType"
  },
  "description": {
    "type": "stringType",
    "value": "The menu is inspired by fresh ingredients, and each sandwich is tastefully handcrafted upon order. Warm homemade soups and organic salads."
  },
  "address": {
    "type": "stringType",
    "value": "303 S Almaden Blvd"
  }
}' \
--asset-files GRACE_BANNER_ASSET=location-images/grace-banner.jpg GRACE_SQUARE_ASSET=location-images/grace-square.jpg \
> /dev/null 2

echo -ne ' Progress: |██████████████------|  70% Complete\r'
xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type SpotLocation \
--fields-json '{
  "squareAsset": {
    "value": "JOES_SQUARE_ASSET",
    "type": "assetType"
  },
  "name": {
    "type": "stringType",
    "value": "Original Joe'\''s"
  },
  "description": {
    "value": "We specialize in traditional, authentic Italian food, prepared as our family always has, & served with San Francisco flair & a smile!",
    "type": "stringType"
  },
  "bannerAsset": {
    "value": "JOES_BANNER_ASSET",
    "type": "assetType"
  },
  "location": {
    "type": "locationType",
    "value": {
      "longitude": -121.887122,
      "latitude": 37.331219
    }
  },
  "phoneNumber": {
    "type": "stringType",
    "value": "408-292-7030"
  },
  "websiteURL": {
    "type": "stringType",
    "value": "https://www.sanjoseoriginaljoes.com/"
  },
  "address": {
    "type": "stringType",
    "value": "301 S 1st St"
  }
}' \
--asset-files JOES_BANNER_ASSET=location-images/joes-banner.jpg JOES_SQUARE_ASSET=location-images/joes-square.jpg \
> /dev/null 2

echo -ne ' Progress: |████████████████----|  80% Complete\r'
xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type SpotLocation \
--fields-json '{
  "address": {
    "type": "stringType",
    "value": "185 Park Ave #183"
  },
  "squareAsset": {
    "type": "assetType",
    "value": "PEGGY_SQUARE_ASSET"
  },
  "location": {
    "type": "locationType",
    "value": {
      "longitude": -121.891043,
      "latitude": 37.331836
    }
  },
  "phoneNumber": {
    "type": "stringType",
    "value": "408-294-0252"
  },
  "websiteURL": {
    "value": "http://www.peggysues.com/park.html",
    "type": "stringType"
  },
  "name": {
    "value": "Peggy Sue'\''s 50'\''s Diner & Bar",
    "type": "stringType"
  },
  "bannerAsset": {
    "value": "PEGGY_BANNER_ASSET",
    "type": "assetType"
  },
  "description": {
    "value": "1950s inspired restaurant that allows our guests to take a step back in time to the days of drive-in movies, rock ’n roll, and milkshakes.",
    "type": "stringType"
  }
}' \
--asset-files PEGGY_BANNER_ASSET=location-images/peggy-banner.jpg PEGGY_SQUARE_ASSET=location-images/peggy-square.jpg \
> /dev/null 2

echo -ne ' Progress: |██████████████████--|  90% Complete\r'

echo -ne ' Progress: |████████████████████| 100% Complete\r'
sleep 1
echo -ne 'The rebuild operation was successful.          \r'
echo -ne '\n'
exit
