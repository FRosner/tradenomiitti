module Nav exposing (..)

import Navigation
import UrlParser as U exposing ((</>))
import Window

type Route = CreateAd | ShowAd Int | ListAds | ListUsers | Home | Info | NotFound | Profile | User Int

routeToPath : Route -> String
routeToPath route =
  case route of
    CreateAd ->
      "/ad/create"
    ShowAd adId ->
      "/ads/" ++ (toString adId)
    ListAds ->
      "/ads"
    ListUsers ->
      "/users"
    Home ->
      "/"
    Info ->
      "/info"
    NotFound ->
      "/notfound"
    Profile ->
      "/profile"
    User userId ->
      "/user/" ++ (toString userId)


parseLocation : Navigation.Location -> Route
parseLocation location =
  let route = U.parsePath routeParser location
  in
    case route of
      Just route -> route
      Nothing -> NotFound

routeParser : U.Parser (Route -> a) a
routeParser =
  U.oneOf
    [ U.map CreateAd (U.s "ad" </> U.s "create")
    , U.map ShowAd (U.s "ads" </> U.int)
    , U.map ListAds (U.s "ads")
    , U.map ListUsers (U.s "users")
    , U.map Home (U.s "")
    , U.map Info (U.s "info")
    , U.map Profile (U.s "profile")
    , U.map User (U.s "user" </> U.int)
    ]


ssoUrl : String -> Route -> String
ssoUrl rootUrl route =
  let
    loginUrl = rootUrl ++ "/login?path=" ++ (routeToPath route)
    returnParameter = Window.encodeURIComponent loginUrl
  in
    "https://tunnistus.avoine.fi/sso-login/?service=tradenomiitti&return=" ++
      returnParameter
