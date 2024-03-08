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
    "value": "https://levybz.business.site/",
    "type": "stringType"
  },
  "address": {
    "type": "stringType",
    "value": "33 Rue des Castries, Lamentin 97129, Guadeloupe"
  },
  "name": {
    "value": "Le Vybz",
    "type": "stringType"
  },
  "description": {
    "type": "stringType",
    "value": "Le restaurant VYBZ propose une cuisine de type Brasserie et est situé à Lamentin. Du poisson grillé, des entrecôtes, des frites."
  },
  "bannerAsset": {
    "type": "assetType",
    "value": "LEVYBZ_BANNER_ASSET"
  },
  "phoneNumber": {
    "value": "0690 51 25 34",
    "type": "stringType"
  },
  "squareAsset": {
    "type": "assetType",
    "value": "LEVYBZ_SQUARE_ASSET"
  },
  "location": {
    "value": {
      "latitude": 16.26687504584551,
      "longitude": -61.64095487301031
    },
    "type": "locationType"
  }
}' \
--asset-files LEVYBZ_BANNER_ASSET=location-images/levybz-banner.jpg LEVYBZ_SQUARE_ASSET=location-images/levybz-square.jpg \
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
    "value": "LEKOUZ_SQUARE_ASSET"
  },
  "websiteURL": {
    "value": "https://www.lekouz.com/",
    "type": "stringType"
  },
  "description": {
    "type": "stringType",
    "value": "Adossé à la brasserie, se trouve un espace de dégustation où tu pourras découvrir nos bières et passer une soirée en toute convivialité."
  },
  "address": {
    "value": "Rue de l’Habitation, Goyave 97128, Guadeloupe",
    "type": "stringType"
  },
  "name": {
    "value": "LeKouz",
    "type": "stringType"
  },
  "bannerAsset": {
    "value": "LEKOUZ_BANNER_ASSET",
    "type": "assetType"
  },
  "phoneNumber": {
    "type": "stringType",
    "value": "0690 40 20 00"
  },
  "location": {
    "type": "locationType",
    "value": {
      "latitude": 16.127077432483613,
      "longitude": -61.5730940963093
    }
  }
}' \
--asset-files LEKOUZ_BANNER_ASSET=location-images/lekouz-banner.jpg LEKOUZ_SQUARE_ASSET=location-images/lekouz-square.jpg \
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
    "value": "PNY_BANNER_ASSET",
    "type": "assetType"
  },
  "phoneNumber": {
    "value": "0690 97 97 00",
    "type": "stringType"
  },
  "squareAsset": {
    "type": "assetType",
    "value": "PNY_SQUARE_ASSET"
  },
  "websiteURL": {
    "value": "https://www.facebook.com/p/Le-Petit-New-York-100064862221093/",
    "type": "stringType"
  },
  "description": {
    "value": "Bar à thèmes, il propose à ses clients des cocktails de choix, alcoolisés ou non ainsi que de très belles références en terme d’alcools forts (rhum blancs/vieux, cognacs).",
    "type": "stringType"
  },
  "location": {
    "type": "locationType",
    "value": {
      "longitude": -61.456767180969116,
      "latitude": 16.203501378551245
    }
  },
  "name": {
    "type": "stringType",
    "value": "Le Petit New-York"
  },
  "address": {
    "type": "stringType",
    "value": "Port de Saint-Felix, Le Gosier, Guadeloupe"
  }
}' \
--asset-files PNY_BANNER_ASSET=location-images/pny-banner.jpg PNY_SQUARE_ASSET=location-images/pny-square.jpg \
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
    "value": "0690 52 78 60",
    "type": "stringType"
  },
  "location": {
    "value": {
      "latitude": 16.32363226654271,
      "longitude": -61.78735628835049
    },
    "type": "locationType"
  },
  "websiteURL": {
    "value": "https://www.facebook.com/karacolibeachspa/",
    "type": "stringType"
  },
  "address": {
    "value": "Plage de Grande-Anse, Deshaies, Guadeloupe",
    "type": "stringType"
  },
  "squareAsset": {
    "value": "KARACOLI_SQUARE_ASSET",
    "type": "assetType"
  },
  "bannerAsset": {
    "type": "assetType",
    "value": "KARACOLI_BANNER_ASSET"
  },
  "name": {
    "value": "Karacoli Beach & Spa",
    "type": "stringType"
  },
  "description": {
    "type": "stringType",
    "value": "Vue sur la mer, sable fin sous les pieds, cocktail à la main : vous voilà parés pour un moment inoubliable. Notre Beach Club vous propose une carte pensée spécialement pour votre satisfaction. De plus, nous vous proposons des espaces réservables, afin que vous puissiez profiter de nos services en toute convivialité."
  }
}' \
--asset-files KARACOLI_BANNER_ASSET=location-images/karacoli-banner.jpg KARACOLI_SQUARE_ASSET=location-images/karacoli-square.jpg \
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
    "value": "47 Rue Henri Becquerel, Baie-Mahault 97122, Guadeloupe"
  },
  "websiteURL": {
    "type": "stringType",
    "value": "https://lappart2-0.com/"
  },
  "bannerAsset": {
    "type": "assetType",
    "value": "LAPPART_BANNER_ASSET"
  },
  "phoneNumber": {
    "type": "stringType",
    "value": "0690 73 51 83"
  },
  "description": {
    "type": "stringType",
    "value": "L’appart 2.0 est le seul lieu en Guadeloupe Combinant une scène intérieure, des mezzanines et un extérieur aménagé tout aussi grand. Pas moins de 3 Bar et un restaurant."
  },
  "name": {
    "type": "stringType",
    "value": "L’Appart 2.0"
  },
  "squareAsset": {
    "value": "LAPPART_SQUARE_ASSET",
    "type": "assetType"
  },
  "location": {
    "type": "locationType",
    "value": {
      "longitude": -61.561736001721314,
      "latitude": 16.244825921235172
    }
  }
}' \
--asset-files LAPPART_BANNER_ASSET=location-images/lappart-banner.jpg LAPPART_SQUARE_ASSET=location-images/lappart-square.jpg \
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
      "longitude": -61.5063637423299,
      "latitude": 16.209033361811585
    },
    "type": "locationType"
  },
  "phoneNumber": {
    "value": "0590 20 42 44",
    "type": "stringType"
  },
  "squareAsset": {
    "type": "assetType",
    "value": "KARUKERACAFE_SQUARE_ASSET"
  },
  "websiteURL": {
    "value": "https://www.facebook.com/karukeracafe/",
    "type": "stringType"
  },
  "bannerAsset": {
    "value": "KARUKERACAFE_BANNER_ASSET",
    "type": "assetType"
  },
  "name": {
    "value": "Karukéra Café",
    "type": "stringType"
  },
  "description": {
    "type": "stringType",
    "value": "Le bar lounge Karukera Café vous propose des cocktails, des rhums, du vin et des tapas. Le bar lounge Karukera Café dispose d’une terrasse. Il se situe en face de l’hôtel la Créole Beach."
  },
  "address": {
    "type": "stringType",
    "value": "Résidence Créole, Bâtiment C, Pointe de la Verdure, Gosier, Guadeloupe"
  }
}' \
--asset-files KARUKERACAFE_BANNER_ASSET=location-images/karukera-cafe-banner.jpg KARUKERACAFE_SQUARE_ASSET=location-images/karukera-cafe-square.jpg \
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
    "value": "TIPSY_SQUARE_ASSET",
    "type": "assetType"
  },
  "name": {
    "type": "stringType",
    "value": "Tipsy Bar"
  },
  "description": {
    "value": "Prolongez votre soirée avec un cocktail maison et une planche de tapas. Nos barmans vous impressionneront par leur savoir-faire avec des cocktails aussi beaux que bons !",
    "type": "stringType"
  },
  "bannerAsset": {
    "value": "TIPSY_BANNER_ASSET",
    "type": "assetType"
  },
  "location": {
    "type": "locationType",
    "value": {
      "longitude": -61.34497015038255,
      "latitude": 16.24731964323023
    }
  },
  "phoneNumber": {
    "type": "stringType",
    "value": "0590 88 48 48"
  },
  "websiteURL": {
    "type": "stringType",
    "value": "https://www.relaisdumoulin.com/fr/restaurants-et-bar.html"
  },
  "address": {
    "type": "stringType",
    "value": "Le Helleux Hôtel Le Relais Du Moulin, Sainte-Anne 97180, Guadeloupe"
  }
}' \
--asset-files TIPSY_BANNER_ASSET=location-images/tipsy-bar-banner.jpg TIPSY_SQUARE_ASSET=location-images/tipsy-bar-square.jpg \
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
    "value": "La Marina, Le Gosier 97190, Guadeloupe"
  },
  "squareAsset": {
    "type": "assetType",
    "value": "ZOOROCK_SQUARE_ASSET"
  },
  "location": {
    "type": "locationType",
    "value": {
      "longitude": -61.52702806428935,
      "latitude": 16.22007491624798
    }
  },
  "phoneNumber": {
    "type": "stringType",
    "value": "0590 90 77 77"
  },
  "websiteURL": {
    "value": "https://www.facebook.com/Zoo.Rock.Cafe/",
    "type": "stringType"
  },
  "name": {
    "value": "Zoo Rock Café",
    "type": "stringType"
  },
  "bannerAsset": {
    "value": "ZOOROCK_BANNER_ASSET",
    "type": "assetType"
  },
  "description": {
    "value": "Depuis 1996 le Zoo Rock Café vous accueille dans son resto-bar mythique sur la marina de Pointe à Pitre. Pour boire un verre entre amis, vous avez soit le bar, grand ouvert sur l’extérieur, soit la discothèque avec une ambiance plus calliente.",
    "type": "stringType"
  }
}' \
--asset-files ZOOROCK_BANNER_ASSET=location-images/zoorock-banner.jpg ZOOROCK_SQUARE_ASSET=location-images/zoorock-square.jpg \
> /dev/null 2

echo -ne ' Progress: |██████████████████--|  90% Complete\r'

echo -ne ' Progress: |████████████████████| 100% Complete\r'
sleep 1
echo -ne 'The rebuild operation was successful.          \r'
echo -ne '\n'
exit
