This is the backend to my web app, page9. This is a magic the gathering market place website. 

On this site, you sign up to add cards to your wantlist (list of cards you want to buy) and havelist (list of cards you have to sell). Base on your wantlist and havelist, we find users that have corresponding matches, that is, users that want to buy your cards and users that have the cards you want to buy.

About this backend api,

1. ruby on rails
2. graphql api
3. json web token for auth
3.5 encrypted password implmentation
4. pretty much all queries/mutations requires jwt.
5. implemented cross origin resource sharing, cors. Currently, any origin can access the api, if you want to access the database with postman or something like that, read more below.
6. uses a SDK from magicthegathering.io, a third party magic the gathering api, to obtain information about cards, those cards are then added to the data.
7. postgresql database
8. output json data

Information about accessing the api

query {
    users(idList: [...]) { // [User]
        id // integer
        fullName // string
        userName // string
        email // string
        address // string
        wantList {// [Item]
          id // integer
          wantHaveRemoved // string
          additionalInfo // string
          listingPrice // float
          productName // string
          productImagePath // string
          user_id // integer
          productName // string
          productOutsideIdent // string
          productImagePath // string
          user { // User
              ...
          }
        }
        haveList { // [Item]
          ...
        }
        haveListMatches { // [Item]
          ...
        }
        wantListMatches { // [Item]
           ...
        }
    }
}

The users query can query for users base on a list (in an array) of ids, if idList is left blank, it will return all users, if idList: [-1], it will return the current user, base on the jwt. Please just use idList:[-1]. From the current user, you can access attributes of the user, fullName, userName, etc, or stuff belonging to the user, like wantList, haveList, etc, which are array of items belonging to the user. An item have attributes or related info of the item.

You can sign up on the website, login to obtain a jwt, and use postman with jwt. Part of the Headers, include the following
Authorization: Bearer PUT-THE-JWT-HERE
