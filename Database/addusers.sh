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
    "value": "My company",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_01",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "BIOMAN"
  },
  "firstName": {
    "type": "stringType",
    "value": "Pierre"
  },
  "lastName": {
    "type": "stringType",
    "value": "LANCE"
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
    "value": "My company",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_02",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "BIOMAN"
  },
  "firstName": {
    "type": "stringType",
    "value": "Pierre"
  },
  "lastName": {
    "type": "stringType",
    "value": "LANCE"
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
    "value": "My company",
    "type": "stringType"
  },
  "avatar": {
    "value": "AVATAR_03",
    "type": "assetType"
  },
  "bio": {
    "type": "stringType",
    "value": "BIOMAN"
  },
  "firstName": {
    "type": "stringType",
    "value": "Pierre"
  },
  "lastName": {
    "type": "stringType",
    "value": "LANCE"
  }
}' \
--asset-files AVATAR_03=avatar-images/user-03.jpg \
> /dev/null 2

