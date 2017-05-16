module Page.Home exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, img)
import Html.Attributes as Attr
import Route
import Page.Header as Header
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



-- VIEW


view : Window.Size -> Model -> Html Msg
view window model =
    div
        [ styles
            [ width (px <| toFloat window.width)
            , height (px <| toFloat window.height)
            ]
        ]
        [ home ]


home : Html msg
home =
    div
        [ styles
            [ height (pct 100)
            ]
        ]
        [ topImage
          -- , description
        ]


topImage : Html msg
topImage =
    div
        [ styles
            [ height (pct 100)
            ]
        ]
        [ img [ styles [ height (pct 100) ], Attr.src "imgs/paper.svg" ] []
        ]


description : Html msg
description =
    div
        [ styles
            [ width (pct 85)
            , float left
            , paddingTop (px 20)
            ]
        ]
        [ Html.text "Welcome to my website! If you enjoy education or educational games, please reach out to me! I love talking with new people."
        ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
