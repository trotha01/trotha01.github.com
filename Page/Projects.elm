module Page.Projects exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p, ul, li, img)
import Html.Attributes as Attr
import Html.Events as Event exposing (defaultOptions)
import Json.Decode as Json
import Route
import Page.Header as Header
import Page.Helper as Helper
import Window


-- MODEL


type alias Model =
    {}


init : Model
init =
    {}



-- UPDATE


type Msg
    = HeaderMsg Header.Msg


update : Msg -> Model -> Model
update msg model =
    model


view : (String -> msg) -> Window.Size -> Model -> Html msg
view onClick window model =
    Helper.topImageView window topImage (projects onClick)


topImage : Html a
topImage =
    Helper.topImage "imgs/tools.svg" carbonFibreBackground


carbonFibreBackground : List Css.Mixin
carbonFibreBackground =
    [ property "background" "radial-gradient(black 15%, transparent 16%) 0 0, radial-gradient(black 15%, transparent 16%) 8px 8px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 0 1px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 8px 9px"
    , property "backgroundColor" "#282828"
    , property "backgroundSize" "16px 16px"
    ]


projects : (String -> msg) -> Html msg
projects onClick =
    div
        [ styles
            [ padding (px 10)
            ]
        ]
        [ ul
            [ styles
                [ listStyleType none
                , width (pct 100)
                , padding (px 0)
                ]
            ]
            [ project onClick "Boxes and Bubbles" "https://github.com/trotha01/boxes-and-bubbles" <|
                "BuiltonClick  on top of Jastice's library (also called boxes-and-bubbles), this is an exporation into collision detection with, as the name implies, boxes and bubbles."
            , project onClick "Bee Game" "https://github.com/trotha01/bee" <|
                "LearnonClick  Spanish while traveling around the world as a bee."
            , project onClick "Treadmill" "https://github.com/trotha01/treadmill" <|
                "Practice your spanish while making a cake."
            ]
        ]


project : (String -> msg) -> String -> String -> String -> Html msg
project onClick title href description =
    li
        [ Attr.class "projectListItem"
        , styles
            [ padding (px 10)
            , cursor pointer
            ]
        ]
        [ a
            [ Attr.href href
            , Event.onWithOptions
                "click"
                { defaultOptions | preventDefault = True }
                (Json.succeed (onClick href))
            , styles
                [ textDecoration none
                , color (hsl 0 0 0)
                ]
            ]
            [ Html.h3 [] [ Html.text title ]
            , p [ styles [ width (px 500) ] ] [ Html.text description ]
            ]
        ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
