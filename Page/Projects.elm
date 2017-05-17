module Page.Projects exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, p, ul, li, img)
import Html.Attributes as Attr
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


view : Window.Size -> Model -> Html Msg
view window model =
    Helper.topImageView window topImage projects


topImage : Html a
topImage =
    Helper.topImage "imgs/tools.svg" carbonFibreBackground


carbonFibreBackground : List Css.Mixin
carbonFibreBackground =
    [ property "background" "radial-gradient(black 15%, transparent 16%) 0 0, radial-gradient(black 15%, transparent 16%) 8px 8px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 0 1px, radial-gradient(rgba(255,255,255,.1) 15%, transparent 20%) 8px 9px"
    , property "backgroundColor" "#282828"
    , property "backgroundSize" "16px 16px"
    ]



{-
   - TODO: update to projects and ideas
-}


projects : Html msg
projects =
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
            [ project "Boxes and Bubbles" "https://github.com/trotha01/boxes-and-bubbles" <|
                "Built on top of Jastice's library (also called boxes-and-bubbles), this is an exporation into collision detection with, as the name implies, boxes and bubbles."
            , project "Bee Game" "https://github.com/trotha01/bee" <|
                "Learn Spanish while traveling around the world as a bee."
            , project "Treadmill" "https://github.com/trotha01/treadmill" <|
                "Practice your spanish while making a cake."
            ]
        ]


project : String -> String -> String -> Html msg
project title href description =
    li
        [ Attr.class "projectListItem"
        , styles
            [ padding (px 10)
            , cursor pointer
            ]
        ]
        [ a
            [ Attr.href href
            , Attr.target "_blank"
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
