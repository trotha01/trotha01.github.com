module Page.Home exposing (Model, Msg, init, view, update)

import Css exposing (..)
import Html exposing (Html, button, div, text, a, img)
import Html.Attributes as Attr
import Route
import Page.Header as Header


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


view : Model -> Html Msg
view model =
    div []
        [ home ]


home : Html msg
home =
    div
        [ styles
            [ padding (px 10)
            ]
        ]
        [ profilePic
        , description
        ]


profilePic : Html msg
profilePic =
    img
        [ styles
            [ width (px 300)
            , height (px 300)
            ]
        , Attr.src "imgs/profile.jpg"
        ]
        []


description : Html msg
description =
    div []
        [ Html.text "Home Page. TODO: add stuff here"
        ]



-- STYLE


styles =
    (Css.asPairs >> Attr.style)
