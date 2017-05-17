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
        [ submarinePaper ]


submarinePaper =
    div
        [ Attr.class "sea"
        , styles [ height (pct 100) ]
        ]
        [ bubble ]


bubble =
    div [ Attr.class "circle-wrapper" ]
        [ div [ Attr.class "bubble" ] []
        , submarine
        ]


submarine =
    div [ Attr.class "submarine-wrapper" ]
        [ div [ Attr.class "submarine-body" ]
            [ div [ Attr.class "window" ] []
            , div [ Attr.class "engine" ] []
            , div [ Attr.class "light" ] []
            ]
        , div [ Attr.class "helix" ] []
        , div [ Attr.class "hat" ]
            [ div [ Attr.class "leds-wrapper" ]
                [ div [ Attr.class "periscope" ] []
                , div [ Attr.class "leds" ] []
                ]
            ]
        ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
