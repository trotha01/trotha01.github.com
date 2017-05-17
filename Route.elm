module Route exposing (Route(..), fromLocation, href, toString)

import UrlParser as Url exposing (parseHash, s, (</>), string, oneOf, Parser)
import Navigation exposing (Location)
import Html exposing (Attribute)
import Html.Attributes as Attr


type Route
    = Home
    | About
    | Projects
    | Resume
    | Contact


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Home (s "")
        , Url.map About (s "about")
        , Url.map Projects (s "projects")
        , Url.map Resume (s "resume")
        , Url.map Contact (s "contact")
        ]


toString : Route -> String
toString page =
    let
        pieces =
            case page of
                Home ->
                    []

                About ->
                    [ "about" ]

                Projects ->
                    [ "projects" ]

                Resume ->
                    [ "resume" ]

                Contact ->
                    [ "contact" ]
    in
        "#/" ++ (String.join "/" pieces)


href : Route -> Attribute msg
href route =
    Attr.href (toString route)


fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Home
    else
        parseHash route location
