#!/bin/zsh
# addusers.sh


xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type UserProfile \
--fields-json '{
  "compagnyName": {
    "value": "Diabolo Juggle",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_01",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "I like to juggle, play jumbé and spit fire. "
  },
  "firstName": {
    "type": "stringType",
    "value": "Pipo"
  },
  "lastName": {
    "type": "stringType",
    "value": "CRANCHESCO"
  }
}' \
--asset-files AVATAR_01=avatar-images/user-01.jpg \
> /dev/null 2


xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type UserProfile \
--fields-json '{
  "compagnyName": {
    "value": "BlingCash",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_02",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "I am an influencer and I like to influence people"
  },
  "firstName": {
    "type": "stringType",
    "value": "Danna"
  },
  "lastName": {
    "type": "stringType",
    "value": "IBANIEZ"
  }
}' \
--asset-files AVATAR_02=avatar-images/user-02.jpg \
> /dev/null 2


xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type UserProfile \
--fields-json '{
  "compagnyName": {
    "value": "OUI OUI BAGUETTE",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_03",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "I like to laugh"
  },
  "firstName": {
    "type": "stringType",
    "value": "Clotilde"
  },
  "lastName": {
    "type": "stringType",
    "value": "DECOURT"
  }
}' \
--asset-files AVATAR_03=avatar-images/user-03.jpg \
> /dev/null 2


xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type UserProfile \
--fields-json '{
  "compagnyName": {
    "value": "Vanguard Group",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_04",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "I like to make money"
  },
  "firstName": {
    "type": "stringType",
    "value": "Athma"
  },
  "lastName": {
    "type": "stringType",
    "value": "ABDOULA"
  }
}' \
--asset-files AVATAR_04=avatar-images/user-04.jpg \
> /dev/null 2


xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type UserProfile \
--fields-json '{
  "compagnyName": {
    "value": "Unrelying",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_05",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "Masters degree in sociology"
  },
  "firstName": {
    "type": "stringType",
    "value": "Pierre"
  },
  "lastName": {
    "type": "stringType",
    "value": "TURLUTUTU"
  }
}' \
--asset-files AVATAR_05=avatar-images/user-05.jpg \
> /dev/null 2


xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type UserProfile \
--fields-json '{
  "compagnyName": {
    "value": "Unrelying",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_06",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "I like to dance around a fire"
  },
  "firstName": {
    "type": "stringType",
    "value": "Sophia"
  },
  "lastName": {
    "type": "stringType",
    "value": "COACHELLA"
  }
}' \
--asset-files AVATAR_06=avatar-images/user-06.jpg \
> /dev/null 2

xcrun cktool create-record \
--team-id W8A2PVHCN3 \
--container-id iCloud.fr.hludovic.AfterBuild \
--environment development \
--database-type public \
--record-type UserProfile \
--fields-json '{
  "compagnyName": {
    "value": "CNRS",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_07",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "Doctor of nuclear physics"
  },
  "firstName": {
    "type": "stringType",
    "value": "Megumi"
  },
  "lastName": {
    "type": "stringType",
    "value": "AMANO"
  }
}' \
--asset-files AVATAR_07=avatar-images/user-07.jpg \
> /dev/null 2
